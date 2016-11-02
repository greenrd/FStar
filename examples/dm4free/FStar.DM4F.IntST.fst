module FStar.DM4F.IntST

open FStar.DM4F.ST

// A simple variant of state with a single integer as the state
// Here is where all the DM4F magic happens
reifiable reflectable new_effect_for_free STINT = STATE_h int
// Some abbreviations
let repr = STINT.repr
let post = STINT.post
let pre = STINT.pre
let wp = STINT.wp

// We define a lift between PURE and STINT
//    -- this is analogous to the return for the monad
//    -- but automatically wiring the return here is not done yet
unfold let lift_pure_stint (a:Type) (wp:pure_wp a) (n:int) (p:post a) =
  wp (fun a -> p (a, n))
sub_effect PURE ~> STINT = lift_pure_stint

// We define an effect abbreviation for using pre-post conditions
effect StInt (a:Type) (pre: pre) (post: (int -> a -> int -> GTot Type0)) =
  STINT a (fun n0 p -> pre n0 /\
            (forall a n1. pre n0 /\ post n0 a n1 ==> p (a, n1)))

// Another effect abbreviation for the trivial pre-post conditions
effect StNull (a:Type) =
  STINT a (fun (n0:int) (p:(a * int) -> Type0) -> forall (x:(a * int)). p x)

// We define an increment function that we verify intrinsically

val incr_intrinsic : unit -> StInt unit (requires (fun n -> True))
                             (ensures (fun n0 _ n1 -> n1 = n0 + 1))
let incr_intrinsic u =
  let n = STINT.get () in
  STINT.put (n + 1)

// Here is a weaker specification for increment

val incr_intrinsic' : unit -> STINT unit
  (fun s0 post -> forall (s1:int). (s1 > s0) ==> post ((), s1))
let incr_intrinsic' u =
  let n = STINT.get () in
  STINT.put (n + 1)

// Or, we can give increment the weakest possible spec and prove
// properties extrinsically (after the fact) using reification

reifiable val incr : unit -> StNull unit
let incr u =
  let n = STINT.get() in
  STINT.put (n + 1)

let incr_increases (s0:int) = assert (snd (reify (incr ()) s0) = s0 + 1)

(* Using this extrinsic style we can also prove information-flow
   control properties of increment and decrement *)

reifiable let decr () : StNull unit =
  let n = STINT.get () in
  STINT.put (n - 1)

reifiable let ifc (h:bool) : StNull int =
  if h then (incr(); let y = STINT.get() in decr(); y)
       else STINT.get() + 1

let ni_ifc = assert (forall h0 h1 s0. reify (ifc h0) s0 = reify (ifc h1) s0)

// Although we have STINT.get and STINT.put now as actions,
// we can also "rederive" them using reflection

val action_get: (u:unit) -> repr int (fun n post -> post (n, n))
let action_get () i = (i, i)

val action_put: x:int -> repr unit (fun n post -> post ((), x))
let action_put x i = ((), x)

reifiable val get' : unit -> STINT int (fun z post -> post (z, z))
let get' () = STINT.reflect (action_get ())

reifiable val put': x:int -> STINT unit (fun z post -> post ((), x))
let put' x = STINT.reflect (action_put x)

let assert_after_reify (_:unit) : StNull unit =
  let n0 = STINT.get() in
  let _, n1 = reify (incr ()) n0 in
  assert (n1 = n0 + 1);
  STINT.put n1

val assert_after_reflect : unit -> StNull int
let assert_after_reflect u =
  let n0 = STINT.get () in
  put' (n0 + 2);
  let n1 = STINT.get () in
  assert (n0 + 2 = n1);
  n1

val reflect_on_the_fly : unit -> StNull int
let reflect_on_the_fly u =
  let n0 = STINT.get () in
  let add_two : repr unit (fun n post -> post ((), n + 2)) =
    //need this annotation, since reflect doesn't insert a M.return; but it should
    fun n0 -> (), n0+2 in
  STINT.reflect add_two;
  let n1 = STINT.get () in
  assert (n0 + 2 = n1);
  n1
