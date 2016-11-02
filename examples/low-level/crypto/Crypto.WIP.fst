module Crypto.WIP

// We implement ideal AEAD on top of ideal Chacha20 and ideal Poly1305. 
// We precisely relate AEAD's log to their underlying state.

// This file intends to match the spec of AEAD0.fst in mitls-fstar. 

open FStar.UInt32
open FStar.Ghost
open Buffer.Utils
open FStar.Monotonic.RRef

open Crypto.Symmetric.Bytes
open Plain
open Flag

open Crypto.Symmetric.PRF
open Crypto.AEAD.Encoding 
open Crypto.AEAD.Invariant
open Crypto.AEAD.Lemmas
open Crypto.AEAD.Lemmas.Part2
open Crypto.AEAD

module HH = FStar.HyperHeap
module HS = FStar.HyperStack

module Spec = Crypto.Symmetric.Poly1305.Spec
module MAC = Crypto.Symmetric.Poly1305.MAC

module Cipher = Crypto.Symmetric.Cipher
module PRF = Crypto.Symmetric.PRF

(* #reset-options "--z3timeout 200 --initial_fuel 0 --max_fuel 0 --initial_ifuel 0 --max_ifuel 0" *)
(* let test (h0:HS.mem) (h1:HS.mem) (r:rid) =  *)
(*   let open FStar.HyperStack in  *)
(*   assume (r `HS.is_in` h0.h); *)
(*   assume (Buffer.modifies_0 h0 h1); *)
(*   Buffer.lemma_reveal_modifies_0 h0 h1; *)
(*   assume (r <> h0.tip); *)
(*   assert (Map.sel h1.h r == Map.sel h0.h r) *)
  
(* assume val temp_to_seq: #a:Type -> b:Buffer.buffer a -> ST (Seq.seq a) *)
(*   (requires (fun h -> Buffer.live h b)) *)
(*   (ensures  (fun h0 r h1 -> h0 == h1 /\ Buffer.live h1 b /\r == Buffer.as_seq #a h1 b)) *)

(* assume val temp_get_plain: #i:id -> #l:UInt32.t -> buf:plainBuffer i (v l) -> ST (plain i (v l)) *)
(*   (requires (fun h -> Plain.live h buf)) *)
(*   (ensures (fun h0 p h1 -> h0==h1 /\ Plain.live h0 buf /\p == Plain.sel_plain h1 l buf)) *)

let lemma_frame_find_mac (#i:PRF.id) (#l:nat) (st:PRF.state i) 
			 (x:PRF.domain i{x.ctr <> 0ul}) (b:lbuffer l)
			 (h0:HS.mem) (h1:HS.mem) 
    : Lemma (requires (modifies_table_above_x_and_buffer st x b h0 h1))
	    (ensures (prf i ==> (
		      let r = PRF.itable i st in
		      let tab0 = HS.sel h0 r in
		      let tab1 = HS.sel h1 r in
		      let x0 = {x with ctr=0ul} in
		      find_mac tab0 x0 == find_mac tab1 x0)))
    = admit()		      

open FStar.Heap
let heap_modifies_fresh_empty_0  (h0:heap) (h1:heap) (h2:heap) (x:FStar.Heap.ref nat)
  : Lemma (requires (Heap.modifies TSet.empty h0 h1 /\
		     Heap.modifies !{x} h1 h2 /\
		     not(h0 `Heap.contains` x)))
          (ensures (Heap.modifies TSet.empty h0 h2))
  = ()	  

let modifies_fresh_empty_0  (h0:mem) (h1:mem) (h2:mem) (r:rid) (x:HS.reference nat)
  : Lemma (requires (HS (h0.h) `Map.contains` r /\
		     HS.modifies_ref r TSet.empty h0 h1 /\
  		     HS.modifies_ref r (TSet.singleton (HS.as_aref x)) h1 h2 /\
		     HS.frameOf x == r /\
		     ~(h0 `HS.contains` x)))
          (ensures (HS.modifies_ref r TSet.empty h0 h2))
  = ()	  
  
let modifies_fresh_empty (i:id) (n: Cipher.iv (alg i)) (r:rid) (m:MAC.state (i,n)) 
			 (h0:mem) (h1:mem) (h2:mem) 
  : Lemma (requires (HS (h0.h) `Map.contains` r /\
		     HS.modifies_ref r TSet.empty h0 h1 /\
		    (mac_log ==> 
		        (let ref = MAC (as_hsref (ilog m.log)) in
			 HS.frameOf ref == r /\
			 HS.modifies_ref r (TSet.singleton (MAC (HS.as_aref ref))) h1 h2)) /\
		    (safeId i ==> ~ (m_contains (MAC (ilog m.log)) h0))))
          (ensures (safeId i ==> HS.modifies_ref r TSet.empty h0 h2))
  = assert (safeId i ==> prf i /\ mac_log);
    ()
  
#reset-options "--z3timeout 400 --initial_fuel 0 --max_fuel 0 --initial_ifuel 0 --max_ifuel 0 --log_queries"

val extend_refines_aux: (i:id) -> (st:state i Writer) -> (nonce:Cipher.iv (alg i)) ->
		       (aadlen: UInt32.t {aadlen <=^ aadmax}) ->
		       (aad: lbuffer (v aadlen)) ->
                       (len:nat{len<>0}) -> (plain:plainBuffer i len) -> (cipher:lbuffer (len + v (Spec.taglen i))) ->
		       (h0:mem) ->
                       (h1:mem{Buffer.live h1 aad /\ Plain.live h1 plain /\ Buffer.live h1 cipher}) ->
    Lemma (requires ( safeId i ==> (
		      let mac_rgn = st.prf.mac_rgn in
      		      let entries_0 = HS.sel h0 st.log in 
		      let blocks_0 = HS.sel h0 (PRF.itable i st.prf) in
		      let table_1 = HS.sel h1 (PRF.itable i st.prf) in
		      Seq.length table_1 > Seq.length blocks_0 /\ (
		      let blocks_1 = Seq.slice table_1 (Seq.length blocks_0) (Seq.length table_1) in

     		      let p = Plain.sel_plain h1 (u len) plain in
		      let c_tagged = Buffer.as_seq h1 cipher in
	              let c, tag = SeqProperties.split c_tagged len in
		      let ad = Buffer.as_seq h1 aad in
  		      let entry = Entry nonce ad len p c_tagged in
		      pre_refines_one_entry i st nonce len plain cipher h0 h1 /\
		      inv h0 st /\
		      refines_one_entry #_ #i h1 entry blocks_1 /\
      		      HS.modifies_ref mac_rgn TSet.empty h0 h1 /\
		      HS.live_region h1 mac_rgn))))
		      
          (ensures ( safeId i ==> (
		      let mac_rgn = st.prf.mac_rgn in
      		      let entries_0 = HS.sel h0 st.log in 
		      let table_1 = HS.sel h1 (PRF.itable i st.prf) in
     		      let p = Plain.sel_plain h1 (u len) plain in
		      let c_tagged = Buffer.as_seq h1 cipher in
	              let c, tag = SeqProperties.split c_tagged len in
		      let ad = Buffer.as_seq h1 aad in
  		      let entry = Entry nonce ad len p c_tagged in
		      refines h1 i mac_rgn (SeqProperties.snoc entries_0 entry) table_1)))
let extend_refines_aux i st nonce aadlen aad len plain cipher h0 h1 = 
  if safeId i then
     let mac_rgn = st.prf.mac_rgn in
     let entries_0 = HS.sel h0 st.log in 
     let blocks_0 = HS.sel h0 (PRF.itable i st.prf) in
     let table_1 = HS.sel h1 (PRF.itable i st.prf) in
     let blocks_1 = Seq.slice table_1 (Seq.length blocks_0) (Seq.length table_1) in
     let p = Plain.sel_plain h1 (u len) plain in
     let c_tagged = Buffer.as_seq h1 cipher in
     let c, tag = SeqProperties.split c_tagged len in
     let ad = Buffer.as_seq h1 aad in
     let entry = Entry nonce ad len p c_tagged in
     extend_refines h0 i mac_rgn entries_0 blocks_0 entry blocks_1 h1

assume val to_seq_temp: #a:Type -> b:Buffer.buffer a -> l:UInt32.t{v l <= Buffer.length b} -> ST (Seq.seq a)
  (requires (fun h -> Buffer.live h b))
  (ensures  (fun h0 r h1 -> h0 == h1 /\ Buffer.live h1 b /\ r == Buffer.as_seq h1 b))

#reset-options "--z3timeout 400 --initial_fuel 1 --max_fuel 1 --initial_ifuel 0 --max_ifuel 0"
let rec frame_refines (i:id{safeId i}) (mac_rgn:region) 
		      (entries:Seq.seq (entry i)) (blocks:Seq.seq (PRF.entry mac_rgn i))
		      (h:mem) (h':mem)
   : Lemma (requires refines h i mac_rgn entries blocks /\
		     HS.modifies_ref mac_rgn TSet.empty h h' /\
		     HS.live_region h' mac_rgn)
	   (ensures  refines h' i mac_rgn entries blocks)
	   (decreases (Seq.length entries))
   = if Seq.length entries = 0 then 
       ()
     else let e = SeqProperties.head entries in
          let b = num_blocks e in 
         (let blocks_for_e = Seq.slice blocks 0 (b + 1) in
       	  let entries_tl = SeqProperties.tail entries in
          let blocks_tl = Seq.slice blocks (b+1) (Seq.length blocks) in
	  frame_refines i mac_rgn entries_tl blocks_tl h h';
	  frame_refines_one_entry h i mac_rgn e blocks_for_e h')

#reset-options "--z3timeout 400 --initial_fuel 0 --max_fuel 0 --initial_ifuel 0 --max_ifuel 0"
val refines_to_inv: (i:id) -> (st:state i Writer) -> (nonce:Cipher.iv (alg i)) ->
		       (aadlen: UInt32.t {aadlen <=^ aadmax}) ->
		       (aad: lbuffer (v aadlen)) ->
		       (len: UInt32.t {len <> 0ul}) ->
		       (plain:plainBuffer i (v len)) -> 
		       (cipher:lbuffer (v len + v (Spec.taglen i))) ->
    ST unit (requires (fun h1 ->
		      Buffer.live h1 aad /\ 
		      Plain.live h1 plain /\ 
		      Buffer.live h1 cipher /\ (
		      HS (h1.h) `Map.contains` st.prf.mac_rgn /\
		      h1 `HS.contains` st.log /\
		      (safeId i ==> (
			let mac_rgn = st.prf.mac_rgn in
      			let entries_0 = HS.sel h1 st.log in 
			let table_1 = HS.sel h1 (PRF.itable i st.prf) in
     			let p = Plain.sel_plain h1 len plain in
			let c_tagged = Buffer.as_seq h1 cipher in
			let c, tag = SeqProperties.split c_tagged (v len) in
			let ad = Buffer.as_seq h1 aad in
  			let entry = Entry nonce ad (v len) p c_tagged in
			h1 `HS.contains` (itable i st.prf) /\
			~ (st.log === (itable i st.prf)) /\
			refines h1 i mac_rgn (SeqProperties.snoc entries_0 entry) table_1)))))
          (ensures (fun h1 _ h2 -> 
      		      Buffer.live h1 aad /\ 
		      Plain.live h1 plain /\ 
		      Buffer.live h1 cipher /\ (
		      inv h2 st /\
		      (if safeId i then 
			let mac_rgn = st.prf.mac_rgn in
      			let entries_0 = HS.sel h1 st.log in 
			let table_1 = HS.sel h1 (PRF.itable i st.prf) in
     			let p = Plain.sel_plain h1 len plain in
			let c_tagged = Buffer.as_seq h1 cipher in
			let c, tag = SeqProperties.split c_tagged (v len) in
			let ad = Buffer.as_seq h1 aad in
  			let entry = Entry nonce ad (v len) p c_tagged in
  			HS.modifies (Set.singleton st.log_region) h1 h2 /\
			HS.modifies_ref st.log_region !{HS.as_ref st.log} h1 h2 /\ 
			HS.sel h2 st.log == SeqProperties.snoc entries_0 entry
		      else HS.modifies Set.empty h1 h2))))
let refines_to_inv i st nonce aadlen aad len plain cipher =
  if safeId i then
    let h0 = get () in 
    let ad = to_seq_temp aad aadlen in
    let p = Plain.load len plain in 
    let c_tagged = to_seq_temp cipher len in
    let entry = Entry nonce ad (v len) p c_tagged in
    st.log := SeqProperties.snoc !st.log entry;
    let h1 = get () in 
    let entries = !st.log in
    let blocks = !(itable i st.prf) in
    frame_refines i st.prf.mac_rgn entries blocks h0 h1
  else ()

let my_inv (#i:id) (#rw:_) (st:state i rw) (h:mem) = 
  inv h st /\
  h `HS.contains` st.log /\
  HS (h.h `Map.contains` st.prf.mac_rgn) /\
  (prf i ==> (h `HS.contains` (itable i st.prf) /\
	     ~ (st.log === (itable i st.prf))))

let mac_ensures (i:MAC.id) (st:MAC.state i) (l:MAC.itext) (acc:MAC.accB i) (tag:MAC.tagB) 
		(h0:mem) (h1:mem) = 
    let open FStar.Buffer in
    let open Crypto.Symmetric.Bytes in
    let open Crypto.Symmetric.Poly1305 in
    let open Crypto.Symmetric.Poly1305.Spec in
    let open Crypto.Symmetric.Poly1305.MAC in
    live h0 st.s /\ 
    live h0 st.r /\ 
    live h1 tag /\ (
    if mac_log then
      HS.modifies (as_set [st.region; Buffer.frameOf tag]) h0 h1 /\
      mods_2 [HS.Ref (as_hsref (ilog st.log)); HS.Ref (Buffer.content tag)] h0 h1 /\
      Buffer.modifies_buf_1 (Buffer.frameOf tag) tag h0 h1 /\
      HS.modifies_ref st.region !{HS.as_ref (as_hsref (ilog st.log))} h0 h1 /\
      m_contains (ilog st.log) h1 /\ (
      let mac = mac_1305 l (sel_elem h0 st.r) (sel_word h0 st.s) in
      mac == little_endian (sel_word h1 tag) /\
      m_sel h1 (ilog st.log) == Some (l, sel_word h1 tag))
    else Buffer.modifies_1 tag h0 h1)
    
val finish_after_mac: h_init:mem -> h0:mem -> i:id -> st:state i Writer -> 
		      nonce: Cipher.iv (alg i) ->
		      aadlen: UInt32.t {aadlen <=^ aadmax} -> 
		      aad: lbuffer (v aadlen) -> 
		      plainlen: UInt32.t {plainlen <> 0ul /\ safelen i (v plainlen) 1ul} -> 
		      plain: plainBuffer i (v plainlen) -> 
		      cipher:lbuffer (v plainlen + v (Spec.taglen i)) ->
		      ak:MAC.state (i, nonce) -> l:MAC.itext -> acc:MAC.accB (i, nonce) -> tag:MAC.tagB -> ST unit 
  (requires (fun h1 -> 
    HS.modifies_ref st.prf.mac_rgn TSet.empty h_init h0 /\
    pre_refines_one_entry i st nonce (v plainlen) plain cipher h_init h0 /\
    mac_ensures (i, nonce) ak l acc tag h0 h1))
  (ensures (fun h0 _ h1 -> True))

let carry_liveness (#a:Type) (b:Buffer.buffer a) (h0:mem) (h1:mem) (s:Set.set HH.rid)
    : Lemma (requires (Buffer.live h0 b /\
		       HS.modifies s h0 h1 /\
		       not (Buffer.frameOf b `Set.mem` s)))
            (ensures (Buffer.live h1 b))
    = ()
    
let finish_after_mac h0 h3 i st n aadlen aad plainlen plain cipher_tagged ak l acc tag = 
  let h4 = get () in
  let cipher = Buffer.sub cipher_tagged 0ul plainlen in
  let x0 = {iv=n; ctr=0ul} in
  assume (my_inv st h0);
  assume (MAC (ak.region = st.prf.mac_rgn));
  assume (safeId i ==> ~ (m_contains (MAC (ilog ak.log)) h0));
  assume (prf i ==> HS.frameOf (PRF.itable i st.prf) <> Buffer.frameOf cipher_tagged);
  assume (Buffer.disjoint (Plain.as_buffer plain) cipher_tagged);
  assume (Buffer.disjoint aad cipher_tagged);
  assume (HH.disjoint (Buffer.frameOf (Plain.as_buffer plain)) st.log_region);
  assume (HH.disjoint (Buffer.frameOf cipher_tagged) st.log_region);  
  assume (Buffer.live h3 cipher_tagged);
  assume (Plain.live h3 plain);
  assume (Buffer.live h3 aad);
  assume (tag == Buffer.sub cipher_tagged plainlen (Spec.taglen i));
  assume (mac_log ==> l == encode_both aadlen (Buffer.as_seq h3 aad) plainlen (Buffer.as_seq h3 cipher)); //from accumulate
  assume (safeId i ==>
  		   (let tab = HS.sel h3 (PRF.itable i st.prf) in
  		    match PRF.find_mac tab x0 with
  		    | None -> False
  		    | Some mac_st -> mac_st == ak));
  assume (safeId i); //FStar.Classical.move_requires (Buffer.lemma_reveal_modifies_1 tag h3) h4;
  intro_mac_refines i st n aad plain cipher_tagged h4;
  modifies_fresh_empty i n st.prf.mac_rgn ak h0 h3 h4;
  frame_pre_refines i st n (v plainlen) plain cipher_tagged h0 h3 h4;
  pre_refines_to_refines i st n aadlen aad (v plainlen) plain cipher_tagged h0 h4;
  extend_refines_aux i st n aadlen aad (v plainlen) plain cipher_tagged h0 h4
  
  refines_to_inv i st n aadlen aad plainlen plain cipher_tagged

  carry_liveness (Plain.as_buffer plain) h3 h4 (as_set [st.prf.mac_rgn; Buffer.frameOf tag])
       ()

(* bad error message ()
(* let finish_after_mac h0 h3 i st n aadlen aad plainlen plain cipher_tagged ak l acc tag =  *)
(*   let h4 = get () in *)
(*   assume (my_inv st h0); *)
(*   assume (MAC (ak.region = st.prf.mac_rgn)); *)
(*   assume (safeId i ==> ~ (m_contains (MAC (ilog ak.log)) h0)); *)
(*   assume (prf i ==> HS.frameOf (PRF.itable i st.prf) <> Buffer.frameOf cipher_tagged); *)
(*   assume (Buffer.disjoint (Plain.as_buffer plain) cipher_tagged); *)
(*   assume (Buffer.frameOf (Plain.as_buffer plain) <> st.prf.mac_rgn); *)
(*   assume (Buffer.live h3 cipher_tagged); *)
(*   assume (Plain.live h3 plain); *)
(*   assume (tag == Buffer.sub cipher_tagged plainlen (Spec.taglen i)); *)
(*   assume (safeId i); *)
(*   carry_liveness (Plain.as_buffer plain) h3 h4 (as_set [st.prf.mac_rgn; Buffer.frameOf tag]) *)

  
  
  admit()

  
val encrypt: 
  i: id -> st:state i Writer -> 
  n: Cipher.iv (alg i) ->
  aadlen: UInt32.t {aadlen <=^ aadmax} -> 
  aad: lbuffer (v aadlen) -> 
  plainlen: UInt32.t {plainlen <> 0ul /\ safelen i (v plainlen) 1ul} -> 
  plain: plainBuffer i (v plainlen) -> 
  cipher:lbuffer (v plainlen + v (Spec.taglen i)) 
  { 
    Buffer.disjoint aad cipher /\
    Buffer.disjoint (Plain.as_buffer plain) aad /\
    Buffer.disjoint (Plain.as_buffer plain) cipher /\
    HH.disjoint (Buffer.frameOf (Plain.as_buffer plain)) st.log_region /\
    HH.disjoint (Buffer.frameOf cipher) st.log_region /\
    HH.disjoint (Buffer.frameOf aad) st.log_region
  }
  ->  
  //STL -- should be STL eventually, but this requires propagation throughout the library
  ST unit
  (requires (fun h -> 
    let prf_rgn = st.prf.rgn in
    my_inv st h /\
    Buffer.live h aad /\
    Buffer.live h cipher /\ 
    Plain.live h plain /\
    (prf i ==> none_above ({iv=n; ctr=0ul}) st.prf h) // The nonce must be fresh!
   ))
  (ensures (fun h0 _ h1 -> 
    //TODO some "heterogeneous" modifies that also records updates to logs and tables
    HS.modifies (Set.union (Set.singleton st.log_region)
			   (Set.singleton (Buffer.frameOf cipher))) h0 h1 /\
    (* Buffer.m_ref (Buffer.frameOf cipher) !{Buffer.modifies_1 cipher h0 h1 /\  *)
    Buffer.live h1 aad /\
    Buffer.live h1 cipher /\ 
    Plain.live h1 plain /\
    my_inv st h1 /\
    (safeId i ==> (
      let aad = Buffer.as_seq h1 aad in
      let p = Plain.sel_plain h1 plainlen plain in
      let c = Buffer.as_seq h1 cipher in
      HS.sel h1 st.log == SeqProperties.snoc (HS.sel h0 st.log) (Entry n aad (v plainlen) p c)))
   ))

let encrypt i st n aadlen aad plainlen plain cipher_tagged =
  let h0 = get() in
  assume (HS (is_stack_region h0.tip)); //TODO: remove this once we move all functions to STL
  assume (HS (HH.disjoint h0.tip st.prf.mac_rgn)); //DO we need disjointness or will disequality do?
  let x = PRF({iv = n; ctr = 0ul}) in // PRF index to the first block
  let ak = PRF.prf_mac i st.prf x in  // used for keying the one-time MAC  
  let h1 = get () in 
  assert (HS.modifies_ref st.prf.mac_rgn TSet.empty h0 h1);
  let cipher = Buffer.sub cipher_tagged 0ul plainlen in
  let tag = Buffer.sub cipher_tagged plainlen (Spec.taglen i) in
  let y = PRF.incr i x in
  //calling this lemma allows us to complete the proof without using any fuel;
  //which makes things a a bit faster
  counterblocks_emp i st.prf.mac_rgn y (v plainlen) 0
      (Plain.sel_plain h1 plainlen plain) (Buffer.as_seq h1 cipher);
  counter_enxor i st.prf y plainlen plainlen plain cipher h1;
  // Compute MAC over additional data and ciphertext
  let h2 = get () in
  FStar.Classical.move_requires (Buffer.lemma_reveal_modifies_1 cipher h1) h2;
  assert (HS.modifies_ref st.prf.mac_rgn TSet.empty h0 h2);
  lemma_frame_find_mac #i #(v plainlen) st.prf y cipher h1 h2;
  intro_refines_one_entry_no_tag #i st n (v plainlen) plain cipher_tagged h0 h1 h2; //we have pre_refines_one_entry here
  assert (Buffer.live h1 aad); //seem to need this hint
  let l, acc = accumulate ak aadlen aad plainlen cipher in
  let h3 = get() in
  Buffer.lemma_reveal_modifies_0 h2 h3;
  assert (HS.modifies_ref st.prf.mac_rgn TSet.empty h0 h3);
  frame_pre_refines_0 i st n (v plainlen) plain cipher_tagged h0 h2 h3;
  assert (Buffer.live h2 aad); //seem to need this hint
  assert (Buffer.live h3 aad); //seem to need this hint
  Buffer.lemma_reveal_modifies_0 h2 h3;
  MAC.mac ak l acc tag;
  let h4 = get () in
  FStar.Classical.move_requires (Buffer.lemma_reveal_modifies_1 tag h3) h4;
  modifies_fresh_empty i n st.prf.mac_rgn ak h0 h3 h4;
  assert (safeId i ==> HS.modifies_ref st.prf.mac_rgn TSet.empty h0 h4);
  frame_pre_refines i st n (v plainlen) plain cipher_tagged h0 h3 h4;
  intro_mac_refines i st n aad plain cipher_tagged h4;
  pre_refines_to_refines i st n aadlen aad (v plainlen) plain cipher_tagged h0 h4;
  extend_refines_aux i st n aadlen aad (v plainlen) plain cipher_tagged h0 h4;
  refines_to_inv i st n aadlen aad plainlen plain cipher_tagged;
  (* assert (my_inv st h4); *)
  admit()
  



  (*   live h0 tag /\ live h0 st.s /\ *)
  (*   disjoint acc st.s /\ disjoint tag acc /\ disjoint tag st.r /\ disjoint tag st.s /\ *)
  (*   acc_inv st l acc h0 /\ *)
  (*   (mac_log ==> m_contains (ilog st.log) h0) /\ *)
  (*   (mac_log /\ safeId (fst i) ==> m_sel h0 (ilog st.log) == None))) *)
  (* (ensures (fun h0 _ h1 -> *)
  (*   live h0 st.s /\  *)
  (*   live h0 st.r /\  *)
  (*   live h1 tag /\ ( *)
  (*   if mac_log then *)
  (*     mods_2 [Ref (as_hsref (ilog st.log)); Ref (Buffer.content tag)] h0 h1 /\ *)
  (*     Buffer.modifies_buf_1 (Buffer.frameOf tag) tag h0 h1 /\ *)
  (*     HS.modifies_ref st.region !{HS.as_ref (as_hsref (ilog st.log))} h0 h1 /\ *)
  (*     m_contains (ilog st.log) h1 /\ ( *)
  (*     let mac = mac_1305 l (sel_elem h0 st.r) (sel_word h0 st.s) in *)
  (*     mac == little_endian (sel_word h1 tag) /\ *)
  (*     m_sel h1 (ilog st.log) == Some (l, sel_word h1 tag)) *)
  (*   else Buffer.modifies_1 tag h0 h1))) *)

  
  (* let _ = *)
  (*   let tab = HS.sel h4 (itable i st.prf) in *)
  (*   match PRF.find_mac tab x with *)
  (*   | None -> assert False *)
  (*   | Some mac_st -> assert(mac_st == ak) in *)
  (* admit() *)
  

  (* admit() *)

    
      (*  admit() in *)
       
      (* let c = Buffer.as_seq h4 cipher in *)
      (* let ad = Buffer.as_seq h4 aad in *)
      (* assume (l == field_encode i ad #plainlen c); *)
      (* intro_mac_refines i st n aad plain cipher_tagged h4 in *)

  (*   () in  *)
  (* admit() *)
  


  (* assume (mac_refines i st.prf.mac_rgn (v plainlen) (as_seq h4 aad) (Plain.sel_plain h4 plainLen plain) (Buffer.as_seq tag) _ h4); *)
  (* assume false *)

  
  (* let h4 = get () in  *)
  (* assume (HS (modifies (Set.union (Set.singleton (Buffer.frameOf tag)) *)
  (* 				  (Set.singleton st.prf.mac_rgn)) h3 h4)); *)
  (* assume (Buffer.modifies_buf_1 (Buffer.frameOf tag) tag h3 h4); *)
  (* let _ =  *)
  (*   let mod_set = MAC (if mac_log then !{HS.as_ref (as_hsref (MAC.ilog ak.log))} else !{}) in *)
  (*   assume (HS (modifies_ref st.prf.mac_rgn mod_set h3 h4)) in *)
  (* if safeId i *)
  (* then begin *)
  (*   let aad = temp_to_seq aad in *)
  (*   let p = temp_get_plain plain in *)
  (*   let c = temp_to_seq cipher in *)
  (*   assume false; *)
  (*   let entry = Entry n aad (v plainlen) p c in *)
  (*   st.log := SeqProperties.snoc !st.log entry *)
  (* end; *)
  (* assume false *)
  (* pop_frame() *)
