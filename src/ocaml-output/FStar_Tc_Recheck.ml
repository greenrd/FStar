
open Prims

let oktype : FStar_Absyn_Syntax.knd Prims.option = Some (FStar_Absyn_Syntax.ktype)


let t_unit : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.unit_lid FStar_Absyn_Syntax.ktype)))


let t_bool : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.bool_lid FStar_Absyn_Syntax.ktype)))


let t_int : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.int_lid FStar_Absyn_Syntax.ktype)))


let t_int8 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.int8_lid FStar_Absyn_Syntax.ktype)))


let t_uint8 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.uint8_lid FStar_Absyn_Syntax.ktype)))


let t_int16 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.int16_lid FStar_Absyn_Syntax.ktype)))


let t_uint16 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.uint16_lid FStar_Absyn_Syntax.ktype)))


let t_int32 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.int32_lid FStar_Absyn_Syntax.ktype)))


let t_uint32 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.uint32_lid FStar_Absyn_Syntax.ktype)))


let t_int64 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.int64_lid FStar_Absyn_Syntax.ktype)))


let t_uint64 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.uint64_lid FStar_Absyn_Syntax.ktype)))


let t_string : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.string_lid FStar_Absyn_Syntax.ktype)))


let t_float : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.float_lid FStar_Absyn_Syntax.ktype)))


let t_char : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.char_lid FStar_Absyn_Syntax.ktype)))


let typing_const : FStar_Range.range  ->  FStar_Const.sconst  ->  FStar_Absyn_Syntax.typ = (fun r s -> (match (s) with
| FStar_Const.Const_unit -> begin
t_unit
end
| FStar_Const.Const_bool (_41_5) -> begin
t_bool
end
| FStar_Const.Const_int (_41_8, None) -> begin
t_int
end
| FStar_Const.Const_int (_41_13, Some (FStar_Const.Unsigned, FStar_Const.Int8)) -> begin
t_uint8
end
| FStar_Const.Const_int (_41_21, Some (FStar_Const.Signed, FStar_Const.Int8)) -> begin
t_int8
end
| FStar_Const.Const_int (_41_29, Some (FStar_Const.Unsigned, FStar_Const.Int16)) -> begin
t_uint16
end
| FStar_Const.Const_int (_41_37, Some (FStar_Const.Signed, FStar_Const.Int16)) -> begin
t_int16
end
| FStar_Const.Const_int (_41_45, Some (FStar_Const.Unsigned, FStar_Const.Int32)) -> begin
t_uint32
end
| FStar_Const.Const_int (_41_53, Some (FStar_Const.Signed, FStar_Const.Int32)) -> begin
t_int32
end
| FStar_Const.Const_int (_41_61, Some (FStar_Const.Unsigned, FStar_Const.Int64)) -> begin
t_uint64
end
| FStar_Const.Const_int (_41_69, Some (FStar_Const.Signed, FStar_Const.Int64)) -> begin
t_int64
end
| FStar_Const.Const_string (_41_77) -> begin
t_string
end
| FStar_Const.Const_float (_41_80) -> begin
t_float
end
| FStar_Const.Const_char (_41_83) -> begin
t_char
end
| _41_86 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unsupported constant"), (r)))))
end))


let rec recompute_kind : (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax = (fun t -> (

let recompute = (fun t -> (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_delayed (_41_91) -> begin
(let _136_40 = (FStar_Absyn_Util.compress_typ t)
in (recompute_kind _136_40))
end
| FStar_Absyn_Syntax.Typ_btvar (a) -> begin
a.FStar_Absyn_Syntax.sort
end
| FStar_Absyn_Syntax.Typ_const (tc) -> begin
(match (tc.FStar_Absyn_Syntax.sort.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Kind_unknown -> begin
(let _136_42 = (let _136_41 = (FStar_Absyn_Print.typ_to_string t)
in (FStar_Util.format1 "UNKNOWN KIND FOR %s" _136_41))
in (FStar_All.failwith _136_42))
end
| _41_99 -> begin
tc.FStar_Absyn_Syntax.sort
end)
end
| (FStar_Absyn_Syntax.Typ_fun (_)) | (FStar_Absyn_Syntax.Typ_refine (_)) -> begin
FStar_Absyn_Syntax.ktype
end
| (FStar_Absyn_Syntax.Typ_ascribed (_, k)) | (FStar_Absyn_Syntax.Typ_uvar (_, k)) -> begin
k
end
| (FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_labeled (_))) | (FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_slack_formula (_))) | (FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_pattern (_))) -> begin
FStar_Absyn_Syntax.ktype
end
| FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_named (t, _41_129)) -> begin
(recompute_kind t)
end
| FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_refresh_label (t, _41_135, _41_137)) -> begin
(recompute_kind t)
end
| FStar_Absyn_Syntax.Typ_lam (binders, body) -> begin
(let _136_44 = (let _136_43 = (recompute_kind body)
in ((binders), (_136_43)))
in (FStar_Absyn_Syntax.mk_Kind_arrow _136_44 t.FStar_Absyn_Syntax.pos))
end
| FStar_Absyn_Syntax.Typ_app (t1, args) -> begin
(match (t1.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_const (tc) when ((((FStar_Absyn_Syntax.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.forall_lid) || (FStar_Absyn_Syntax.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.exists_lid)) || (FStar_Absyn_Syntax.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.allTyp_lid)) || (FStar_Absyn_Syntax.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.exTyp_lid)) -> begin
FStar_Absyn_Syntax.ktype
end
| _41_152 -> begin
(

let k1 = (recompute_kind t1)
in (

let _41_156 = (FStar_Absyn_Util.kind_formals k1)
in (match (_41_156) with
| (bs, k) -> begin
(

let rec aux = (fun subst bs args -> (match (((bs), (args))) with
| ([], []) -> begin
(FStar_Absyn_Util.subst_kind subst k)
end
| (_41_165, []) -> begin
(let _136_51 = (FStar_Absyn_Syntax.mk_Kind_arrow ((bs), (k)) t.FStar_Absyn_Syntax.pos)
in (FStar_All.pipe_right _136_51 (FStar_Absyn_Util.subst_kind subst)))
end
| ((b)::bs, (a)::args) -> begin
(

let subst = (let _136_52 = (FStar_Absyn_Util.subst_formal b a)
in (_136_52)::subst)
in (aux subst bs args))
end
| _41_177 -> begin
(let _136_58 = (let _136_57 = (FStar_Range.string_of_range t.FStar_Absyn_Syntax.pos)
in (let _136_56 = (FStar_Absyn_Print.kind_to_string k1)
in (let _136_55 = (FStar_Absyn_Print.tag_of_typ t)
in (let _136_54 = (FStar_Absyn_Print.kind_to_string k)
in (let _136_53 = (FStar_All.pipe_right (FStar_List.length args) FStar_Util.string_of_int)
in (FStar_Util.format5 "(%s) HEAD KIND is %s\nToo many arguments in type %s; result kind is %s\nwith %s remaining args\n" _136_57 _136_56 _136_55 _136_54 _136_53))))))
in (FStar_All.failwith _136_58))
end))
in (aux [] bs args))
end)))
end)
end
| FStar_Absyn_Syntax.Typ_unknown -> begin
FStar_Absyn_Syntax.kun
end))
in (match ((FStar_ST.read t.FStar_Absyn_Syntax.tk)) with
| Some (k) -> begin
k
end
| None -> begin
(

let k = (recompute t)
in (

let _41_183 = (FStar_ST.op_Colon_Equals t.FStar_Absyn_Syntax.tk (Some (k)))
in k))
end)))


let rec recompute_typ : FStar_Absyn_Syntax.exp  ->  FStar_Absyn_Syntax.typ = (fun e -> (

let recompute = (fun e -> (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_delayed (_41_189) -> begin
(let _136_63 = (FStar_Absyn_Util.compress_exp e)
in (recompute_typ _136_63))
end
| FStar_Absyn_Syntax.Exp_bvar (x) -> begin
x.FStar_Absyn_Syntax.sort
end
| FStar_Absyn_Syntax.Exp_fvar (f, _41_195) -> begin
f.FStar_Absyn_Syntax.sort
end
| FStar_Absyn_Syntax.Exp_constant (s) -> begin
(typing_const e.FStar_Absyn_Syntax.pos s)
end
| FStar_Absyn_Syntax.Exp_abs (bs, body) -> begin
(let _136_66 = (let _136_65 = (let _136_64 = (recompute_typ body)
in (FStar_Absyn_Syntax.mk_Total _136_64))
in ((bs), (_136_65)))
in (FStar_Absyn_Syntax.mk_Typ_fun _136_66 None e.FStar_Absyn_Syntax.pos))
end
| FStar_Absyn_Syntax.Exp_app (head, args) -> begin
(

let t1 = (recompute_typ head)
in (match ((FStar_Absyn_Util.function_formals t1)) with
| None -> begin
FStar_Absyn_Syntax.tun
end
| Some (bs, c) -> begin
(

let rec aux = (fun subst bs args -> (match (((bs), (args))) with
| ([], []) -> begin
(FStar_Absyn_Util.subst_typ subst (FStar_Absyn_Util.comp_result c))
end
| (_41_222, []) -> begin
(let _136_73 = (FStar_Absyn_Syntax.mk_Typ_fun ((bs), (c)) None e.FStar_Absyn_Syntax.pos)
in (FStar_All.pipe_right _136_73 (FStar_Absyn_Util.subst_typ subst)))
end
| ((b)::bs, (a)::args) -> begin
(

let subst = (let _136_74 = (FStar_Absyn_Util.subst_formal b a)
in (_136_74)::subst)
in (aux subst bs args))
end
| _41_234 -> begin
(FStar_All.failwith "Too many arguments")
end))
in (aux [] bs args))
end))
end
| FStar_Absyn_Syntax.Exp_match (_41_236) -> begin
(FStar_All.failwith "Expect match nodes to be annotated already")
end
| FStar_Absyn_Syntax.Exp_ascribed (_41_239, t, _41_242) -> begin
t
end
| FStar_Absyn_Syntax.Exp_let (_41_246, e) -> begin
(recompute_typ e)
end
| FStar_Absyn_Syntax.Exp_uvar (_41_251, t) -> begin
t
end
| FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared (e, _41_257)) -> begin
(recompute_typ e)
end))
in (match ((FStar_ST.read e.FStar_Absyn_Syntax.tk)) with
| Some (t) -> begin
t
end
| None -> begin
(

let t = (recompute e)
in (

let _41_265 = (FStar_ST.op_Colon_Equals e.FStar_Absyn_Syntax.tk (Some (t)))
in t))
end)))




