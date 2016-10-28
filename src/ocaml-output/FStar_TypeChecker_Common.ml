
open Prims

type rel =
| EQ
| SUB
| SUBINV


let is_EQ = (fun _discr_ -> (match (_discr_) with
| EQ (_) -> begin
true
end
| _ -> begin
false
end))


let is_SUB = (fun _discr_ -> (match (_discr_) with
| SUB (_) -> begin
true
end
| _ -> begin
false
end))


let is_SUBINV = (fun _discr_ -> (match (_discr_) with
| SUBINV (_) -> begin
true
end
| _ -> begin
false
end))


type ('a, 'b) problem =
{pid : Prims.int; lhs : 'a; relation : rel; rhs : 'a; element : 'b Prims.option; logical_guard : (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term); scope : FStar_Syntax_Syntax.binders; reason : Prims.string Prims.list; loc : FStar_Range.range; rank : Prims.int Prims.option}


let is_Mkproblem = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkproblem"))))


type prob =
| TProb of (FStar_Syntax_Syntax.typ, FStar_Syntax_Syntax.term) problem
| CProb of (FStar_Syntax_Syntax.comp, Prims.unit) problem


let is_TProb = (fun _discr_ -> (match (_discr_) with
| TProb (_) -> begin
true
end
| _ -> begin
false
end))


let is_CProb = (fun _discr_ -> (match (_discr_) with
| CProb (_) -> begin
true
end
| _ -> begin
false
end))


let ___TProb____0 = (fun projectee -> (match (projectee) with
| TProb (_51_17) -> begin
_51_17
end))


let ___CProb____0 = (fun projectee -> (match (projectee) with
| CProb (_51_20) -> begin
_51_20
end))


type probs =
prob Prims.list


type guard_formula =
| Trivial
| NonTrivial of FStar_Syntax_Syntax.formula


let is_Trivial = (fun _discr_ -> (match (_discr_) with
| Trivial (_) -> begin
true
end
| _ -> begin
false
end))


let is_NonTrivial = (fun _discr_ -> (match (_discr_) with
| NonTrivial (_) -> begin
true
end
| _ -> begin
false
end))


let ___NonTrivial____0 = (fun projectee -> (match (projectee) with
| NonTrivial (_51_23) -> begin
_51_23
end))


type deferred =
(Prims.string * prob) Prims.list


type univ_ineq =
(FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.universe)


let tconst : FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun l -> (let _146_83 = (let _146_82 = (FStar_Syntax_Syntax.lid_as_fv l FStar_Syntax_Syntax.Delta_constant None)
in FStar_Syntax_Syntax.Tm_fvar (_146_82))
in (FStar_Syntax_Syntax.mk _146_83 (Some (FStar_Syntax_Util.ktype0.FStar_Syntax_Syntax.n)) FStar_Range.dummyRange)))


let tabbrev : FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun l -> (let _146_87 = (let _146_86 = (FStar_Syntax_Syntax.lid_as_fv l (FStar_Syntax_Syntax.Delta_defined_at_level ((Prims.parse_int "1"))) None)
in FStar_Syntax_Syntax.Tm_fvar (_146_86))
in (FStar_Syntax_Syntax.mk _146_87 (Some (FStar_Syntax_Util.ktype0.FStar_Syntax_Syntax.n)) FStar_Range.dummyRange)))


let t_unit : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (tconst FStar_Syntax_Const.unit_lid)


let t_bool : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (tconst FStar_Syntax_Const.bool_lid)


let t_int : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (tconst FStar_Syntax_Const.int_lid)


let t_string : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (tconst FStar_Syntax_Const.string_lid)


let t_float : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (tconst FStar_Syntax_Const.float_lid)


let t_char : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (tabbrev FStar_Syntax_Const.char_lid)


let t_range : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (tconst FStar_Syntax_Const.range_lid)


let rec delta_depth_greater_than : FStar_Syntax_Syntax.delta_depth  ->  FStar_Syntax_Syntax.delta_depth  ->  Prims.bool = (fun l m -> (match (((l), (m))) with
| (FStar_Syntax_Syntax.Delta_constant, _51_30) -> begin
false
end
| (FStar_Syntax_Syntax.Delta_equational, _51_34) -> begin
true
end
| (_51_37, FStar_Syntax_Syntax.Delta_equational) -> begin
false
end
| (FStar_Syntax_Syntax.Delta_defined_at_level (i), FStar_Syntax_Syntax.Delta_defined_at_level (j)) -> begin
(i > j)
end
| (FStar_Syntax_Syntax.Delta_defined_at_level (_51_46), FStar_Syntax_Syntax.Delta_constant) -> begin
true
end
| (FStar_Syntax_Syntax.Delta_abstract (d), _51_53) -> begin
(delta_depth_greater_than d m)
end
| (_51_56, FStar_Syntax_Syntax.Delta_abstract (d)) -> begin
(delta_depth_greater_than l d)
end))


let rec decr_delta_depth : FStar_Syntax_Syntax.delta_depth  ->  FStar_Syntax_Syntax.delta_depth Prims.option = (fun _51_1 -> (match (_51_1) with
| (FStar_Syntax_Syntax.Delta_constant) | (FStar_Syntax_Syntax.Delta_equational) -> begin
None
end
| FStar_Syntax_Syntax.Delta_defined_at_level (_146_94) when (_146_94 = (Prims.parse_int "1")) -> begin
Some (FStar_Syntax_Syntax.Delta_constant)
end
| FStar_Syntax_Syntax.Delta_defined_at_level (i) -> begin
Some (FStar_Syntax_Syntax.Delta_defined_at_level ((i - (Prims.parse_int "1"))))
end
| FStar_Syntax_Syntax.Delta_abstract (d) -> begin
(decr_delta_depth d)
end))




