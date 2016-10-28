
open Prims

type ident =
FStar_Ident.ident


type lident =
FStar_Ident.lid


exception Err of (Prims.string)


let is_Err = (fun _discr_ -> (match (_discr_) with
| Err (_) -> begin
true
end
| _ -> begin
false
end))


let ___Err____0 = (fun projectee -> (match (projectee) with
| Err (_28_7) -> begin
_28_7
end))


exception Error of ((Prims.string * FStar_Range.range))


let is_Error = (fun _discr_ -> (match (_discr_) with
| Error (_) -> begin
true
end
| _ -> begin
false
end))


let ___Error____0 = (fun projectee -> (match (projectee) with
| Error (_28_9) -> begin
_28_9
end))


exception Warning of ((Prims.string * FStar_Range.range))


let is_Warning = (fun _discr_ -> (match (_discr_) with
| Warning (_) -> begin
true
end
| _ -> begin
false
end))


let ___Warning____0 = (fun projectee -> (match (projectee) with
| Warning (_28_11) -> begin
_28_11
end))


type ('a, 't) withinfo_t =
{v : 'a; sort : 't; p : FStar_Range.range}


let is_Mkwithinfo_t = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkwithinfo_t"))))


type 't var =
(lident, 't) withinfo_t


type fieldname =
lident


type 'a bvdef =
{ppname : ident; realname : ident}


let is_Mkbvdef = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkbvdef"))))


type ('a, 't) bvar =
('a bvdef, 't) withinfo_t


type sconst =
FStar_Const.sconst


type pragma =
| SetOptions of Prims.string
| ResetOptions of Prims.string Prims.option


let is_SetOptions = (fun _discr_ -> (match (_discr_) with
| SetOptions (_) -> begin
true
end
| _ -> begin
false
end))


let is_ResetOptions = (fun _discr_ -> (match (_discr_) with
| ResetOptions (_) -> begin
true
end
| _ -> begin
false
end))


let ___SetOptions____0 = (fun projectee -> (match (projectee) with
| SetOptions (_28_27) -> begin
_28_27
end))


let ___ResetOptions____0 = (fun projectee -> (match (projectee) with
| ResetOptions (_28_30) -> begin
_28_30
end))


type 'a memo =
'a Prims.option FStar_ST.ref


type arg_qualifier =
| Implicit of Prims.bool
| Equality


let is_Implicit = (fun _discr_ -> (match (_discr_) with
| Implicit (_) -> begin
true
end
| _ -> begin
false
end))


let is_Equality = (fun _discr_ -> (match (_discr_) with
| Equality (_) -> begin
true
end
| _ -> begin
false
end))


let ___Implicit____0 = (fun projectee -> (match (projectee) with
| Implicit (_28_34) -> begin
_28_34
end))


type aqual =
arg_qualifier Prims.option


type typ' =
| Typ_btvar of btvar
| Typ_const of ftvar
| Typ_fun of (binders * comp)
| Typ_refine of (bvvar * typ)
| Typ_app of (typ * args)
| Typ_lam of (binders * typ)
| Typ_ascribed of (typ * knd)
| Typ_meta of meta_t
| Typ_uvar of (uvar_t * knd)
| Typ_delayed of (((typ * subst_t), Prims.unit  ->  typ) FStar_Util.either * typ memo)
| Typ_unknown 
 and comp_typ =
{effect_name : lident; result_typ : typ; effect_args : args; flags : cflags Prims.list} 
 and comp' =
| Total of typ
| Comp of comp_typ 
 and cflags =
| TOTAL
| MLEFFECT
| RETURN
| PARTIAL_RETURN
| SOMETRIVIAL
| LEMMA
| DECREASES of exp 
 and meta_t =
| Meta_pattern of (typ * arg Prims.list Prims.list)
| Meta_named of (typ * lident)
| Meta_labeled of (typ * Prims.string * FStar_Range.range * Prims.bool)
| Meta_refresh_label of (typ * Prims.bool Prims.option * FStar_Range.range)
| Meta_slack_formula of (typ * typ * Prims.bool FStar_ST.ref) 
 and 'a uvar_basis =
| Uvar
| Fixed of 'a 
 and exp' =
| Exp_bvar of bvvar
| Exp_fvar of (fvvar * fv_qual Prims.option)
| Exp_constant of sconst
| Exp_abs of (binders * exp)
| Exp_app of (exp * args)
| Exp_match of (exp * (pat * exp Prims.option * exp) Prims.list)
| Exp_ascribed of (exp * typ * lident Prims.option)
| Exp_let of (letbindings * exp)
| Exp_uvar of (uvar_e * typ)
| Exp_delayed of (exp * subst_t * exp memo)
| Exp_meta of meta_e 
 and meta_e =
| Meta_desugared of (exp * meta_source_info) 
 and meta_source_info =
| Data_app
| Sequence
| Primop
| Masked_effect
| Meta_smt_pat 
 and fv_qual =
| Data_ctor
| Record_projector of lident
| Record_ctor of (lident * fieldname Prims.list) 
 and pat' =
| Pat_disj of pat Prims.list
| Pat_constant of sconst
| Pat_cons of (fvvar * fv_qual Prims.option * (pat * Prims.bool) Prims.list)
| Pat_var of bvvar
| Pat_tvar of btvar
| Pat_wild of bvvar
| Pat_twild of btvar
| Pat_dot_term of (bvvar * exp)
| Pat_dot_typ of (btvar * typ) 
 and knd' =
| Kind_type
| Kind_effect
| Kind_abbrev of (kabbrev * knd)
| Kind_arrow of (binders * knd)
| Kind_uvar of uvar_k_app
| Kind_lam of (binders * knd)
| Kind_delayed of (knd * subst_t * knd memo)
| Kind_unknown 
 and letbinding =
{lbname : lbname; lbtyp : typ; lbeff : lident; lbdef : exp} 
 and freevars =
{ftvs : btvar FStar_Util.set; fxvs : bvvar FStar_Util.set} 
 and uvars =
{uvars_k : uvar_k FStar_Util.set; uvars_t : (uvar_t * knd) FStar_Util.set; uvars_e : (uvar_e * typ) FStar_Util.set} 
 and ('a, 'b) syntax =
{n : 'a; tk : 'b memo; pos : FStar_Range.range; fvs : freevars memo; uvs : uvars memo} 
 and arg =
((typ, exp) FStar_Util.either * aqual) 
 and args =
arg Prims.list 
 and binder =
((btvar, bvvar) FStar_Util.either * arg_qualifier Prims.option) 
 and binders =
binder Prims.list 
 and typ =
(typ', knd) syntax 
 and comp =
(comp', Prims.unit) syntax 
 and uvar_t =
typ uvar_basis FStar_Unionfind.uvar 
 and exp =
(exp', typ) syntax 
 and uvar_e =
exp uvar_basis FStar_Unionfind.uvar 
 and btvdef =
typ bvdef 
 and bvvdef =
exp bvdef 
 and pat =
(pat', (knd, typ) FStar_Util.either Prims.option) withinfo_t 
 and knd =
(knd', Prims.unit) syntax 
 and uvar_k_app =
(uvar_k * args) 
 and kabbrev =
(lident * args) 
 and uvar_k =
knd uvar_basis FStar_Unionfind.uvar 
 and lbname =
(bvvdef, lident) FStar_Util.either 
 and letbindings =
(Prims.bool * letbinding Prims.list) 
 and subst_t =
subst_elt Prims.list Prims.list 
 and subst_map =
(typ, exp) FStar_Util.either FStar_Util.smap 
 and subst_elt =
((btvdef * typ), (bvvdef * exp)) FStar_Util.either 
 and fvar =
(btvdef, bvvdef) FStar_Util.either 
 and btvar =
(typ, knd) bvar 
 and bvvar =
(exp, typ) bvar 
 and ftvar =
knd var 
 and fvvar =
typ var


let is_Typ_btvar = (fun _discr_ -> (match (_discr_) with
| Typ_btvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_const = (fun _discr_ -> (match (_discr_) with
| Typ_const (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_fun = (fun _discr_ -> (match (_discr_) with
| Typ_fun (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_refine = (fun _discr_ -> (match (_discr_) with
| Typ_refine (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_app = (fun _discr_ -> (match (_discr_) with
| Typ_app (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_lam = (fun _discr_ -> (match (_discr_) with
| Typ_lam (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_ascribed = (fun _discr_ -> (match (_discr_) with
| Typ_ascribed (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_meta = (fun _discr_ -> (match (_discr_) with
| Typ_meta (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_uvar = (fun _discr_ -> (match (_discr_) with
| Typ_uvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_delayed = (fun _discr_ -> (match (_discr_) with
| Typ_delayed (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_unknown = (fun _discr_ -> (match (_discr_) with
| Typ_unknown (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mkcomp_typ : comp_typ  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkcomp_typ"))))


let is_Total = (fun _discr_ -> (match (_discr_) with
| Total (_) -> begin
true
end
| _ -> begin
false
end))


let is_Comp = (fun _discr_ -> (match (_discr_) with
| Comp (_) -> begin
true
end
| _ -> begin
false
end))


let is_TOTAL = (fun _discr_ -> (match (_discr_) with
| TOTAL (_) -> begin
true
end
| _ -> begin
false
end))


let is_MLEFFECT = (fun _discr_ -> (match (_discr_) with
| MLEFFECT (_) -> begin
true
end
| _ -> begin
false
end))


let is_RETURN = (fun _discr_ -> (match (_discr_) with
| RETURN (_) -> begin
true
end
| _ -> begin
false
end))


let is_PARTIAL_RETURN = (fun _discr_ -> (match (_discr_) with
| PARTIAL_RETURN (_) -> begin
true
end
| _ -> begin
false
end))


let is_SOMETRIVIAL = (fun _discr_ -> (match (_discr_) with
| SOMETRIVIAL (_) -> begin
true
end
| _ -> begin
false
end))


let is_LEMMA = (fun _discr_ -> (match (_discr_) with
| LEMMA (_) -> begin
true
end
| _ -> begin
false
end))


let is_DECREASES = (fun _discr_ -> (match (_discr_) with
| DECREASES (_) -> begin
true
end
| _ -> begin
false
end))


let is_Meta_pattern = (fun _discr_ -> (match (_discr_) with
| Meta_pattern (_) -> begin
true
end
| _ -> begin
false
end))


let is_Meta_named = (fun _discr_ -> (match (_discr_) with
| Meta_named (_) -> begin
true
end
| _ -> begin
false
end))


let is_Meta_labeled = (fun _discr_ -> (match (_discr_) with
| Meta_labeled (_) -> begin
true
end
| _ -> begin
false
end))


let is_Meta_refresh_label = (fun _discr_ -> (match (_discr_) with
| Meta_refresh_label (_) -> begin
true
end
| _ -> begin
false
end))


let is_Meta_slack_formula = (fun _discr_ -> (match (_discr_) with
| Meta_slack_formula (_) -> begin
true
end
| _ -> begin
false
end))


let is_Uvar = (fun _ _discr_ -> (match (_discr_) with
| Uvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Fixed = (fun _ _discr_ -> (match (_discr_) with
| Fixed (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_bvar = (fun _discr_ -> (match (_discr_) with
| Exp_bvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_fvar = (fun _discr_ -> (match (_discr_) with
| Exp_fvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_constant = (fun _discr_ -> (match (_discr_) with
| Exp_constant (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_abs = (fun _discr_ -> (match (_discr_) with
| Exp_abs (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_app = (fun _discr_ -> (match (_discr_) with
| Exp_app (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_match = (fun _discr_ -> (match (_discr_) with
| Exp_match (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_ascribed = (fun _discr_ -> (match (_discr_) with
| Exp_ascribed (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_let = (fun _discr_ -> (match (_discr_) with
| Exp_let (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_uvar = (fun _discr_ -> (match (_discr_) with
| Exp_uvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_delayed = (fun _discr_ -> (match (_discr_) with
| Exp_delayed (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exp_meta = (fun _discr_ -> (match (_discr_) with
| Exp_meta (_) -> begin
true
end
| _ -> begin
false
end))


let is_Meta_desugared = (fun _discr_ -> (match (_discr_) with
| Meta_desugared (_) -> begin
true
end
| _ -> begin
false
end))


let is_Data_app = (fun _discr_ -> (match (_discr_) with
| Data_app (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sequence = (fun _discr_ -> (match (_discr_) with
| Sequence (_) -> begin
true
end
| _ -> begin
false
end))


let is_Primop = (fun _discr_ -> (match (_discr_) with
| Primop (_) -> begin
true
end
| _ -> begin
false
end))


let is_Masked_effect = (fun _discr_ -> (match (_discr_) with
| Masked_effect (_) -> begin
true
end
| _ -> begin
false
end))


let is_Meta_smt_pat = (fun _discr_ -> (match (_discr_) with
| Meta_smt_pat (_) -> begin
true
end
| _ -> begin
false
end))


let is_Data_ctor = (fun _discr_ -> (match (_discr_) with
| Data_ctor (_) -> begin
true
end
| _ -> begin
false
end))


let is_Record_projector = (fun _discr_ -> (match (_discr_) with
| Record_projector (_) -> begin
true
end
| _ -> begin
false
end))


let is_Record_ctor = (fun _discr_ -> (match (_discr_) with
| Record_ctor (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_disj = (fun _discr_ -> (match (_discr_) with
| Pat_disj (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_constant = (fun _discr_ -> (match (_discr_) with
| Pat_constant (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_cons = (fun _discr_ -> (match (_discr_) with
| Pat_cons (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_var = (fun _discr_ -> (match (_discr_) with
| Pat_var (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_tvar = (fun _discr_ -> (match (_discr_) with
| Pat_tvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_wild = (fun _discr_ -> (match (_discr_) with
| Pat_wild (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_twild = (fun _discr_ -> (match (_discr_) with
| Pat_twild (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_dot_term = (fun _discr_ -> (match (_discr_) with
| Pat_dot_term (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pat_dot_typ = (fun _discr_ -> (match (_discr_) with
| Pat_dot_typ (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_type = (fun _discr_ -> (match (_discr_) with
| Kind_type (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_effect = (fun _discr_ -> (match (_discr_) with
| Kind_effect (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_abbrev = (fun _discr_ -> (match (_discr_) with
| Kind_abbrev (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_arrow = (fun _discr_ -> (match (_discr_) with
| Kind_arrow (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_uvar = (fun _discr_ -> (match (_discr_) with
| Kind_uvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_lam = (fun _discr_ -> (match (_discr_) with
| Kind_lam (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_delayed = (fun _discr_ -> (match (_discr_) with
| Kind_delayed (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind_unknown = (fun _discr_ -> (match (_discr_) with
| Kind_unknown (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mkletbinding : letbinding  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkletbinding"))))


let is_Mkfreevars : freevars  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkfreevars"))))


let is_Mkuvars : uvars  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkuvars"))))


let is_Mksyntax = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mksyntax"))))


let ___Typ_btvar____0 = (fun projectee -> (match (projectee) with
| Typ_btvar (_28_58) -> begin
_28_58
end))


let ___Typ_const____0 = (fun projectee -> (match (projectee) with
| Typ_const (_28_61) -> begin
_28_61
end))


let ___Typ_fun____0 = (fun projectee -> (match (projectee) with
| Typ_fun (_28_64) -> begin
_28_64
end))


let ___Typ_refine____0 = (fun projectee -> (match (projectee) with
| Typ_refine (_28_67) -> begin
_28_67
end))


let ___Typ_app____0 = (fun projectee -> (match (projectee) with
| Typ_app (_28_70) -> begin
_28_70
end))


let ___Typ_lam____0 = (fun projectee -> (match (projectee) with
| Typ_lam (_28_73) -> begin
_28_73
end))


let ___Typ_ascribed____0 = (fun projectee -> (match (projectee) with
| Typ_ascribed (_28_76) -> begin
_28_76
end))


let ___Typ_meta____0 = (fun projectee -> (match (projectee) with
| Typ_meta (_28_79) -> begin
_28_79
end))


let ___Typ_uvar____0 = (fun projectee -> (match (projectee) with
| Typ_uvar (_28_82) -> begin
_28_82
end))


let ___Typ_delayed____0 = (fun projectee -> (match (projectee) with
| Typ_delayed (_28_85) -> begin
_28_85
end))


let ___Total____0 = (fun projectee -> (match (projectee) with
| Total (_28_89) -> begin
_28_89
end))


let ___Comp____0 = (fun projectee -> (match (projectee) with
| Comp (_28_92) -> begin
_28_92
end))


let ___DECREASES____0 = (fun projectee -> (match (projectee) with
| DECREASES (_28_95) -> begin
_28_95
end))


let ___Meta_pattern____0 = (fun projectee -> (match (projectee) with
| Meta_pattern (_28_98) -> begin
_28_98
end))


let ___Meta_named____0 = (fun projectee -> (match (projectee) with
| Meta_named (_28_101) -> begin
_28_101
end))


let ___Meta_labeled____0 = (fun projectee -> (match (projectee) with
| Meta_labeled (_28_104) -> begin
_28_104
end))


let ___Meta_refresh_label____0 = (fun projectee -> (match (projectee) with
| Meta_refresh_label (_28_107) -> begin
_28_107
end))


let ___Meta_slack_formula____0 = (fun projectee -> (match (projectee) with
| Meta_slack_formula (_28_110) -> begin
_28_110
end))


let ___Fixed____0 = (fun projectee -> (match (projectee) with
| Fixed (_28_113) -> begin
_28_113
end))


let ___Exp_bvar____0 = (fun projectee -> (match (projectee) with
| Exp_bvar (_28_116) -> begin
_28_116
end))


let ___Exp_fvar____0 = (fun projectee -> (match (projectee) with
| Exp_fvar (_28_119) -> begin
_28_119
end))


let ___Exp_constant____0 = (fun projectee -> (match (projectee) with
| Exp_constant (_28_122) -> begin
_28_122
end))


let ___Exp_abs____0 = (fun projectee -> (match (projectee) with
| Exp_abs (_28_125) -> begin
_28_125
end))


let ___Exp_app____0 = (fun projectee -> (match (projectee) with
| Exp_app (_28_128) -> begin
_28_128
end))


let ___Exp_match____0 = (fun projectee -> (match (projectee) with
| Exp_match (_28_131) -> begin
_28_131
end))


let ___Exp_ascribed____0 = (fun projectee -> (match (projectee) with
| Exp_ascribed (_28_134) -> begin
_28_134
end))


let ___Exp_let____0 = (fun projectee -> (match (projectee) with
| Exp_let (_28_137) -> begin
_28_137
end))


let ___Exp_uvar____0 = (fun projectee -> (match (projectee) with
| Exp_uvar (_28_140) -> begin
_28_140
end))


let ___Exp_delayed____0 = (fun projectee -> (match (projectee) with
| Exp_delayed (_28_143) -> begin
_28_143
end))


let ___Exp_meta____0 = (fun projectee -> (match (projectee) with
| Exp_meta (_28_146) -> begin
_28_146
end))


let ___Meta_desugared____0 = (fun projectee -> (match (projectee) with
| Meta_desugared (_28_148) -> begin
_28_148
end))


let ___Record_projector____0 = (fun projectee -> (match (projectee) with
| Record_projector (_28_151) -> begin
_28_151
end))


let ___Record_ctor____0 = (fun projectee -> (match (projectee) with
| Record_ctor (_28_154) -> begin
_28_154
end))


let ___Pat_disj____0 = (fun projectee -> (match (projectee) with
| Pat_disj (_28_157) -> begin
_28_157
end))


let ___Pat_constant____0 = (fun projectee -> (match (projectee) with
| Pat_constant (_28_160) -> begin
_28_160
end))


let ___Pat_cons____0 = (fun projectee -> (match (projectee) with
| Pat_cons (_28_163) -> begin
_28_163
end))


let ___Pat_var____0 = (fun projectee -> (match (projectee) with
| Pat_var (_28_166) -> begin
_28_166
end))


let ___Pat_tvar____0 = (fun projectee -> (match (projectee) with
| Pat_tvar (_28_169) -> begin
_28_169
end))


let ___Pat_wild____0 = (fun projectee -> (match (projectee) with
| Pat_wild (_28_172) -> begin
_28_172
end))


let ___Pat_twild____0 = (fun projectee -> (match (projectee) with
| Pat_twild (_28_175) -> begin
_28_175
end))


let ___Pat_dot_term____0 = (fun projectee -> (match (projectee) with
| Pat_dot_term (_28_178) -> begin
_28_178
end))


let ___Pat_dot_typ____0 = (fun projectee -> (match (projectee) with
| Pat_dot_typ (_28_181) -> begin
_28_181
end))


let ___Kind_abbrev____0 = (fun projectee -> (match (projectee) with
| Kind_abbrev (_28_184) -> begin
_28_184
end))


let ___Kind_arrow____0 = (fun projectee -> (match (projectee) with
| Kind_arrow (_28_187) -> begin
_28_187
end))


let ___Kind_uvar____0 = (fun projectee -> (match (projectee) with
| Kind_uvar (_28_190) -> begin
_28_190
end))


let ___Kind_lam____0 = (fun projectee -> (match (projectee) with
| Kind_lam (_28_193) -> begin
_28_193
end))


let ___Kind_delayed____0 = (fun projectee -> (match (projectee) with
| Kind_delayed (_28_196) -> begin
_28_196
end))


type subst =
subst_elt Prims.list


type either_var =
(btvar, bvvar) FStar_Util.either


type freevars_l =
either_var Prims.list


type formula =
typ


type formulae =
typ Prims.list


type qualifier =
| Private
| Assumption
| Opaque
| Logic
| Abstract
| New
| Discriminator of lident
| Projector of (lident * (btvdef, bvvdef) FStar_Util.either)
| RecordType of fieldname Prims.list
| RecordConstructor of fieldname Prims.list
| ExceptionConstructor
| DefaultEffect of lident Prims.option
| TotalEffect
| HasMaskedEffect
| Effect


let is_Private = (fun _discr_ -> (match (_discr_) with
| Private (_) -> begin
true
end
| _ -> begin
false
end))


let is_Assumption = (fun _discr_ -> (match (_discr_) with
| Assumption (_) -> begin
true
end
| _ -> begin
false
end))


let is_Opaque = (fun _discr_ -> (match (_discr_) with
| Opaque (_) -> begin
true
end
| _ -> begin
false
end))


let is_Logic = (fun _discr_ -> (match (_discr_) with
| Logic (_) -> begin
true
end
| _ -> begin
false
end))


let is_Abstract = (fun _discr_ -> (match (_discr_) with
| Abstract (_) -> begin
true
end
| _ -> begin
false
end))


let is_New = (fun _discr_ -> (match (_discr_) with
| New (_) -> begin
true
end
| _ -> begin
false
end))


let is_Discriminator = (fun _discr_ -> (match (_discr_) with
| Discriminator (_) -> begin
true
end
| _ -> begin
false
end))


let is_Projector = (fun _discr_ -> (match (_discr_) with
| Projector (_) -> begin
true
end
| _ -> begin
false
end))


let is_RecordType = (fun _discr_ -> (match (_discr_) with
| RecordType (_) -> begin
true
end
| _ -> begin
false
end))


let is_RecordConstructor = (fun _discr_ -> (match (_discr_) with
| RecordConstructor (_) -> begin
true
end
| _ -> begin
false
end))


let is_ExceptionConstructor = (fun _discr_ -> (match (_discr_) with
| ExceptionConstructor (_) -> begin
true
end
| _ -> begin
false
end))


let is_DefaultEffect = (fun _discr_ -> (match (_discr_) with
| DefaultEffect (_) -> begin
true
end
| _ -> begin
false
end))


let is_TotalEffect = (fun _discr_ -> (match (_discr_) with
| TotalEffect (_) -> begin
true
end
| _ -> begin
false
end))


let is_HasMaskedEffect = (fun _discr_ -> (match (_discr_) with
| HasMaskedEffect (_) -> begin
true
end
| _ -> begin
false
end))


let is_Effect = (fun _discr_ -> (match (_discr_) with
| Effect (_) -> begin
true
end
| _ -> begin
false
end))


let ___Discriminator____0 = (fun projectee -> (match (projectee) with
| Discriminator (_28_203) -> begin
_28_203
end))


let ___Projector____0 = (fun projectee -> (match (projectee) with
| Projector (_28_206) -> begin
_28_206
end))


let ___RecordType____0 = (fun projectee -> (match (projectee) with
| RecordType (_28_209) -> begin
_28_209
end))


let ___RecordConstructor____0 = (fun projectee -> (match (projectee) with
| RecordConstructor (_28_212) -> begin
_28_212
end))


let ___DefaultEffect____0 = (fun projectee -> (match (projectee) with
| DefaultEffect (_28_215) -> begin
_28_215
end))


type tycon =
(lident * binders * knd)


type monad_abbrev =
{mabbrev : lident; parms : binders; def : typ}


let is_Mkmonad_abbrev : monad_abbrev  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkmonad_abbrev"))))


type sub_eff =
{source : lident; target : lident; lift : typ}


let is_Mksub_eff : sub_eff  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mksub_eff"))))


type eff_decl =
{mname : lident; binders : binders; qualifiers : qualifier Prims.list; signature : knd; ret : typ; bind_wp : typ; bind_wlp : typ; if_then_else : typ; ite_wp : typ; ite_wlp : typ; wp_binop : typ; wp_as_type : typ; close_wp : typ; close_wp_t : typ; assert_p : typ; assume_p : typ; null_wp : typ; trivial : typ} 
 and sigelt =
| Sig_tycon of (lident * binders * knd * lident Prims.list * lident Prims.list * qualifier Prims.list * FStar_Range.range)
| Sig_kind_abbrev of (lident * binders * knd * FStar_Range.range)
| Sig_typ_abbrev of (lident * binders * knd * typ * qualifier Prims.list * FStar_Range.range)
| Sig_datacon of (lident * typ * tycon * qualifier Prims.list * lident Prims.list * FStar_Range.range)
| Sig_val_decl of (lident * typ * qualifier Prims.list * FStar_Range.range)
| Sig_assume of (lident * formula * qualifier Prims.list * FStar_Range.range)
| Sig_let of (letbindings * FStar_Range.range * lident Prims.list * qualifier Prims.list)
| Sig_main of (exp * FStar_Range.range)
| Sig_bundle of (sigelt Prims.list * qualifier Prims.list * lident Prims.list * FStar_Range.range)
| Sig_new_effect of (eff_decl * FStar_Range.range)
| Sig_sub_effect of (sub_eff * FStar_Range.range)
| Sig_effect_abbrev of (lident * binders * comp * qualifier Prims.list * FStar_Range.range)
| Sig_pragma of (pragma * FStar_Range.range)


let is_Mkeff_decl : eff_decl  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkeff_decl"))))


let is_Sig_tycon = (fun _discr_ -> (match (_discr_) with
| Sig_tycon (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_kind_abbrev = (fun _discr_ -> (match (_discr_) with
| Sig_kind_abbrev (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_typ_abbrev = (fun _discr_ -> (match (_discr_) with
| Sig_typ_abbrev (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_datacon = (fun _discr_ -> (match (_discr_) with
| Sig_datacon (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_val_decl = (fun _discr_ -> (match (_discr_) with
| Sig_val_decl (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_assume = (fun _discr_ -> (match (_discr_) with
| Sig_assume (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_let = (fun _discr_ -> (match (_discr_) with
| Sig_let (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_main = (fun _discr_ -> (match (_discr_) with
| Sig_main (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_bundle = (fun _discr_ -> (match (_discr_) with
| Sig_bundle (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_new_effect = (fun _discr_ -> (match (_discr_) with
| Sig_new_effect (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_sub_effect = (fun _discr_ -> (match (_discr_) with
| Sig_sub_effect (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_effect_abbrev = (fun _discr_ -> (match (_discr_) with
| Sig_effect_abbrev (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sig_pragma = (fun _discr_ -> (match (_discr_) with
| Sig_pragma (_) -> begin
true
end
| _ -> begin
false
end))


let ___Sig_tycon____0 = (fun projectee -> (match (projectee) with
| Sig_tycon (_28_245) -> begin
_28_245
end))


let ___Sig_kind_abbrev____0 = (fun projectee -> (match (projectee) with
| Sig_kind_abbrev (_28_248) -> begin
_28_248
end))


let ___Sig_typ_abbrev____0 = (fun projectee -> (match (projectee) with
| Sig_typ_abbrev (_28_251) -> begin
_28_251
end))


let ___Sig_datacon____0 = (fun projectee -> (match (projectee) with
| Sig_datacon (_28_254) -> begin
_28_254
end))


let ___Sig_val_decl____0 = (fun projectee -> (match (projectee) with
| Sig_val_decl (_28_257) -> begin
_28_257
end))


let ___Sig_assume____0 = (fun projectee -> (match (projectee) with
| Sig_assume (_28_260) -> begin
_28_260
end))


let ___Sig_let____0 = (fun projectee -> (match (projectee) with
| Sig_let (_28_263) -> begin
_28_263
end))


let ___Sig_main____0 = (fun projectee -> (match (projectee) with
| Sig_main (_28_266) -> begin
_28_266
end))


let ___Sig_bundle____0 = (fun projectee -> (match (projectee) with
| Sig_bundle (_28_269) -> begin
_28_269
end))


let ___Sig_new_effect____0 = (fun projectee -> (match (projectee) with
| Sig_new_effect (_28_272) -> begin
_28_272
end))


let ___Sig_sub_effect____0 = (fun projectee -> (match (projectee) with
| Sig_sub_effect (_28_275) -> begin
_28_275
end))


let ___Sig_effect_abbrev____0 = (fun projectee -> (match (projectee) with
| Sig_effect_abbrev (_28_278) -> begin
_28_278
end))


let ___Sig_pragma____0 = (fun projectee -> (match (projectee) with
| Sig_pragma (_28_281) -> begin
_28_281
end))


type sigelts =
sigelt Prims.list


type modul =
{name : lident; declarations : sigelts; exports : sigelts; is_interface : Prims.bool; is_deserialized : Prims.bool}


let is_Mkmodul : modul  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkmodul"))))


type ktec =
| K of knd
| T of (typ * knd Prims.option)
| E of exp
| C of comp


let is_K = (fun _discr_ -> (match (_discr_) with
| K (_) -> begin
true
end
| _ -> begin
false
end))


let is_T = (fun _discr_ -> (match (_discr_) with
| T (_) -> begin
true
end
| _ -> begin
false
end))


let is_E = (fun _discr_ -> (match (_discr_) with
| E (_) -> begin
true
end
| _ -> begin
false
end))


let is_C = (fun _discr_ -> (match (_discr_) with
| C (_) -> begin
true
end
| _ -> begin
false
end))


let ___K____0 = (fun projectee -> (match (projectee) with
| K (_28_290) -> begin
_28_290
end))


let ___T____0 = (fun projectee -> (match (projectee) with
| T (_28_293) -> begin
_28_293
end))


let ___E____0 = (fun projectee -> (match (projectee) with
| E (_28_296) -> begin
_28_296
end))


let ___C____0 = (fun projectee -> (match (projectee) with
| C (_28_299) -> begin
_28_299
end))


type lcomp =
{eff_name : lident; res_typ : typ; cflags : cflags Prims.list; comp : Prims.unit  ->  comp}


let is_Mklcomp : lcomp  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mklcomp"))))


type path =
Prims.string Prims.list


let dummyRange : FStar_Range.range = FStar_Range.dummyRange


let withinfo = (fun v s r -> {v = v; sort = s; p = r})


let withsort = (fun v s -> (withinfo v s dummyRange))


let mk_ident : (Prims.string * FStar_Range.range)  ->  ident = (fun _28_335 -> (match (_28_335) with
| (text, range) -> begin
{FStar_Ident.idText = text; FStar_Ident.idRange = range}
end))


let id_of_text : Prims.string  ->  ident = (fun str -> (mk_ident ((str), (dummyRange))))


let text_of_id : ident  ->  Prims.string = (fun id -> id.FStar_Ident.idText)


let text_of_path : path  ->  Prims.string = (fun path -> (FStar_Util.concat_l "." path))


let path_of_text : Prims.string  ->  Prims.string Prims.list = (fun text -> (FStar_String.split (('.')::[]) text))


let path_of_ns : ident Prims.list  ->  Prims.string Prims.list = (fun ns -> (FStar_List.map text_of_id ns))


let path_of_lid : lident  ->  path = (fun lid -> (FStar_List.map text_of_id (FStar_List.append lid.FStar_Ident.ns ((lid.FStar_Ident.ident)::[]))))


let ids_of_lid : lident  ->  ident Prims.list = (fun lid -> (FStar_List.append lid.FStar_Ident.ns ((lid.FStar_Ident.ident)::[])))


let lid_of_ids : ident Prims.list  ->  lident = (fun ids -> (

let _28_346 = (FStar_Util.prefix ids)
in (match (_28_346) with
| (ns, id) -> begin
(

let nsstr = (let _123_1285 = (FStar_List.map text_of_id ns)
in (FStar_All.pipe_right _123_1285 text_of_path))
in {FStar_Ident.ns = ns; FStar_Ident.ident = id; FStar_Ident.nsstr = nsstr; FStar_Ident.str = if (nsstr = "") then begin
id.FStar_Ident.idText
end else begin
(Prims.strcat nsstr (Prims.strcat "." id.FStar_Ident.idText))
end})
end)))


let lid_of_path : path  ->  FStar_Range.range  ->  lident = (fun path pos -> (

let ids = (FStar_List.map (fun s -> (mk_ident ((s), (pos)))) path)
in (lid_of_ids ids)))


let text_of_lid : lident  ->  Prims.string = (fun lid -> lid.FStar_Ident.str)


let lid_equals : lident  ->  lident  ->  Prims.bool = (fun l1 l2 -> (l1.FStar_Ident.str = l2.FStar_Ident.str))


let bvd_eq = (fun bvd1 bvd2 -> (bvd1.realname.FStar_Ident.idText = bvd2.realname.FStar_Ident.idText))


let order_bvd = (fun x y -> (match (((x), (y))) with
| (FStar_Util.Inl (_28_361), FStar_Util.Inr (_28_364)) -> begin
(~- ((Prims.parse_int "1")))
end
| (FStar_Util.Inr (_28_368), FStar_Util.Inl (_28_371)) -> begin
(Prims.parse_int "1")
end
| (FStar_Util.Inl (x), FStar_Util.Inl (y)) -> begin
(FStar_String.compare x.realname.FStar_Ident.idText y.realname.FStar_Ident.idText)
end
| (FStar_Util.Inr (x), FStar_Util.Inr (y)) -> begin
(FStar_String.compare x.realname.FStar_Ident.idText y.realname.FStar_Ident.idText)
end))


let lid_with_range : lident  ->  FStar_Range.range  ->  lident = (fun lid r -> (

let id = (

let _28_386 = lid.FStar_Ident.ident
in {FStar_Ident.idText = _28_386.FStar_Ident.idText; FStar_Ident.idRange = r})
in (

let _28_389 = lid
in {FStar_Ident.ns = _28_389.FStar_Ident.ns; FStar_Ident.ident = id; FStar_Ident.nsstr = _28_389.FStar_Ident.nsstr; FStar_Ident.str = _28_389.FStar_Ident.str})))


let range_of_lid : lident  ->  FStar_Range.range = (fun lid -> lid.FStar_Ident.ident.FStar_Ident.idRange)


let range_of_lbname : lbname  ->  FStar_Range.range = (fun l -> (match (l) with
| FStar_Util.Inl (x) -> begin
x.ppname.FStar_Ident.idRange
end
| FStar_Util.Inr (l) -> begin
(range_of_lid l)
end))


let syn = (fun p k f -> (f k p))


let mk_fvs = (fun _28_400 -> (match (()) with
| () -> begin
(FStar_Util.mk_ref None)
end))


let mk_uvs = (fun _28_401 -> (match (()) with
| () -> begin
(FStar_Util.mk_ref None)
end))


let new_ftv_set = (fun _28_402 -> (match (()) with
| () -> begin
(FStar_Util.new_set (fun x y -> (FStar_Util.compare x.v.realname.FStar_Ident.idText y.v.realname.FStar_Ident.idText)) (fun x -> (FStar_Util.hashcode x.v.realname.FStar_Ident.idText)))
end))


let new_uv_set = (fun _28_406 -> (match (()) with
| () -> begin
(FStar_Util.new_set (fun x y -> ((FStar_Unionfind.uvar_id x) - (FStar_Unionfind.uvar_id y))) FStar_Unionfind.uvar_id)
end))


let new_uvt_set = (fun _28_409 -> (match (()) with
| () -> begin
(FStar_Util.new_set (fun _28_417 _28_421 -> (match (((_28_417), (_28_421))) with
| ((x, _28_416), (y, _28_420)) -> begin
((FStar_Unionfind.uvar_id x) - (FStar_Unionfind.uvar_id y))
end)) (fun _28_413 -> (match (_28_413) with
| (x, _28_412) -> begin
(FStar_Unionfind.uvar_id x)
end)))
end))


let no_fvs : freevars = (let _123_1334 = (new_ftv_set ())
in (let _123_1333 = (new_ftv_set ())
in {ftvs = _123_1334; fxvs = _123_1333}))


let no_uvs : uvars = (let _123_1337 = (new_uv_set ())
in (let _123_1336 = (new_uvt_set ())
in (let _123_1335 = (new_uvt_set ())
in {uvars_k = _123_1337; uvars_t = _123_1336; uvars_e = _123_1335})))


let memo_no_uvs : uvars Prims.option FStar_ST.ref = (FStar_Util.mk_ref (Some (no_uvs)))


let memo_no_fvs : freevars Prims.option FStar_ST.ref = (FStar_Util.mk_ref (Some (no_fvs)))


let freevars_of_list : (btvar, bvvar) FStar_Util.either Prims.list  ->  freevars = (fun l -> (FStar_All.pipe_right l (FStar_List.fold_left (fun out _28_1 -> (match (_28_1) with
| FStar_Util.Inl (btv) -> begin
(

let _28_427 = out
in (let _123_1342 = (FStar_Util.set_add btv out.ftvs)
in {ftvs = _123_1342; fxvs = _28_427.fxvs}))
end
| FStar_Util.Inr (bxv) -> begin
(

let _28_431 = out
in (let _123_1343 = (FStar_Util.set_add bxv out.fxvs)
in {ftvs = _28_431.ftvs; fxvs = _123_1343}))
end)) no_fvs)))


let list_of_freevars : freevars  ->  (btvar, bvvar) FStar_Util.either Prims.list = (fun fvs -> (let _123_1351 = (let _123_1347 = (FStar_Util.set_elements fvs.ftvs)
in (FStar_All.pipe_right _123_1347 (FStar_List.map (fun x -> FStar_Util.Inl (x)))))
in (let _123_1350 = (let _123_1349 = (FStar_Util.set_elements fvs.fxvs)
in (FStar_All.pipe_right _123_1349 (FStar_List.map (fun x -> FStar_Util.Inr (x)))))
in (FStar_List.append _123_1351 _123_1350))))


let get_unit_ref : Prims.unit  ->  Prims.unit Prims.option FStar_ST.ref = (fun _28_436 -> (match (()) with
| () -> begin
(

let x = (FStar_Util.mk_ref (Some (())))
in (

let _28_438 = (FStar_ST.op_Colon_Equals x None)
in x))
end))


let mk_Kind_type : (knd', Prims.unit) syntax = (let _123_1356 = (get_unit_ref ())
in (let _123_1355 = (mk_fvs ())
in (let _123_1354 = (mk_uvs ())
in {n = Kind_type; tk = _123_1356; pos = dummyRange; fvs = _123_1355; uvs = _123_1354})))


let mk_Kind_effect : (knd', Prims.unit) syntax = (let _123_1359 = (get_unit_ref ())
in (let _123_1358 = (mk_fvs ())
in (let _123_1357 = (mk_uvs ())
in {n = Kind_effect; tk = _123_1359; pos = dummyRange; fvs = _123_1358; uvs = _123_1357})))


let mk_Kind_abbrev : (kabbrev * knd)  ->  FStar_Range.range  ->  knd = (fun _28_442 p -> (match (_28_442) with
| (kabr, k) -> begin
(let _123_1366 = (get_unit_ref ())
in (let _123_1365 = (mk_fvs ())
in (let _123_1364 = (mk_uvs ())
in {n = Kind_abbrev (((kabr), (k))); tk = _123_1366; pos = p; fvs = _123_1365; uvs = _123_1364})))
end))


let mk_Kind_arrow : (binders * knd)  ->  FStar_Range.range  ->  knd = (fun _28_446 p -> (match (_28_446) with
| (bs, k) -> begin
(let _123_1373 = (get_unit_ref ())
in (let _123_1372 = (mk_fvs ())
in (let _123_1371 = (mk_uvs ())
in {n = Kind_arrow (((bs), (k))); tk = _123_1373; pos = p; fvs = _123_1372; uvs = _123_1371})))
end))


let mk_Kind_arrow' : (binders * knd)  ->  FStar_Range.range  ->  knd = (fun _28_450 p -> (match (_28_450) with
| (bs, k) -> begin
(match (bs) with
| [] -> begin
k
end
| _28_454 -> begin
(match (k.n) with
| Kind_arrow (bs', k') -> begin
(mk_Kind_arrow (((FStar_List.append bs bs')), (k')) p)
end
| _28_460 -> begin
(mk_Kind_arrow ((bs), (k)) p)
end)
end)
end))


let mk_Kind_uvar : uvar_k_app  ->  FStar_Range.range  ->  knd = (fun uv p -> (let _123_1384 = (get_unit_ref ())
in (let _123_1383 = (mk_fvs ())
in (let _123_1382 = (mk_uvs ())
in {n = Kind_uvar (uv); tk = _123_1384; pos = p; fvs = _123_1383; uvs = _123_1382}))))


let mk_Kind_lam : (binders * knd)  ->  FStar_Range.range  ->  knd = (fun _28_465 p -> (match (_28_465) with
| (vs, k) -> begin
(let _123_1391 = (get_unit_ref ())
in (let _123_1390 = (mk_fvs ())
in (let _123_1389 = (mk_uvs ())
in {n = Kind_lam (((vs), (k))); tk = _123_1391; pos = p; fvs = _123_1390; uvs = _123_1389})))
end))


let mk_Kind_delayed : (knd * subst_t * knd memo)  ->  FStar_Range.range  ->  knd = (fun _28_470 p -> (match (_28_470) with
| (k, s, m) -> begin
(let _123_1398 = (get_unit_ref ())
in (let _123_1397 = (mk_fvs ())
in (let _123_1396 = (mk_uvs ())
in {n = Kind_delayed (((k), (s), (m))); tk = _123_1398; pos = p; fvs = _123_1397; uvs = _123_1396})))
end))


let mk_Kind_unknown : (knd', Prims.unit) syntax = (let _123_1401 = (get_unit_ref ())
in (let _123_1400 = (mk_fvs ())
in (let _123_1399 = (mk_uvs ())
in {n = Kind_unknown; tk = _123_1401; pos = dummyRange; fvs = _123_1400; uvs = _123_1399})))


let get_knd_nref : Prims.unit  ->  (knd', Prims.unit) syntax Prims.option FStar_ST.ref = (fun _28_472 -> (match (()) with
| () -> begin
(

let x = (FStar_Util.mk_ref (Some (mk_Kind_unknown)))
in (

let _28_474 = (FStar_ST.op_Colon_Equals x None)
in x))
end))


let get_knd_ref : (knd', Prims.unit) syntax Prims.option  ->  (knd', Prims.unit) syntax Prims.option FStar_ST.ref = (fun k -> (

let x = (FStar_Util.mk_ref (Some (mk_Kind_unknown)))
in (

let _28_478 = (FStar_ST.op_Colon_Equals x k)
in x)))


let mk_Typ_btvar : btvar  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun x k p -> (let _123_1414 = (get_knd_ref k)
in (let _123_1413 = (mk_fvs ())
in (let _123_1412 = (mk_uvs ())
in {n = Typ_btvar (x); tk = _123_1414; pos = p; fvs = _123_1413; uvs = _123_1412}))))


let mk_Typ_const : ftvar  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun x k p -> (let _123_1421 = (get_knd_ref k)
in {n = Typ_const (x); tk = _123_1421; pos = p; fvs = memo_no_fvs; uvs = memo_no_uvs}))


let rec check_fun = (fun bs c p -> (match (bs) with
| [] -> begin
(FStar_All.failwith "Empty binders")
end
| _28_491 -> begin
Typ_fun (((bs), (c)))
end))


let mk_Typ_fun : (binders * comp)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_494 k p -> (match (_28_494) with
| (bs, c) -> begin
(let _123_1434 = (check_fun bs c p)
in (let _123_1433 = (FStar_Util.mk_ref k)
in (let _123_1432 = (mk_fvs ())
in (let _123_1431 = (mk_uvs ())
in {n = _123_1434; tk = _123_1433; pos = p; fvs = _123_1432; uvs = _123_1431}))))
end))


let mk_Typ_refine : (bvvar * formula)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_499 k p -> (match (_28_499) with
| (x, phi) -> begin
(let _123_1443 = (FStar_Util.mk_ref k)
in (let _123_1442 = (mk_fvs ())
in (let _123_1441 = (mk_uvs ())
in {n = Typ_refine (((x), (phi))); tk = _123_1443; pos = p; fvs = _123_1442; uvs = _123_1441})))
end))


let mk_Typ_app : (typ * args)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_504 k p -> (match (_28_504) with
| (t1, args) -> begin
(match (args) with
| [] -> begin
t1
end
| _28_509 -> begin
(let _123_1452 = (FStar_Util.mk_ref k)
in (let _123_1451 = (mk_fvs ())
in (let _123_1450 = (mk_uvs ())
in {n = Typ_app (((t1), (args))); tk = _123_1452; pos = p; fvs = _123_1451; uvs = _123_1450})))
end)
end))


let mk_Typ_app' : (typ * args)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_512 k p -> (match (_28_512) with
| (t1, args) -> begin
(match (args) with
| [] -> begin
t1
end
| _28_517 -> begin
(mk_Typ_app ((t1), (args)) k p)
end)
end))


let extend_typ_app : (typ * arg)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_520 k p -> (match (_28_520) with
| (t, arg) -> begin
(match (t.n) with
| Typ_app (h, args) -> begin
(mk_Typ_app ((h), ((FStar_List.append args ((arg)::[])))) k p)
end
| _28_528 -> begin
(mk_Typ_app ((t), ((arg)::[])) k p)
end)
end))


let mk_Typ_lam : (binders * typ)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_531 k p -> (match (_28_531) with
| (b, t) -> begin
(match (b) with
| [] -> begin
t
end
| _28_536 -> begin
(let _123_1473 = (FStar_Util.mk_ref k)
in (let _123_1472 = (mk_fvs ())
in (let _123_1471 = (mk_uvs ())
in {n = Typ_lam (((b), (t))); tk = _123_1473; pos = p; fvs = _123_1472; uvs = _123_1471})))
end)
end))


let mk_Typ_lam' : (binders * typ)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_539 k p -> (match (_28_539) with
| (bs, t) -> begin
(mk_Typ_lam ((bs), (t)) k p)
end))


let mk_Typ_ascribed' : (typ * knd)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_544 k' p -> (match (_28_544) with
| (t, k) -> begin
(let _123_1488 = (FStar_Util.mk_ref k')
in (let _123_1487 = (mk_fvs ())
in (let _123_1486 = (mk_uvs ())
in {n = Typ_ascribed (((t), (k))); tk = _123_1488; pos = p; fvs = _123_1487; uvs = _123_1486})))
end))


let mk_Typ_ascribed : (typ * knd)  ->  FStar_Range.range  ->  typ = (fun _28_549 p -> (match (_28_549) with
| (t, k) -> begin
(mk_Typ_ascribed' ((t), (k)) (Some (k)) p)
end))


let mk_Typ_meta' : meta_t  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun m k p -> (let _123_1501 = (FStar_Util.mk_ref k)
in (let _123_1500 = (mk_fvs ())
in (let _123_1499 = (mk_uvs ())
in {n = Typ_meta (m); tk = _123_1501; pos = p; fvs = _123_1500; uvs = _123_1499}))))


let mk_Typ_meta : meta_t  ->  typ = (fun m -> (match (m) with
| (Meta_pattern (t, _)) | (Meta_named (t, _)) | (Meta_labeled (t, _, _, _)) | (Meta_refresh_label (t, _, _)) | (Meta_slack_formula (t, _, _)) -> begin
(let _123_1504 = (FStar_ST.read t.tk)
in (mk_Typ_meta' m _123_1504 t.pos))
end))


let mk_Typ_uvar' : (uvar_t * knd)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_586 k' p -> (match (_28_586) with
| (u, k) -> begin
(let _123_1513 = (get_knd_ref k')
in (let _123_1512 = (mk_fvs ())
in (let _123_1511 = (mk_uvs ())
in {n = Typ_uvar (((u), (k))); tk = _123_1513; pos = p; fvs = _123_1512; uvs = _123_1511})))
end))


let mk_Typ_uvar : (uvar_t * knd)  ->  FStar_Range.range  ->  typ = (fun _28_591 p -> (match (_28_591) with
| (u, k) -> begin
(mk_Typ_uvar' ((u), (k)) (Some (k)) p)
end))


let mk_Typ_delayed : (typ * subst_t * typ memo)  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun _28_596 k p -> (match (_28_596) with
| (t, s, m) -> begin
(let _123_1533 = (match (t.n) with
| Typ_delayed (_28_600) -> begin
(FStar_All.failwith "NESTED DELAYED TYPES!")
end
| _28_603 -> begin
Typ_delayed (((FStar_Util.Inl (((t), (s)))), (m)))
end)
in (let _123_1532 = (FStar_Util.mk_ref k)
in (let _123_1531 = (mk_fvs ())
in (let _123_1530 = (mk_uvs ())
in {n = _123_1533; tk = _123_1532; pos = p; fvs = _123_1531; uvs = _123_1530}))))
end))


let mk_Typ_delayed' : ((typ * subst_t), Prims.unit  ->  typ) FStar_Util.either  ->  knd Prims.option  ->  FStar_Range.range  ->  typ = (fun st k p -> (let _123_1555 = (let _123_1551 = (let _123_1550 = (FStar_Util.mk_ref None)
in ((st), (_123_1550)))
in Typ_delayed (_123_1551))
in (let _123_1554 = (FStar_Util.mk_ref k)
in (let _123_1553 = (mk_fvs ())
in (let _123_1552 = (mk_uvs ())
in {n = _123_1555; tk = _123_1554; pos = p; fvs = _123_1553; uvs = _123_1552})))))


let mk_Typ_unknown : (typ', (knd', Prims.unit) syntax) syntax = (let _123_1558 = (get_knd_nref ())
in (let _123_1557 = (mk_fvs ())
in (let _123_1556 = (mk_uvs ())
in {n = Typ_unknown; tk = _123_1558; pos = dummyRange; fvs = _123_1557; uvs = _123_1556})))


let get_typ_nref : Prims.unit  ->  (typ', (knd', Prims.unit) syntax) syntax Prims.option FStar_ST.ref = (fun _28_607 -> (match (()) with
| () -> begin
(

let x = (FStar_Util.mk_ref (Some (mk_Typ_unknown)))
in (

let _28_609 = (FStar_ST.op_Colon_Equals x None)
in x))
end))


let get_typ_ref : (typ', (knd', Prims.unit) syntax) syntax Prims.option  ->  (typ', (knd', Prims.unit) syntax) syntax Prims.option FStar_ST.ref = (fun t -> (

let x = (FStar_Util.mk_ref (Some (mk_Typ_unknown)))
in (

let _28_613 = (FStar_ST.op_Colon_Equals x t)
in x)))


let mk_Total : typ  ->  comp = (fun t -> (let _123_1567 = (FStar_Util.mk_ref None)
in (let _123_1566 = (mk_fvs ())
in (let _123_1565 = (mk_uvs ())
in {n = Total (t); tk = _123_1567; pos = t.pos; fvs = _123_1566; uvs = _123_1565}))))


let mk_Comp : comp_typ  ->  comp = (fun ct -> (let _123_1572 = (FStar_Util.mk_ref None)
in (let _123_1571 = (mk_fvs ())
in (let _123_1570 = (mk_uvs ())
in {n = Comp (ct); tk = _123_1572; pos = ct.result_typ.pos; fvs = _123_1571; uvs = _123_1570}))))


let mk_Exp_bvar : bvvar  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun x t p -> (let _123_1581 = (get_typ_ref t)
in (let _123_1580 = (mk_fvs ())
in (let _123_1579 = (mk_uvs ())
in {n = Exp_bvar (x); tk = _123_1581; pos = p; fvs = _123_1580; uvs = _123_1579}))))


let mk_Exp_fvar : (fvvar * fv_qual Prims.option)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_622 t p -> (match (_28_622) with
| (x, b) -> begin
(let _123_1590 = (get_typ_ref t)
in (let _123_1589 = (mk_fvs ())
in (let _123_1588 = (mk_uvs ())
in {n = Exp_fvar (((x), (b))); tk = _123_1590; pos = p; fvs = _123_1589; uvs = _123_1588})))
end))


let mk_Exp_constant : sconst  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun s t p -> (let _123_1599 = (get_typ_ref t)
in (let _123_1598 = (mk_fvs ())
in (let _123_1597 = (mk_uvs ())
in {n = Exp_constant (s); tk = _123_1599; pos = p; fvs = _123_1598; uvs = _123_1597}))))


let mk_Exp_abs : (binders * exp)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_630 t' p -> (match (_28_630) with
| (b, e) -> begin
(match (b) with
| [] -> begin
e
end
| _28_635 -> begin
(let _123_1608 = (get_typ_ref t')
in (let _123_1607 = (mk_fvs ())
in (let _123_1606 = (mk_uvs ())
in {n = Exp_abs (((b), (e))); tk = _123_1608; pos = p; fvs = _123_1607; uvs = _123_1606})))
end)
end))


let mk_Exp_abs' : (binders * exp)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_638 t' p -> (match (_28_638) with
| (b, e) -> begin
(let _123_1618 = (match (((b), (e.n))) with
| (_28_642, Exp_abs ((b0)::bs, body)) -> begin
Exp_abs ((((FStar_List.append b ((b0)::bs))), (body)))
end
| ([], _28_652) -> begin
(FStar_All.failwith "abstraction with no binders!")
end
| _28_655 -> begin
Exp_abs (((b), (e)))
end)
in (let _123_1617 = (get_typ_ref t')
in (let _123_1616 = (mk_fvs ())
in (let _123_1615 = (mk_uvs ())
in {n = _123_1618; tk = _123_1617; pos = p; fvs = _123_1616; uvs = _123_1615}))))
end))


let mk_Exp_app : (exp * args)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_658 t p -> (match (_28_658) with
| (e1, args) -> begin
(match (args) with
| [] -> begin
e1
end
| _28_663 -> begin
(let _123_1627 = (get_typ_ref t)
in (let _123_1626 = (mk_fvs ())
in (let _123_1625 = (mk_uvs ())
in {n = Exp_app (((e1), (args))); tk = _123_1627; pos = p; fvs = _123_1626; uvs = _123_1625})))
end)
end))


let mk_Exp_app_flat : (exp * args)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_666 t p -> (match (_28_666) with
| (e1, args) -> begin
(match (e1.n) with
| Exp_app (e1', args') -> begin
(mk_Exp_app ((e1'), ((FStar_List.append args' args))) t p)
end
| _28_674 -> begin
(mk_Exp_app ((e1), (args)) t p)
end)
end))


let mk_Exp_app' : (exp * args)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_677 t p -> (match (_28_677) with
| (e1, args) -> begin
(match (args) with
| [] -> begin
e1
end
| _28_682 -> begin
(mk_Exp_app ((e1), (args)) t p)
end)
end))


let rec pat_vars : pat  ->  (btvdef, bvvdef) FStar_Util.either Prims.list = (fun p -> (match (p.v) with
| Pat_cons (_28_685, _28_687, ps) -> begin
(

let vars = (FStar_List.collect (fun _28_694 -> (match (_28_694) with
| (x, _28_693) -> begin
(pat_vars x)
end)) ps)
in if (FStar_All.pipe_right vars (FStar_Util.nodups (fun x y -> (match (((x), (y))) with
| (FStar_Util.Inl (x), FStar_Util.Inl (y)) -> begin
(bvd_eq x y)
end
| (FStar_Util.Inr (x), FStar_Util.Inr (y)) -> begin
(bvd_eq x y)
end
| _28_709 -> begin
false
end)))) then begin
vars
end else begin
(Prims.raise (Error ((("Pattern variables may not occur more than once"), (p.p)))))
end)
end
| Pat_var (x) -> begin
(FStar_Util.Inr (x.v))::[]
end
| Pat_tvar (a) -> begin
(FStar_Util.Inl (a.v))::[]
end
| Pat_disj (ps) -> begin
(

let vars = (FStar_List.map pat_vars ps)
in if (not ((let _123_1648 = (FStar_List.tl vars)
in (let _123_1647 = (let _123_1646 = (let _123_1645 = (FStar_List.hd vars)
in (FStar_Util.set_eq order_bvd _123_1645))
in (FStar_Util.for_all _123_1646))
in (FStar_All.pipe_right _123_1648 _123_1647))))) then begin
(

let vars = (let _123_1652 = (FStar_All.pipe_right vars (FStar_List.map (fun v -> (let _123_1651 = (FStar_List.map (fun _28_2 -> (match (_28_2) with
| FStar_Util.Inr (x) -> begin
x.ppname.FStar_Ident.idText
end
| FStar_Util.Inl (x) -> begin
x.ppname.FStar_Ident.idText
end)) v)
in (FStar_Util.concat_l ", " _123_1651)))))
in (FStar_Util.concat_l ";\n" _123_1652))
in (let _123_1655 = (let _123_1654 = (let _123_1653 = (FStar_Util.format1 "Each branch of this pattern binds different variables: %s" vars)
in ((_123_1653), (p.p)))
in Error (_123_1654))
in (Prims.raise _123_1655)))
end else begin
(FStar_List.hd vars)
end)
end
| (Pat_dot_term (_)) | (Pat_dot_typ (_)) | (Pat_wild (_)) | (Pat_twild (_)) | (Pat_constant (_)) -> begin
[]
end))


let mk_Exp_match : (exp * (pat * exp Prims.option * exp) Prims.list)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_741 t p -> (match (_28_741) with
| (e, pats) -> begin
(let _123_1664 = (get_typ_ref t)
in (let _123_1663 = (mk_fvs ())
in (let _123_1662 = (mk_uvs ())
in {n = Exp_match (((e), (pats))); tk = _123_1664; pos = p; fvs = _123_1663; uvs = _123_1662})))
end))


let mk_Exp_ascribed : (exp * typ * lident Prims.option)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_747 t' p -> (match (_28_747) with
| (e, t, l) -> begin
(let _123_1673 = (get_typ_ref t')
in (let _123_1672 = (mk_fvs ())
in (let _123_1671 = (mk_uvs ())
in {n = Exp_ascribed (((e), (t), (l))); tk = _123_1673; pos = p; fvs = _123_1672; uvs = _123_1671})))
end))


let mk_Exp_let : (letbindings * exp)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_752 t p -> (match (_28_752) with
| (lbs, e) -> begin
(let _123_1682 = (get_typ_ref t)
in (let _123_1681 = (mk_fvs ())
in (let _123_1680 = (mk_uvs ())
in {n = Exp_let (((lbs), (e))); tk = _123_1682; pos = p; fvs = _123_1681; uvs = _123_1680})))
end))


let mk_Exp_uvar' : (uvar_e * typ)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_757 t' p -> (match (_28_757) with
| (u, t) -> begin
(let _123_1691 = (get_typ_ref t')
in (let _123_1690 = (mk_fvs ())
in (let _123_1689 = (mk_uvs ())
in {n = Exp_uvar (((u), (t))); tk = _123_1691; pos = p; fvs = _123_1690; uvs = _123_1689})))
end))


let mk_Exp_uvar : (uvar_e * typ)  ->  FStar_Range.range  ->  exp = (fun _28_762 p -> (match (_28_762) with
| (u, t) -> begin
(mk_Exp_uvar' ((u), (t)) (Some (t)) p)
end))


let mk_Exp_delayed : (exp * subst_t * exp memo)  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun _28_767 t p -> (match (_28_767) with
| (e, s, m) -> begin
(let _123_1704 = (get_typ_ref t)
in (let _123_1703 = (mk_fvs ())
in (let _123_1702 = (mk_uvs ())
in {n = Exp_delayed (((e), (s), (m))); tk = _123_1704; pos = p; fvs = _123_1703; uvs = _123_1702})))
end))


let mk_Exp_meta' : meta_e  ->  typ Prims.option  ->  FStar_Range.range  ->  exp = (fun m t p -> (let _123_1713 = (get_typ_ref t)
in (let _123_1712 = (mk_fvs ())
in (let _123_1711 = (mk_uvs ())
in {n = Exp_meta (m); tk = _123_1713; pos = p; fvs = _123_1712; uvs = _123_1711}))))


let mk_Exp_meta : meta_e  ->  exp = (fun m -> (match (m) with
| Meta_desugared (e, _28_776) -> begin
(let _123_1716 = (FStar_ST.read e.tk)
in (mk_Exp_meta' m _123_1716 e.pos))
end))


let mk_lb : (lbname * lident * typ * exp)  ->  letbinding = (fun _28_783 -> (match (_28_783) with
| (x, eff, t, e) -> begin
{lbname = x; lbtyp = t; lbeff = eff; lbdef = e}
end))


let mk_subst : subst  ->  subst = (fun s -> s)


let extend_subst : (((typ', (knd', Prims.unit) syntax) syntax bvdef * (typ', (knd', Prims.unit) syntax) syntax), ((exp', (typ', (knd', Prims.unit) syntax) syntax) syntax bvdef * (exp', (typ', (knd', Prims.unit) syntax) syntax) syntax)) FStar_Util.either  ->  (((typ', (knd', Prims.unit) syntax) syntax bvdef * (typ', (knd', Prims.unit) syntax) syntax), ((exp', (typ', (knd', Prims.unit) syntax) syntax) syntax bvdef * (exp', (typ', (knd', Prims.unit) syntax) syntax) syntax)) FStar_Util.either Prims.list  ->  (((typ', (knd', Prims.unit) syntax) syntax bvdef * (typ', (knd', Prims.unit) syntax) syntax), ((exp', (typ', (knd', Prims.unit) syntax) syntax) syntax bvdef * (exp', (typ', (knd', Prims.unit) syntax) syntax) syntax)) FStar_Util.either Prims.list = (fun x s -> (x)::s)


let argpos : arg  ->  FStar_Range.range = (fun x -> (match (x) with
| (FStar_Util.Inl (t), _28_791) -> begin
t.pos
end
| (FStar_Util.Inr (e), _28_796) -> begin
e.pos
end))


let tun : typ = mk_Typ_unknown


let kun : knd = mk_Kind_unknown


let ktype : knd = mk_Kind_type


let keffect : knd = mk_Kind_effect


let null_id : ident = (mk_ident (("_"), (dummyRange)))


let null_bvd = {ppname = null_id; realname = null_id}


let null_bvar = (fun k -> {v = null_bvd; sort = k; p = dummyRange})


let t_binder : btvar  ->  binder = (fun a -> ((FStar_Util.Inl (a)), (None)))


let v_binder : bvvar  ->  binder = (fun a -> ((FStar_Util.Inr (a)), (None)))


let null_t_binder : knd  ->  binder = (fun t -> (let _123_1735 = (let _123_1734 = (null_bvar t)
in FStar_Util.Inl (_123_1734))
in ((_123_1735), (None))))


let null_v_binder : typ  ->  binder = (fun t -> (let _123_1739 = (let _123_1738 = (null_bvar t)
in FStar_Util.Inr (_123_1738))
in ((_123_1739), (None))))


let itarg : typ  ->  arg = (fun t -> ((FStar_Util.Inl (t)), (Some (Implicit (false)))))


let ivarg : exp  ->  arg = (fun v -> ((FStar_Util.Inr (v)), (Some (Implicit (false)))))


let targ : typ  ->  arg = (fun t -> ((FStar_Util.Inl (t)), (None)))


let varg : exp  ->  arg = (fun v -> ((FStar_Util.Inr (v)), (None)))


let is_null_pp = (fun b -> (b.ppname.FStar_Ident.idText = null_id.FStar_Ident.idText))


let is_null_bvd = (fun b -> (b.realname.FStar_Ident.idText = null_id.FStar_Ident.idText))


let is_null_bvar = (fun b -> (is_null_bvd b.v))


let is_null_binder : binder  ->  Prims.bool = (fun b -> (match (b) with
| (FStar_Util.Inl (a), _28_818) -> begin
(is_null_bvar a)
end
| (FStar_Util.Inr (x), _28_823) -> begin
(is_null_bvar x)
end))


let freevars_of_binders : binders  ->  freevars = (fun bs -> (FStar_All.pipe_right bs (FStar_List.fold_left (fun out _28_3 -> (match (_28_3) with
| (FStar_Util.Inl (btv), _28_831) -> begin
(

let _28_833 = out
in (let _123_1760 = (FStar_Util.set_add btv out.ftvs)
in {ftvs = _123_1760; fxvs = _28_833.fxvs}))
end
| (FStar_Util.Inr (bxv), _28_838) -> begin
(

let _28_840 = out
in (let _123_1761 = (FStar_Util.set_add bxv out.fxvs)
in {ftvs = _28_840.ftvs; fxvs = _123_1761}))
end)) no_fvs)))


let binders_of_list : (btvar, bvvar) FStar_Util.either Prims.list  ->  binders = (fun fvs -> (FStar_All.pipe_right fvs (FStar_List.map (fun t -> ((t), (None))))))


let binders_of_freevars : freevars  ->  binders = (fun fvs -> (let _123_1770 = (let _123_1767 = (FStar_Util.set_elements fvs.ftvs)
in (FStar_All.pipe_right _123_1767 (FStar_List.map t_binder)))
in (let _123_1769 = (let _123_1768 = (FStar_Util.set_elements fvs.fxvs)
in (FStar_All.pipe_right _123_1768 (FStar_List.map v_binder)))
in (FStar_List.append _123_1770 _123_1769))))


let is_implicit : aqual  ->  Prims.bool = (fun _28_4 -> (match (_28_4) with
| Some (Implicit (_28_847)) -> begin
true
end
| _28_851 -> begin
false
end))


let as_implicit : Prims.bool  ->  aqual = (fun _28_5 -> (match (_28_5) with
| true -> begin
Some (Implicit (false))
end
| _28_855 -> begin
None
end))




