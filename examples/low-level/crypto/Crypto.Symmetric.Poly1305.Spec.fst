module Crypto.Symmetric.Poly1305.Spec

(* Just the mathematical specification,
   used in the probabilistic security assumption,
   aiming for a generic group *)

open FStar.Mul
open FStar.Ghost
open FStar.Seq

(** Machine integers *)
open FStar.UInt8
open FStar.UInt64
open FStar.Int.Cast

(** Mathematical definitions *)
open FStar.Math.Lib
open FStar.Math.Lemmas
open Crypto.Symmetric.Bytes 

module U8  = FStar.UInt8
module U32 = FStar.UInt32
module U64 = FStar.UInt64

#reset-options "--initial_fuel 4 --max_fuel 4"

// prime (do we prove it? use it?)
let p_1305: p:nat{pow2 128 < p} =
  assert_norm (pow2 128 < pow2 130 - 5);
  pow2 130 - 5

#reset-options

type elem = n:nat{n < p_1305} // elements of the field Z / p_1305 Z

type word = b:seq byte {Seq.length b <= 16}
type word_16 = b:seq byte {Seq.length b = 16}
// we only use full words for AEAD

type text = seq elem // not word_16
type tag = word_16
let taglen 'id = 16ul

(* * *********************************************)
(* *            Field operations                 *)
(* * *********************************************)
val field_add: elem -> elem -> Tot elem
let field_add a b = (a + b) % p_1305
val field_mul: elem -> elem -> Tot elem
let field_mul a b = (a * b) % p_1305

(* Infix field operators for readability *)
let op_Plus_At = field_add
let op_Star_At = field_mul




(* REST OF THE FILE TO BE RESHUFFLED OR DELETED,
   PARTLY COPIED TO BUFFER.UTIL OR ENCODING *)

(* * *********************************************)
(* *            Encoding                         *)
(* * *********************************************)

let encode (w:word) : Tot elem =
  let l = length w in
  pow2_le_compat 128 (8 * l);
  pow2 (8 * l) +@ little_endian w

// a spec for encoding and padding, convenient for injectivity proof
// TODO: Unused now
let pad_0 b l = Seq.append b (Seq.create l 0uy)

val encode_pad: prefix:Seq.seq elem -> txt:Seq.seq UInt8.t -> GTot (Seq.seq elem) 
  (decreases (Seq.length txt))
let rec encode_pad prefix txt =
  let l = Seq.length txt in
  if l = 0 then prefix
  else if l < 16 then
    let w = txt in
    SeqProperties.snoc prefix (encode w)
  else
    begin
    let w, txt = SeqProperties.split txt 16 in
    let prefix = SeqProperties.snoc prefix (encode w) in
    encode_pad prefix txt
    end


let trunc_1305 (e:elem) : Tot elem = e % pow2 128

(* * *********************************************)
(* *          Encoding-related lemmas            *)
(* * *********************************************)

#reset-options "--initial_fuel 1 --max_fuel 1 --initial_ifuel 0 --max_ifuel 0"


val lemma_pad_0_injective: b0:Seq.seq UInt8.t -> b1:Seq.seq UInt8.t -> l:nat -> Lemma
  (requires (pad_0 b0 l == pad_0 b1 l))
  (ensures  (b0 == b1))
let lemma_pad_0_injective b0 b1 l =
  SeqProperties.lemma_append_inj b0 (Seq.create l 0uy) b1 (Seq.create l 0uy);
  Seq.lemma_eq_intro b0 b1

val lemma_encode_injective: w0:word -> w1:word -> Lemma
  (requires (length w0 == length w1 /\ encode w0 == encode w1))
  (ensures  (w0 == w1))
let lemma_encode_injective w0 w1 =
  let l = length w0 in
  lemma_little_endian_is_bounded w0;
  lemma_little_endian_is_bounded w1;
  pow2_le_compat 128 (8 * l);
  lemma_mod_plus_injective p_1305 (pow2 (8 * l))
    (little_endian w0) (little_endian w1);
  assert (little_endian w0 == little_endian w1);
  Seq.lemma_eq_intro (Seq.slice w0 0 l) w0;
  Seq.lemma_eq_intro (Seq.slice w1 0 l) w1;
  lemma_little_endian_is_injective w0 w1 l

val lemma_encode_pad_injective: p0:Seq.seq elem -> t0:Seq.seq UInt8.t -> p1:Seq.seq elem -> t1:Seq.seq UInt8.t -> Lemma
  (requires length t0 == length t1 /\ encode_pad p0 t0 == encode_pad p1 t1)
  (ensures  p0 == p1 /\ t0 == t1)
  (decreases (Seq.length t0))
let rec lemma_encode_pad_injective p0 t0 p1 t1 =
  let l = Seq.length t0 in
  if l = 0 then Seq.lemma_eq_intro t0 t1
  else if l < 16 then
    begin
    SeqProperties.lemma_append_inj
      p0 (Seq.create 1 (encode t0))
      p1 (Seq.create 1 (encode t1));
    lemma_index_create 1 (encode t0) 0;
    lemma_index_create 1 (encode t1) 0;
    lemma_encode_injective t0 t1
    end
  else
    begin
    let w0, t0' = SeqProperties.split_eq t0 16 in
    let w1, t1' = SeqProperties.split_eq t1 16 in
    let p0' = SeqProperties.snoc p0 (encode w0) in
    let p1' = SeqProperties.snoc p1 (encode w1) in
    assert (encode_pad p0' t0' == encode_pad p1' t1');
    lemma_encode_pad_injective p0' t0' p1' t1';
    SeqProperties.lemma_append_inj
      p0 (Seq.create 1 (encode w0))
      p1 (Seq.create 1 (encode w1));
    lemma_index_create 1 (encode w0) 0;
    lemma_index_create 1 (encode w1) 0;
    lemma_encode_injective w0 w1
    end

val encode_pad_empty: prefix:Seq.seq elem -> txt:Seq.seq UInt8.t -> Lemma
  (requires Seq.length txt == 0)
  (ensures  encode_pad prefix txt == prefix)
let encode_pad_empty prefix txt = ()

val encode_pad_snoc: prefix:Seq.seq elem -> txt:Seq.seq UInt8.t -> w:word_16 -> Lemma
  (encode_pad (SeqProperties.snoc prefix (encode w)) txt ==
   encode_pad prefix (append w txt))
let encode_pad_snoc prefix txt w =
  Seq.lemma_len_append w txt;
  assert (16 <= Seq.length (append w txt));
  let w', txt' = SeqProperties.split (append w txt) 16 in
  let prefix' = SeqProperties.snoc prefix (encode w') in
  Seq.lemma_eq_intro w w';
  Seq.lemma_eq_intro txt txt'

(* * *********************************************)
(* *        Poly1305 functional invariant        *)
(* * *********************************************)

let seq_head (vs:seq 'a {Seq.length vs > 0}) = Seq.slice vs 0 (Seq.length vs - 1)

val poly: vs:seq elem -> r:elem -> Tot (a:elem) (decreases (Seq.length vs))
let rec poly vs r =
  if Seq.length vs = 0 then 0
  else (poly (seq_head vs) r +@ Seq.index vs (length vs - 1)) *@ r

(* the definition above captures what POLY1305 does, 
   not the usual polynomial computation; 
   it may be more natural to flip the sequence, 
   so that the coefficients are aligned. 
   (i.e. a_0::a_1::a_2 stands for a_0 + a_1 X + a_2 X^2 , is implicitly extended with 0s.) *)

val poly': vs:seq elem -> r:elem -> Tot (a:elem) (decreases (Seq.length vs))
let rec poly' vs r =
  if Seq.length vs = 0 then 0
  else (SeqProperties.head vs +@ poly' (SeqProperties.tail vs) r ) *@ r

val eq_poly0: p:seq elem -> Tot bool (decreases (length p)) 
let rec eq_poly0 p = 
  Seq.length p = 0 || 
  (SeqProperties.head p = 0 && eq_poly0 (SeqProperties.tail p))
  
val eq_poly: p0:seq elem -> p1:seq elem -> Tot bool (decreases (length p0))
let rec eq_poly p0 p1 = 
  if Seq.length p0 = 0 then eq_poly0 p1 
  else if Seq.length p1 = 0 then eq_poly0 p0
  else SeqProperties.head p0 = SeqProperties.head p1 && eq_poly (SeqProperties.tail p0) (SeqProperties.tail p1)

#set-options "--lax"
private let rec lemma_sane_eq_poly0 (p:seq elem) (r:elem) : Lemma
  (requires eq_poly0 p)
  (ensures (poly' p r = 0)) (decreases (Seq.length p)) = 
  if Seq.length p = 0 then () 
  else if SeqProperties.head p = 0 then lemma_sane_eq_poly0 (SeqProperties.tail p) r
#reset-options "--z3timeout 1000"
private let rec lemma_sane_eq_poly (p0:seq elem) (p1:seq elem) (r:elem) : Lemma
  (requires eq_poly p0 p1)
  (ensures (poly' p0 r = poly' p1 r)) (decreases (Seq.length p0)) = 
  if Seq.length p0 = 0 then lemma_sane_eq_poly0 p1 r 
  else if Seq.length p1 = 0 then lemma_sane_eq_poly0 p0 r
  else lemma_sane_eq_poly (SeqProperties.tail p0) (SeqProperties.tail p1) r


//16-10-15 to stay close to the paper, we may apply "encode" in the poly specification

private let fix (r:word_16) (i:nat {i < 16}) m : Tot word_16 =
  Seq.upd r i (U8 (Seq.index r i &^ m))

// an abstract spec of clamping for our state invariant
// for our polynomial-sampling assumption,
// we rely solely on the number of fixed bits (22, right?)
val clamp: word_16 -> Tot elem
let clamp r =
  let r = fix r  3  15uy in // 0000****
  let r = fix r  7  15uy in
  let r = fix r 11  15uy in
  let r = fix r 15  15uy in
  let r = fix r  4 252uy in // ******00
  let r = fix r  8 252uy in
  let r = fix r 12 252uy in
  little_endian r

(** REMARK: this is equivalent to (poly vs r + little_endian s) % pow2 128 *)
val mac_1305: vs:seq elem -> r:elem -> s:seq byte -> GTot int
let mac_1305 vs r s = (trunc_1305 (poly vs r) + little_endian s) % pow2 128
