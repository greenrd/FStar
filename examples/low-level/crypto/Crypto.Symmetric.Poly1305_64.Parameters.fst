module Hacl.Symmetric.Poly1305_64.Parameters

(* Standard platform integer size *)
inline_for_extraction let platform_size : pos = 64
(* Integer size after multiplication *)
inline_for_extraction let platform_wide : pos = 128
(* Canonical number of limbs *)
inline_for_extraction let norm_length : pos = 3
inline_for_extraction let nlength : FStar.UInt32.t = 3ul
(* Canonical number of bytes *)
inline_for_extraction let bytes_length : pos = 17
inline_for_extraction let blength : FStar.UInt32.t = assert_norm (17 < pow2 32); 17ul
(* Representation template *)
inline_for_extraction val templ: nat -> Tot pos
inline_for_extraction let templ = fun x -> 44
