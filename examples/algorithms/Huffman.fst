module Huffman

open FStar.Char
open FStar.List.Tot

type symbol = char

type trie =
  | Leaf : w:pos -> s:symbol -> trie
  | Node : w:pos -> l:trie -> r:trie -> trie

let weight (t:trie) : Tot pos =
  match t with
  | Leaf w _ -> w
  | Node w _ _ -> w

let leq_trie (t1:trie) (t2:trie) : Tot bool =
  weight t1 <= weight t2

let rec sorted (ts:list trie) : Tot bool=
  match ts with
  | [] | [_] -> true
  | t1::t2::ts' -> (leq_trie t1 t1) && (sorted (t2::ts'))

let rec insert_in_sorted (x:trie) (xs:list trie) : Pure (list trie)
    (requires (b2t (sorted xs)))
    (ensures (fun ys -> sorted ys
           /\ List.Tot.length ys == List.Tot.length xs + 1)) =
  match xs with
  | [] -> [x]
  | x'::xs' -> if weight x < weight x' then (admit(); x :: xs)
               else (admit(); x' :: (insert_in_sorted x xs'))

let rec huffman_trie (ts:list trie) : Pure trie
    (requires (sorted ts /\ List.Tot.length ts > 0))
    (ensures (fun cs -> True)) (decreases (List.Tot.length ts)) =
  match ts with
  | t1::t2::ts' ->
      let w = weight t1 + weight t2 in
      huffman_trie (Node w t1 t2 `insert_in_sorted` ts')
  | [t1] -> t1

let rec encode_one (t:trie) (s:symbol) : Tot (option (list bool)) =
  match t with
  | Leaf _ s' -> if s = s' then Some [] else None
  | Node _ t1 t2 ->
      match encode_one t1 s with
      | Some bs -> Some (false :: bs)
      | None -> match encode_one t2 s with
                | Some bs -> Some (true :: bs)
                | None -> None

// Modulo the option this is flatten (map (encode_one t) ss)
let rec encode (t:trie) (ss:list symbol) : Tot (option (list bool)) =
  match ss with
  | [] -> Some []
  | s::ss' -> match encode_one t s, encode t ss' with
              | Some bs, Some bs' -> Some (bs @ bs')
              | _, _ -> None

let rec decode_one (t:trie) (bs:list bool) : Pure (option (symbol * list bool))
    (requires (True))
    (ensures (fun r -> is_Some r ==>
                   (List.Tot.length (snd (Some.v r)) <= List.Tot.length bs /\
     (is_Node t ==> List.Tot.length (snd (Some.v r)) < List.Tot.length bs)))) =
  match t, bs with
  | Node _ t1 t2, b::bs' -> decode_one (if b then t1 else t2) bs'
  | Leaf _ s, _ -> Some (s, bs)
  | Node _ _ _, [] -> None

let rec decode (t:trie) (bs:list bool) : Pure (option (list symbol))
    (requires (b2t (is_Node t))) (ensures (fun _ -> True))
    (decreases (List.Tot.length bs)) =
  match bs with
  | [] -> Some []
  | _::_ -> match decode_one t bs with
            | Some (s, bs') -> (match decode t bs' with
                                | Some ss -> Some (s :: ss)
                                | None    -> None)
            | _ -> None

// proving this should require prefix freedom
let cancelation (t:trie) (ss:list symbol) : Lemma
  (requires (b2t (is_Node t)))
  (ensures (is_Node t ==>
            (match encode t ss with
            | Some e -> (match decode t e with
                        | Some d -> d = ss
                        | None -> True)
            | None -> True))) = admit()










(* open Platform.Bytes *)

(* val huffman_trie : ss:(list (symbol * pos)) -> Pure trie *)
(*   (requires (b2t (sorted ss))) *)
(*   (ensures (fun cs -> True)) *)

(* assume val trie_to_code : trie -> Tot (list byte) // symbols as well? *)

(* assume val huffman_code : ss:(list (symbol * pos)) -> Pure (list bytes) *)
(*   (requires (b2t (sorted ss))) *)
(*   (ensures (fun cs -> List.Tot.length cs == List.Tot.length ss)) *)

(* val code_length : ss:(list (symbol * pos)) -> cs:(list bytes) -> Pure nat *)
(*   (requires (sorted ss /\ List.Tot.length cs == List.Tot.length ss)) *)
(*   (ensures (fun _ -> True)) *)
(* let code_length ss cs = *)
(*   fold_left2 (fun (a:nat) (sw:symbol*pos) c -> *)
(*               let (s,w) = sw in *)
(*               a + w `op_Multiply` length c) 0 ss cs *)

(* assume val minimality : ss:(list (symbol * pos)) -> cs:list bytes -> Lemma *)
(*   (requires (sorted ss)) -- need more conditions on cs, needs to be an encoding *)
(*   (ensures (code_length ss (huffman_code ss) >= code_length ss cs)) *)




(* Some References:

David A. Huffman. A Method for the Construction of Minimum-Redundancy Codes.
Proc. IRE, pp. 1098-1101, September 1952.
http://compression.ru/download/articles/huff/huffman_1952_minimum-redundancy-codes.pdf

Bird, R., Wadler, P.: Introduction to Functional Programming. Prentice
Hall International Series in Computer Science. Prentice Hall, Hemel
Hempstead, UK (1988). Pages 239--246.
https://usi-pl.github.io/lc/sp-2015/doc/Bird_Wadler.%20Introduction%20to%20Functional%20Programming.1ed.pdf

Jasmin Christian Blanchette.
Proof Pearl: Mechanizing the Textbook Proof of Huffman’s Algorithm.
Journal of Automated Reasoning. June 2009, Volume 43, Issue 1, pp 1–18.
http://people.mpi-inf.mpg.de/~jblanche/jar2009-huffman.pdf
- proves optimality, doesn't even implement encode/decode

Laurent Théry. Formalising Huffman algorithm. 
https://github.com/coq-contribs/huffman
ftp://ftp-sop.inria.fr/marelle/Laurent.Thery/Huffman/Note.pdf
- does include encode/decode

*)
