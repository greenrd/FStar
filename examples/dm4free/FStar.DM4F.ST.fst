module FStar.DM4F.ST

(**********************************************************
 * Dijkstra Monads for Free : Simple state
 *
 * A minimal example of defining a state effect along
 * with actions, over a parametrized state type.
 *
 **********************************************************)

(* The underlying representation type *)
let st (s:Type) (a:Type) = s -> M (a * s)

(* Monad definition *)
let return_st (s:Type) (a:Type) (x:a) : st s a = fun s0 -> x, s0

let bind_st (s:Type) (a:Type) (b:Type) (f:st s a) (g:a -> st s b) : st s b
  = fun s0 -> let (x,s) = f s0 in g x s
  (* = fun s0 -> let x, s1 = f s0 in g x s1 *)

(* Actions *)
let get (s:Type) () : st s s = fun s0 -> s0, s0

let put (s:Type) (x:s) : st s unit = fun _ -> (), x

(*
 * Do the DM4F work. Note that the heap type is a parameter
 * of the resulting effect.
 *)
total reifiable reflectable new_effect_for_free {
  STATE_h (s:Type) : a:Type -> Effect
  with repr     = st s
     ; bind     = bind_st s
     ; return   = return_st s
  and effect_actions
       get      = get s
     ; put      = put s
}

// Works fine
//let repr0 = STATE_h.repr int

// I would expect STATE.get to have type (s:Type) -> unit -> STATE s int
// but this is not a valid type in F* (the effect is depedent on the input type s)
// In current F*, we need to create a new applied effect in order to use this definition
// i.e. new_effect_for_free STATE_int = STATE_h int
