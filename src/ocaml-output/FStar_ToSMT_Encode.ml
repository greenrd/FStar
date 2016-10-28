
open Prims

let add_fuel = (fun x tl -> if (FStar_Options.unthrottle_inductives ()) then begin
tl
end else begin
(x)::tl
end)


let withenv = (fun c _50_40 -> (match (_50_40) with
| (a, b) -> begin
((a), (b), (c))
end))


let vargs = (fun args -> (FStar_List.filter (fun _50_1 -> (match (_50_1) with
| (FStar_Util.Inl (_50_44), _50_47) -> begin
false
end
| _50_50 -> begin
true
end)) args))


let escape : Prims.string  ->  Prims.string = (fun s -> (FStar_Util.replace_char s '\'' '_'))


let escape_null_name = (fun a -> if (a.FStar_Absyn_Syntax.ppname.FStar_Ident.idText = "_") then begin
(Prims.strcat a.FStar_Absyn_Syntax.ppname.FStar_Ident.idText a.FStar_Absyn_Syntax.realname.FStar_Ident.idText)
end else begin
a.FStar_Absyn_Syntax.ppname.FStar_Ident.idText
end)


let mk_typ_projector_name : FStar_Ident.lident  ->  FStar_Absyn_Syntax.btvdef  ->  Prims.string = (fun lid a -> (let _145_14 = (FStar_Util.format2 "%s_%s" lid.FStar_Ident.str (escape_null_name a))
in (FStar_All.pipe_left escape _145_14)))


let mk_term_projector_name : FStar_Ident.lident  ->  FStar_Absyn_Syntax.bvvdef  ->  Prims.string = (fun lid a -> (

let a = (let _145_19 = (FStar_Absyn_Util.unmangle_field_name a.FStar_Absyn_Syntax.ppname)
in {FStar_Absyn_Syntax.ppname = _145_19; FStar_Absyn_Syntax.realname = a.FStar_Absyn_Syntax.realname})
in (let _145_20 = (FStar_Util.format2 "%s_%s" lid.FStar_Ident.str (escape_null_name a))
in (FStar_All.pipe_left escape _145_20))))


let primitive_projector_by_pos : FStar_Tc_Env.env  ->  FStar_Ident.lident  ->  Prims.int  ->  Prims.string = (fun env lid i -> (

let fail = (fun _50_62 -> (match (()) with
| () -> begin
(let _145_30 = (let _145_29 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "Projector %s on data constructor %s not found" _145_29 lid.FStar_Ident.str))
in (FStar_All.failwith _145_30))
end))
in (

let t = (FStar_Tc_Env.lookup_datacon env lid)
in (match ((let _145_31 = (FStar_Absyn_Util.compress_typ t)
in _145_31.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_fun (binders, _50_66) -> begin
if ((i < (Prims.parse_int "0")) || (i >= (FStar_List.length binders))) then begin
(fail ())
end else begin
(

let b = (FStar_List.nth binders i)
in (match ((Prims.fst b)) with
| FStar_Util.Inl (a) -> begin
(mk_typ_projector_name lid a.FStar_Absyn_Syntax.v)
end
| FStar_Util.Inr (x) -> begin
(mk_term_projector_name lid x.FStar_Absyn_Syntax.v)
end))
end
end
| _50_75 -> begin
(fail ())
end))))


let mk_term_projector_name_by_pos : FStar_Ident.lident  ->  Prims.int  ->  Prims.string = (fun lid i -> (let _145_37 = (let _145_36 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "%s_%s" lid.FStar_Ident.str _145_36))
in (FStar_All.pipe_left escape _145_37)))


let mk_typ_projector : FStar_Ident.lident  ->  FStar_Absyn_Syntax.btvdef  ->  FStar_ToSMT_Term.term = (fun lid a -> (let _145_43 = (let _145_42 = (mk_typ_projector_name lid a)
in ((_145_42), (FStar_ToSMT_Term.Arrow (((FStar_ToSMT_Term.Term_sort), (FStar_ToSMT_Term.Type_sort))))))
in (FStar_ToSMT_Term.mkFreeV _145_43)))


let mk_term_projector : FStar_Ident.lident  ->  FStar_Absyn_Syntax.bvvdef  ->  FStar_ToSMT_Term.term = (fun lid a -> (let _145_49 = (let _145_48 = (mk_term_projector_name lid a)
in ((_145_48), (FStar_ToSMT_Term.Arrow (((FStar_ToSMT_Term.Term_sort), (FStar_ToSMT_Term.Term_sort))))))
in (FStar_ToSMT_Term.mkFreeV _145_49)))


let mk_term_projector_by_pos : FStar_Ident.lident  ->  Prims.int  ->  FStar_ToSMT_Term.term = (fun lid i -> (let _145_55 = (let _145_54 = (mk_term_projector_name_by_pos lid i)
in ((_145_54), (FStar_ToSMT_Term.Arrow (((FStar_ToSMT_Term.Term_sort), (FStar_ToSMT_Term.Term_sort))))))
in (FStar_ToSMT_Term.mkFreeV _145_55)))


let mk_data_tester = (fun env l x -> (FStar_ToSMT_Term.mk_tester (escape l.FStar_Ident.str) x))


type varops_t =
{push : Prims.unit  ->  Prims.unit; pop : Prims.unit  ->  Prims.unit; mark : Prims.unit  ->  Prims.unit; reset_mark : Prims.unit  ->  Prims.unit; commit_mark : Prims.unit  ->  Prims.unit; new_var : FStar_Ident.ident  ->  FStar_Ident.ident  ->  Prims.string; new_fvar : FStar_Ident.lident  ->  Prims.string; fresh : Prims.string  ->  Prims.string; string_const : Prims.string  ->  FStar_ToSMT_Term.term; next_id : Prims.unit  ->  Prims.int}


let is_Mkvarops_t : varops_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkvarops_t"))))


let varops : varops_t = (

let initial_ctr = (Prims.parse_int "10")
in (

let ctr = (FStar_Util.mk_ref initial_ctr)
in (

let new_scope = (fun _50_101 -> (match (()) with
| () -> begin
(let _145_159 = (FStar_Util.smap_create (Prims.parse_int "100"))
in (let _145_158 = (FStar_Util.smap_create (Prims.parse_int "100"))
in ((_145_159), (_145_158))))
end))
in (

let scopes = (let _145_161 = (let _145_160 = (new_scope ())
in (_145_160)::[])
in (FStar_Util.mk_ref _145_161))
in (

let mk_unique = (fun y -> (

let y = (escape y)
in (

let y = (match ((let _145_165 = (FStar_ST.read scopes)
in (FStar_Util.find_map _145_165 (fun _50_109 -> (match (_50_109) with
| (names, _50_108) -> begin
(FStar_Util.smap_try_find names y)
end))))) with
| None -> begin
y
end
| Some (_50_112) -> begin
(

let _50_114 = (FStar_Util.incr ctr)
in (let _145_168 = (let _145_167 = (let _145_166 = (FStar_ST.read ctr)
in (FStar_Util.string_of_int _145_166))
in (Prims.strcat "__" _145_167))
in (Prims.strcat y _145_168)))
end)
in (

let top_scope = (let _145_170 = (let _145_169 = (FStar_ST.read scopes)
in (FStar_List.hd _145_169))
in (FStar_All.pipe_left Prims.fst _145_170))
in (

let _50_118 = (FStar_Util.smap_add top_scope y true)
in y)))))
in (

let new_var = (fun pp rn -> (FStar_All.pipe_left mk_unique (Prims.strcat pp.FStar_Ident.idText (Prims.strcat "__" rn.FStar_Ident.idText))))
in (

let new_fvar = (fun lid -> (mk_unique lid.FStar_Ident.str))
in (

let next_id = (fun _50_126 -> (match (()) with
| () -> begin
(

let _50_127 = (FStar_Util.incr ctr)
in (FStar_ST.read ctr))
end))
in (

let fresh = (fun pfx -> (let _145_182 = (let _145_181 = (next_id ())
in (FStar_All.pipe_left FStar_Util.string_of_int _145_181))
in (FStar_Util.format2 "%s_%s" pfx _145_182)))
in (

let string_const = (fun s -> (match ((let _145_186 = (FStar_ST.read scopes)
in (FStar_Util.find_map _145_186 (fun _50_136 -> (match (_50_136) with
| (_50_134, strings) -> begin
(FStar_Util.smap_try_find strings s)
end))))) with
| Some (f) -> begin
f
end
| None -> begin
(

let id = (next_id ())
in (

let f = (let _145_187 = (FStar_ToSMT_Term.mk_String_const id)
in (FStar_All.pipe_left FStar_ToSMT_Term.boxString _145_187))
in (

let top_scope = (let _145_189 = (let _145_188 = (FStar_ST.read scopes)
in (FStar_List.hd _145_188))
in (FStar_All.pipe_left Prims.snd _145_189))
in (

let _50_143 = (FStar_Util.smap_add top_scope s f)
in f))))
end))
in (

let push = (fun _50_146 -> (match (()) with
| () -> begin
(let _145_194 = (let _145_193 = (new_scope ())
in (let _145_192 = (FStar_ST.read scopes)
in (_145_193)::_145_192))
in (FStar_ST.op_Colon_Equals scopes _145_194))
end))
in (

let pop = (fun _50_148 -> (match (()) with
| () -> begin
(let _145_198 = (let _145_197 = (FStar_ST.read scopes)
in (FStar_List.tl _145_197))
in (FStar_ST.op_Colon_Equals scopes _145_198))
end))
in (

let mark = (fun _50_150 -> (match (()) with
| () -> begin
(push ())
end))
in (

let reset_mark = (fun _50_152 -> (match (()) with
| () -> begin
(pop ())
end))
in (

let commit_mark = (fun _50_154 -> (match (()) with
| () -> begin
(match ((FStar_ST.read scopes)) with
| ((hd1, hd2))::((next1, next2))::tl -> begin
(

let _50_167 = (FStar_Util.smap_fold hd1 (fun key value v -> (FStar_Util.smap_add next1 key value)) ())
in (

let _50_172 = (FStar_Util.smap_fold hd2 (fun key value v -> (FStar_Util.smap_add next2 key value)) ())
in (FStar_ST.op_Colon_Equals scopes ((((next1), (next2)))::tl))))
end
| _50_175 -> begin
(FStar_All.failwith "Impossible")
end)
end))
in {push = push; pop = pop; mark = mark; reset_mark = reset_mark; commit_mark = commit_mark; new_var = new_var; new_fvar = new_fvar; fresh = fresh; string_const = string_const; next_id = next_id})))))))))))))))


let unmangle = (fun x -> (let _145_214 = (let _145_213 = (FStar_Absyn_Util.unmangle_field_name x.FStar_Absyn_Syntax.ppname)
in (let _145_212 = (FStar_Absyn_Util.unmangle_field_name x.FStar_Absyn_Syntax.realname)
in ((_145_213), (_145_212))))
in (FStar_Absyn_Util.mkbvd _145_214)))


type binding =
| Binding_var of (FStar_Absyn_Syntax.bvvdef * FStar_ToSMT_Term.term)
| Binding_tvar of (FStar_Absyn_Syntax.btvdef * FStar_ToSMT_Term.term)
| Binding_fvar of (FStar_Ident.lident * Prims.string * FStar_ToSMT_Term.term Prims.option * FStar_ToSMT_Term.term Prims.option)
| Binding_ftvar of (FStar_Ident.lident * Prims.string * FStar_ToSMT_Term.term Prims.option)


let is_Binding_var = (fun _discr_ -> (match (_discr_) with
| Binding_var (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_tvar = (fun _discr_ -> (match (_discr_) with
| Binding_tvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_fvar = (fun _discr_ -> (match (_discr_) with
| Binding_fvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_ftvar = (fun _discr_ -> (match (_discr_) with
| Binding_ftvar (_) -> begin
true
end
| _ -> begin
false
end))


let ___Binding_var____0 = (fun projectee -> (match (projectee) with
| Binding_var (_50_180) -> begin
_50_180
end))


let ___Binding_tvar____0 = (fun projectee -> (match (projectee) with
| Binding_tvar (_50_183) -> begin
_50_183
end))


let ___Binding_fvar____0 = (fun projectee -> (match (projectee) with
| Binding_fvar (_50_186) -> begin
_50_186
end))


let ___Binding_ftvar____0 = (fun projectee -> (match (projectee) with
| Binding_ftvar (_50_189) -> begin
_50_189
end))


let binder_of_eithervar = (fun v -> ((v), (None)))


type env_t =
{bindings : binding Prims.list; depth : Prims.int; tcenv : FStar_Tc_Env.env; warn : Prims.bool; cache : (Prims.string * FStar_ToSMT_Term.sort Prims.list * FStar_ToSMT_Term.decl Prims.list) FStar_Util.smap; nolabels : Prims.bool; use_zfuel_name : Prims.bool; encode_non_total_function_typ : Prims.bool}


let is_Mkenv_t : env_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkenv_t"))))


let print_env : env_t  ->  Prims.string = (fun e -> (let _145_300 = (FStar_All.pipe_right e.bindings (FStar_List.map (fun _50_2 -> (match (_50_2) with
| Binding_var (x, t) -> begin
(FStar_Absyn_Print.strBvd x)
end
| Binding_tvar (a, t) -> begin
(FStar_Absyn_Print.strBvd a)
end
| Binding_fvar (l, s, t, _50_214) -> begin
(FStar_Absyn_Print.sli l)
end
| Binding_ftvar (l, s, t) -> begin
(FStar_Absyn_Print.sli l)
end))))
in (FStar_All.pipe_right _145_300 (FStar_String.concat ", "))))


let lookup_binding = (fun env f -> (FStar_Util.find_map env.bindings f))


let caption_t : env_t  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  Prims.string Prims.option = (fun env t -> if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _145_310 = (FStar_Absyn_Print.typ_to_string t)
in Some (_145_310))
end else begin
None
end)


let fresh_fvar : Prims.string  ->  FStar_ToSMT_Term.sort  ->  (Prims.string * FStar_ToSMT_Term.term) = (fun x s -> (

let xsym = (varops.fresh x)
in (let _145_315 = (FStar_ToSMT_Term.mkFreeV ((xsym), (s)))
in ((xsym), (_145_315)))))


let gen_term_var : env_t  ->  FStar_Absyn_Syntax.bvvdef  ->  (Prims.string * FStar_ToSMT_Term.term * env_t) = (fun env x -> (

let ysym = (let _145_320 = (FStar_Util.string_of_int env.depth)
in (Prims.strcat "@x" _145_320))
in (

let y = (FStar_ToSMT_Term.mkFreeV ((ysym), (FStar_ToSMT_Term.Term_sort)))
in ((ysym), (y), ((

let _50_233 = env
in {bindings = (Binding_var (((x), (y))))::env.bindings; depth = (env.depth + (Prims.parse_int "1")); tcenv = _50_233.tcenv; warn = _50_233.warn; cache = _50_233.cache; nolabels = _50_233.nolabels; use_zfuel_name = _50_233.use_zfuel_name; encode_non_total_function_typ = _50_233.encode_non_total_function_typ}))))))


let new_term_constant : env_t  ->  FStar_Absyn_Syntax.bvvdef  ->  (Prims.string * FStar_ToSMT_Term.term * env_t) = (fun env x -> (

let ysym = (varops.new_var x.FStar_Absyn_Syntax.ppname x.FStar_Absyn_Syntax.realname)
in (

let y = (FStar_ToSMT_Term.mkApp ((ysym), ([])))
in ((ysym), (y), ((

let _50_239 = env
in {bindings = (Binding_var (((x), (y))))::env.bindings; depth = _50_239.depth; tcenv = _50_239.tcenv; warn = _50_239.warn; cache = _50_239.cache; nolabels = _50_239.nolabels; use_zfuel_name = _50_239.use_zfuel_name; encode_non_total_function_typ = _50_239.encode_non_total_function_typ}))))))


let push_term_var : env_t  ->  FStar_Absyn_Syntax.bvvdef  ->  FStar_ToSMT_Term.term  ->  env_t = (fun env x t -> (

let _50_244 = env
in {bindings = (Binding_var (((x), (t))))::env.bindings; depth = _50_244.depth; tcenv = _50_244.tcenv; warn = _50_244.warn; cache = _50_244.cache; nolabels = _50_244.nolabels; use_zfuel_name = _50_244.use_zfuel_name; encode_non_total_function_typ = _50_244.encode_non_total_function_typ}))


let lookup_term_var = (fun env a -> (match ((lookup_binding env (fun _50_3 -> (match (_50_3) with
| Binding_var (b, t) when (FStar_Absyn_Util.bvd_eq b a.FStar_Absyn_Syntax.v) -> begin
Some (((b), (t)))
end
| _50_254 -> begin
None
end)))) with
| None -> begin
(let _145_335 = (let _145_334 = (FStar_Absyn_Print.strBvd a.FStar_Absyn_Syntax.v)
in (FStar_Util.format1 "Bound term variable not found: %s" _145_334))
in (FStar_All.failwith _145_335))
end
| Some (b, t) -> begin
t
end))


let gen_typ_var : env_t  ->  FStar_Absyn_Syntax.btvdef  ->  (Prims.string * FStar_ToSMT_Term.term * env_t) = (fun env x -> (

let ysym = (let _145_340 = (FStar_Util.string_of_int env.depth)
in (Prims.strcat "@a" _145_340))
in (

let y = (FStar_ToSMT_Term.mkFreeV ((ysym), (FStar_ToSMT_Term.Type_sort)))
in ((ysym), (y), ((

let _50_264 = env
in {bindings = (Binding_tvar (((x), (y))))::env.bindings; depth = (env.depth + (Prims.parse_int "1")); tcenv = _50_264.tcenv; warn = _50_264.warn; cache = _50_264.cache; nolabels = _50_264.nolabels; use_zfuel_name = _50_264.use_zfuel_name; encode_non_total_function_typ = _50_264.encode_non_total_function_typ}))))))


let new_typ_constant : env_t  ->  FStar_Absyn_Syntax.btvdef  ->  (Prims.string * FStar_ToSMT_Term.term * env_t) = (fun env x -> (

let ysym = (varops.new_var x.FStar_Absyn_Syntax.ppname x.FStar_Absyn_Syntax.realname)
in (

let y = (FStar_ToSMT_Term.mkApp ((ysym), ([])))
in ((ysym), (y), ((

let _50_270 = env
in {bindings = (Binding_tvar (((x), (y))))::env.bindings; depth = _50_270.depth; tcenv = _50_270.tcenv; warn = _50_270.warn; cache = _50_270.cache; nolabels = _50_270.nolabels; use_zfuel_name = _50_270.use_zfuel_name; encode_non_total_function_typ = _50_270.encode_non_total_function_typ}))))))


let push_typ_var : env_t  ->  FStar_Absyn_Syntax.btvdef  ->  FStar_ToSMT_Term.term  ->  env_t = (fun env x t -> (

let _50_275 = env
in {bindings = (Binding_tvar (((x), (t))))::env.bindings; depth = _50_275.depth; tcenv = _50_275.tcenv; warn = _50_275.warn; cache = _50_275.cache; nolabels = _50_275.nolabels; use_zfuel_name = _50_275.use_zfuel_name; encode_non_total_function_typ = _50_275.encode_non_total_function_typ}))


let lookup_typ_var = (fun env a -> (match ((lookup_binding env (fun _50_4 -> (match (_50_4) with
| Binding_tvar (b, t) when (FStar_Absyn_Util.bvd_eq b a.FStar_Absyn_Syntax.v) -> begin
Some (((b), (t)))
end
| _50_285 -> begin
None
end)))) with
| None -> begin
(let _145_355 = (let _145_354 = (FStar_Absyn_Print.strBvd a.FStar_Absyn_Syntax.v)
in (FStar_Util.format1 "Bound type variable not found: %s" _145_354))
in (FStar_All.failwith _145_355))
end
| Some (b, t) -> begin
t
end))


let new_term_constant_and_tok_from_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * Prims.string * env_t) = (fun env x -> (

let fname = (varops.new_fvar x)
in (

let ftok = (Prims.strcat fname "@tok")
in (let _145_366 = (

let _50_295 = env
in (let _145_365 = (let _145_364 = (let _145_363 = (let _145_362 = (let _145_361 = (FStar_ToSMT_Term.mkApp ((ftok), ([])))
in (FStar_All.pipe_left (fun _145_360 -> Some (_145_360)) _145_361))
in ((x), (fname), (_145_362), (None)))
in Binding_fvar (_145_363))
in (_145_364)::env.bindings)
in {bindings = _145_365; depth = _50_295.depth; tcenv = _50_295.tcenv; warn = _50_295.warn; cache = _50_295.cache; nolabels = _50_295.nolabels; use_zfuel_name = _50_295.use_zfuel_name; encode_non_total_function_typ = _50_295.encode_non_total_function_typ}))
in ((fname), (ftok), (_145_366))))))


let try_lookup_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * FStar_ToSMT_Term.term Prims.option * FStar_ToSMT_Term.term Prims.option) Prims.option = (fun env a -> (lookup_binding env (fun _50_5 -> (match (_50_5) with
| Binding_fvar (b, t1, t2, t3) when (FStar_Ident.lid_equals b a) -> begin
Some (((t1), (t2), (t3)))
end
| _50_307 -> begin
None
end))))


let lookup_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * FStar_ToSMT_Term.term Prims.option * FStar_ToSMT_Term.term Prims.option) = (fun env a -> (match ((try_lookup_lid env a)) with
| None -> begin
(let _145_377 = (let _145_376 = (FStar_Absyn_Print.sli a)
in (FStar_Util.format1 "Name not found: %s" _145_376))
in (FStar_All.failwith _145_377))
end
| Some (s) -> begin
s
end))


let push_free_var : env_t  ->  FStar_Ident.lident  ->  Prims.string  ->  FStar_ToSMT_Term.term Prims.option  ->  env_t = (fun env x fname ftok -> (

let _50_317 = env
in {bindings = (Binding_fvar (((x), (fname), (ftok), (None))))::env.bindings; depth = _50_317.depth; tcenv = _50_317.tcenv; warn = _50_317.warn; cache = _50_317.cache; nolabels = _50_317.nolabels; use_zfuel_name = _50_317.use_zfuel_name; encode_non_total_function_typ = _50_317.encode_non_total_function_typ}))


let push_zfuel_name : env_t  ->  FStar_Ident.lident  ->  Prims.string  ->  env_t = (fun env x f -> (

let _50_326 = (lookup_lid env x)
in (match (_50_326) with
| (t1, t2, _50_325) -> begin
(

let t3 = (let _145_394 = (let _145_393 = (let _145_392 = (FStar_ToSMT_Term.mkApp (("ZFuel"), ([])))
in (_145_392)::[])
in ((f), (_145_393)))
in (FStar_ToSMT_Term.mkApp _145_394))
in (

let _50_328 = env
in {bindings = (Binding_fvar (((x), (t1), (t2), (Some (t3)))))::env.bindings; depth = _50_328.depth; tcenv = _50_328.tcenv; warn = _50_328.warn; cache = _50_328.cache; nolabels = _50_328.nolabels; use_zfuel_name = _50_328.use_zfuel_name; encode_non_total_function_typ = _50_328.encode_non_total_function_typ}))
end)))


let lookup_free_var = (fun env a -> (

let _50_335 = (lookup_lid env a.FStar_Absyn_Syntax.v)
in (match (_50_335) with
| (name, sym, zf_opt) -> begin
(match (zf_opt) with
| Some (f) when env.use_zfuel_name -> begin
f
end
| _50_339 -> begin
(match (sym) with
| Some (t) -> begin
(match (t.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (_50_343, (fuel)::[]) -> begin
if (let _145_398 = (let _145_397 = (FStar_ToSMT_Term.fv_of_term fuel)
in (FStar_All.pipe_right _145_397 Prims.fst))
in (FStar_Util.starts_with _145_398 "fuel")) then begin
(let _145_399 = (FStar_ToSMT_Term.mkFreeV ((name), (FStar_ToSMT_Term.Term_sort)))
in (FStar_ToSMT_Term.mk_ApplyEF _145_399 fuel))
end else begin
t
end
end
| _50_349 -> begin
t
end)
end
| _50_351 -> begin
(let _145_401 = (let _145_400 = (FStar_Absyn_Print.sli a.FStar_Absyn_Syntax.v)
in (FStar_Util.format1 "Name not found: %s" _145_400))
in (FStar_All.failwith _145_401))
end)
end)
end)))


let lookup_free_var_name = (fun env a -> (

let _50_359 = (lookup_lid env a.FStar_Absyn_Syntax.v)
in (match (_50_359) with
| (x, _50_356, _50_358) -> begin
x
end)))


let lookup_free_var_sym = (fun env a -> (

let _50_365 = (lookup_lid env a.FStar_Absyn_Syntax.v)
in (match (_50_365) with
| (name, sym, zf_opt) -> begin
(match (zf_opt) with
| Some ({FStar_ToSMT_Term.tm = FStar_ToSMT_Term.App (g, zf); FStar_ToSMT_Term.hash = _50_369; FStar_ToSMT_Term.freevars = _50_367}) when env.use_zfuel_name -> begin
((g), (zf))
end
| _50_377 -> begin
(match (sym) with
| None -> begin
((FStar_ToSMT_Term.Var (name)), ([]))
end
| Some (sym) -> begin
(match (sym.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (g, (fuel)::[]) -> begin
((g), ((fuel)::[]))
end
| _50_387 -> begin
((FStar_ToSMT_Term.Var (name)), ([]))
end)
end)
end)
end)))


let new_typ_constant_and_tok_from_lid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * Prims.string * env_t) = (fun env x -> (

let fname = (varops.new_fvar x)
in (

let ftok = (Prims.strcat fname "@tok")
in (let _145_416 = (

let _50_392 = env
in (let _145_415 = (let _145_414 = (let _145_413 = (let _145_412 = (let _145_411 = (FStar_ToSMT_Term.mkApp ((ftok), ([])))
in (FStar_All.pipe_left (fun _145_410 -> Some (_145_410)) _145_411))
in ((x), (fname), (_145_412)))
in Binding_ftvar (_145_413))
in (_145_414)::env.bindings)
in {bindings = _145_415; depth = _50_392.depth; tcenv = _50_392.tcenv; warn = _50_392.warn; cache = _50_392.cache; nolabels = _50_392.nolabels; use_zfuel_name = _50_392.use_zfuel_name; encode_non_total_function_typ = _50_392.encode_non_total_function_typ}))
in ((fname), (ftok), (_145_416))))))


let lookup_tlid : env_t  ->  FStar_Ident.lident  ->  (Prims.string * FStar_ToSMT_Term.term Prims.option) = (fun env a -> (match ((lookup_binding env (fun _50_6 -> (match (_50_6) with
| Binding_ftvar (b, t1, t2) when (FStar_Ident.lid_equals b a) -> begin
Some (((t1), (t2)))
end
| _50_403 -> begin
None
end)))) with
| None -> begin
(let _145_423 = (let _145_422 = (FStar_Absyn_Print.sli a)
in (FStar_Util.format1 "Type name not found: %s" _145_422))
in (FStar_All.failwith _145_423))
end
| Some (s) -> begin
s
end))


let push_free_tvar : env_t  ->  FStar_Ident.lident  ->  Prims.string  ->  FStar_ToSMT_Term.term Prims.option  ->  env_t = (fun env x fname ftok -> (

let _50_411 = env
in {bindings = (Binding_ftvar (((x), (fname), (ftok))))::env.bindings; depth = _50_411.depth; tcenv = _50_411.tcenv; warn = _50_411.warn; cache = _50_411.cache; nolabels = _50_411.nolabels; use_zfuel_name = _50_411.use_zfuel_name; encode_non_total_function_typ = _50_411.encode_non_total_function_typ}))


let lookup_free_tvar = (fun env a -> (match ((let _145_434 = (lookup_tlid env a.FStar_Absyn_Syntax.v)
in (FStar_All.pipe_right _145_434 Prims.snd))) with
| None -> begin
(let _145_436 = (let _145_435 = (FStar_Absyn_Print.sli a.FStar_Absyn_Syntax.v)
in (FStar_Util.format1 "Type name not found: %s" _145_435))
in (FStar_All.failwith _145_436))
end
| Some (t) -> begin
t
end))


let lookup_free_tvar_name = (fun env a -> (let _145_439 = (lookup_tlid env a.FStar_Absyn_Syntax.v)
in (FStar_All.pipe_right _145_439 Prims.fst)))


let tok_of_name : env_t  ->  Prims.string  ->  FStar_ToSMT_Term.term Prims.option = (fun env nm -> (FStar_Util.find_map env.bindings (fun _50_7 -> (match (_50_7) with
| (Binding_fvar (_, nm', tok, _)) | (Binding_ftvar (_, nm', tok)) when (nm = nm') -> begin
tok
end
| _50_436 -> begin
None
end))))


let mkForall_fuel' = (fun n _50_441 -> (match (_50_441) with
| (pats, vars, body) -> begin
(

let fallback = (fun _50_443 -> (match (()) with
| () -> begin
(FStar_ToSMT_Term.mkForall ((pats), (vars), (body)))
end))
in if (FStar_Options.unthrottle_inductives ()) then begin
(fallback ())
end else begin
(

let _50_446 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_446) with
| (fsym, fterm) -> begin
(

let add_fuel = (fun tms -> (FStar_All.pipe_right tms (FStar_List.map (fun p -> (match (p.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.Var ("HasType"), args) -> begin
(FStar_ToSMT_Term.mkApp (("HasTypeFuel"), ((fterm)::args)))
end
| _50_456 -> begin
p
end)))))
in (

let pats = (FStar_List.map add_fuel pats)
in (

let body = (match (body.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.Imp, (guard)::(body')::[]) -> begin
(

let guard = (match (guard.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.And, guards) -> begin
(let _145_452 = (add_fuel guards)
in (FStar_ToSMT_Term.mk_and_l _145_452))
end
| _50_469 -> begin
(let _145_453 = (add_fuel ((guard)::[]))
in (FStar_All.pipe_right _145_453 FStar_List.hd))
end)
in (FStar_ToSMT_Term.mkImp ((guard), (body'))))
end
| _50_472 -> begin
body
end)
in (

let vars = (((fsym), (FStar_ToSMT_Term.Fuel_sort)))::vars
in (FStar_ToSMT_Term.mkForall ((pats), (vars), (body)))))))
end))
end)
end))


let mkForall_fuel : (FStar_ToSMT_Term.pat Prims.list Prims.list * FStar_ToSMT_Term.fvs * FStar_ToSMT_Term.term)  ->  FStar_ToSMT_Term.term = (mkForall_fuel' (Prims.parse_int "1"))


let head_normal : env_t  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  Prims.bool = (fun env t -> (

let t = (FStar_Absyn_Util.unmeta_typ t)
in (match (t.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Typ_fun (_)) | (FStar_Absyn_Syntax.Typ_refine (_)) | (FStar_Absyn_Syntax.Typ_btvar (_)) | (FStar_Absyn_Syntax.Typ_uvar (_)) | (FStar_Absyn_Syntax.Typ_lam (_)) -> begin
true
end
| (FStar_Absyn_Syntax.Typ_const (v)) | (FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (v); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _)) -> begin
(let _145_459 = (FStar_Tc_Env.lookup_typ_abbrev env.tcenv v.FStar_Absyn_Syntax.v)
in (FStar_All.pipe_right _145_459 FStar_Option.isNone))
end
| _50_510 -> begin
false
end)))


let whnf : env_t  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env t -> if (head_normal env t) then begin
t
end else begin
(FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.WHNF)::(FStar_Tc_Normalize.DeltaHard)::[]) env.tcenv t)
end)


let whnf_e : env_t  ->  FStar_Absyn_Syntax.exp  ->  FStar_Absyn_Syntax.exp = (fun env e -> (FStar_Tc_Normalize.norm_exp ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.WHNF)::[]) env.tcenv e))


let norm_t : env_t  ->  FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ = (fun env t -> (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.Beta)::[]) env.tcenv t))


let norm_k : env_t  ->  FStar_Absyn_Syntax.knd  ->  FStar_Absyn_Syntax.knd = (fun env k -> (FStar_Tc_Normalize.normalize_kind env.tcenv k))


let trivial_post : FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ = (fun t -> (let _145_481 = (let _145_480 = (let _145_478 = (FStar_Absyn_Syntax.null_v_binder t)
in (_145_478)::[])
in (let _145_479 = (FStar_Absyn_Util.ftv FStar_Absyn_Const.true_lid FStar_Absyn_Syntax.ktype)
in ((_145_480), (_145_479))))
in (FStar_Absyn_Syntax.mk_Typ_lam _145_481 None t.FStar_Absyn_Syntax.pos)))


let mk_ApplyE : FStar_ToSMT_Term.term  ->  (Prims.string * FStar_ToSMT_Term.sort) Prims.list  ->  FStar_ToSMT_Term.term = (fun e vars -> (FStar_All.pipe_right vars (FStar_List.fold_left (fun out var -> (match ((Prims.snd var)) with
| FStar_ToSMT_Term.Type_sort -> begin
(let _145_488 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyET out _145_488))
end
| FStar_ToSMT_Term.Fuel_sort -> begin
(let _145_489 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyEF out _145_489))
end
| _50_527 -> begin
(let _145_490 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyEE out _145_490))
end)) e)))


let mk_ApplyE_args : FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term, FStar_ToSMT_Term.term) FStar_Util.either Prims.list  ->  FStar_ToSMT_Term.term = (fun e args -> (FStar_All.pipe_right args (FStar_List.fold_left (fun out arg -> (match (arg) with
| FStar_Util.Inl (t) -> begin
(FStar_ToSMT_Term.mk_ApplyET out t)
end
| FStar_Util.Inr (e) -> begin
(FStar_ToSMT_Term.mk_ApplyEE out e)
end)) e)))


let mk_ApplyT : FStar_ToSMT_Term.term  ->  (Prims.string * FStar_ToSMT_Term.sort) Prims.list  ->  FStar_ToSMT_Term.term = (fun t vars -> (FStar_All.pipe_right vars (FStar_List.fold_left (fun out var -> (match ((Prims.snd var)) with
| FStar_ToSMT_Term.Type_sort -> begin
(let _145_503 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyTT out _145_503))
end
| _50_542 -> begin
(let _145_504 = (FStar_ToSMT_Term.mkFreeV var)
in (FStar_ToSMT_Term.mk_ApplyTE out _145_504))
end)) t)))


let mk_ApplyT_args : FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term, FStar_ToSMT_Term.term) FStar_Util.either Prims.list  ->  FStar_ToSMT_Term.term = (fun t args -> (FStar_All.pipe_right args (FStar_List.fold_left (fun out arg -> (match (arg) with
| FStar_Util.Inl (t) -> begin
(FStar_ToSMT_Term.mk_ApplyTT out t)
end
| FStar_Util.Inr (e) -> begin
(FStar_ToSMT_Term.mk_ApplyTE out e)
end)) t)))


let is_app : FStar_ToSMT_Term.op  ->  Prims.bool = (fun _50_8 -> (match (_50_8) with
| (FStar_ToSMT_Term.Var ("ApplyTT")) | (FStar_ToSMT_Term.Var ("ApplyTE")) | (FStar_ToSMT_Term.Var ("ApplyET")) | (FStar_ToSMT_Term.Var ("ApplyEE")) -> begin
true
end
| _50_561 -> begin
false
end))


let is_eta : env_t  ->  FStar_ToSMT_Term.fv Prims.list  ->  FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term Prims.option = (fun env vars t -> (

let rec aux = (fun t xs -> (match (((t.FStar_ToSMT_Term.tm), (xs))) with
| (FStar_ToSMT_Term.App (app, (f)::({FStar_ToSMT_Term.tm = FStar_ToSMT_Term.FreeV (y); FStar_ToSMT_Term.hash = _50_572; FStar_ToSMT_Term.freevars = _50_570})::[]), (x)::xs) when ((is_app app) && (FStar_ToSMT_Term.fv_eq x y)) -> begin
(aux f xs)
end
| (FStar_ToSMT_Term.App (FStar_ToSMT_Term.Var (f), args), _50_590) -> begin
if (((FStar_List.length args) = (FStar_List.length vars)) && (FStar_List.forall2 (fun a v -> (match (a.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.FreeV (fv) -> begin
(FStar_ToSMT_Term.fv_eq fv v)
end
| _50_597 -> begin
false
end)) args vars)) then begin
(tok_of_name env f)
end else begin
None
end
end
| (_50_599, []) -> begin
(

let fvs = (FStar_ToSMT_Term.free_variables t)
in if (FStar_All.pipe_right fvs (FStar_List.for_all (fun fv -> (not ((FStar_Util.for_some (FStar_ToSMT_Term.fv_eq fv) vars)))))) then begin
Some (t)
end else begin
None
end)
end
| _50_605 -> begin
None
end))
in (aux t (FStar_List.rev vars))))


type label =
(FStar_ToSMT_Term.fv * Prims.string * FStar_Range.range)


type labels =
label Prims.list


type pattern =
{pat_vars : (FStar_Absyn_Syntax.either_var * FStar_ToSMT_Term.fv) Prims.list; pat_term : Prims.unit  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t); guard : FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term; projections : FStar_ToSMT_Term.term  ->  (FStar_Absyn_Syntax.either_var * FStar_ToSMT_Term.term) Prims.list}


let is_Mkpattern : pattern  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkpattern"))))


exception Let_rec_unencodeable


let is_Let_rec_unencodeable = (fun _discr_ -> (match (_discr_) with
| Let_rec_unencodeable (_) -> begin
true
end
| _ -> begin
false
end))


exception Bad_form


let is_Bad_form = (fun _discr_ -> (match (_discr_) with
| Bad_form (_) -> begin
true
end
| _ -> begin
false
end))


let constructor_string_of_int_qualifier : (FStar_Const.signedness * FStar_Const.width)  ->  Prims.string = (fun _50_9 -> (match (_50_9) with
| (FStar_Const.Unsigned, FStar_Const.Int8) -> begin
"FStar.UInt8.UInt8"
end
| (FStar_Const.Signed, FStar_Const.Int8) -> begin
"FStar.Int8.Int8"
end
| (FStar_Const.Unsigned, FStar_Const.Int16) -> begin
"FStar.UInt16.UInt16"
end
| (FStar_Const.Signed, FStar_Const.Int16) -> begin
"FStar.Int16.Int16"
end
| (FStar_Const.Unsigned, FStar_Const.Int32) -> begin
"FStar.UInt32.UInt32"
end
| (FStar_Const.Signed, FStar_Const.Int32) -> begin
"FStar.Int32.Int32"
end
| (FStar_Const.Unsigned, FStar_Const.Int64) -> begin
"FStar.UInt64.UInt64"
end
| (FStar_Const.Signed, FStar_Const.Int64) -> begin
"FStar.Int64.Int64"
end))


let encode_const : FStar_Const.sconst  ->  FStar_ToSMT_Term.term = (fun _50_10 -> (match (_50_10) with
| FStar_Const.Const_unit -> begin
FStar_ToSMT_Term.mk_Term_unit
end
| FStar_Const.Const_bool (true) -> begin
(FStar_ToSMT_Term.boxBool FStar_ToSMT_Term.mkTrue)
end
| FStar_Const.Const_bool (false) -> begin
(FStar_ToSMT_Term.boxBool FStar_ToSMT_Term.mkFalse)
end
| FStar_Const.Const_char (c) -> begin
(let _145_566 = (let _145_565 = (let _145_564 = (let _145_563 = (FStar_ToSMT_Term.mkInteger' (FStar_Util.int_of_char c))
in (FStar_ToSMT_Term.boxInt _145_563))
in (_145_564)::[])
in (("FStar.Char.Char"), (_145_565)))
in (FStar_ToSMT_Term.mkApp _145_566))
end
| FStar_Const.Const_int (i, None) -> begin
(let _145_567 = (FStar_ToSMT_Term.mkInteger i)
in (FStar_ToSMT_Term.boxInt _145_567))
end
| FStar_Const.Const_int (i, Some (q)) -> begin
(let _145_571 = (let _145_570 = (let _145_569 = (let _145_568 = (FStar_ToSMT_Term.mkInteger i)
in (FStar_ToSMT_Term.boxInt _145_568))
in (_145_569)::[])
in (((constructor_string_of_int_qualifier q)), (_145_570)))
in (FStar_ToSMT_Term.mkApp _145_571))
end
| FStar_Const.Const_string (bytes, _50_655) -> begin
(let _145_572 = (FStar_All.pipe_left FStar_Util.string_of_bytes bytes)
in (varops.string_const _145_572))
end
| c -> begin
(let _145_574 = (let _145_573 = (FStar_Absyn_Print.const_to_string c)
in (FStar_Util.format1 "Unhandled constant: %s\n" _145_573))
in (FStar_All.failwith _145_574))
end))


let as_function_typ : env_t  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env t0 -> (

let rec aux = (fun norm t -> (

let t = (FStar_Absyn_Util.compress_typ t)
in (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (_50_666) -> begin
t
end
| FStar_Absyn_Syntax.Typ_refine (_50_669) -> begin
(let _145_583 = (FStar_Absyn_Util.unrefine t)
in (aux true _145_583))
end
| _50_672 -> begin
if norm then begin
(let _145_584 = (whnf env t)
in (aux false _145_584))
end else begin
(let _145_587 = (let _145_586 = (FStar_Range.string_of_range t0.FStar_Absyn_Syntax.pos)
in (let _145_585 = (FStar_Absyn_Print.typ_to_string t0)
in (FStar_Util.format2 "(%s) Expected a function typ; got %s" _145_586 _145_585)))
in (FStar_All.failwith _145_587))
end
end)))
in (aux true t0)))


let rec encode_knd_term : FStar_Absyn_Syntax.knd  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun k env -> (match ((let _145_624 = (FStar_Absyn_Util.compress_kind k)
in _145_624.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Kind_type -> begin
((FStar_ToSMT_Term.mk_Kind_type), ([]))
end
| FStar_Absyn_Syntax.Kind_abbrev (_50_677, k0) -> begin
(

let _50_681 = if (FStar_Tc_Env.debug env.tcenv (FStar_Options.Other ("Encoding"))) then begin
(let _145_626 = (FStar_Absyn_Print.kind_to_string k)
in (let _145_625 = (FStar_Absyn_Print.kind_to_string k0)
in (FStar_Util.print2 "Encoding kind abbrev %s, expanded to %s\n" _145_626 _145_625)))
end else begin
()
end
in (encode_knd_term k0 env))
end
| FStar_Absyn_Syntax.Kind_uvar (uv, _50_685) -> begin
(let _145_628 = (let _145_627 = (FStar_Unionfind.uvar_id uv)
in (FStar_ToSMT_Term.mk_Kind_uvar _145_627))
in ((_145_628), ([])))
end
| FStar_Absyn_Syntax.Kind_arrow (bs, kbody) -> begin
(

let tsym = (let _145_629 = (varops.fresh "t")
in ((_145_629), (FStar_ToSMT_Term.Type_sort)))
in (

let t = (FStar_ToSMT_Term.mkFreeV tsym)
in (

let _50_700 = (encode_binders None bs env)
in (match (_50_700) with
| (vars, guards, env', decls, _50_699) -> begin
(

let app = (mk_ApplyT t vars)
in (

let _50_704 = (encode_knd kbody env' app)
in (match (_50_704) with
| (kbody, decls') -> begin
(

let rec aux = (fun app vars guards -> (match (((vars), (guards))) with
| ([], []) -> begin
kbody
end
| ((x)::vars, (g)::guards) -> begin
(

let app = (mk_ApplyT app ((x)::[]))
in (

let body = (aux app vars guards)
in (

let body = (match (vars) with
| [] -> begin
body
end
| _50_723 -> begin
(let _145_638 = (let _145_637 = (let _145_636 = (FStar_ToSMT_Term.mk_PreKind app)
in (FStar_ToSMT_Term.mk_tester "Kind_arrow" _145_636))
in ((_145_637), (body)))
in (FStar_ToSMT_Term.mkAnd _145_638))
end)
in (let _145_640 = (let _145_639 = (FStar_ToSMT_Term.mkImp ((g), (body)))
in ((((app)::[])::[]), ((x)::[]), (_145_639)))
in (FStar_ToSMT_Term.mkForall _145_640)))))
end
| _50_726 -> begin
(FStar_All.failwith "Impossible: vars and guards are in 1-1 correspondence")
end))
in (

let k_interp = (aux t vars guards)
in (

let cvars = (let _145_642 = (FStar_ToSMT_Term.free_variables k_interp)
in (FStar_All.pipe_right _145_642 (FStar_List.filter (fun _50_731 -> (match (_50_731) with
| (x, _50_730) -> begin
(x <> (Prims.fst tsym))
end)))))
in (

let tkey = (FStar_ToSMT_Term.mkForall (([]), ((tsym)::cvars), (k_interp)))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (k', sorts, _50_737) -> begin
(let _145_645 = (let _145_644 = (let _145_643 = (FStar_All.pipe_right cvars (FStar_List.map FStar_ToSMT_Term.mkFreeV))
in ((k'), (_145_643)))
in (FStar_ToSMT_Term.mkApp _145_644))
in ((_145_645), ([])))
end
| None -> begin
(

let ksym = (varops.fresh "Kind_arrow")
in (

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let caption = if (FStar_Options.log_queries ()) then begin
(let _145_646 = (FStar_Tc_Normalize.kind_norm_to_string env.tcenv k)
in Some (_145_646))
end else begin
None
end
in (

let kdecl = FStar_ToSMT_Term.DeclFun (((ksym), (cvar_sorts), (FStar_ToSMT_Term.Kind_sort), (caption)))
in (

let k = (let _145_648 = (let _145_647 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in ((ksym), (_145_647)))
in (FStar_ToSMT_Term.mkApp _145_648))
in (

let t_has_k = (FStar_ToSMT_Term.mk_HasKind t k)
in (

let k_interp = (let _145_657 = (let _145_656 = (let _145_655 = (let _145_654 = (let _145_653 = (let _145_652 = (let _145_651 = (let _145_650 = (let _145_649 = (FStar_ToSMT_Term.mk_PreKind t)
in (FStar_ToSMT_Term.mk_tester "Kind_arrow" _145_649))
in ((_145_650), (k_interp)))
in (FStar_ToSMT_Term.mkAnd _145_651))
in ((t_has_k), (_145_652)))
in (FStar_ToSMT_Term.mkIff _145_653))
in ((((t_has_k)::[])::[]), ((tsym)::cvars), (_145_654)))
in (FStar_ToSMT_Term.mkForall _145_655))
in ((_145_656), (Some ((Prims.strcat ksym " interpretation")))))
in FStar_ToSMT_Term.Assume (_145_657))
in (

let k_decls = (FStar_List.append decls (FStar_List.append decls' ((kdecl)::(k_interp)::[])))
in (

let _50_749 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash ((ksym), (cvar_sorts), (k_decls)))
in ((k), (k_decls)))))))))))
end)))))
end)))
end))))
end
| _50_752 -> begin
(let _145_659 = (let _145_658 = (FStar_Absyn_Print.kind_to_string k)
in (FStar_Util.format1 "Unknown kind: %s" _145_658))
in (FStar_All.failwith _145_659))
end))
and encode_knd : FStar_Absyn_Syntax.knd  ->  env_t  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decl Prims.list) = (fun k env t -> (

let _50_758 = (encode_knd_term k env)
in (match (_50_758) with
| (k, decls) -> begin
(let _145_663 = (FStar_ToSMT_Term.mk_HasKind t k)
in ((_145_663), (decls)))
end)))
and encode_binders : FStar_ToSMT_Term.term Prims.option  ->  FStar_Absyn_Syntax.binders  ->  env_t  ->  (FStar_ToSMT_Term.fv Prims.list * FStar_ToSMT_Term.term Prims.list * env_t * FStar_ToSMT_Term.decls_t * (FStar_Absyn_Syntax.btvdef, FStar_Absyn_Syntax.bvvdef) FStar_Util.either Prims.list) = (fun fuel_opt bs env -> (

let _50_762 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _145_667 = (FStar_Absyn_Print.binders_to_string ", " bs)
in (FStar_Util.print1 "Encoding binders %s\n" _145_667))
end else begin
()
end
in (

let _50_812 = (FStar_All.pipe_right bs (FStar_List.fold_left (fun _50_769 b -> (match (_50_769) with
| (vars, guards, env, decls, names) -> begin
(

let _50_806 = (match ((Prims.fst b)) with
| FStar_Util.Inl ({FStar_Absyn_Syntax.v = a; FStar_Absyn_Syntax.sort = k; FStar_Absyn_Syntax.p = _50_772}) -> begin
(

let a = (unmangle a)
in (

let _50_781 = (gen_typ_var env a)
in (match (_50_781) with
| (aasym, aa, env') -> begin
(

let _50_782 = if (FStar_Tc_Env.debug env.tcenv (FStar_Options.Other ("Encoding"))) then begin
(let _145_671 = (FStar_Absyn_Print.strBvd a)
in (let _145_670 = (FStar_Absyn_Print.kind_to_string k)
in (FStar_Util.print3 "Encoding type binder %s (%s) at kind %s\n" _145_671 aasym _145_670)))
end else begin
()
end
in (

let _50_786 = (encode_knd k env aa)
in (match (_50_786) with
| (guard_a_k, decls') -> begin
((((aasym), (FStar_ToSMT_Term.Type_sort))), (guard_a_k), (env'), (decls'), (FStar_Util.Inl (a)))
end)))
end)))
end
| FStar_Util.Inr ({FStar_Absyn_Syntax.v = x; FStar_Absyn_Syntax.sort = t; FStar_Absyn_Syntax.p = _50_788}) -> begin
(

let x = (unmangle x)
in (

let _50_797 = (gen_term_var env x)
in (match (_50_797) with
| (xxsym, xx, env') -> begin
(

let _50_800 = (let _145_672 = (norm_t env t)
in (encode_typ_pred fuel_opt _145_672 env xx))
in (match (_50_800) with
| (guard_x_t, decls') -> begin
((((xxsym), (FStar_ToSMT_Term.Term_sort))), (guard_x_t), (env'), (decls'), (FStar_Util.Inr (x)))
end))
end)))
end)
in (match (_50_806) with
| (v, g, env, decls', n) -> begin
(((v)::vars), ((g)::guards), (env), ((FStar_List.append decls decls')), ((n)::names))
end))
end)) (([]), ([]), (env), ([]), ([]))))
in (match (_50_812) with
| (vars, guards, env, decls, names) -> begin
(((FStar_List.rev vars)), ((FStar_List.rev guards)), (env), (decls), ((FStar_List.rev names)))
end))))
and encode_typ_pred : FStar_ToSMT_Term.term Prims.option  ->  FStar_Absyn_Syntax.typ  ->  env_t  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun fuel_opt t env e -> (

let t = (FStar_Absyn_Util.compress_typ t)
in (

let _50_820 = (encode_typ_term t env)
in (match (_50_820) with
| (t, decls) -> begin
(let _145_677 = (FStar_ToSMT_Term.mk_HasTypeWithFuel fuel_opt e t)
in ((_145_677), (decls)))
end))))
and encode_typ_pred' : FStar_ToSMT_Term.term Prims.option  ->  FStar_Absyn_Syntax.typ  ->  env_t  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun fuel_opt t env e -> (

let t = (FStar_Absyn_Util.compress_typ t)
in (

let _50_828 = (encode_typ_term t env)
in (match (_50_828) with
| (t, decls) -> begin
(match (fuel_opt) with
| None -> begin
(let _145_682 = (FStar_ToSMT_Term.mk_HasTypeZ e t)
in ((_145_682), (decls)))
end
| Some (f) -> begin
(let _145_683 = (FStar_ToSMT_Term.mk_HasTypeFuel f e t)
in ((_145_683), (decls)))
end)
end))))
and encode_typ_term : FStar_Absyn_Syntax.typ  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun t env -> (

let t0 = (FStar_Absyn_Util.compress_typ t)
in (match (t0.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_btvar (a) -> begin
(let _145_686 = (lookup_typ_var env a)
in ((_145_686), ([])))
end
| FStar_Absyn_Syntax.Typ_const (fv) -> begin
(let _145_687 = (lookup_free_tvar env fv)
in ((_145_687), ([])))
end
| FStar_Absyn_Syntax.Typ_fun (binders, res) -> begin
if ((env.encode_non_total_function_typ && (FStar_Absyn_Util.is_pure_or_ghost_comp res)) || (FStar_Absyn_Util.is_tot_or_gtot_comp res)) then begin
(

let _50_849 = (encode_binders None binders env)
in (match (_50_849) with
| (vars, guards, env', decls, _50_848) -> begin
(

let fsym = (let _145_688 = (varops.fresh "f")
in ((_145_688), (FStar_ToSMT_Term.Term_sort)))
in (

let f = (FStar_ToSMT_Term.mkFreeV fsym)
in (

let app = (mk_ApplyE f vars)
in (

let _50_855 = (FStar_Tc_Util.pure_or_ghost_pre_and_post env.tcenv res)
in (match (_50_855) with
| (pre_opt, res_t) -> begin
(

let _50_858 = (encode_typ_pred None res_t env' app)
in (match (_50_858) with
| (res_pred, decls') -> begin
(

let _50_867 = (match (pre_opt) with
| None -> begin
(let _145_689 = (FStar_ToSMT_Term.mk_and_l guards)
in ((_145_689), (decls)))
end
| Some (pre) -> begin
(

let _50_864 = (encode_formula pre env')
in (match (_50_864) with
| (guard, decls0) -> begin
(let _145_690 = (FStar_ToSMT_Term.mk_and_l ((guard)::guards))
in ((_145_690), ((FStar_List.append decls decls0))))
end))
end)
in (match (_50_867) with
| (guards, guard_decls) -> begin
(

let t_interp = (let _145_692 = (let _145_691 = (FStar_ToSMT_Term.mkImp ((guards), (res_pred)))
in ((((app)::[])::[]), (vars), (_145_691)))
in (FStar_ToSMT_Term.mkForall _145_692))
in (

let cvars = (let _145_694 = (FStar_ToSMT_Term.free_variables t_interp)
in (FStar_All.pipe_right _145_694 (FStar_List.filter (fun _50_872 -> (match (_50_872) with
| (x, _50_871) -> begin
(x <> (Prims.fst fsym))
end)))))
in (

let tkey = (FStar_ToSMT_Term.mkForall (([]), ((fsym)::cvars), (t_interp)))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (t', sorts, _50_878) -> begin
(let _145_697 = (let _145_696 = (let _145_695 = (FStar_All.pipe_right cvars (FStar_List.map FStar_ToSMT_Term.mkFreeV))
in ((t'), (_145_695)))
in (FStar_ToSMT_Term.mkApp _145_696))
in ((_145_697), ([])))
end
| None -> begin
(

let tsym = (varops.fresh "Typ_fun")
in (

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let caption = if (FStar_Options.log_queries ()) then begin
(let _145_698 = (FStar_Tc_Normalize.typ_norm_to_string env.tcenv t0)
in Some (_145_698))
end else begin
None
end
in (

let tdecl = FStar_ToSMT_Term.DeclFun (((tsym), (cvar_sorts), (FStar_ToSMT_Term.Type_sort), (caption)))
in (

let t = (let _145_700 = (let _145_699 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in ((tsym), (_145_699)))
in (FStar_ToSMT_Term.mkApp _145_700))
in (

let t_has_kind = (FStar_ToSMT_Term.mk_HasKind t FStar_ToSMT_Term.mk_Kind_type)
in (

let k_assumption = (let _145_702 = (let _145_701 = (FStar_ToSMT_Term.mkForall ((((t_has_kind)::[])::[]), (cvars), (t_has_kind)))
in ((_145_701), (Some ((Prims.strcat tsym " kinding")))))
in FStar_ToSMT_Term.Assume (_145_702))
in (

let f_has_t = (FStar_ToSMT_Term.mk_HasType f t)
in (

let f_has_t_z = (FStar_ToSMT_Term.mk_HasTypeZ f t)
in (

let pre_typing = (let _145_709 = (let _145_708 = (let _145_707 = (let _145_706 = (let _145_705 = (let _145_704 = (let _145_703 = (FStar_ToSMT_Term.mk_PreType f)
in (FStar_ToSMT_Term.mk_tester "Typ_fun" _145_703))
in ((f_has_t), (_145_704)))
in (FStar_ToSMT_Term.mkImp _145_705))
in ((((f_has_t)::[])::[]), ((fsym)::cvars), (_145_706)))
in (mkForall_fuel _145_707))
in ((_145_708), (Some ("pre-typing for functions"))))
in FStar_ToSMT_Term.Assume (_145_709))
in (

let t_interp = (let _145_713 = (let _145_712 = (let _145_711 = (let _145_710 = (FStar_ToSMT_Term.mkIff ((f_has_t_z), (t_interp)))
in ((((f_has_t_z)::[])::[]), ((fsym)::cvars), (_145_710)))
in (FStar_ToSMT_Term.mkForall _145_711))
in ((_145_712), (Some ((Prims.strcat tsym " interpretation")))))
in FStar_ToSMT_Term.Assume (_145_713))
in (

let t_decls = (FStar_List.append decls (FStar_List.append decls' ((tdecl)::(k_assumption)::(pre_typing)::(t_interp)::[])))
in (

let _50_894 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash ((tsym), (cvar_sorts), (t_decls)))
in ((t), (t_decls)))))))))))))))
end))))
end))
end))
end)))))
end))
end else begin
(

let tsym = (varops.fresh "Non_total_Typ_fun")
in (

let tdecl = FStar_ToSMT_Term.DeclFun (((tsym), ([]), (FStar_ToSMT_Term.Type_sort), (None)))
in (

let t = (FStar_ToSMT_Term.mkApp ((tsym), ([])))
in (

let t_kinding = (let _145_715 = (let _145_714 = (FStar_ToSMT_Term.mk_HasKind t FStar_ToSMT_Term.mk_Kind_type)
in ((_145_714), (None)))
in FStar_ToSMT_Term.Assume (_145_715))
in (

let fsym = (("f"), (FStar_ToSMT_Term.Term_sort))
in (

let f = (FStar_ToSMT_Term.mkFreeV fsym)
in (

let f_has_t = (FStar_ToSMT_Term.mk_HasType f t)
in (

let t_interp = (let _145_722 = (let _145_721 = (let _145_720 = (let _145_719 = (let _145_718 = (let _145_717 = (let _145_716 = (FStar_ToSMT_Term.mk_PreType f)
in (FStar_ToSMT_Term.mk_tester "Typ_fun" _145_716))
in ((f_has_t), (_145_717)))
in (FStar_ToSMT_Term.mkImp _145_718))
in ((((f_has_t)::[])::[]), ((fsym)::[]), (_145_719)))
in (mkForall_fuel _145_720))
in ((_145_721), (Some ("pre-typing"))))
in FStar_ToSMT_Term.Assume (_145_722))
in ((t), ((tdecl)::(t_kinding)::(t_interp)::[]))))))))))
end
end
| FStar_Absyn_Syntax.Typ_refine (_50_905) -> begin
(

let _50_924 = (match ((FStar_Tc_Normalize.normalize_refinement [] env.tcenv t0)) with
| {FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_refine (x, f); FStar_Absyn_Syntax.tk = _50_914; FStar_Absyn_Syntax.pos = _50_912; FStar_Absyn_Syntax.fvs = _50_910; FStar_Absyn_Syntax.uvs = _50_908} -> begin
((x), (f))
end
| _50_921 -> begin
(FStar_All.failwith "impossible")
end)
in (match (_50_924) with
| (x, f) -> begin
(

let _50_927 = (encode_typ_term x.FStar_Absyn_Syntax.sort env)
in (match (_50_927) with
| (base_t, decls) -> begin
(

let _50_931 = (gen_term_var env x.FStar_Absyn_Syntax.v)
in (match (_50_931) with
| (x, xtm, env') -> begin
(

let _50_934 = (encode_formula f env')
in (match (_50_934) with
| (refinement, decls') -> begin
(

let _50_937 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_937) with
| (fsym, fterm) -> begin
(

let encoding = (let _145_724 = (let _145_723 = (FStar_ToSMT_Term.mk_HasTypeWithFuel (Some (fterm)) xtm base_t)
in ((_145_723), (refinement)))
in (FStar_ToSMT_Term.mkAnd _145_724))
in (

let cvars = (let _145_726 = (FStar_ToSMT_Term.free_variables encoding)
in (FStar_All.pipe_right _145_726 (FStar_List.filter (fun _50_942 -> (match (_50_942) with
| (y, _50_941) -> begin
((y <> x) && (y <> fsym))
end)))))
in (

let xfv = ((x), (FStar_ToSMT_Term.Term_sort))
in (

let ffv = ((fsym), (FStar_ToSMT_Term.Fuel_sort))
in (

let tkey = (FStar_ToSMT_Term.mkForall (([]), ((ffv)::(xfv)::cvars), (encoding)))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (t, _50_949, _50_951) -> begin
(let _145_729 = (let _145_728 = (let _145_727 = (FStar_All.pipe_right cvars (FStar_List.map FStar_ToSMT_Term.mkFreeV))
in ((t), (_145_727)))
in (FStar_ToSMT_Term.mkApp _145_728))
in ((_145_729), ([])))
end
| None -> begin
(

let tsym = (varops.fresh "Typ_refine")
in (

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let tdecl = FStar_ToSMT_Term.DeclFun (((tsym), (cvar_sorts), (FStar_ToSMT_Term.Type_sort), (None)))
in (

let t = (let _145_731 = (let _145_730 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in ((tsym), (_145_730)))
in (FStar_ToSMT_Term.mkApp _145_731))
in (

let x_has_t = (FStar_ToSMT_Term.mk_HasTypeWithFuel (Some (fterm)) xtm t)
in (

let t_has_kind = (FStar_ToSMT_Term.mk_HasKind t FStar_ToSMT_Term.mk_Kind_type)
in (

let t_kinding = (FStar_ToSMT_Term.mkForall ((((t_has_kind)::[])::[]), (cvars), (t_has_kind)))
in (

let assumption = (let _145_733 = (let _145_732 = (FStar_ToSMT_Term.mkIff ((x_has_t), (encoding)))
in ((((x_has_t)::[])::[]), ((ffv)::(xfv)::cvars), (_145_732)))
in (FStar_ToSMT_Term.mkForall _145_733))
in (

let t_decls = (let _145_741 = (let _145_740 = (let _145_739 = (let _145_738 = (let _145_737 = (let _145_736 = (let _145_735 = (let _145_734 = (FStar_Absyn_Print.typ_to_string t0)
in Some (_145_734))
in ((assumption), (_145_735)))
in FStar_ToSMT_Term.Assume (_145_736))
in (_145_737)::[])
in (FStar_ToSMT_Term.Assume (((t_kinding), (None))))::_145_738)
in (tdecl)::_145_739)
in (FStar_List.append decls' _145_740))
in (FStar_List.append decls _145_741))
in (

let _50_964 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash ((tsym), (cvar_sorts), (t_decls)))
in ((t), (t_decls))))))))))))
end))))))
end))
end))
end))
end))
end))
end
| FStar_Absyn_Syntax.Typ_uvar (uv, k) -> begin
(

let ttm = (let _145_742 = (FStar_Unionfind.uvar_id uv)
in (FStar_ToSMT_Term.mk_Typ_uvar _145_742))
in (

let _50_973 = (encode_knd k env ttm)
in (match (_50_973) with
| (t_has_k, decls) -> begin
(

let d = FStar_ToSMT_Term.Assume (((t_has_k), (None)))
in ((ttm), ((d)::decls)))
end)))
end
| FStar_Absyn_Syntax.Typ_app (head, args) -> begin
(

let is_full_app = (fun _50_980 -> (match (()) with
| () -> begin
(

let kk = (FStar_Tc_Recheck.recompute_kind head)
in (

let _50_985 = (FStar_Absyn_Util.kind_formals kk)
in (match (_50_985) with
| (formals, _50_984) -> begin
((FStar_List.length formals) = (FStar_List.length args))
end)))
end))
in (

let head = (FStar_Absyn_Util.compress_typ head)
in (match (head.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_btvar (a) -> begin
(

let head = (lookup_typ_var env a)
in (

let _50_992 = (encode_args args env)
in (match (_50_992) with
| (args, decls) -> begin
(

let t = (mk_ApplyT_args head args)
in ((t), (decls)))
end)))
end
| FStar_Absyn_Syntax.Typ_const (fv) -> begin
(

let _50_998 = (encode_args args env)
in (match (_50_998) with
| (args, decls) -> begin
if (is_full_app ()) then begin
(

let head = (lookup_free_tvar_name env fv)
in (

let t = (let _145_747 = (let _145_746 = (FStar_List.map (fun _50_11 -> (match (_50_11) with
| (FStar_Util.Inl (t)) | (FStar_Util.Inr (t)) -> begin
t
end)) args)
in ((head), (_145_746)))
in (FStar_ToSMT_Term.mkApp _145_747))
in ((t), (decls))))
end else begin
(

let head = (lookup_free_tvar env fv)
in (

let t = (mk_ApplyT_args head args)
in ((t), (decls))))
end
end))
end
| FStar_Absyn_Syntax.Typ_uvar (uv, k) -> begin
(

let ttm = (let _145_748 = (FStar_Unionfind.uvar_id uv)
in (FStar_ToSMT_Term.mk_Typ_uvar _145_748))
in (

let _50_1014 = (encode_knd k env ttm)
in (match (_50_1014) with
| (t_has_k, decls) -> begin
(

let d = FStar_ToSMT_Term.Assume (((t_has_k), (None)))
in ((ttm), ((d)::decls)))
end)))
end
| _50_1017 -> begin
(

let t = (norm_t env t)
in (encode_typ_term t env))
end)))
end
| FStar_Absyn_Syntax.Typ_lam (bs, body) -> begin
(

let _50_1029 = (encode_binders None bs env)
in (match (_50_1029) with
| (vars, guards, env, decls, _50_1028) -> begin
(

let _50_1032 = (encode_typ_term body env)
in (match (_50_1032) with
| (body, decls') -> begin
(

let key_body = (let _145_752 = (let _145_751 = (let _145_750 = (let _145_749 = (FStar_ToSMT_Term.mk_and_l guards)
in ((_145_749), (body)))
in (FStar_ToSMT_Term.mkImp _145_750))
in (([]), (vars), (_145_751)))
in (FStar_ToSMT_Term.mkForall _145_752))
in (

let cvars = (FStar_ToSMT_Term.free_variables key_body)
in (

let tkey = (FStar_ToSMT_Term.mkForall (([]), (cvars), (key_body)))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (t, _50_1038, _50_1040) -> begin
(let _145_755 = (let _145_754 = (let _145_753 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in ((t), (_145_753)))
in (FStar_ToSMT_Term.mkApp _145_754))
in ((_145_755), ([])))
end
| None -> begin
(match ((is_eta env vars body)) with
| Some (head) -> begin
((head), ([]))
end
| None -> begin
(

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let tsym = (varops.fresh "Typ_lam")
in (

let tdecl = FStar_ToSMT_Term.DeclFun (((tsym), (cvar_sorts), (FStar_ToSMT_Term.Type_sort), (None)))
in (

let t = (let _145_757 = (let _145_756 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in ((tsym), (_145_756)))
in (FStar_ToSMT_Term.mkApp _145_757))
in (

let app = (mk_ApplyT t vars)
in (

let interp = (let _145_764 = (let _145_763 = (let _145_762 = (let _145_761 = (let _145_760 = (let _145_759 = (FStar_ToSMT_Term.mk_and_l guards)
in (let _145_758 = (FStar_ToSMT_Term.mkEq ((app), (body)))
in ((_145_759), (_145_758))))
in (FStar_ToSMT_Term.mkImp _145_760))
in ((((app)::[])::[]), ((FStar_List.append vars cvars)), (_145_761)))
in (FStar_ToSMT_Term.mkForall _145_762))
in ((_145_763), (Some ("Typ_lam interpretation"))))
in FStar_ToSMT_Term.Assume (_145_764))
in (

let kinding = (

let _50_1055 = (let _145_765 = (FStar_Tc_Recheck.recompute_kind t0)
in (encode_knd _145_765 env t))
in (match (_50_1055) with
| (ktm, decls'') -> begin
(let _145_769 = (let _145_768 = (let _145_767 = (let _145_766 = (FStar_ToSMT_Term.mkForall ((((t)::[])::[]), (cvars), (ktm)))
in ((_145_766), (Some ("Typ_lam kinding"))))
in FStar_ToSMT_Term.Assume (_145_767))
in (_145_768)::[])
in (FStar_List.append decls'' _145_769))
end))
in (

let t_decls = (FStar_List.append decls (FStar_List.append decls' ((tdecl)::(interp)::kinding)))
in (

let _50_1058 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash ((tsym), (cvar_sorts), (t_decls)))
in ((t), (t_decls)))))))))))
end)
end))))
end))
end))
end
| FStar_Absyn_Syntax.Typ_ascribed (t, _50_1062) -> begin
(encode_typ_term t env)
end
| FStar_Absyn_Syntax.Typ_meta (_50_1066) -> begin
(let _145_770 = (FStar_Absyn_Util.unmeta_typ t0)
in (encode_typ_term _145_770 env))
end
| (FStar_Absyn_Syntax.Typ_delayed (_)) | (FStar_Absyn_Syntax.Typ_unknown) -> begin
(let _145_775 = (let _145_774 = (FStar_All.pipe_left FStar_Range.string_of_range t.FStar_Absyn_Syntax.pos)
in (let _145_773 = (FStar_Absyn_Print.tag_of_typ t0)
in (let _145_772 = (FStar_Absyn_Print.typ_to_string t0)
in (let _145_771 = (FStar_Absyn_Print.typ_to_string t)
in (FStar_Util.format4 "(%s) Impossible: %s\n%s\n%s\n" _145_774 _145_773 _145_772 _145_771)))))
in (FStar_All.failwith _145_775))
end)))
and encode_exp : FStar_Absyn_Syntax.exp  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun e env -> (

let e = (FStar_Absyn_Visit.compress_exp_uvars e)
in (

let e0 = e
in (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_delayed (_50_1077) -> begin
(let _145_778 = (FStar_Absyn_Util.compress_exp e)
in (encode_exp _145_778 env))
end
| FStar_Absyn_Syntax.Exp_bvar (x) -> begin
(

let t = (lookup_term_var env x)
in ((t), ([])))
end
| FStar_Absyn_Syntax.Exp_fvar (v, _50_1084) -> begin
(let _145_779 = (lookup_free_var env v)
in ((_145_779), ([])))
end
| FStar_Absyn_Syntax.Exp_constant (c) -> begin
(let _145_780 = (encode_const c)
in ((_145_780), ([])))
end
| FStar_Absyn_Syntax.Exp_ascribed (e, t, _50_1092) -> begin
(

let _50_1095 = (FStar_ST.op_Colon_Equals e.FStar_Absyn_Syntax.tk (Some (t)))
in (encode_exp e env))
end
| FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared (e, _50_1099)) -> begin
(encode_exp e env)
end
| FStar_Absyn_Syntax.Exp_uvar (uv, _50_1105) -> begin
(

let e = (let _145_781 = (FStar_Unionfind.uvar_id uv)
in (FStar_ToSMT_Term.mk_Exp_uvar _145_781))
in ((e), ([])))
end
| FStar_Absyn_Syntax.Exp_abs (bs, body) -> begin
(

let fallback = (fun _50_1114 -> (match (()) with
| () -> begin
(

let f = (varops.fresh "Exp_abs")
in (

let decl = FStar_ToSMT_Term.DeclFun (((f), ([]), (FStar_ToSMT_Term.Term_sort), (None)))
in (let _145_784 = (FStar_ToSMT_Term.mkFreeV ((f), (FStar_ToSMT_Term.Term_sort)))
in ((_145_784), ((decl)::[])))))
end))
in (match ((FStar_ST.read e.FStar_Absyn_Syntax.tk)) with
| None -> begin
(

let _50_1118 = (FStar_Tc_Errors.warn e.FStar_Absyn_Syntax.pos "Losing precision when encoding a function literal")
in (fallback ()))
end
| Some (tfun) -> begin
if (let _145_785 = (FStar_Absyn_Util.is_pure_or_ghost_function tfun)
in (FStar_All.pipe_left Prims.op_Negation _145_785)) then begin
(fallback ())
end else begin
(

let tfun = (as_function_typ env tfun)
in (match (tfun.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (bs', c) -> begin
(

let nformals = (FStar_List.length bs')
in if ((nformals < (FStar_List.length bs)) && (FStar_Absyn_Util.is_total_comp c)) then begin
(

let _50_1130 = (FStar_Util.first_N nformals bs)
in (match (_50_1130) with
| (bs0, rest) -> begin
(

let res_t = (match ((FStar_Absyn_Util.mk_subst_binder bs0 bs')) with
| Some (s) -> begin
(FStar_Absyn_Util.subst_typ s (FStar_Absyn_Util.comp_result c))
end
| _50_1134 -> begin
(FStar_All.failwith "Impossible")
end)
in (

let e = (let _145_787 = (let _145_786 = (FStar_Absyn_Syntax.mk_Exp_abs ((rest), (body)) (Some (res_t)) body.FStar_Absyn_Syntax.pos)
in ((bs0), (_145_786)))
in (FStar_Absyn_Syntax.mk_Exp_abs _145_787 (Some (tfun)) e0.FStar_Absyn_Syntax.pos))
in (encode_exp e env)))
end))
end else begin
(

let _50_1143 = (encode_binders None bs env)
in (match (_50_1143) with
| (vars, guards, envbody, decls, _50_1142) -> begin
(

let _50_1146 = (encode_exp body envbody)
in (match (_50_1146) with
| (body, decls') -> begin
(

let key_body = (let _145_791 = (let _145_790 = (let _145_789 = (let _145_788 = (FStar_ToSMT_Term.mk_and_l guards)
in ((_145_788), (body)))
in (FStar_ToSMT_Term.mkImp _145_789))
in (([]), (vars), (_145_790)))
in (FStar_ToSMT_Term.mkForall _145_791))
in (

let cvars = (FStar_ToSMT_Term.free_variables key_body)
in (

let tkey = (FStar_ToSMT_Term.mkForall (([]), (cvars), (key_body)))
in (match ((FStar_Util.smap_try_find env.cache tkey.FStar_ToSMT_Term.hash)) with
| Some (t, _50_1152, _50_1154) -> begin
(let _145_794 = (let _145_793 = (let _145_792 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in ((t), (_145_792)))
in (FStar_ToSMT_Term.mkApp _145_793))
in ((_145_794), ([])))
end
| None -> begin
(match ((is_eta env vars body)) with
| Some (t) -> begin
((t), ([]))
end
| None -> begin
(

let cvar_sorts = (FStar_List.map Prims.snd cvars)
in (

let fsym = (varops.fresh "Exp_abs")
in (

let fdecl = FStar_ToSMT_Term.DeclFun (((fsym), (cvar_sorts), (FStar_ToSMT_Term.Term_sort), (None)))
in (

let f = (let _145_796 = (let _145_795 = (FStar_List.map FStar_ToSMT_Term.mkFreeV cvars)
in ((fsym), (_145_795)))
in (FStar_ToSMT_Term.mkApp _145_796))
in (

let app = (mk_ApplyE f vars)
in (

let _50_1168 = (encode_typ_pred None tfun env f)
in (match (_50_1168) with
| (f_has_t, decls'') -> begin
(

let typing_f = (let _145_798 = (let _145_797 = (FStar_ToSMT_Term.mkForall ((((f)::[])::[]), (cvars), (f_has_t)))
in ((_145_797), (Some ((Prims.strcat fsym " typing")))))
in FStar_ToSMT_Term.Assume (_145_798))
in (

let interp_f = (let _145_805 = (let _145_804 = (let _145_803 = (let _145_802 = (let _145_801 = (let _145_800 = (FStar_ToSMT_Term.mk_IsTyped app)
in (let _145_799 = (FStar_ToSMT_Term.mkEq ((app), (body)))
in ((_145_800), (_145_799))))
in (FStar_ToSMT_Term.mkImp _145_801))
in ((((app)::[])::[]), ((FStar_List.append vars cvars)), (_145_802)))
in (FStar_ToSMT_Term.mkForall _145_803))
in ((_145_804), (Some ((Prims.strcat fsym " interpretation")))))
in FStar_ToSMT_Term.Assume (_145_805))
in (

let f_decls = (FStar_List.append decls (FStar_List.append decls' (FStar_List.append ((fdecl)::decls'') ((typing_f)::(interp_f)::[]))))
in (

let _50_1172 = (FStar_Util.smap_add env.cache tkey.FStar_ToSMT_Term.hash ((fsym), (cvar_sorts), (f_decls)))
in ((f), (f_decls))))))
end)))))))
end)
end))))
end))
end))
end)
end
| _50_1175 -> begin
(FStar_All.failwith "Impossible")
end))
end
end))
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (l, _50_1186); FStar_Absyn_Syntax.tk = _50_1183; FStar_Absyn_Syntax.pos = _50_1181; FStar_Absyn_Syntax.fvs = _50_1179; FStar_Absyn_Syntax.uvs = _50_1177}, ((FStar_Util.Inl (_50_1201), _50_1204))::((FStar_Util.Inr (v1), _50_1198))::((FStar_Util.Inr (v2), _50_1193))::[]) when (FStar_Ident.lid_equals l.FStar_Absyn_Syntax.v FStar_Absyn_Const.lexcons_lid) -> begin
(

let _50_1211 = (encode_exp v1 env)
in (match (_50_1211) with
| (v1, decls1) -> begin
(

let _50_1214 = (encode_exp v2 env)
in (match (_50_1214) with
| (v2, decls2) -> begin
(let _145_806 = (FStar_ToSMT_Term.mk_LexCons v1 v2)
in ((_145_806), ((FStar_List.append decls1 decls2))))
end))
end))
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_abs (_50_1224); FStar_Absyn_Syntax.tk = _50_1222; FStar_Absyn_Syntax.pos = _50_1220; FStar_Absyn_Syntax.fvs = _50_1218; FStar_Absyn_Syntax.uvs = _50_1216}, _50_1228) -> begin
(let _145_807 = (whnf_e env e)
in (encode_exp _145_807 env))
end
| FStar_Absyn_Syntax.Exp_app (head, args_e) -> begin
(

let _50_1237 = (encode_args args_e env)
in (match (_50_1237) with
| (args, decls) -> begin
(

let encode_partial_app = (fun ht_opt -> (

let _50_1242 = (encode_exp head env)
in (match (_50_1242) with
| (head, decls') -> begin
(

let app_tm = (mk_ApplyE_args head args)
in (match (ht_opt) with
| None -> begin
((app_tm), ((FStar_List.append decls decls')))
end
| Some (formals, c) -> begin
(

let _50_1251 = (FStar_Util.first_N (FStar_List.length args_e) formals)
in (match (_50_1251) with
| (formals, rest) -> begin
(

let subst = (FStar_Absyn_Util.formals_for_actuals formals args_e)
in (

let ty = (let _145_810 = (FStar_Absyn_Syntax.mk_Typ_fun ((rest), (c)) (Some (FStar_Absyn_Syntax.ktype)) e0.FStar_Absyn_Syntax.pos)
in (FStar_All.pipe_right _145_810 (FStar_Absyn_Util.subst_typ subst)))
in (

let _50_1256 = (encode_typ_pred None ty env app_tm)
in (match (_50_1256) with
| (has_type, decls'') -> begin
(

let cvars = (FStar_ToSMT_Term.free_variables has_type)
in (

let e_typing = (let _145_812 = (let _145_811 = (FStar_ToSMT_Term.mkForall ((((has_type)::[])::[]), (cvars), (has_type)))
in ((_145_811), (None)))
in FStar_ToSMT_Term.Assume (_145_812))
in ((app_tm), ((FStar_List.append decls (FStar_List.append decls' (FStar_List.append decls'' ((e_typing)::[]))))))))
end))))
end))
end))
end)))
in (

let encode_full_app = (fun fv -> (

let _50_1263 = (lookup_free_var_sym env fv)
in (match (_50_1263) with
| (fname, fuel_args) -> begin
(

let tm = (let _145_818 = (let _145_817 = (let _145_816 = (FStar_List.map (fun _50_12 -> (match (_50_12) with
| (FStar_Util.Inl (t)) | (FStar_Util.Inr (t)) -> begin
t
end)) args)
in (FStar_List.append fuel_args _145_816))
in ((fname), (_145_817)))
in (FStar_ToSMT_Term.mkApp' _145_818))
in ((tm), (decls)))
end)))
in (

let head = (FStar_Absyn_Util.compress_exp head)
in (

let _50_1270 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env.tcenv) (FStar_Options.Other ("186"))) then begin
(let _145_820 = (FStar_Absyn_Print.exp_to_string head)
in (let _145_819 = (FStar_Absyn_Print.exp_to_string e)
in (FStar_Util.print2 "Recomputing type for %s\nFull term is %s\n" _145_820 _145_819)))
end else begin
()
end
in (

let head_type = (let _145_823 = (let _145_822 = (let _145_821 = (FStar_Tc_Recheck.recompute_typ head)
in (FStar_Absyn_Util.unrefine _145_821))
in (whnf env _145_822))
in (FStar_All.pipe_left FStar_Absyn_Util.unrefine _145_823))
in (

let _50_1273 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env.tcenv) (FStar_Options.Other ("Encoding"))) then begin
(let _145_826 = (FStar_Absyn_Print.exp_to_string head)
in (let _145_825 = (FStar_Absyn_Print.tag_of_exp head)
in (let _145_824 = (FStar_Absyn_Print.typ_to_string head_type)
in (FStar_Util.print3 "Recomputed type of head %s (%s) to be %s\n" _145_826 _145_825 _145_824))))
end else begin
()
end
in (match ((FStar_Absyn_Util.function_formals head_type)) with
| None -> begin
(let _145_830 = (let _145_829 = (FStar_Range.string_of_range e0.FStar_Absyn_Syntax.pos)
in (let _145_828 = (FStar_Absyn_Print.exp_to_string e0)
in (let _145_827 = (FStar_Absyn_Print.typ_to_string head_type)
in (FStar_Util.format3 "(%s) term is %s; head type is %s\n" _145_829 _145_828 _145_827))))
in (FStar_All.failwith _145_830))
end
| Some (formals, c) -> begin
(match (head.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_fvar (fv, _50_1282) when ((FStar_List.length formals) = (FStar_List.length args)) -> begin
(encode_full_app fv)
end
| _50_1286 -> begin
if ((FStar_List.length formals) > (FStar_List.length args)) then begin
(encode_partial_app (Some (((formals), (c)))))
end else begin
(encode_partial_app None)
end
end)
end)))))))
end))
end
| FStar_Absyn_Syntax.Exp_let ((false, ({FStar_Absyn_Syntax.lbname = FStar_Util.Inr (_50_1295); FStar_Absyn_Syntax.lbtyp = _50_1293; FStar_Absyn_Syntax.lbeff = _50_1291; FStar_Absyn_Syntax.lbdef = _50_1289})::[]), _50_1301) -> begin
(FStar_All.failwith "Impossible: already handled by encoding of Sig_let")
end
| FStar_Absyn_Syntax.Exp_let ((false, ({FStar_Absyn_Syntax.lbname = FStar_Util.Inl (x); FStar_Absyn_Syntax.lbtyp = t1; FStar_Absyn_Syntax.lbeff = _50_1307; FStar_Absyn_Syntax.lbdef = e1})::[]), e2) -> begin
(

let _50_1319 = (encode_exp e1 env)
in (match (_50_1319) with
| (ee1, decls1) -> begin
(

let env' = (push_term_var env x ee1)
in (

let _50_1323 = (encode_exp e2 env')
in (match (_50_1323) with
| (ee2, decls2) -> begin
((ee2), ((FStar_List.append decls1 decls2)))
end)))
end))
end
| FStar_Absyn_Syntax.Exp_let (_50_1325) -> begin
(

let _50_1327 = (FStar_Tc_Errors.warn e.FStar_Absyn_Syntax.pos "Non-top-level recursive functions are not yet fully encoded to the SMT solver; you may not be able to prove some facts")
in (

let e = (varops.fresh "let-rec")
in (

let decl_e = FStar_ToSMT_Term.DeclFun (((e), ([]), (FStar_ToSMT_Term.Term_sort), (None)))
in (let _145_831 = (FStar_ToSMT_Term.mkFreeV ((e), (FStar_ToSMT_Term.Term_sort)))
in ((_145_831), ((decl_e)::[]))))))
end
| FStar_Absyn_Syntax.Exp_match (e, pats) -> begin
(

let _50_1337 = (encode_exp e env)
in (match (_50_1337) with
| (scr, decls) -> begin
(

let _50_1377 = (FStar_List.fold_right (fun _50_1341 _50_1344 -> (match (((_50_1341), (_50_1344))) with
| ((p, w, br), (else_case, decls)) -> begin
(

let patterns = (encode_pat env p)
in (FStar_List.fold_right (fun _50_1348 _50_1351 -> (match (((_50_1348), (_50_1351))) with
| ((env0, pattern), (else_case, decls)) -> begin
(

let guard = (pattern.guard scr)
in (

let projections = (pattern.projections scr)
in (

let env = (FStar_All.pipe_right projections (FStar_List.fold_left (fun env _50_1357 -> (match (_50_1357) with
| (x, t) -> begin
(match (x) with
| FStar_Util.Inl (a) -> begin
(push_typ_var env a.FStar_Absyn_Syntax.v t)
end
| FStar_Util.Inr (x) -> begin
(push_term_var env x.FStar_Absyn_Syntax.v t)
end)
end)) env))
in (

let _50_1371 = (match (w) with
| None -> begin
((guard), ([]))
end
| Some (w) -> begin
(

let _50_1368 = (encode_exp w env)
in (match (_50_1368) with
| (w, decls2) -> begin
(let _145_842 = (let _145_841 = (let _145_840 = (let _145_839 = (let _145_838 = (FStar_ToSMT_Term.boxBool FStar_ToSMT_Term.mkTrue)
in ((w), (_145_838)))
in (FStar_ToSMT_Term.mkEq _145_839))
in ((guard), (_145_840)))
in (FStar_ToSMT_Term.mkAnd _145_841))
in ((_145_842), (decls2)))
end))
end)
in (match (_50_1371) with
| (guard, decls2) -> begin
(

let _50_1374 = (encode_exp br env)
in (match (_50_1374) with
| (br, decls3) -> begin
(let _145_843 = (FStar_ToSMT_Term.mkITE ((guard), (br), (else_case)))
in ((_145_843), ((FStar_List.append decls (FStar_List.append decls2 decls3)))))
end))
end)))))
end)) patterns ((else_case), (decls))))
end)) pats ((FStar_ToSMT_Term.mk_Term_unit), (decls)))
in (match (_50_1377) with
| (match_tm, decls) -> begin
((match_tm), (decls))
end))
end))
end
| FStar_Absyn_Syntax.Exp_meta (_50_1379) -> begin
(let _145_846 = (let _145_845 = (FStar_Range.string_of_range e.FStar_Absyn_Syntax.pos)
in (let _145_844 = (FStar_Absyn_Print.exp_to_string e)
in (FStar_Util.format2 "(%s): Impossible: encode_exp got %s" _145_845 _145_844)))
in (FStar_All.failwith _145_846))
end))))
and encode_pat : env_t  ->  FStar_Absyn_Syntax.pat  ->  (env_t * pattern) Prims.list = (fun env pat -> (match (pat.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj (ps) -> begin
(FStar_List.map (encode_one_pat env) ps)
end
| _50_1386 -> begin
(let _145_849 = (encode_one_pat env pat)
in (_145_849)::[])
end))
and encode_one_pat : env_t  ->  FStar_Absyn_Syntax.pat  ->  (env_t * pattern) = (fun env pat -> (

let _50_1389 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _145_852 = (FStar_Absyn_Print.pat_to_string pat)
in (FStar_Util.print1 "Encoding pattern %s\n" _145_852))
end else begin
()
end
in (

let _50_1393 = (FStar_Tc_Util.decorated_pattern_as_either pat)
in (match (_50_1393) with
| (vars, pat_exp_or_typ) -> begin
(

let _50_1414 = (FStar_All.pipe_right vars (FStar_List.fold_left (fun _50_1396 v -> (match (_50_1396) with
| (env, vars) -> begin
(match (v) with
| FStar_Util.Inl (a) -> begin
(

let _50_1404 = (gen_typ_var env a.FStar_Absyn_Syntax.v)
in (match (_50_1404) with
| (aa, _50_1402, env) -> begin
((env), ((((v), (((aa), (FStar_ToSMT_Term.Type_sort)))))::vars))
end))
end
| FStar_Util.Inr (x) -> begin
(

let _50_1411 = (gen_term_var env x.FStar_Absyn_Syntax.v)
in (match (_50_1411) with
| (xx, _50_1409, env) -> begin
((env), ((((v), (((xx), (FStar_ToSMT_Term.Term_sort)))))::vars))
end))
end)
end)) ((env), ([]))))
in (match (_50_1414) with
| (env, vars) -> begin
(

let rec mk_guard = (fun pat scrutinee -> (match (pat.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj (_50_1419) -> begin
(FStar_All.failwith "Impossible")
end
| (FStar_Absyn_Syntax.Pat_var (_)) | (FStar_Absyn_Syntax.Pat_wild (_)) | (FStar_Absyn_Syntax.Pat_tvar (_)) | (FStar_Absyn_Syntax.Pat_twild (_)) | (FStar_Absyn_Syntax.Pat_dot_term (_)) | (FStar_Absyn_Syntax.Pat_dot_typ (_)) -> begin
FStar_ToSMT_Term.mkTrue
end
| FStar_Absyn_Syntax.Pat_constant (c) -> begin
(let _145_860 = (let _145_859 = (encode_const c)
in ((scrutinee), (_145_859)))
in (FStar_ToSMT_Term.mkEq _145_860))
end
| FStar_Absyn_Syntax.Pat_cons (f, _50_1443, args) -> begin
(

let is_f = (mk_data_tester env f.FStar_Absyn_Syntax.v scrutinee)
in (

let sub_term_guards = (FStar_All.pipe_right args (FStar_List.mapi (fun i _50_1452 -> (match (_50_1452) with
| (arg, _50_1451) -> begin
(

let proj = (primitive_projector_by_pos env.tcenv f.FStar_Absyn_Syntax.v i)
in (let _145_863 = (FStar_ToSMT_Term.mkApp ((proj), ((scrutinee)::[])))
in (mk_guard arg _145_863)))
end))))
in (FStar_ToSMT_Term.mk_and_l ((is_f)::sub_term_guards))))
end))
in (

let rec mk_projections = (fun pat scrutinee -> (match (pat.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_disj (_50_1459) -> begin
(FStar_All.failwith "Impossible")
end
| (FStar_Absyn_Syntax.Pat_dot_term (x, _)) | (FStar_Absyn_Syntax.Pat_var (x)) | (FStar_Absyn_Syntax.Pat_wild (x)) -> begin
(((FStar_Util.Inr (x)), (scrutinee)))::[]
end
| (FStar_Absyn_Syntax.Pat_dot_typ (a, _)) | (FStar_Absyn_Syntax.Pat_tvar (a)) | (FStar_Absyn_Syntax.Pat_twild (a)) -> begin
(((FStar_Util.Inl (a)), (scrutinee)))::[]
end
| FStar_Absyn_Syntax.Pat_constant (_50_1476) -> begin
[]
end
| FStar_Absyn_Syntax.Pat_cons (f, _50_1480, args) -> begin
(let _145_871 = (FStar_All.pipe_right args (FStar_List.mapi (fun i _50_1488 -> (match (_50_1488) with
| (arg, _50_1487) -> begin
(

let proj = (primitive_projector_by_pos env.tcenv f.FStar_Absyn_Syntax.v i)
in (let _145_870 = (FStar_ToSMT_Term.mkApp ((proj), ((scrutinee)::[])))
in (mk_projections arg _145_870)))
end))))
in (FStar_All.pipe_right _145_871 FStar_List.flatten))
end))
in (

let pat_term = (fun _50_1491 -> (match (()) with
| () -> begin
(match (pat_exp_or_typ) with
| FStar_Util.Inl (t) -> begin
(encode_typ_term t env)
end
| FStar_Util.Inr (e) -> begin
(encode_exp e env)
end)
end))
in (

let pattern = {pat_vars = vars; pat_term = pat_term; guard = (mk_guard pat); projections = (mk_projections pat)}
in ((env), (pattern))))))
end))
end))))
and encode_args : FStar_Absyn_Syntax.args  ->  env_t  ->  ((FStar_ToSMT_Term.term, FStar_ToSMT_Term.term) FStar_Util.either Prims.list * FStar_ToSMT_Term.decls_t) = (fun l env -> (

let _50_1521 = (FStar_All.pipe_right l (FStar_List.fold_left (fun _50_1501 x -> (match (_50_1501) with
| (tms, decls) -> begin
(match (x) with
| (FStar_Util.Inl (t), _50_1506) -> begin
(

let _50_1510 = (encode_typ_term t env)
in (match (_50_1510) with
| (t, decls') -> begin
(((FStar_Util.Inl (t))::tms), ((FStar_List.append decls decls')))
end))
end
| (FStar_Util.Inr (e), _50_1514) -> begin
(

let _50_1518 = (encode_exp e env)
in (match (_50_1518) with
| (t, decls') -> begin
(((FStar_Util.Inr (t))::tms), ((FStar_List.append decls decls')))
end))
end)
end)) (([]), ([]))))
in (match (_50_1521) with
| (l, decls) -> begin
(((FStar_List.rev l)), (decls))
end)))
and encode_formula : FStar_Absyn_Syntax.typ  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun phi env -> (

let _50_1527 = (encode_formula_with_labels phi env)
in (match (_50_1527) with
| (t, vars, decls) -> begin
(match (vars) with
| [] -> begin
((t), (decls))
end
| _50_1530 -> begin
(FStar_All.failwith "Unexpected labels in formula")
end)
end)))
and encode_function_type_as_formula : FStar_ToSMT_Term.term Prims.option  ->  FStar_Absyn_Syntax.exp Prims.option  ->  FStar_Absyn_Syntax.typ  ->  env_t  ->  (FStar_ToSMT_Term.term * FStar_ToSMT_Term.decls_t) = (fun induction_on new_pats t env -> (

let rec list_elements = (fun e -> (match ((let _145_886 = (FStar_Absyn_Util.unmeta_exp e)
in _145_886.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1547); FStar_Absyn_Syntax.tk = _50_1544; FStar_Absyn_Syntax.pos = _50_1542; FStar_Absyn_Syntax.fvs = _50_1540; FStar_Absyn_Syntax.uvs = _50_1538}, _50_1552) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.nil_lid) -> begin
[]
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1565); FStar_Absyn_Syntax.tk = _50_1562; FStar_Absyn_Syntax.pos = _50_1560; FStar_Absyn_Syntax.fvs = _50_1558; FStar_Absyn_Syntax.uvs = _50_1556}, (_50_1580)::((FStar_Util.Inr (hd), _50_1577))::((FStar_Util.Inr (tl), _50_1572))::[]) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.cons_lid) -> begin
(let _145_887 = (list_elements tl)
in (hd)::_145_887)
end
| _50_1585 -> begin
(

let _50_1586 = (FStar_Tc_Errors.warn e.FStar_Absyn_Syntax.pos "SMT pattern is not a list literal; ignoring the pattern")
in [])
end))
in (

let v_or_t_pat = (fun p -> (match ((let _145_890 = (FStar_Absyn_Util.unmeta_exp p)
in _145_890.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1600); FStar_Absyn_Syntax.tk = _50_1597; FStar_Absyn_Syntax.pos = _50_1595; FStar_Absyn_Syntax.fvs = _50_1593; FStar_Absyn_Syntax.uvs = _50_1591}, ((FStar_Util.Inl (_50_1610), _50_1613))::((FStar_Util.Inr (e), _50_1607))::[]) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.smtpat_lid) -> begin
(FStar_Absyn_Syntax.varg e)
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1628); FStar_Absyn_Syntax.tk = _50_1625; FStar_Absyn_Syntax.pos = _50_1623; FStar_Absyn_Syntax.fvs = _50_1621; FStar_Absyn_Syntax.uvs = _50_1619}, ((FStar_Util.Inl (t), _50_1635))::[]) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.smtpatT_lid) -> begin
(FStar_Absyn_Syntax.targ t)
end
| _50_1641 -> begin
(FStar_All.failwith "Unexpected pattern term")
end))
in (

let lemma_pats = (fun p -> (

let elts = (list_elements p)
in (match (elts) with
| ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _50_1663); FStar_Absyn_Syntax.tk = _50_1660; FStar_Absyn_Syntax.pos = _50_1658; FStar_Absyn_Syntax.fvs = _50_1656; FStar_Absyn_Syntax.uvs = _50_1654}, ((FStar_Util.Inr (e), _50_1670))::[]); FStar_Absyn_Syntax.tk = _50_1652; FStar_Absyn_Syntax.pos = _50_1650; FStar_Absyn_Syntax.fvs = _50_1648; FStar_Absyn_Syntax.uvs = _50_1646})::[] when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.smtpatOr_lid) -> begin
(let _145_895 = (list_elements e)
in (FStar_All.pipe_right _145_895 (FStar_List.map (fun branch -> (let _145_894 = (list_elements branch)
in (FStar_All.pipe_right _145_894 (FStar_List.map v_or_t_pat)))))))
end
| _50_1679 -> begin
(let _145_896 = (FStar_All.pipe_right elts (FStar_List.map v_or_t_pat))
in (_145_896)::[])
end)))
in (

let _50_1722 = (match ((let _145_897 = (FStar_Absyn_Util.compress_typ t)
in _145_897.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_fun (binders, {FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Comp (ct); FStar_Absyn_Syntax.tk = _50_1688; FStar_Absyn_Syntax.pos = _50_1686; FStar_Absyn_Syntax.fvs = _50_1684; FStar_Absyn_Syntax.uvs = _50_1682}) -> begin
(match (ct.FStar_Absyn_Syntax.effect_args) with
| ((FStar_Util.Inl (pre), _50_1707))::((FStar_Util.Inl (post), _50_1702))::((FStar_Util.Inr (pats), _50_1697))::[] -> begin
(

let pats' = (match (new_pats) with
| Some (new_pats') -> begin
new_pats'
end
| None -> begin
pats
end)
in (let _145_898 = (lemma_pats pats')
in ((binders), (pre), (post), (_145_898))))
end
| _50_1715 -> begin
(FStar_All.failwith "impos")
end)
end
| _50_1717 -> begin
(FStar_All.failwith "Impos")
end)
in (match (_50_1722) with
| (binders, pre, post, patterns) -> begin
(

let _50_1729 = (encode_binders None binders env)
in (match (_50_1729) with
| (vars, guards, env, decls, _50_1728) -> begin
(

let _50_1749 = (let _145_902 = (FStar_All.pipe_right patterns (FStar_List.map (fun branch -> (

let _50_1746 = (let _145_901 = (FStar_All.pipe_right branch (FStar_List.map (fun _50_13 -> (match (_50_13) with
| (FStar_Util.Inl (t), _50_1735) -> begin
(encode_formula t env)
end
| (FStar_Util.Inr (e), _50_1740) -> begin
(encode_exp e (

let _50_1742 = env
in {bindings = _50_1742.bindings; depth = _50_1742.depth; tcenv = _50_1742.tcenv; warn = _50_1742.warn; cache = _50_1742.cache; nolabels = _50_1742.nolabels; use_zfuel_name = true; encode_non_total_function_typ = _50_1742.encode_non_total_function_typ}))
end))))
in (FStar_All.pipe_right _145_901 FStar_List.unzip))
in (match (_50_1746) with
| (pats, decls) -> begin
((pats), (decls))
end)))))
in (FStar_All.pipe_right _145_902 FStar_List.unzip))
in (match (_50_1749) with
| (pats, decls') -> begin
(

let decls' = (FStar_List.flatten decls')
in (

let pats = (match (induction_on) with
| None -> begin
pats
end
| Some (e) -> begin
(match (vars) with
| [] -> begin
pats
end
| (l)::[] -> begin
(FStar_All.pipe_right pats (FStar_List.map (fun p -> (let _145_905 = (let _145_904 = (FStar_ToSMT_Term.mkFreeV l)
in (FStar_ToSMT_Term.mk_Precedes _145_904 e))
in (_145_905)::p))))
end
| _50_1759 -> begin
(

let rec aux = (fun tl vars -> (match (vars) with
| [] -> begin
(FStar_All.pipe_right pats (FStar_List.map (fun p -> (let _145_911 = (FStar_ToSMT_Term.mk_Precedes tl e)
in (_145_911)::p))))
end
| ((x, FStar_ToSMT_Term.Term_sort))::vars -> begin
(let _145_913 = (let _145_912 = (FStar_ToSMT_Term.mkFreeV ((x), (FStar_ToSMT_Term.Term_sort)))
in (FStar_ToSMT_Term.mk_LexCons _145_912 tl))
in (aux _145_913 vars))
end
| _50_1771 -> begin
pats
end))
in (let _145_914 = (FStar_ToSMT_Term.mkFreeV (("Prims.LexTop"), (FStar_ToSMT_Term.Term_sort)))
in (aux _145_914 vars)))
end)
end)
in (

let env = (

let _50_1773 = env
in {bindings = _50_1773.bindings; depth = _50_1773.depth; tcenv = _50_1773.tcenv; warn = _50_1773.warn; cache = _50_1773.cache; nolabels = true; use_zfuel_name = _50_1773.use_zfuel_name; encode_non_total_function_typ = _50_1773.encode_non_total_function_typ})
in (

let _50_1778 = (let _145_915 = (FStar_Absyn_Util.unmeta_typ pre)
in (encode_formula _145_915 env))
in (match (_50_1778) with
| (pre, decls'') -> begin
(

let _50_1781 = (let _145_916 = (FStar_Absyn_Util.unmeta_typ post)
in (encode_formula _145_916 env))
in (match (_50_1781) with
| (post, decls''') -> begin
(

let decls = (FStar_List.append decls (FStar_List.append (FStar_List.flatten decls') (FStar_List.append decls'' decls''')))
in (let _145_921 = (let _145_920 = (let _145_919 = (let _145_918 = (let _145_917 = (FStar_ToSMT_Term.mk_and_l ((pre)::guards))
in ((_145_917), (post)))
in (FStar_ToSMT_Term.mkImp _145_918))
in ((pats), (vars), (_145_919)))
in (FStar_ToSMT_Term.mkForall _145_920))
in ((_145_921), (decls))))
end))
end)))))
end))
end))
end))))))
and encode_formula_with_labels : FStar_Absyn_Syntax.typ  ->  env_t  ->  (FStar_ToSMT_Term.term * labels * FStar_ToSMT_Term.decls_t) = (fun phi env -> (

let enc = (fun f l -> (

let _50_1802 = (FStar_Util.fold_map (fun decls x -> (match ((Prims.fst x)) with
| FStar_Util.Inl (t) -> begin
(

let _50_1794 = (encode_typ_term t env)
in (match (_50_1794) with
| (t, decls') -> begin
(((FStar_List.append decls decls')), (t))
end))
end
| FStar_Util.Inr (e) -> begin
(

let _50_1799 = (encode_exp e env)
in (match (_50_1799) with
| (e, decls') -> begin
(((FStar_List.append decls decls')), (e))
end))
end)) [] l)
in (match (_50_1802) with
| (decls, args) -> begin
(let _145_939 = (f args)
in ((_145_939), ([]), (decls)))
end)))
in (

let enc_prop_c = (fun f l -> (

let _50_1822 = (FStar_List.fold_right (fun t _50_1810 -> (match (_50_1810) with
| (phis, labs, decls) -> begin
(match ((Prims.fst t)) with
| FStar_Util.Inl (t) -> begin
(

let _50_1816 = (encode_formula_with_labels t env)
in (match (_50_1816) with
| (phi, labs', decls') -> begin
(((phi)::phis), ((FStar_List.append labs' labs)), ((FStar_List.append decls' decls)))
end))
end
| _50_1818 -> begin
(FStar_All.failwith "Expected a formula")
end)
end)) l (([]), ([]), ([])))
in (match (_50_1822) with
| (phis, labs, decls) -> begin
(let _145_955 = (f phis)
in ((_145_955), (labs), (decls)))
end)))
in (

let const_op = (fun f _50_1825 -> ((f), ([]), ([])))
in (

let un_op = (fun f l -> (let _145_969 = (FStar_List.hd l)
in (FStar_All.pipe_left f _145_969)))
in (

let bin_op = (fun f _50_14 -> (match (_50_14) with
| (t1)::(t2)::[] -> begin
(f ((t1), (t2)))
end
| _50_1836 -> begin
(FStar_All.failwith "Impossible")
end))
in (

let eq_op = (fun _50_15 -> (match (_50_15) with
| (_50_1844)::(_50_1842)::(e1)::(e2)::[] -> begin
(enc (bin_op FStar_ToSMT_Term.mkEq) ((e1)::(e2)::[]))
end
| l -> begin
(enc (bin_op FStar_ToSMT_Term.mkEq) l)
end))
in (

let mk_imp = (fun _50_16 -> (match (_50_16) with
| ((FStar_Util.Inl (lhs), _50_1857))::((FStar_Util.Inl (rhs), _50_1852))::[] -> begin
(

let _50_1863 = (encode_formula_with_labels rhs env)
in (match (_50_1863) with
| (l1, labs1, decls1) -> begin
(match (l1.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.True, _50_1866) -> begin
((l1), (labs1), (decls1))
end
| _50_1870 -> begin
(

let _50_1874 = (encode_formula_with_labels lhs env)
in (match (_50_1874) with
| (l2, labs2, decls2) -> begin
(let _145_983 = (FStar_ToSMT_Term.mkImp ((l2), (l1)))
in ((_145_983), ((FStar_List.append labs1 labs2)), ((FStar_List.append decls1 decls2))))
end))
end)
end))
end
| _50_1876 -> begin
(FStar_All.failwith "impossible")
end))
in (

let mk_ite = (fun _50_17 -> (match (_50_17) with
| ((FStar_Util.Inl (guard), _50_1892))::((FStar_Util.Inl (_then), _50_1887))::((FStar_Util.Inl (_else), _50_1882))::[] -> begin
(

let _50_1898 = (encode_formula_with_labels guard env)
in (match (_50_1898) with
| (g, labs1, decls1) -> begin
(

let _50_1902 = (encode_formula_with_labels _then env)
in (match (_50_1902) with
| (t, labs2, decls2) -> begin
(

let _50_1906 = (encode_formula_with_labels _else env)
in (match (_50_1906) with
| (e, labs3, decls3) -> begin
(

let res = (FStar_ToSMT_Term.mkITE ((g), (t), (e)))
in ((res), ((FStar_List.append labs1 (FStar_List.append labs2 labs3))), ((FStar_List.append decls1 (FStar_List.append decls2 decls3)))))
end))
end))
end))
end
| _50_1909 -> begin
(FStar_All.failwith "impossible")
end))
in (

let unboxInt_l = (fun f l -> (let _145_995 = (FStar_List.map FStar_ToSMT_Term.unboxInt l)
in (f _145_995)))
in (

let connectives = (let _145_1056 = (let _145_1004 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_ToSMT_Term.mkAnd))
in ((FStar_Absyn_Const.and_lid), (_145_1004)))
in (let _145_1055 = (let _145_1054 = (let _145_1010 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_ToSMT_Term.mkOr))
in ((FStar_Absyn_Const.or_lid), (_145_1010)))
in (let _145_1053 = (let _145_1052 = (let _145_1051 = (let _145_1019 = (FStar_All.pipe_left enc_prop_c (bin_op FStar_ToSMT_Term.mkIff))
in ((FStar_Absyn_Const.iff_lid), (_145_1019)))
in (let _145_1050 = (let _145_1049 = (let _145_1048 = (let _145_1028 = (FStar_All.pipe_left enc_prop_c (un_op FStar_ToSMT_Term.mkNot))
in ((FStar_Absyn_Const.not_lid), (_145_1028)))
in (let _145_1047 = (let _145_1046 = (let _145_1034 = (FStar_All.pipe_left enc (bin_op FStar_ToSMT_Term.mkEq))
in ((FStar_Absyn_Const.eqT_lid), (_145_1034)))
in (_145_1046)::(((FStar_Absyn_Const.eq2_lid), (eq_op)))::(((FStar_Absyn_Const.true_lid), ((const_op FStar_ToSMT_Term.mkTrue))))::(((FStar_Absyn_Const.false_lid), ((const_op FStar_ToSMT_Term.mkFalse))))::[])
in (_145_1048)::_145_1047))
in (((FStar_Absyn_Const.ite_lid), (mk_ite)))::_145_1049)
in (_145_1051)::_145_1050))
in (((FStar_Absyn_Const.imp_lid), (mk_imp)))::_145_1052)
in (_145_1054)::_145_1053))
in (_145_1056)::_145_1055))
in (

let fallback = (fun phi -> (match (phi.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_labeled (phi', msg, r, b)) -> begin
(

let _50_1927 = (encode_formula_with_labels phi' env)
in (match (_50_1927) with
| (phi, labs, decls) -> begin
if env.nolabels then begin
((phi), ([]), (decls))
end else begin
(

let lvar = (let _145_1059 = (varops.fresh "label")
in ((_145_1059), (FStar_ToSMT_Term.Bool_sort)))
in (

let lterm = (FStar_ToSMT_Term.mkFreeV lvar)
in (

let lphi = (FStar_ToSMT_Term.mkOr ((lterm), (phi)))
in ((lphi), ((((lvar), (msg), (r)))::labs), (decls)))))
end
end))
end
| FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (ih); FStar_Absyn_Syntax.tk = _50_1938; FStar_Absyn_Syntax.pos = _50_1936; FStar_Absyn_Syntax.fvs = _50_1934; FStar_Absyn_Syntax.uvs = _50_1932}, (_50_1953)::((FStar_Util.Inr (l), _50_1950))::((FStar_Util.Inl (phi), _50_1945))::[]) when (FStar_Ident.lid_equals ih.FStar_Absyn_Syntax.v FStar_Absyn_Const.using_IH) -> begin
if (FStar_Absyn_Util.is_lemma phi) then begin
(

let _50_1959 = (encode_exp l env)
in (match (_50_1959) with
| (e, decls) -> begin
(

let _50_1962 = (encode_function_type_as_formula (Some (e)) None phi env)
in (match (_50_1962) with
| (f, decls') -> begin
((f), ([]), ((FStar_List.append decls decls')))
end))
end))
end else begin
((FStar_ToSMT_Term.mkTrue), ([]), ([]))
end
end
| FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (ih); FStar_Absyn_Syntax.tk = _50_1970; FStar_Absyn_Syntax.pos = _50_1968; FStar_Absyn_Syntax.fvs = _50_1966; FStar_Absyn_Syntax.uvs = _50_1964}, (_50_1982)::((FStar_Util.Inl (phi), _50_1978))::tl) when (FStar_Ident.lid_equals ih.FStar_Absyn_Syntax.v FStar_Absyn_Const.using_lem) -> begin
if (FStar_Absyn_Util.is_lemma phi) then begin
(

let pat = (match (tl) with
| [] -> begin
None
end
| ((FStar_Util.Inr (pat), _50_1990))::[] -> begin
Some (pat)
end
| _50_1994 -> begin
(Prims.raise Bad_form)
end)
in (

let _50_1998 = (encode_function_type_as_formula None pat phi env)
in (match (_50_1998) with
| (f, decls) -> begin
((f), ([]), (decls))
end)))
end else begin
((FStar_ToSMT_Term.mkTrue), ([]), ([]))
end
end
| _50_2000 -> begin
(

let _50_2003 = (encode_typ_term phi env)
in (match (_50_2003) with
| (tt, decls) -> begin
(let _145_1060 = (FStar_ToSMT_Term.mk_Valid tt)
in ((_145_1060), ([]), (decls)))
end))
end))
in (

let encode_q_body = (fun env bs ps body -> (

let _50_2015 = (encode_binders None bs env)
in (match (_50_2015) with
| (vars, guards, env, decls, _50_2014) -> begin
(

let _50_2035 = (let _145_1072 = (FStar_All.pipe_right ps (FStar_List.map (fun p -> (

let _50_2032 = (let _145_1071 = (FStar_All.pipe_right p (FStar_List.map (fun _50_18 -> (match (_50_18) with
| (FStar_Util.Inl (t), _50_2021) -> begin
(encode_typ_term t env)
end
| (FStar_Util.Inr (e), _50_2026) -> begin
(encode_exp e (

let _50_2028 = env
in {bindings = _50_2028.bindings; depth = _50_2028.depth; tcenv = _50_2028.tcenv; warn = _50_2028.warn; cache = _50_2028.cache; nolabels = _50_2028.nolabels; use_zfuel_name = true; encode_non_total_function_typ = _50_2028.encode_non_total_function_typ}))
end))))
in (FStar_All.pipe_right _145_1071 FStar_List.unzip))
in (match (_50_2032) with
| (p, decls) -> begin
((p), ((FStar_List.flatten decls)))
end)))))
in (FStar_All.pipe_right _145_1072 FStar_List.unzip))
in (match (_50_2035) with
| (pats, decls') -> begin
(

let _50_2039 = (encode_formula_with_labels body env)
in (match (_50_2039) with
| (body, labs, decls'') -> begin
(let _145_1073 = (FStar_ToSMT_Term.mk_and_l guards)
in ((vars), (pats), (_145_1073), (body), (labs), ((FStar_List.append decls (FStar_List.append (FStar_List.flatten decls') decls'')))))
end))
end))
end)))
in (

let _50_2040 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _145_1074 = (FStar_Absyn_Print.formula_to_string phi)
in (FStar_Util.print1 ">>>> Destructing as formula ... %s\n" _145_1074))
end else begin
()
end
in (

let phi = (FStar_Absyn_Util.compress_typ phi)
in (match ((FStar_Absyn_Util.destruct_typ_as_formula phi)) with
| None -> begin
(fallback phi)
end
| Some (FStar_Absyn_Util.BaseConn (op, arms)) -> begin
(match ((FStar_All.pipe_right connectives (FStar_List.tryFind (fun _50_2052 -> (match (_50_2052) with
| (l, _50_2051) -> begin
(FStar_Ident.lid_equals op l)
end))))) with
| None -> begin
(fallback phi)
end
| Some (_50_2055, f) -> begin
(f arms)
end)
end
| Some (FStar_Absyn_Util.QAll (vars, pats, body)) -> begin
(

let _50_2065 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _145_1091 = (FStar_All.pipe_right vars (FStar_Absyn_Print.binders_to_string "; "))
in (FStar_Util.print1 ">>>> Got QALL [%s]\n" _145_1091))
end else begin
()
end
in (

let _50_2073 = (encode_q_body env vars pats body)
in (match (_50_2073) with
| (vars, pats, guard, body, labs, decls) -> begin
(let _145_1094 = (let _145_1093 = (let _145_1092 = (FStar_ToSMT_Term.mkImp ((guard), (body)))
in ((pats), (vars), (_145_1092)))
in (FStar_ToSMT_Term.mkForall _145_1093))
in ((_145_1094), (labs), (decls)))
end)))
end
| Some (FStar_Absyn_Util.QEx (vars, pats, body)) -> begin
(

let _50_2086 = (encode_q_body env vars pats body)
in (match (_50_2086) with
| (vars, pats, guard, body, labs, decls) -> begin
(let _145_1097 = (let _145_1096 = (let _145_1095 = (FStar_ToSMT_Term.mkAnd ((guard), (body)))
in ((pats), (vars), (_145_1095)))
in (FStar_ToSMT_Term.mkExists _145_1096))
in ((_145_1097), (labs), (decls)))
end))
end))))))))))))))))


type prims_t =
{mk : FStar_Ident.lident  ->  Prims.string  ->  FStar_ToSMT_Term.decl Prims.list; is : FStar_Ident.lident  ->  Prims.bool}


let is_Mkprims_t : prims_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkprims_t"))))


let prims : prims_t = (

let _50_2092 = (fresh_fvar "a" FStar_ToSMT_Term.Type_sort)
in (match (_50_2092) with
| (asym, a) -> begin
(

let _50_2095 = (fresh_fvar "x" FStar_ToSMT_Term.Term_sort)
in (match (_50_2095) with
| (xsym, x) -> begin
(

let _50_2098 = (fresh_fvar "y" FStar_ToSMT_Term.Term_sort)
in (match (_50_2098) with
| (ysym, y) -> begin
(

let deffun = (fun vars body x -> (let _145_1132 = (let _145_1131 = (let _145_1130 = (FStar_All.pipe_right vars (FStar_List.map Prims.snd))
in (let _145_1129 = (FStar_ToSMT_Term.abstr vars body)
in ((x), (_145_1130), (FStar_ToSMT_Term.Term_sort), (_145_1129), (None))))
in FStar_ToSMT_Term.DefineFun (_145_1131))
in (_145_1132)::[]))
in (

let quant = (fun vars body x -> (

let t1 = (let _145_1144 = (let _145_1143 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in ((x), (_145_1143)))
in (FStar_ToSMT_Term.mkApp _145_1144))
in (

let vname_decl = (let _145_1146 = (let _145_1145 = (FStar_All.pipe_right vars (FStar_List.map Prims.snd))
in ((x), (_145_1145), (FStar_ToSMT_Term.Term_sort), (None)))
in FStar_ToSMT_Term.DeclFun (_145_1146))
in (let _145_1152 = (let _145_1151 = (let _145_1150 = (let _145_1149 = (let _145_1148 = (let _145_1147 = (FStar_ToSMT_Term.mkEq ((t1), (body)))
in ((((t1)::[])::[]), (vars), (_145_1147)))
in (FStar_ToSMT_Term.mkForall _145_1148))
in ((_145_1149), (None)))
in FStar_ToSMT_Term.Assume (_145_1150))
in (_145_1151)::[])
in (vname_decl)::_145_1152))))
in (

let def_or_quant = (fun vars body x -> if (FStar_Options.inline_arith ()) then begin
(deffun vars body x)
end else begin
(quant vars body x)
end)
in (

let axy = (((asym), (FStar_ToSMT_Term.Type_sort)))::(((xsym), (FStar_ToSMT_Term.Term_sort)))::(((ysym), (FStar_ToSMT_Term.Term_sort)))::[]
in (

let xy = (((xsym), (FStar_ToSMT_Term.Term_sort)))::(((ysym), (FStar_ToSMT_Term.Term_sort)))::[]
in (

let qx = (((xsym), (FStar_ToSMT_Term.Term_sort)))::[]
in (

let prims = (let _145_1318 = (let _145_1167 = (let _145_1166 = (let _145_1165 = (FStar_ToSMT_Term.mkEq ((x), (y)))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1165))
in (def_or_quant axy _145_1166))
in ((FStar_Absyn_Const.op_Eq), (_145_1167)))
in (let _145_1317 = (let _145_1316 = (let _145_1174 = (let _145_1173 = (let _145_1172 = (let _145_1171 = (FStar_ToSMT_Term.mkEq ((x), (y)))
in (FStar_ToSMT_Term.mkNot _145_1171))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1172))
in (def_or_quant axy _145_1173))
in ((FStar_Absyn_Const.op_notEq), (_145_1174)))
in (let _145_1315 = (let _145_1314 = (let _145_1183 = (let _145_1182 = (let _145_1181 = (let _145_1180 = (let _145_1179 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1178 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1179), (_145_1178))))
in (FStar_ToSMT_Term.mkLT _145_1180))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1181))
in (def_or_quant xy _145_1182))
in ((FStar_Absyn_Const.op_LT), (_145_1183)))
in (let _145_1313 = (let _145_1312 = (let _145_1192 = (let _145_1191 = (let _145_1190 = (let _145_1189 = (let _145_1188 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1187 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1188), (_145_1187))))
in (FStar_ToSMT_Term.mkLTE _145_1189))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1190))
in (def_or_quant xy _145_1191))
in ((FStar_Absyn_Const.op_LTE), (_145_1192)))
in (let _145_1311 = (let _145_1310 = (let _145_1201 = (let _145_1200 = (let _145_1199 = (let _145_1198 = (let _145_1197 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1196 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1197), (_145_1196))))
in (FStar_ToSMT_Term.mkGT _145_1198))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1199))
in (def_or_quant xy _145_1200))
in ((FStar_Absyn_Const.op_GT), (_145_1201)))
in (let _145_1309 = (let _145_1308 = (let _145_1210 = (let _145_1209 = (let _145_1208 = (let _145_1207 = (let _145_1206 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1205 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1206), (_145_1205))))
in (FStar_ToSMT_Term.mkGTE _145_1207))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1208))
in (def_or_quant xy _145_1209))
in ((FStar_Absyn_Const.op_GTE), (_145_1210)))
in (let _145_1307 = (let _145_1306 = (let _145_1219 = (let _145_1218 = (let _145_1217 = (let _145_1216 = (let _145_1215 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1214 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1215), (_145_1214))))
in (FStar_ToSMT_Term.mkSub _145_1216))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _145_1217))
in (def_or_quant xy _145_1218))
in ((FStar_Absyn_Const.op_Subtraction), (_145_1219)))
in (let _145_1305 = (let _145_1304 = (let _145_1226 = (let _145_1225 = (let _145_1224 = (let _145_1223 = (FStar_ToSMT_Term.unboxInt x)
in (FStar_ToSMT_Term.mkMinus _145_1223))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _145_1224))
in (def_or_quant qx _145_1225))
in ((FStar_Absyn_Const.op_Minus), (_145_1226)))
in (let _145_1303 = (let _145_1302 = (let _145_1235 = (let _145_1234 = (let _145_1233 = (let _145_1232 = (let _145_1231 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1230 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1231), (_145_1230))))
in (FStar_ToSMT_Term.mkAdd _145_1232))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _145_1233))
in (def_or_quant xy _145_1234))
in ((FStar_Absyn_Const.op_Addition), (_145_1235)))
in (let _145_1301 = (let _145_1300 = (let _145_1244 = (let _145_1243 = (let _145_1242 = (let _145_1241 = (let _145_1240 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1239 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1240), (_145_1239))))
in (FStar_ToSMT_Term.mkMul _145_1241))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _145_1242))
in (def_or_quant xy _145_1243))
in ((FStar_Absyn_Const.op_Multiply), (_145_1244)))
in (let _145_1299 = (let _145_1298 = (let _145_1253 = (let _145_1252 = (let _145_1251 = (let _145_1250 = (let _145_1249 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1248 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1249), (_145_1248))))
in (FStar_ToSMT_Term.mkDiv _145_1250))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _145_1251))
in (def_or_quant xy _145_1252))
in ((FStar_Absyn_Const.op_Division), (_145_1253)))
in (let _145_1297 = (let _145_1296 = (let _145_1262 = (let _145_1261 = (let _145_1260 = (let _145_1259 = (let _145_1258 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1257 = (FStar_ToSMT_Term.unboxInt y)
in ((_145_1258), (_145_1257))))
in (FStar_ToSMT_Term.mkMod _145_1259))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxInt _145_1260))
in (def_or_quant xy _145_1261))
in ((FStar_Absyn_Const.op_Modulus), (_145_1262)))
in (let _145_1295 = (let _145_1294 = (let _145_1271 = (let _145_1270 = (let _145_1269 = (let _145_1268 = (let _145_1267 = (FStar_ToSMT_Term.unboxBool x)
in (let _145_1266 = (FStar_ToSMT_Term.unboxBool y)
in ((_145_1267), (_145_1266))))
in (FStar_ToSMT_Term.mkAnd _145_1268))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1269))
in (def_or_quant xy _145_1270))
in ((FStar_Absyn_Const.op_And), (_145_1271)))
in (let _145_1293 = (let _145_1292 = (let _145_1280 = (let _145_1279 = (let _145_1278 = (let _145_1277 = (let _145_1276 = (FStar_ToSMT_Term.unboxBool x)
in (let _145_1275 = (FStar_ToSMT_Term.unboxBool y)
in ((_145_1276), (_145_1275))))
in (FStar_ToSMT_Term.mkOr _145_1277))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1278))
in (def_or_quant xy _145_1279))
in ((FStar_Absyn_Const.op_Or), (_145_1280)))
in (let _145_1291 = (let _145_1290 = (let _145_1287 = (let _145_1286 = (let _145_1285 = (let _145_1284 = (FStar_ToSMT_Term.unboxBool x)
in (FStar_ToSMT_Term.mkNot _145_1284))
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_1285))
in (def_or_quant qx _145_1286))
in ((FStar_Absyn_Const.op_Negation), (_145_1287)))
in (_145_1290)::[])
in (_145_1292)::_145_1291))
in (_145_1294)::_145_1293))
in (_145_1296)::_145_1295))
in (_145_1298)::_145_1297))
in (_145_1300)::_145_1299))
in (_145_1302)::_145_1301))
in (_145_1304)::_145_1303))
in (_145_1306)::_145_1305))
in (_145_1308)::_145_1307))
in (_145_1310)::_145_1309))
in (_145_1312)::_145_1311))
in (_145_1314)::_145_1313))
in (_145_1316)::_145_1315))
in (_145_1318)::_145_1317))
in (

let mk = (fun l v -> (let _145_1350 = (FStar_All.pipe_right prims (FStar_List.filter (fun _50_2122 -> (match (_50_2122) with
| (l', _50_2121) -> begin
(FStar_Ident.lid_equals l l')
end))))
in (FStar_All.pipe_right _145_1350 (FStar_List.collect (fun _50_2126 -> (match (_50_2126) with
| (_50_2124, b) -> begin
(b v)
end))))))
in (

let is = (fun l -> (FStar_All.pipe_right prims (FStar_Util.for_some (fun _50_2132 -> (match (_50_2132) with
| (l', _50_2131) -> begin
(FStar_Ident.lid_equals l l')
end)))))
in {mk = mk; is = is})))))))))
end))
end))
end))


let primitive_type_axioms : FStar_Ident.lident  ->  Prims.string  ->  FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.decl Prims.list = (

let xx = (("x"), (FStar_ToSMT_Term.Term_sort))
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let yy = (("y"), (FStar_ToSMT_Term.Term_sort))
in (

let y = (FStar_ToSMT_Term.mkFreeV yy)
in (

let mk_unit = (fun _50_2138 tt -> (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x tt)
in (let _145_1382 = (let _145_1373 = (let _145_1372 = (FStar_ToSMT_Term.mk_HasType FStar_ToSMT_Term.mk_Term_unit tt)
in ((_145_1372), (Some ("unit typing"))))
in FStar_ToSMT_Term.Assume (_145_1373))
in (let _145_1381 = (let _145_1380 = (let _145_1379 = (let _145_1378 = (let _145_1377 = (let _145_1376 = (let _145_1375 = (let _145_1374 = (FStar_ToSMT_Term.mkEq ((x), (FStar_ToSMT_Term.mk_Term_unit)))
in ((typing_pred), (_145_1374)))
in (FStar_ToSMT_Term.mkImp _145_1375))
in ((((typing_pred)::[])::[]), ((xx)::[]), (_145_1376)))
in (mkForall_fuel _145_1377))
in ((_145_1378), (Some ("unit inversion"))))
in FStar_ToSMT_Term.Assume (_145_1379))
in (_145_1380)::[])
in (_145_1382)::_145_1381))))
in (

let mk_bool = (fun _50_2143 tt -> (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x tt)
in (

let bb = (("b"), (FStar_ToSMT_Term.Bool_sort))
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (let _145_1403 = (let _145_1392 = (let _145_1391 = (let _145_1390 = (let _145_1389 = (let _145_1388 = (let _145_1387 = (FStar_ToSMT_Term.mk_tester "BoxBool" x)
in ((typing_pred), (_145_1387)))
in (FStar_ToSMT_Term.mkImp _145_1388))
in ((((typing_pred)::[])::[]), ((xx)::[]), (_145_1389)))
in (mkForall_fuel _145_1390))
in ((_145_1391), (Some ("bool inversion"))))
in FStar_ToSMT_Term.Assume (_145_1392))
in (let _145_1402 = (let _145_1401 = (let _145_1400 = (let _145_1399 = (let _145_1398 = (let _145_1397 = (let _145_1394 = (let _145_1393 = (FStar_ToSMT_Term.boxBool b)
in (_145_1393)::[])
in (_145_1394)::[])
in (let _145_1396 = (let _145_1395 = (FStar_ToSMT_Term.boxBool b)
in (FStar_ToSMT_Term.mk_HasType _145_1395 tt))
in ((_145_1397), ((bb)::[]), (_145_1396))))
in (FStar_ToSMT_Term.mkForall _145_1398))
in ((_145_1399), (Some ("bool typing"))))
in FStar_ToSMT_Term.Assume (_145_1400))
in (_145_1401)::[])
in (_145_1403)::_145_1402))))))
in (

let mk_int = (fun _50_2150 tt -> (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x tt)
in (

let typing_pred_y = (FStar_ToSMT_Term.mk_HasType y tt)
in (

let aa = (("a"), (FStar_ToSMT_Term.Int_sort))
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let bb = (("b"), (FStar_ToSMT_Term.Int_sort))
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let precedes = (let _145_1415 = (let _145_1414 = (let _145_1413 = (let _145_1412 = (let _145_1411 = (let _145_1410 = (FStar_ToSMT_Term.boxInt a)
in (let _145_1409 = (let _145_1408 = (FStar_ToSMT_Term.boxInt b)
in (_145_1408)::[])
in (_145_1410)::_145_1409))
in (tt)::_145_1411)
in (tt)::_145_1412)
in (("Prims.Precedes"), (_145_1413)))
in (FStar_ToSMT_Term.mkApp _145_1414))
in (FStar_All.pipe_left FStar_ToSMT_Term.mk_Valid _145_1415))
in (

let precedes_y_x = (let _145_1416 = (FStar_ToSMT_Term.mkApp (("Precedes"), ((y)::(x)::[])))
in (FStar_All.pipe_left FStar_ToSMT_Term.mk_Valid _145_1416))
in (let _145_1458 = (let _145_1422 = (let _145_1421 = (let _145_1420 = (let _145_1419 = (let _145_1418 = (let _145_1417 = (FStar_ToSMT_Term.mk_tester "BoxInt" x)
in ((typing_pred), (_145_1417)))
in (FStar_ToSMT_Term.mkImp _145_1418))
in ((((typing_pred)::[])::[]), ((xx)::[]), (_145_1419)))
in (mkForall_fuel _145_1420))
in ((_145_1421), (Some ("int inversion"))))
in FStar_ToSMT_Term.Assume (_145_1422))
in (let _145_1457 = (let _145_1456 = (let _145_1430 = (let _145_1429 = (let _145_1428 = (let _145_1427 = (let _145_1424 = (let _145_1423 = (FStar_ToSMT_Term.boxInt b)
in (_145_1423)::[])
in (_145_1424)::[])
in (let _145_1426 = (let _145_1425 = (FStar_ToSMT_Term.boxInt b)
in (FStar_ToSMT_Term.mk_HasType _145_1425 tt))
in ((_145_1427), ((bb)::[]), (_145_1426))))
in (FStar_ToSMT_Term.mkForall _145_1428))
in ((_145_1429), (Some ("int typing"))))
in FStar_ToSMT_Term.Assume (_145_1430))
in (let _145_1455 = (let _145_1454 = (let _145_1453 = (let _145_1452 = (let _145_1451 = (let _145_1450 = (let _145_1449 = (let _145_1448 = (let _145_1447 = (let _145_1446 = (let _145_1445 = (let _145_1444 = (let _145_1433 = (let _145_1432 = (FStar_ToSMT_Term.unboxInt x)
in (let _145_1431 = (FStar_ToSMT_Term.mkInteger' (Prims.parse_int "0"))
in ((_145_1432), (_145_1431))))
in (FStar_ToSMT_Term.mkGT _145_1433))
in (let _145_1443 = (let _145_1442 = (let _145_1436 = (let _145_1435 = (FStar_ToSMT_Term.unboxInt y)
in (let _145_1434 = (FStar_ToSMT_Term.mkInteger' (Prims.parse_int "0"))
in ((_145_1435), (_145_1434))))
in (FStar_ToSMT_Term.mkGTE _145_1436))
in (let _145_1441 = (let _145_1440 = (let _145_1439 = (let _145_1438 = (FStar_ToSMT_Term.unboxInt y)
in (let _145_1437 = (FStar_ToSMT_Term.unboxInt x)
in ((_145_1438), (_145_1437))))
in (FStar_ToSMT_Term.mkLT _145_1439))
in (_145_1440)::[])
in (_145_1442)::_145_1441))
in (_145_1444)::_145_1443))
in (typing_pred_y)::_145_1445)
in (typing_pred)::_145_1446)
in (FStar_ToSMT_Term.mk_and_l _145_1447))
in ((_145_1448), (precedes_y_x)))
in (FStar_ToSMT_Term.mkImp _145_1449))
in ((((typing_pred)::(typing_pred_y)::(precedes_y_x)::[])::[]), ((xx)::(yy)::[]), (_145_1450)))
in (mkForall_fuel _145_1451))
in ((_145_1452), (Some ("well-founded ordering on nat (alt)"))))
in FStar_ToSMT_Term.Assume (_145_1453))
in (_145_1454)::[])
in (_145_1456)::_145_1455))
in (_145_1458)::_145_1457)))))))))))
in (

let mk_int_alias = (fun _50_2162 tt -> (let _145_1467 = (let _145_1466 = (let _145_1465 = (let _145_1464 = (let _145_1463 = (FStar_ToSMT_Term.mkApp ((FStar_Absyn_Const.int_lid.FStar_Ident.str), ([])))
in ((tt), (_145_1463)))
in (FStar_ToSMT_Term.mkEq _145_1464))
in ((_145_1465), (Some ("mapping to int; for now"))))
in FStar_ToSMT_Term.Assume (_145_1466))
in (_145_1467)::[]))
in (

let mk_str = (fun _50_2166 tt -> (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x tt)
in (

let bb = (("b"), (FStar_ToSMT_Term.String_sort))
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (let _145_1488 = (let _145_1477 = (let _145_1476 = (let _145_1475 = (let _145_1474 = (let _145_1473 = (let _145_1472 = (FStar_ToSMT_Term.mk_tester "BoxString" x)
in ((typing_pred), (_145_1472)))
in (FStar_ToSMT_Term.mkImp _145_1473))
in ((((typing_pred)::[])::[]), ((xx)::[]), (_145_1474)))
in (mkForall_fuel _145_1475))
in ((_145_1476), (Some ("string inversion"))))
in FStar_ToSMT_Term.Assume (_145_1477))
in (let _145_1487 = (let _145_1486 = (let _145_1485 = (let _145_1484 = (let _145_1483 = (let _145_1482 = (let _145_1479 = (let _145_1478 = (FStar_ToSMT_Term.boxString b)
in (_145_1478)::[])
in (_145_1479)::[])
in (let _145_1481 = (let _145_1480 = (FStar_ToSMT_Term.boxString b)
in (FStar_ToSMT_Term.mk_HasType _145_1480 tt))
in ((_145_1482), ((bb)::[]), (_145_1481))))
in (FStar_ToSMT_Term.mkForall _145_1483))
in ((_145_1484), (Some ("string typing"))))
in FStar_ToSMT_Term.Assume (_145_1485))
in (_145_1486)::[])
in (_145_1488)::_145_1487))))))
in (

let mk_ref = (fun reft_name _50_2174 -> (

let r = (("r"), (FStar_ToSMT_Term.Ref_sort))
in (

let aa = (("a"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("b"), (FStar_ToSMT_Term.Type_sort))
in (

let refa = (let _145_1495 = (let _145_1494 = (let _145_1493 = (FStar_ToSMT_Term.mkFreeV aa)
in (_145_1493)::[])
in ((reft_name), (_145_1494)))
in (FStar_ToSMT_Term.mkApp _145_1495))
in (

let refb = (let _145_1498 = (let _145_1497 = (let _145_1496 = (FStar_ToSMT_Term.mkFreeV bb)
in (_145_1496)::[])
in ((reft_name), (_145_1497)))
in (FStar_ToSMT_Term.mkApp _145_1498))
in (

let typing_pred = (FStar_ToSMT_Term.mk_HasType x refa)
in (

let typing_pred_b = (FStar_ToSMT_Term.mk_HasType x refb)
in (let _145_1517 = (let _145_1504 = (let _145_1503 = (let _145_1502 = (let _145_1501 = (let _145_1500 = (let _145_1499 = (FStar_ToSMT_Term.mk_tester "BoxRef" x)
in ((typing_pred), (_145_1499)))
in (FStar_ToSMT_Term.mkImp _145_1500))
in ((((typing_pred)::[])::[]), ((xx)::(aa)::[]), (_145_1501)))
in (mkForall_fuel _145_1502))
in ((_145_1503), (Some ("ref inversion"))))
in FStar_ToSMT_Term.Assume (_145_1504))
in (let _145_1516 = (let _145_1515 = (let _145_1514 = (let _145_1513 = (let _145_1512 = (let _145_1511 = (let _145_1510 = (let _145_1509 = (FStar_ToSMT_Term.mkAnd ((typing_pred), (typing_pred_b)))
in (let _145_1508 = (let _145_1507 = (let _145_1506 = (FStar_ToSMT_Term.mkFreeV aa)
in (let _145_1505 = (FStar_ToSMT_Term.mkFreeV bb)
in ((_145_1506), (_145_1505))))
in (FStar_ToSMT_Term.mkEq _145_1507))
in ((_145_1509), (_145_1508))))
in (FStar_ToSMT_Term.mkImp _145_1510))
in ((((typing_pred)::(typing_pred_b)::[])::[]), ((xx)::(aa)::(bb)::[]), (_145_1511)))
in (mkForall_fuel' (Prims.parse_int "2") _145_1512))
in ((_145_1513), (Some ("ref typing is injective"))))
in FStar_ToSMT_Term.Assume (_145_1514))
in (_145_1515)::[])
in (_145_1517)::_145_1516))))))))))
in (

let mk_false_interp = (fun _50_2184 false_tm -> (

let valid = (FStar_ToSMT_Term.mkApp (("Valid"), ((false_tm)::[])))
in (let _145_1524 = (let _145_1523 = (let _145_1522 = (FStar_ToSMT_Term.mkIff ((FStar_ToSMT_Term.mkFalse), (valid)))
in ((_145_1522), (Some ("False interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1523))
in (_145_1524)::[])))
in (

let mk_and_interp = (fun conj _50_2190 -> (

let aa = (("a"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("b"), (FStar_ToSMT_Term.Type_sort))
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _145_1531 = (let _145_1530 = (let _145_1529 = (FStar_ToSMT_Term.mkApp ((conj), ((a)::(b)::[])))
in (_145_1529)::[])
in (("Valid"), (_145_1530)))
in (FStar_ToSMT_Term.mkApp _145_1531))
in (

let valid_a = (FStar_ToSMT_Term.mkApp (("Valid"), ((a)::[])))
in (

let valid_b = (FStar_ToSMT_Term.mkApp (("Valid"), ((b)::[])))
in (let _145_1538 = (let _145_1537 = (let _145_1536 = (let _145_1535 = (let _145_1534 = (let _145_1533 = (let _145_1532 = (FStar_ToSMT_Term.mkAnd ((valid_a), (valid_b)))
in ((_145_1532), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1533))
in ((((valid)::[])::[]), ((aa)::(bb)::[]), (_145_1534)))
in (FStar_ToSMT_Term.mkForall _145_1535))
in ((_145_1536), (Some ("/\\ interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1537))
in (_145_1538)::[])))))))))
in (

let mk_or_interp = (fun disj _50_2201 -> (

let aa = (("a"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("b"), (FStar_ToSMT_Term.Type_sort))
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _145_1545 = (let _145_1544 = (let _145_1543 = (FStar_ToSMT_Term.mkApp ((disj), ((a)::(b)::[])))
in (_145_1543)::[])
in (("Valid"), (_145_1544)))
in (FStar_ToSMT_Term.mkApp _145_1545))
in (

let valid_a = (FStar_ToSMT_Term.mkApp (("Valid"), ((a)::[])))
in (

let valid_b = (FStar_ToSMT_Term.mkApp (("Valid"), ((b)::[])))
in (let _145_1552 = (let _145_1551 = (let _145_1550 = (let _145_1549 = (let _145_1548 = (let _145_1547 = (let _145_1546 = (FStar_ToSMT_Term.mkOr ((valid_a), (valid_b)))
in ((_145_1546), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1547))
in ((((valid)::[])::[]), ((aa)::(bb)::[]), (_145_1548)))
in (FStar_ToSMT_Term.mkForall _145_1549))
in ((_145_1550), (Some ("\\/ interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1551))
in (_145_1552)::[])))))))))
in (

let mk_eq2_interp = (fun eq2 tt -> (

let aa = (("a"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("b"), (FStar_ToSMT_Term.Type_sort))
in (

let xx = (("x"), (FStar_ToSMT_Term.Term_sort))
in (

let yy = (("y"), (FStar_ToSMT_Term.Term_sort))
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let y = (FStar_ToSMT_Term.mkFreeV yy)
in (

let valid = (let _145_1559 = (let _145_1558 = (let _145_1557 = (FStar_ToSMT_Term.mkApp ((eq2), ((a)::(b)::(x)::(y)::[])))
in (_145_1557)::[])
in (("Valid"), (_145_1558)))
in (FStar_ToSMT_Term.mkApp _145_1559))
in (let _145_1566 = (let _145_1565 = (let _145_1564 = (let _145_1563 = (let _145_1562 = (let _145_1561 = (let _145_1560 = (FStar_ToSMT_Term.mkEq ((x), (y)))
in ((_145_1560), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1561))
in ((((valid)::[])::[]), ((aa)::(bb)::(xx)::(yy)::[]), (_145_1562)))
in (FStar_ToSMT_Term.mkForall _145_1563))
in ((_145_1564), (Some ("Eq2 interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1565))
in (_145_1566)::[])))))))))))
in (

let mk_imp_interp = (fun imp tt -> (

let aa = (("a"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("b"), (FStar_ToSMT_Term.Type_sort))
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _145_1573 = (let _145_1572 = (let _145_1571 = (FStar_ToSMT_Term.mkApp ((imp), ((a)::(b)::[])))
in (_145_1571)::[])
in (("Valid"), (_145_1572)))
in (FStar_ToSMT_Term.mkApp _145_1573))
in (

let valid_a = (FStar_ToSMT_Term.mkApp (("Valid"), ((a)::[])))
in (

let valid_b = (FStar_ToSMT_Term.mkApp (("Valid"), ((b)::[])))
in (let _145_1580 = (let _145_1579 = (let _145_1578 = (let _145_1577 = (let _145_1576 = (let _145_1575 = (let _145_1574 = (FStar_ToSMT_Term.mkImp ((valid_a), (valid_b)))
in ((_145_1574), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1575))
in ((((valid)::[])::[]), ((aa)::(bb)::[]), (_145_1576)))
in (FStar_ToSMT_Term.mkForall _145_1577))
in ((_145_1578), (Some ("==> interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1579))
in (_145_1580)::[])))))))))
in (

let mk_iff_interp = (fun iff tt -> (

let aa = (("a"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("b"), (FStar_ToSMT_Term.Type_sort))
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _145_1587 = (let _145_1586 = (let _145_1585 = (FStar_ToSMT_Term.mkApp ((iff), ((a)::(b)::[])))
in (_145_1585)::[])
in (("Valid"), (_145_1586)))
in (FStar_ToSMT_Term.mkApp _145_1587))
in (

let valid_a = (FStar_ToSMT_Term.mkApp (("Valid"), ((a)::[])))
in (

let valid_b = (FStar_ToSMT_Term.mkApp (("Valid"), ((b)::[])))
in (let _145_1594 = (let _145_1593 = (let _145_1592 = (let _145_1591 = (let _145_1590 = (let _145_1589 = (let _145_1588 = (FStar_ToSMT_Term.mkIff ((valid_a), (valid_b)))
in ((_145_1588), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1589))
in ((((valid)::[])::[]), ((aa)::(bb)::[]), (_145_1590)))
in (FStar_ToSMT_Term.mkForall _145_1591))
in ((_145_1592), (Some ("<==> interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1593))
in (_145_1594)::[])))))))))
in (

let mk_forall_interp = (fun for_all tt -> (

let aa = (("a"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("b"), (FStar_ToSMT_Term.Type_sort))
in (

let xx = (("x"), (FStar_ToSMT_Term.Term_sort))
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let valid = (let _145_1601 = (let _145_1600 = (let _145_1599 = (FStar_ToSMT_Term.mkApp ((for_all), ((a)::(b)::[])))
in (_145_1599)::[])
in (("Valid"), (_145_1600)))
in (FStar_ToSMT_Term.mkApp _145_1601))
in (

let valid_b_x = (let _145_1604 = (let _145_1603 = (let _145_1602 = (FStar_ToSMT_Term.mk_ApplyTE b x)
in (_145_1602)::[])
in (("Valid"), (_145_1603)))
in (FStar_ToSMT_Term.mkApp _145_1604))
in (let _145_1618 = (let _145_1617 = (let _145_1616 = (let _145_1615 = (let _145_1614 = (let _145_1613 = (let _145_1612 = (let _145_1611 = (let _145_1610 = (let _145_1606 = (let _145_1605 = (FStar_ToSMT_Term.mk_HasTypeZ x a)
in (_145_1605)::[])
in (_145_1606)::[])
in (let _145_1609 = (let _145_1608 = (let _145_1607 = (FStar_ToSMT_Term.mk_HasTypeZ x a)
in ((_145_1607), (valid_b_x)))
in (FStar_ToSMT_Term.mkImp _145_1608))
in ((_145_1610), ((xx)::[]), (_145_1609))))
in (FStar_ToSMT_Term.mkForall _145_1611))
in ((_145_1612), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1613))
in ((((valid)::[])::[]), ((aa)::(bb)::[]), (_145_1614)))
in (FStar_ToSMT_Term.mkForall _145_1615))
in ((_145_1616), (Some ("forall interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1617))
in (_145_1618)::[]))))))))))
in (

let mk_exists_interp = (fun for_all tt -> (

let aa = (("a"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("b"), (FStar_ToSMT_Term.Type_sort))
in (

let xx = (("x"), (FStar_ToSMT_Term.Term_sort))
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let valid = (let _145_1625 = (let _145_1624 = (let _145_1623 = (FStar_ToSMT_Term.mkApp ((for_all), ((a)::(b)::[])))
in (_145_1623)::[])
in (("Valid"), (_145_1624)))
in (FStar_ToSMT_Term.mkApp _145_1625))
in (

let valid_b_x = (let _145_1628 = (let _145_1627 = (let _145_1626 = (FStar_ToSMT_Term.mk_ApplyTE b x)
in (_145_1626)::[])
in (("Valid"), (_145_1627)))
in (FStar_ToSMT_Term.mkApp _145_1628))
in (let _145_1642 = (let _145_1641 = (let _145_1640 = (let _145_1639 = (let _145_1638 = (let _145_1637 = (let _145_1636 = (let _145_1635 = (let _145_1634 = (let _145_1630 = (let _145_1629 = (FStar_ToSMT_Term.mk_HasTypeZ x a)
in (_145_1629)::[])
in (_145_1630)::[])
in (let _145_1633 = (let _145_1632 = (let _145_1631 = (FStar_ToSMT_Term.mk_HasTypeZ x a)
in ((_145_1631), (valid_b_x)))
in (FStar_ToSMT_Term.mkImp _145_1632))
in ((_145_1634), ((xx)::[]), (_145_1633))))
in (FStar_ToSMT_Term.mkExists _145_1635))
in ((_145_1636), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1637))
in ((((valid)::[])::[]), ((aa)::(bb)::[]), (_145_1638)))
in (FStar_ToSMT_Term.mkForall _145_1639))
in ((_145_1640), (Some ("exists interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1641))
in (_145_1642)::[]))))))))))
in (

let mk_foralltyp_interp = (fun for_all tt -> (

let kk = (("k"), (FStar_ToSMT_Term.Kind_sort))
in (

let aa = (("aa"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("bb"), (FStar_ToSMT_Term.Term_sort))
in (

let k = (FStar_ToSMT_Term.mkFreeV kk)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _145_1649 = (let _145_1648 = (let _145_1647 = (FStar_ToSMT_Term.mkApp ((for_all), ((k)::(a)::[])))
in (_145_1647)::[])
in (("Valid"), (_145_1648)))
in (FStar_ToSMT_Term.mkApp _145_1649))
in (

let valid_a_b = (let _145_1652 = (let _145_1651 = (let _145_1650 = (FStar_ToSMT_Term.mk_ApplyTE a b)
in (_145_1650)::[])
in (("Valid"), (_145_1651)))
in (FStar_ToSMT_Term.mkApp _145_1652))
in (let _145_1666 = (let _145_1665 = (let _145_1664 = (let _145_1663 = (let _145_1662 = (let _145_1661 = (let _145_1660 = (let _145_1659 = (let _145_1658 = (let _145_1654 = (let _145_1653 = (FStar_ToSMT_Term.mk_HasKind b k)
in (_145_1653)::[])
in (_145_1654)::[])
in (let _145_1657 = (let _145_1656 = (let _145_1655 = (FStar_ToSMT_Term.mk_HasKind b k)
in ((_145_1655), (valid_a_b)))
in (FStar_ToSMT_Term.mkImp _145_1656))
in ((_145_1658), ((bb)::[]), (_145_1657))))
in (FStar_ToSMT_Term.mkForall _145_1659))
in ((_145_1660), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1661))
in ((((valid)::[])::[]), ((kk)::(aa)::[]), (_145_1662)))
in (FStar_ToSMT_Term.mkForall _145_1663))
in ((_145_1664), (Some ("ForallTyp interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1665))
in (_145_1666)::[]))))))))))
in (

let mk_existstyp_interp = (fun for_some tt -> (

let kk = (("k"), (FStar_ToSMT_Term.Kind_sort))
in (

let aa = (("aa"), (FStar_ToSMT_Term.Type_sort))
in (

let bb = (("bb"), (FStar_ToSMT_Term.Term_sort))
in (

let k = (FStar_ToSMT_Term.mkFreeV kk)
in (

let a = (FStar_ToSMT_Term.mkFreeV aa)
in (

let b = (FStar_ToSMT_Term.mkFreeV bb)
in (

let valid = (let _145_1673 = (let _145_1672 = (let _145_1671 = (FStar_ToSMT_Term.mkApp ((for_some), ((k)::(a)::[])))
in (_145_1671)::[])
in (("Valid"), (_145_1672)))
in (FStar_ToSMT_Term.mkApp _145_1673))
in (

let valid_a_b = (let _145_1676 = (let _145_1675 = (let _145_1674 = (FStar_ToSMT_Term.mk_ApplyTE a b)
in (_145_1674)::[])
in (("Valid"), (_145_1675)))
in (FStar_ToSMT_Term.mkApp _145_1676))
in (let _145_1690 = (let _145_1689 = (let _145_1688 = (let _145_1687 = (let _145_1686 = (let _145_1685 = (let _145_1684 = (let _145_1683 = (let _145_1682 = (let _145_1678 = (let _145_1677 = (FStar_ToSMT_Term.mk_HasKind b k)
in (_145_1677)::[])
in (_145_1678)::[])
in (let _145_1681 = (let _145_1680 = (let _145_1679 = (FStar_ToSMT_Term.mk_HasKind b k)
in ((_145_1679), (valid_a_b)))
in (FStar_ToSMT_Term.mkImp _145_1680))
in ((_145_1682), ((bb)::[]), (_145_1681))))
in (FStar_ToSMT_Term.mkExists _145_1683))
in ((_145_1684), (valid)))
in (FStar_ToSMT_Term.mkIff _145_1685))
in ((((valid)::[])::[]), ((kk)::(aa)::[]), (_145_1686)))
in (FStar_ToSMT_Term.mkForall _145_1687))
in ((_145_1688), (Some ("ExistsTyp interpretation"))))
in FStar_ToSMT_Term.Assume (_145_1689))
in (_145_1690)::[]))))))))))
in (

let prims = (((FStar_Absyn_Const.unit_lid), (mk_unit)))::(((FStar_Absyn_Const.bool_lid), (mk_bool)))::(((FStar_Absyn_Const.int_lid), (mk_int)))::(((FStar_Absyn_Const.string_lid), (mk_str)))::(((FStar_Absyn_Const.ref_lid), (mk_ref)))::(((FStar_Absyn_Const.false_lid), (mk_false_interp)))::(((FStar_Absyn_Const.and_lid), (mk_and_interp)))::(((FStar_Absyn_Const.or_lid), (mk_or_interp)))::(((FStar_Absyn_Const.eq2_lid), (mk_eq2_interp)))::(((FStar_Absyn_Const.imp_lid), (mk_imp_interp)))::(((FStar_Absyn_Const.iff_lid), (mk_iff_interp)))::(((FStar_Absyn_Const.forall_lid), (mk_forall_interp)))::(((FStar_Absyn_Const.exists_lid), (mk_exists_interp)))::[]
in (fun t s tt -> (match ((FStar_Util.find_opt (fun _50_2294 -> (match (_50_2294) with
| (l, _50_2293) -> begin
(FStar_Ident.lid_equals l t)
end)) prims)) with
| None -> begin
[]
end
| Some (_50_2297, f) -> begin
(f s tt)
end)))))))))))))))))))))))


let rec encode_sigelt : env_t  ->  FStar_Absyn_Syntax.sigelt  ->  (FStar_ToSMT_Term.decls_t * env_t) = (fun env se -> (

let _50_2303 = if (FStar_Tc_Env.debug env.tcenv FStar_Options.Low) then begin
(let _145_1821 = (FStar_Absyn_Print.sigelt_to_string se)
in (FStar_All.pipe_left (FStar_Util.print1 ">>>>Encoding [%s]\n") _145_1821))
end else begin
()
end
in (

let nm = (match ((FStar_Absyn_Util.lid_of_sigelt se)) with
| None -> begin
""
end
| Some (l) -> begin
l.FStar_Ident.str
end)
in (

let _50_2311 = (encode_sigelt' env se)
in (match (_50_2311) with
| (g, e) -> begin
(match (g) with
| [] -> begin
(let _145_1824 = (let _145_1823 = (let _145_1822 = (FStar_Util.format1 "<Skipped %s/>" nm)
in FStar_ToSMT_Term.Caption (_145_1822))
in (_145_1823)::[])
in ((_145_1824), (e)))
end
| _50_2314 -> begin
(let _145_1831 = (let _145_1830 = (let _145_1826 = (let _145_1825 = (FStar_Util.format1 "<Start encoding %s>" nm)
in FStar_ToSMT_Term.Caption (_145_1825))
in (_145_1826)::g)
in (let _145_1829 = (let _145_1828 = (let _145_1827 = (FStar_Util.format1 "</end encoding %s>" nm)
in FStar_ToSMT_Term.Caption (_145_1827))
in (_145_1828)::[])
in (FStar_List.append _145_1830 _145_1829)))
in ((_145_1831), (e)))
end)
end)))))
and encode_sigelt' : env_t  ->  FStar_Absyn_Syntax.sigelt  ->  (FStar_ToSMT_Term.decls_t * env_t) = (fun env se -> (

let should_skip = (fun l -> ((((FStar_Util.starts_with l.FStar_Ident.str "Prims.pure_") || (FStar_Util.starts_with l.FStar_Ident.str "Prims.ex_")) || (FStar_Util.starts_with l.FStar_Ident.str "Prims.st_")) || (FStar_Util.starts_with l.FStar_Ident.str "Prims.all_")))
in (

let encode_top_level_val = (fun env lid t quals -> (

let tt = (whnf env t)
in (

let _50_2327 = (encode_free_var env lid t tt quals)
in (match (_50_2327) with
| (decls, env) -> begin
if (FStar_Absyn_Util.is_smt_lemma t) then begin
(let _145_1845 = (let _145_1844 = (encode_smt_lemma env lid t)
in (FStar_List.append decls _145_1844))
in ((_145_1845), (env)))
end else begin
((decls), (env))
end
end))))
in (

let encode_top_level_vals = (fun env bindings quals -> (FStar_All.pipe_right bindings (FStar_List.fold_left (fun _50_2334 lb -> (match (_50_2334) with
| (decls, env) -> begin
(

let _50_2338 = (let _145_1854 = (FStar_Util.right lb.FStar_Absyn_Syntax.lbname)
in (encode_top_level_val env _145_1854 lb.FStar_Absyn_Syntax.lbtyp quals))
in (match (_50_2338) with
| (decls', env) -> begin
(((FStar_List.append decls decls')), (env))
end))
end)) (([]), (env)))))
in (match (se) with
| FStar_Absyn_Syntax.Sig_typ_abbrev (_50_2340, _50_2342, _50_2344, _50_2346, (FStar_Absyn_Syntax.Effect)::[], _50_2350) -> begin
(([]), (env))
end
| FStar_Absyn_Syntax.Sig_typ_abbrev (lid, _50_2355, _50_2357, _50_2359, _50_2361, _50_2363) when (should_skip lid) -> begin
(([]), (env))
end
| FStar_Absyn_Syntax.Sig_typ_abbrev (lid, _50_2368, _50_2370, _50_2372, _50_2374, _50_2376) when (FStar_Ident.lid_equals lid FStar_Absyn_Const.b2t_lid) -> begin
(

let _50_2382 = (new_typ_constant_and_tok_from_lid env lid)
in (match (_50_2382) with
| (tname, ttok, env) -> begin
(

let xx = (("x"), (FStar_ToSMT_Term.Term_sort))
in (

let x = (FStar_ToSMT_Term.mkFreeV xx)
in (

let valid_b2t_x = (let _145_1857 = (let _145_1856 = (let _145_1855 = (FStar_ToSMT_Term.mkApp (("Prims.b2t"), ((x)::[])))
in (_145_1855)::[])
in (("Valid"), (_145_1856)))
in (FStar_ToSMT_Term.mkApp _145_1857))
in (

let decls = (let _145_1865 = (let _145_1864 = (let _145_1863 = (let _145_1862 = (let _145_1861 = (let _145_1860 = (let _145_1859 = (let _145_1858 = (FStar_ToSMT_Term.mkApp (("BoxBool_proj_0"), ((x)::[])))
in ((valid_b2t_x), (_145_1858)))
in (FStar_ToSMT_Term.mkEq _145_1859))
in ((((valid_b2t_x)::[])::[]), ((xx)::[]), (_145_1860)))
in (FStar_ToSMT_Term.mkForall _145_1861))
in ((_145_1862), (Some ("b2t def"))))
in FStar_ToSMT_Term.Assume (_145_1863))
in (_145_1864)::[])
in (FStar_ToSMT_Term.DeclFun (((tname), ((FStar_ToSMT_Term.Term_sort)::[]), (FStar_ToSMT_Term.Type_sort), (None))))::_145_1865)
in ((decls), (env))))))
end))
end
| FStar_Absyn_Syntax.Sig_typ_abbrev (lid, tps, _50_2390, t, tags, _50_2394) -> begin
(

let _50_2400 = (new_typ_constant_and_tok_from_lid env lid)
in (match (_50_2400) with
| (tname, ttok, env) -> begin
(

let _50_2409 = (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_lam (tps', body) -> begin
(((FStar_List.append tps tps')), (body))
end
| _50_2406 -> begin
((tps), (t))
end)
in (match (_50_2409) with
| (tps, t) -> begin
(

let _50_2416 = (encode_binders None tps env)
in (match (_50_2416) with
| (vars, guards, env', binder_decls, _50_2415) -> begin
(

let tok_app = (let _145_1866 = (FStar_ToSMT_Term.mkApp ((ttok), ([])))
in (mk_ApplyT _145_1866 vars))
in (

let tok_decl = FStar_ToSMT_Term.DeclFun (((ttok), ([]), (FStar_ToSMT_Term.Type_sort), (None)))
in (

let app = (let _145_1868 = (let _145_1867 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in ((tname), (_145_1867)))
in (FStar_ToSMT_Term.mkApp _145_1868))
in (

let fresh_tok = (match (vars) with
| [] -> begin
[]
end
| _50_2422 -> begin
(let _145_1870 = (let _145_1869 = (varops.next_id ())
in (FStar_ToSMT_Term.fresh_token ((ttok), (FStar_ToSMT_Term.Type_sort)) _145_1869))
in (_145_1870)::[])
end)
in (

let decls = (let _145_1881 = (let _145_1873 = (let _145_1872 = (let _145_1871 = (FStar_List.map Prims.snd vars)
in ((tname), (_145_1871), (FStar_ToSMT_Term.Type_sort), (None)))
in FStar_ToSMT_Term.DeclFun (_145_1872))
in (_145_1873)::(tok_decl)::[])
in (let _145_1880 = (let _145_1879 = (let _145_1878 = (let _145_1877 = (let _145_1876 = (let _145_1875 = (let _145_1874 = (FStar_ToSMT_Term.mkEq ((tok_app), (app)))
in ((((tok_app)::[])::[]), (vars), (_145_1874)))
in (FStar_ToSMT_Term.mkForall _145_1875))
in ((_145_1876), (Some ("name-token correspondence"))))
in FStar_ToSMT_Term.Assume (_145_1877))
in (_145_1878)::[])
in (FStar_List.append fresh_tok _145_1879))
in (FStar_List.append _145_1881 _145_1880)))
in (

let t = if (FStar_All.pipe_right tags (FStar_List.contains FStar_Absyn_Syntax.Opaque)) then begin
(FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.DeltaHard)::(FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.Simplify)::[]) env.tcenv t)
end else begin
(whnf env t)
end
in (

let _50_2434 = if (FStar_All.pipe_right tags (FStar_Util.for_some (fun _50_19 -> (match (_50_19) with
| FStar_Absyn_Syntax.Logic -> begin
true
end
| _50_2429 -> begin
false
end)))) then begin
(let _145_1884 = (FStar_ToSMT_Term.mk_Valid app)
in (let _145_1883 = (encode_formula t env')
in ((_145_1884), (_145_1883))))
end else begin
(let _145_1885 = (encode_typ_term t env')
in ((app), (_145_1885)))
end
in (match (_50_2434) with
| (def, (body, decls1)) -> begin
(

let abbrev_def = (let _145_1892 = (let _145_1891 = (let _145_1890 = (let _145_1889 = (let _145_1888 = (let _145_1887 = (FStar_ToSMT_Term.mk_and_l guards)
in (let _145_1886 = (FStar_ToSMT_Term.mkEq ((def), (body)))
in ((_145_1887), (_145_1886))))
in (FStar_ToSMT_Term.mkImp _145_1888))
in ((((def)::[])::[]), (vars), (_145_1889)))
in (FStar_ToSMT_Term.mkForall _145_1890))
in ((_145_1891), (Some ("abbrev. elimination"))))
in FStar_ToSMT_Term.Assume (_145_1892))
in (

let kindingAx = (

let _50_2438 = (let _145_1893 = (FStar_Tc_Recheck.recompute_kind t)
in (encode_knd _145_1893 env' app))
in (match (_50_2438) with
| (k, decls) -> begin
(let _145_1901 = (let _145_1900 = (let _145_1899 = (let _145_1898 = (let _145_1897 = (let _145_1896 = (let _145_1895 = (let _145_1894 = (FStar_ToSMT_Term.mk_and_l guards)
in ((_145_1894), (k)))
in (FStar_ToSMT_Term.mkImp _145_1895))
in ((((app)::[])::[]), (vars), (_145_1896)))
in (FStar_ToSMT_Term.mkForall _145_1897))
in ((_145_1898), (Some ("abbrev. kinding"))))
in FStar_ToSMT_Term.Assume (_145_1899))
in (_145_1900)::[])
in (FStar_List.append decls _145_1901))
end))
in (

let g = (let _145_1905 = (let _145_1904 = (let _145_1903 = (let _145_1902 = (primitive_type_axioms lid tname app)
in (FStar_List.append ((abbrev_def)::kindingAx) _145_1902))
in (FStar_List.append decls1 _145_1903))
in (FStar_List.append decls _145_1904))
in (FStar_List.append binder_decls _145_1905))
in ((g), (env)))))
end))))))))
end))
end))
end))
end
| FStar_Absyn_Syntax.Sig_val_decl (lid, t, quals, _50_2445) -> begin
if ((FStar_All.pipe_right quals (FStar_List.contains FStar_Absyn_Syntax.Assumption)) || env.tcenv.FStar_Tc_Env.is_iface) then begin
(encode_top_level_val env lid t quals)
end else begin
(([]), (env))
end
end
| FStar_Absyn_Syntax.Sig_assume (l, f, _50_2451, _50_2453) -> begin
(

let _50_2458 = (encode_formula f env)
in (match (_50_2458) with
| (f, decls) -> begin
(

let g = (let _145_1910 = (let _145_1909 = (let _145_1908 = (let _145_1907 = (let _145_1906 = (FStar_Absyn_Print.sli l)
in (FStar_Util.format1 "Assumption: %s" _145_1906))
in Some (_145_1907))
in ((f), (_145_1908)))
in FStar_ToSMT_Term.Assume (_145_1909))
in (_145_1910)::[])
in (((FStar_List.append decls g)), (env)))
end))
end
| FStar_Absyn_Syntax.Sig_tycon (t, tps, k, _50_2464, datas, quals, _50_2468) when (FStar_Ident.lid_equals t FStar_Absyn_Const.precedes_lid) -> begin
(

let _50_2474 = (new_typ_constant_and_tok_from_lid env t)
in (match (_50_2474) with
| (tname, ttok, env) -> begin
(([]), (env))
end))
end
| FStar_Absyn_Syntax.Sig_tycon (t, _50_2477, _50_2479, _50_2481, _50_2483, _50_2485, _50_2487) when ((FStar_Ident.lid_equals t FStar_Absyn_Const.char_lid) || (FStar_Ident.lid_equals t FStar_Absyn_Const.uint8_lid)) -> begin
(

let tname = t.FStar_Ident.str
in (

let tsym = (FStar_ToSMT_Term.mkFreeV ((tname), (FStar_ToSMT_Term.Type_sort)))
in (

let decl = FStar_ToSMT_Term.DeclFun (((tname), ([]), (FStar_ToSMT_Term.Type_sort), (None)))
in (let _145_1912 = (let _145_1911 = (primitive_type_axioms t tname tsym)
in (decl)::_145_1911)
in ((_145_1912), ((push_free_tvar env t tname (Some (tsym)))))))))
end
| FStar_Absyn_Syntax.Sig_tycon (t, tps, k, _50_2497, datas, quals, _50_2501) -> begin
(

let is_logical = (FStar_All.pipe_right quals (FStar_Util.for_some (fun _50_20 -> (match (_50_20) with
| (FStar_Absyn_Syntax.Logic) | (FStar_Absyn_Syntax.Assumption) -> begin
true
end
| _50_2508 -> begin
false
end))))
in (

let constructor_or_logic_type_decl = (fun c -> if is_logical then begin
(

let _50_2518 = c
in (match (_50_2518) with
| (name, args, _50_2515, _50_2517) -> begin
(let _145_1918 = (let _145_1917 = (let _145_1916 = (FStar_All.pipe_right args (FStar_List.map Prims.snd))
in ((name), (_145_1916), (FStar_ToSMT_Term.Type_sort), (None)))
in FStar_ToSMT_Term.DeclFun (_145_1917))
in (_145_1918)::[])
end))
end else begin
(FStar_ToSMT_Term.constructor_to_decl c)
end)
in (

let inversion_axioms = (fun tapp vars -> if (((FStar_List.length datas) = (Prims.parse_int "0")) || (FStar_All.pipe_right datas (FStar_Util.for_some (fun l -> (let _145_1924 = (FStar_Tc_Env.lookup_qname env.tcenv l)
in (FStar_All.pipe_right _145_1924 FStar_Option.isNone)))))) then begin
[]
end else begin
(

let _50_2525 = (fresh_fvar "x" FStar_ToSMT_Term.Term_sort)
in (match (_50_2525) with
| (xxsym, xx) -> begin
(

let _50_2568 = (FStar_All.pipe_right datas (FStar_List.fold_left (fun _50_2528 l -> (match (_50_2528) with
| (out, decls) -> begin
(

let data_t = (FStar_Tc_Env.lookup_datacon env.tcenv l)
in (

let _50_2538 = (match ((FStar_Absyn_Util.function_formals data_t)) with
| Some (formals, res) -> begin
((formals), ((FStar_Absyn_Util.comp_result res)))
end
| None -> begin
(([]), (data_t))
end)
in (match (_50_2538) with
| (args, res) -> begin
(

let indices = (match ((let _145_1927 = (FStar_Absyn_Util.compress_typ res)
in _145_1927.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_app (_50_2540, indices) -> begin
indices
end
| _50_2545 -> begin
[]
end)
in (

let env = (FStar_All.pipe_right args (FStar_List.fold_left (fun env a -> (match ((Prims.fst a)) with
| FStar_Util.Inl (a) -> begin
(let _145_1932 = (let _145_1931 = (let _145_1930 = (mk_typ_projector_name l a.FStar_Absyn_Syntax.v)
in ((_145_1930), ((xx)::[])))
in (FStar_ToSMT_Term.mkApp _145_1931))
in (push_typ_var env a.FStar_Absyn_Syntax.v _145_1932))
end
| FStar_Util.Inr (x) -> begin
(let _145_1935 = (let _145_1934 = (let _145_1933 = (mk_term_projector_name l x.FStar_Absyn_Syntax.v)
in ((_145_1933), ((xx)::[])))
in (FStar_ToSMT_Term.mkApp _145_1934))
in (push_term_var env x.FStar_Absyn_Syntax.v _145_1935))
end)) env))
in (

let _50_2556 = (encode_args indices env)
in (match (_50_2556) with
| (indices, decls') -> begin
(

let _50_2557 = if ((FStar_List.length indices) <> (FStar_List.length vars)) then begin
(FStar_All.failwith "Impossible")
end else begin
()
end
in (

let eqs = (let _145_1942 = (FStar_List.map2 (fun v a -> (match (a) with
| FStar_Util.Inl (a) -> begin
(let _145_1939 = (let _145_1938 = (FStar_ToSMT_Term.mkFreeV v)
in ((_145_1938), (a)))
in (FStar_ToSMT_Term.mkEq _145_1939))
end
| FStar_Util.Inr (a) -> begin
(let _145_1941 = (let _145_1940 = (FStar_ToSMT_Term.mkFreeV v)
in ((_145_1940), (a)))
in (FStar_ToSMT_Term.mkEq _145_1941))
end)) vars indices)
in (FStar_All.pipe_right _145_1942 FStar_ToSMT_Term.mk_and_l))
in (let _145_1947 = (let _145_1946 = (let _145_1945 = (let _145_1944 = (let _145_1943 = (mk_data_tester env l xx)
in ((_145_1943), (eqs)))
in (FStar_ToSMT_Term.mkAnd _145_1944))
in ((out), (_145_1945)))
in (FStar_ToSMT_Term.mkOr _145_1946))
in ((_145_1947), ((FStar_List.append decls decls'))))))
end))))
end)))
end)) ((FStar_ToSMT_Term.mkFalse), ([]))))
in (match (_50_2568) with
| (data_ax, decls) -> begin
(

let _50_2571 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_2571) with
| (ffsym, ff) -> begin
(

let xx_has_type = (let _145_1948 = (FStar_ToSMT_Term.mkApp (("SFuel"), ((ff)::[])))
in (FStar_ToSMT_Term.mk_HasTypeFuel _145_1948 xx tapp))
in (let _145_1955 = (let _145_1954 = (let _145_1953 = (let _145_1952 = (let _145_1951 = (let _145_1950 = (add_fuel ((ffsym), (FStar_ToSMT_Term.Fuel_sort)) ((((xxsym), (FStar_ToSMT_Term.Term_sort)))::vars))
in (let _145_1949 = (FStar_ToSMT_Term.mkImp ((xx_has_type), (data_ax)))
in ((((xx_has_type)::[])::[]), (_145_1950), (_145_1949))))
in (FStar_ToSMT_Term.mkForall _145_1951))
in ((_145_1952), (Some ("inversion axiom"))))
in FStar_ToSMT_Term.Assume (_145_1953))
in (_145_1954)::[])
in (FStar_List.append decls _145_1955)))
end))
end))
end))
end)
in (

let k = (FStar_Absyn_Util.close_kind tps k)
in (

let _50_2583 = (match ((let _145_1956 = (FStar_Absyn_Util.compress_kind k)
in _145_1956.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Kind_arrow (bs, res) -> begin
((true), (bs), (res))
end
| _50_2579 -> begin
((false), ([]), (k))
end)
in (match (_50_2583) with
| (is_kind_arrow, formals, res) -> begin
(

let _50_2590 = (encode_binders None formals env)
in (match (_50_2590) with
| (vars, guards, env', binder_decls, _50_2589) -> begin
(

let projection_axioms = (fun tapp vars -> (match ((FStar_All.pipe_right quals (FStar_Util.find_opt (fun _50_21 -> (match (_50_21) with
| FStar_Absyn_Syntax.Projector (_50_2596) -> begin
true
end
| _50_2599 -> begin
false
end))))) with
| Some (FStar_Absyn_Syntax.Projector (d, FStar_Util.Inl (a))) -> begin
(

let rec projectee = (fun i _50_22 -> (match (_50_22) with
| [] -> begin
i
end
| (f)::tl -> begin
(match ((Prims.fst f)) with
| FStar_Util.Inl (_50_2614) -> begin
(projectee (i + (Prims.parse_int "1")) tl)
end
| FStar_Util.Inr (x) -> begin
if (x.FStar_Absyn_Syntax.v.FStar_Absyn_Syntax.ppname.FStar_Ident.idText = "projectee") then begin
i
end else begin
(projectee (i + (Prims.parse_int "1")) tl)
end
end)
end))
in (

let projectee_pos = (projectee (Prims.parse_int "0") formals)
in (

let _50_2629 = (match ((FStar_Util.first_N projectee_pos vars)) with
| (_50_2620, (xx)::suffix) -> begin
((xx), (suffix))
end
| _50_2626 -> begin
(FStar_All.failwith "impossible")
end)
in (match (_50_2629) with
| (xx, suffix) -> begin
(

let dproj_app = (let _145_1970 = (let _145_1969 = (let _145_1968 = (mk_typ_projector_name d a)
in (let _145_1967 = (let _145_1966 = (FStar_ToSMT_Term.mkFreeV xx)
in (_145_1966)::[])
in ((_145_1968), (_145_1967))))
in (FStar_ToSMT_Term.mkApp _145_1969))
in (mk_ApplyT _145_1970 suffix))
in (let _145_1975 = (let _145_1974 = (let _145_1973 = (let _145_1972 = (let _145_1971 = (FStar_ToSMT_Term.mkEq ((tapp), (dproj_app)))
in ((((tapp)::[])::[]), (vars), (_145_1971)))
in (FStar_ToSMT_Term.mkForall _145_1972))
in ((_145_1973), (Some ("projector axiom"))))
in FStar_ToSMT_Term.Assume (_145_1974))
in (_145_1975)::[]))
end))))
end
| _50_2632 -> begin
[]
end))
in (

let pretype_axioms = (fun tapp vars -> (

let _50_2638 = (fresh_fvar "x" FStar_ToSMT_Term.Term_sort)
in (match (_50_2638) with
| (xxsym, xx) -> begin
(

let _50_2641 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_2641) with
| (ffsym, ff) -> begin
(

let xx_has_type = (FStar_ToSMT_Term.mk_HasTypeFuel ff xx tapp)
in (let _145_1988 = (let _145_1987 = (let _145_1986 = (let _145_1985 = (let _145_1984 = (let _145_1983 = (let _145_1982 = (let _145_1981 = (let _145_1980 = (FStar_ToSMT_Term.mkApp (("PreType"), ((xx)::[])))
in ((tapp), (_145_1980)))
in (FStar_ToSMT_Term.mkEq _145_1981))
in ((xx_has_type), (_145_1982)))
in (FStar_ToSMT_Term.mkImp _145_1983))
in ((((xx_has_type)::[])::[]), ((((xxsym), (FStar_ToSMT_Term.Term_sort)))::(((ffsym), (FStar_ToSMT_Term.Fuel_sort)))::vars), (_145_1984)))
in (FStar_ToSMT_Term.mkForall _145_1985))
in ((_145_1986), (Some ("pretyping"))))
in FStar_ToSMT_Term.Assume (_145_1987))
in (_145_1988)::[]))
end))
end)))
in (

let _50_2646 = (new_typ_constant_and_tok_from_lid env t)
in (match (_50_2646) with
| (tname, ttok, env) -> begin
(

let ttok_tm = (FStar_ToSMT_Term.mkApp ((ttok), ([])))
in (

let guard = (FStar_ToSMT_Term.mk_and_l guards)
in (

let tapp = (let _145_1990 = (let _145_1989 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in ((tname), (_145_1989)))
in (FStar_ToSMT_Term.mkApp _145_1990))
in (

let _50_2667 = (

let tname_decl = (let _145_1994 = (let _145_1993 = (FStar_All.pipe_right vars (FStar_List.map (fun _50_2652 -> (match (_50_2652) with
| (n, s) -> begin
(((Prims.strcat tname n)), (s))
end))))
in (let _145_1992 = (varops.next_id ())
in ((tname), (_145_1993), (FStar_ToSMT_Term.Type_sort), (_145_1992))))
in (constructor_or_logic_type_decl _145_1994))
in (

let _50_2664 = (match (vars) with
| [] -> begin
(let _145_1998 = (let _145_1997 = (let _145_1996 = (FStar_ToSMT_Term.mkApp ((tname), ([])))
in (FStar_All.pipe_left (fun _145_1995 -> Some (_145_1995)) _145_1996))
in (push_free_tvar env t tname _145_1997))
in (([]), (_145_1998)))
end
| _50_2656 -> begin
(

let ttok_decl = FStar_ToSMT_Term.DeclFun (((ttok), ([]), (FStar_ToSMT_Term.Type_sort), (Some ("token"))))
in (

let ttok_fresh = (let _145_1999 = (varops.next_id ())
in (FStar_ToSMT_Term.fresh_token ((ttok), (FStar_ToSMT_Term.Type_sort)) _145_1999))
in (

let ttok_app = (mk_ApplyT ttok_tm vars)
in (

let pats = ((ttok_app)::[])::((tapp)::[])::[]
in (

let name_tok_corr = (let _145_2003 = (let _145_2002 = (let _145_2001 = (let _145_2000 = (FStar_ToSMT_Term.mkEq ((ttok_app), (tapp)))
in ((pats), (None), (vars), (_145_2000)))
in (FStar_ToSMT_Term.mkForall' _145_2001))
in ((_145_2002), (Some ("name-token correspondence"))))
in FStar_ToSMT_Term.Assume (_145_2003))
in (((ttok_decl)::(ttok_fresh)::(name_tok_corr)::[]), (env)))))))
end)
in (match (_50_2664) with
| (tok_decls, env) -> begin
(((FStar_List.append tname_decl tok_decls)), (env))
end)))
in (match (_50_2667) with
| (decls, env) -> begin
(

let kindingAx = (

let _50_2670 = (encode_knd res env' tapp)
in (match (_50_2670) with
| (k, decls) -> begin
(

let karr = if is_kind_arrow then begin
(let _145_2007 = (let _145_2006 = (let _145_2005 = (let _145_2004 = (FStar_ToSMT_Term.mk_PreKind ttok_tm)
in (FStar_ToSMT_Term.mk_tester "Kind_arrow" _145_2004))
in ((_145_2005), (Some ("kinding"))))
in FStar_ToSMT_Term.Assume (_145_2006))
in (_145_2007)::[])
end else begin
[]
end
in (let _145_2014 = (let _145_2013 = (let _145_2012 = (let _145_2011 = (let _145_2010 = (let _145_2009 = (let _145_2008 = (FStar_ToSMT_Term.mkImp ((guard), (k)))
in ((((tapp)::[])::[]), (vars), (_145_2008)))
in (FStar_ToSMT_Term.mkForall _145_2009))
in ((_145_2010), (Some ("kinding"))))
in FStar_ToSMT_Term.Assume (_145_2011))
in (_145_2012)::[])
in (FStar_List.append karr _145_2013))
in (FStar_List.append decls _145_2014)))
end))
in (

let aux = if is_logical then begin
(let _145_2015 = (projection_axioms tapp vars)
in (FStar_List.append kindingAx _145_2015))
end else begin
(let _145_2022 = (let _145_2021 = (primitive_type_axioms t tname tapp)
in (let _145_2020 = (let _145_2019 = (inversion_axioms tapp vars)
in (let _145_2018 = (let _145_2017 = (projection_axioms tapp vars)
in (let _145_2016 = (pretype_axioms tapp vars)
in (FStar_List.append _145_2017 _145_2016)))
in (FStar_List.append _145_2019 _145_2018)))
in (FStar_List.append _145_2021 _145_2020)))
in (FStar_List.append kindingAx _145_2022))
end
in (

let g = (FStar_List.append decls (FStar_List.append binder_decls aux))
in ((g), (env)))))
end)))))
end))))
end))
end))))))
end
| FStar_Absyn_Syntax.Sig_datacon (d, _50_2677, _50_2679, _50_2681, _50_2683, _50_2685) when (FStar_Ident.lid_equals d FStar_Absyn_Const.lexcons_lid) -> begin
(([]), (env))
end
| FStar_Absyn_Syntax.Sig_datacon (d, t, (_50_2691, tps, _50_2694), quals, _50_2698, drange) -> begin
(

let t = (let _145_2024 = (FStar_List.map (fun _50_2705 -> (match (_50_2705) with
| (x, _50_2704) -> begin
((x), (Some (FStar_Absyn_Syntax.Implicit (true))))
end)) tps)
in (FStar_Absyn_Util.close_typ _145_2024 t))
in (

let _50_2710 = (new_term_constant_and_tok_from_lid env d)
in (match (_50_2710) with
| (ddconstrsym, ddtok, env) -> begin
(

let ddtok_tm = (FStar_ToSMT_Term.mkApp ((ddtok), ([])))
in (

let _50_2719 = (match ((FStar_Absyn_Util.function_formals t)) with
| Some (f, c) -> begin
((f), ((FStar_Absyn_Util.comp_result c)))
end
| None -> begin
(([]), (t))
end)
in (match (_50_2719) with
| (formals, t_res) -> begin
(

let _50_2722 = (fresh_fvar "f" FStar_ToSMT_Term.Fuel_sort)
in (match (_50_2722) with
| (fuel_var, fuel_tm) -> begin
(

let s_fuel_tm = (FStar_ToSMT_Term.mkApp (("SFuel"), ((fuel_tm)::[])))
in (

let _50_2729 = (encode_binders (Some (fuel_tm)) formals env)
in (match (_50_2729) with
| (vars, guards, env', binder_decls, names) -> begin
(

let projectors = (FStar_All.pipe_right names (FStar_List.map (fun _50_23 -> (match (_50_23) with
| FStar_Util.Inl (a) -> begin
(let _145_2026 = (mk_typ_projector_name d a)
in ((_145_2026), (FStar_ToSMT_Term.Type_sort)))
end
| FStar_Util.Inr (x) -> begin
(let _145_2027 = (mk_term_projector_name d x)
in ((_145_2027), (FStar_ToSMT_Term.Term_sort)))
end))))
in (

let datacons = (let _145_2029 = (let _145_2028 = (varops.next_id ())
in ((ddconstrsym), (projectors), (FStar_ToSMT_Term.Term_sort), (_145_2028)))
in (FStar_All.pipe_right _145_2029 FStar_ToSMT_Term.constructor_to_decl))
in (

let app = (mk_ApplyE ddtok_tm vars)
in (

let guard = (FStar_ToSMT_Term.mk_and_l guards)
in (

let xvars = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (

let dapp = (FStar_ToSMT_Term.mkApp ((ddconstrsym), (xvars)))
in (

let _50_2743 = (encode_typ_pred None t env ddtok_tm)
in (match (_50_2743) with
| (tok_typing, decls3) -> begin
(

let _50_2750 = (encode_binders (Some (fuel_tm)) formals env)
in (match (_50_2750) with
| (vars', guards', env'', decls_formals, _50_2749) -> begin
(

let _50_2755 = (

let xvars = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars')
in (

let dapp = (FStar_ToSMT_Term.mkApp ((ddconstrsym), (xvars)))
in (encode_typ_pred (Some (fuel_tm)) t_res env'' dapp)))
in (match (_50_2755) with
| (ty_pred', decls_pred) -> begin
(

let guard' = (FStar_ToSMT_Term.mk_and_l guards')
in (

let proxy_fresh = (match (formals) with
| [] -> begin
[]
end
| _50_2759 -> begin
(let _145_2031 = (let _145_2030 = (varops.next_id ())
in (FStar_ToSMT_Term.fresh_token ((ddtok), (FStar_ToSMT_Term.Term_sort)) _145_2030))
in (_145_2031)::[])
end)
in (

let encode_elim = (fun _50_2762 -> (match (()) with
| () -> begin
(

let _50_2765 = (FStar_Absyn_Util.head_and_args t_res)
in (match (_50_2765) with
| (head, args) -> begin
(match ((let _145_2034 = (FStar_Absyn_Util.compress_typ head)
in _145_2034.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_const (fv) -> begin
(

let encoded_head = (lookup_free_tvar_name env' fv)
in (

let _50_2771 = (encode_args args env')
in (match (_50_2771) with
| (encoded_args, arg_decls) -> begin
(

let _50_2795 = (FStar_List.fold_left (fun _50_2775 arg -> (match (_50_2775) with
| (env, arg_vars, eqns) -> begin
(match (arg) with
| FStar_Util.Inl (targ) -> begin
(

let _50_2783 = (let _145_2037 = (FStar_Absyn_Util.new_bvd None)
in (gen_typ_var env _145_2037))
in (match (_50_2783) with
| (_50_2780, tv, env) -> begin
(let _145_2039 = (let _145_2038 = (FStar_ToSMT_Term.mkEq ((targ), (tv)))
in (_145_2038)::eqns)
in ((env), ((tv)::arg_vars), (_145_2039)))
end))
end
| FStar_Util.Inr (varg) -> begin
(

let _50_2790 = (let _145_2040 = (FStar_Absyn_Util.new_bvd None)
in (gen_term_var env _145_2040))
in (match (_50_2790) with
| (_50_2787, xv, env) -> begin
(let _145_2042 = (let _145_2041 = (FStar_ToSMT_Term.mkEq ((varg), (xv)))
in (_145_2041)::eqns)
in ((env), ((xv)::arg_vars), (_145_2042)))
end))
end)
end)) ((env'), ([]), ([])) encoded_args)
in (match (_50_2795) with
| (_50_2792, arg_vars, eqns) -> begin
(

let arg_vars = (FStar_List.rev arg_vars)
in (

let ty = (FStar_ToSMT_Term.mkApp ((encoded_head), (arg_vars)))
in (

let xvars = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (

let dapp = (FStar_ToSMT_Term.mkApp ((ddconstrsym), (xvars)))
in (

let ty_pred = (FStar_ToSMT_Term.mk_HasTypeWithFuel (Some (s_fuel_tm)) dapp ty)
in (

let arg_binders = (FStar_List.map FStar_ToSMT_Term.fv_of_term arg_vars)
in (

let typing_inversion = (let _145_2049 = (let _145_2048 = (let _145_2047 = (let _145_2046 = (add_fuel ((fuel_var), (FStar_ToSMT_Term.Fuel_sort)) (FStar_List.append vars arg_binders))
in (let _145_2045 = (let _145_2044 = (let _145_2043 = (FStar_ToSMT_Term.mk_and_l (FStar_List.append eqns guards))
in ((ty_pred), (_145_2043)))
in (FStar_ToSMT_Term.mkImp _145_2044))
in ((((ty_pred)::[])::[]), (_145_2046), (_145_2045))))
in (FStar_ToSMT_Term.mkForall _145_2047))
in ((_145_2048), (Some ("data constructor typing elim"))))
in FStar_ToSMT_Term.Assume (_145_2049))
in (

let subterm_ordering = if (FStar_Ident.lid_equals d FStar_Absyn_Const.lextop_lid) then begin
(

let x = (let _145_2050 = (varops.fresh "x")
in ((_145_2050), (FStar_ToSMT_Term.Term_sort)))
in (

let xtm = (FStar_ToSMT_Term.mkFreeV x)
in (let _145_2060 = (let _145_2059 = (let _145_2058 = (let _145_2057 = (let _145_2052 = (let _145_2051 = (FStar_ToSMT_Term.mk_Precedes xtm dapp)
in (_145_2051)::[])
in (_145_2052)::[])
in (let _145_2056 = (let _145_2055 = (let _145_2054 = (FStar_ToSMT_Term.mk_tester "LexCons" xtm)
in (let _145_2053 = (FStar_ToSMT_Term.mk_Precedes xtm dapp)
in ((_145_2054), (_145_2053))))
in (FStar_ToSMT_Term.mkImp _145_2055))
in ((_145_2057), ((x)::[]), (_145_2056))))
in (FStar_ToSMT_Term.mkForall _145_2058))
in ((_145_2059), (Some ("lextop is top"))))
in FStar_ToSMT_Term.Assume (_145_2060))))
end else begin
(

let prec = (FStar_All.pipe_right vars (FStar_List.collect (fun v -> (match ((Prims.snd v)) with
| (FStar_ToSMT_Term.Type_sort) | (FStar_ToSMT_Term.Fuel_sort) -> begin
[]
end
| FStar_ToSMT_Term.Term_sort -> begin
(let _145_2063 = (let _145_2062 = (FStar_ToSMT_Term.mkFreeV v)
in (FStar_ToSMT_Term.mk_Precedes _145_2062 dapp))
in (_145_2063)::[])
end
| _50_2810 -> begin
(FStar_All.failwith "unexpected sort")
end))))
in (let _145_2070 = (let _145_2069 = (let _145_2068 = (let _145_2067 = (add_fuel ((fuel_var), (FStar_ToSMT_Term.Fuel_sort)) (FStar_List.append vars arg_binders))
in (let _145_2066 = (let _145_2065 = (let _145_2064 = (FStar_ToSMT_Term.mk_and_l prec)
in ((ty_pred), (_145_2064)))
in (FStar_ToSMT_Term.mkImp _145_2065))
in ((((ty_pred)::[])::[]), (_145_2067), (_145_2066))))
in (FStar_ToSMT_Term.mkForall _145_2068))
in ((_145_2069), (Some ("subterm ordering"))))
in FStar_ToSMT_Term.Assume (_145_2070)))
end
in ((arg_decls), ((typing_inversion)::(subterm_ordering)::[]))))))))))
end))
end)))
end
| _50_2814 -> begin
(

let _50_2815 = (let _145_2073 = (let _145_2072 = (FStar_Absyn_Print.sli d)
in (let _145_2071 = (FStar_Absyn_Print.typ_to_string head)
in (FStar_Util.format2 "Constructor %s builds an unexpected type %s\n" _145_2072 _145_2071)))
in (FStar_Tc_Errors.warn drange _145_2073))
in (([]), ([])))
end)
end))
end))
in (

let _50_2819 = (encode_elim ())
in (match (_50_2819) with
| (decls2, elim) -> begin
(

let g = (let _145_2100 = (let _145_2099 = (let _145_2098 = (let _145_2097 = (let _145_2078 = (let _145_2077 = (let _145_2076 = (let _145_2075 = (let _145_2074 = (FStar_Absyn_Print.sli d)
in (FStar_Util.format1 "data constructor proxy: %s" _145_2074))
in Some (_145_2075))
in ((ddtok), ([]), (FStar_ToSMT_Term.Term_sort), (_145_2076)))
in FStar_ToSMT_Term.DeclFun (_145_2077))
in (_145_2078)::[])
in (let _145_2096 = (let _145_2095 = (let _145_2094 = (let _145_2093 = (let _145_2092 = (let _145_2091 = (let _145_2090 = (let _145_2082 = (let _145_2081 = (let _145_2080 = (let _145_2079 = (FStar_ToSMT_Term.mkEq ((app), (dapp)))
in ((((app)::[])::[]), (vars), (_145_2079)))
in (FStar_ToSMT_Term.mkForall _145_2080))
in ((_145_2081), (Some ("equality for proxy"))))
in FStar_ToSMT_Term.Assume (_145_2082))
in (let _145_2089 = (let _145_2088 = (let _145_2087 = (let _145_2086 = (let _145_2085 = (let _145_2084 = (add_fuel ((fuel_var), (FStar_ToSMT_Term.Fuel_sort)) vars')
in (let _145_2083 = (FStar_ToSMT_Term.mkImp ((guard'), (ty_pred')))
in ((((ty_pred')::[])::[]), (_145_2084), (_145_2083))))
in (FStar_ToSMT_Term.mkForall _145_2085))
in ((_145_2086), (Some ("data constructor typing intro"))))
in FStar_ToSMT_Term.Assume (_145_2087))
in (_145_2088)::[])
in (_145_2090)::_145_2089))
in (FStar_ToSMT_Term.Assume (((tok_typing), (Some ("typing for data constructor proxy")))))::_145_2091)
in (FStar_List.append _145_2092 elim))
in (FStar_List.append decls_pred _145_2093))
in (FStar_List.append decls_formals _145_2094))
in (FStar_List.append proxy_fresh _145_2095))
in (FStar_List.append _145_2097 _145_2096)))
in (FStar_List.append decls3 _145_2098))
in (FStar_List.append decls2 _145_2099))
in (FStar_List.append binder_decls _145_2100))
in (((FStar_List.append datacons g)), (env)))
end)))))
end))
end))
end))))))))
end)))
end))
end)))
end)))
end
| FStar_Absyn_Syntax.Sig_bundle (ses, _50_2823, _50_2825, _50_2827) -> begin
(

let _50_2832 = (encode_signature env ses)
in (match (_50_2832) with
| (g, env) -> begin
(

let _50_2844 = (FStar_All.pipe_right g (FStar_List.partition (fun _50_24 -> (match (_50_24) with
| FStar_ToSMT_Term.Assume (_50_2835, Some ("inversion axiom")) -> begin
false
end
| _50_2841 -> begin
true
end))))
in (match (_50_2844) with
| (g', inversions) -> begin
(

let _50_2853 = (FStar_All.pipe_right g' (FStar_List.partition (fun _50_25 -> (match (_50_25) with
| FStar_ToSMT_Term.DeclFun (_50_2847) -> begin
true
end
| _50_2850 -> begin
false
end))))
in (match (_50_2853) with
| (decls, rest) -> begin
(((FStar_List.append decls (FStar_List.append rest inversions))), (env))
end))
end))
end))
end
| FStar_Absyn_Syntax.Sig_let (_50_2855, _50_2857, _50_2859, quals) when (FStar_All.pipe_right quals (FStar_Util.for_some (fun _50_26 -> (match (_50_26) with
| (FStar_Absyn_Syntax.Projector (_)) | (FStar_Absyn_Syntax.Discriminator (_)) -> begin
true
end
| _50_2871 -> begin
false
end)))) -> begin
(([]), (env))
end
| FStar_Absyn_Syntax.Sig_let ((is_rec, bindings), _50_2876, _50_2878, quals) -> begin
(

let eta_expand = (fun binders formals body t -> (

let nbinders = (FStar_List.length binders)
in (

let _50_2890 = (FStar_Util.first_N nbinders formals)
in (match (_50_2890) with
| (formals, extra_formals) -> begin
(

let subst = (FStar_List.map2 (fun formal binder -> (match ((((Prims.fst formal)), ((Prims.fst binder)))) with
| (FStar_Util.Inl (a), FStar_Util.Inl (b)) -> begin
(let _145_2115 = (let _145_2114 = (FStar_Absyn_Util.btvar_to_typ b)
in ((a.FStar_Absyn_Syntax.v), (_145_2114)))
in FStar_Util.Inl (_145_2115))
end
| (FStar_Util.Inr (x), FStar_Util.Inr (y)) -> begin
(let _145_2117 = (let _145_2116 = (FStar_Absyn_Util.bvar_to_exp y)
in ((x.FStar_Absyn_Syntax.v), (_145_2116)))
in FStar_Util.Inr (_145_2117))
end
| _50_2904 -> begin
(FStar_All.failwith "Impossible")
end)) formals binders)
in (

let extra_formals = (let _145_2118 = (FStar_Absyn_Util.subst_binders subst extra_formals)
in (FStar_All.pipe_right _145_2118 FStar_Absyn_Util.name_binders))
in (

let body = (let _145_2124 = (let _145_2120 = (let _145_2119 = (FStar_Absyn_Util.args_of_binders extra_formals)
in (FStar_All.pipe_left Prims.snd _145_2119))
in ((body), (_145_2120)))
in (let _145_2123 = (let _145_2122 = (FStar_Absyn_Util.subst_typ subst t)
in (FStar_All.pipe_left (fun _145_2121 -> Some (_145_2121)) _145_2122))
in (FStar_Absyn_Syntax.mk_Exp_app_flat _145_2124 _145_2123 body.FStar_Absyn_Syntax.pos)))
in (((FStar_List.append binders extra_formals)), (body)))))
end))))
in (

let destruct_bound_function = (fun flid t_norm e -> (match (e.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Exp_ascribed ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_abs (binders, body); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _, _)) | (FStar_Absyn_Syntax.Exp_abs (binders, body)) -> begin
(match (t_norm.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (formals, c) -> begin
(

let nformals = (FStar_List.length formals)
in (

let nbinders = (FStar_List.length binders)
in (

let tres = (FStar_Absyn_Util.comp_result c)
in if ((nformals < nbinders) && (FStar_Absyn_Util.is_total_comp c)) then begin
(

let _50_2942 = (FStar_Util.first_N nformals binders)
in (match (_50_2942) with
| (bs0, rest) -> begin
(

let tres = (match ((FStar_Absyn_Util.mk_subst_binder bs0 formals)) with
| Some (s) -> begin
(FStar_Absyn_Util.subst_typ s tres)
end
| _50_2946 -> begin
(FStar_All.failwith "impossible")
end)
in (

let body = (FStar_Absyn_Syntax.mk_Exp_abs ((rest), (body)) (Some (tres)) body.FStar_Absyn_Syntax.pos)
in ((bs0), (body), (bs0), (tres))))
end))
end else begin
if (nformals > nbinders) then begin
(

let _50_2951 = (eta_expand binders formals body tres)
in (match (_50_2951) with
| (binders, body) -> begin
((binders), (body), (formals), (tres))
end))
end else begin
((binders), (body), (formals), (tres))
end
end)))
end
| _50_2953 -> begin
(let _145_2133 = (let _145_2132 = (FStar_Absyn_Print.exp_to_string e)
in (let _145_2131 = (FStar_Absyn_Print.typ_to_string t_norm)
in (FStar_Util.format3 "Impossible! let-bound lambda %s = %s has a type that\'s not a function: %s\n" flid.FStar_Ident.str _145_2132 _145_2131)))
in (FStar_All.failwith _145_2133))
end)
end
| _50_2955 -> begin
(match (t_norm.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (formals, c) -> begin
(

let tres = (FStar_Absyn_Util.comp_result c)
in (

let _50_2963 = (eta_expand [] formals e tres)
in (match (_50_2963) with
| (binders, body) -> begin
((binders), (body), (formals), (tres))
end)))
end
| _50_2965 -> begin
(([]), (e), ([]), (t_norm))
end)
end))
in try
(match (()) with
| () -> begin
if ((FStar_All.pipe_right quals (FStar_Util.for_some (fun _50_27 -> (match (_50_27) with
| FStar_Absyn_Syntax.Opaque -> begin
true
end
| _50_2978 -> begin
false
end)))) || (FStar_All.pipe_right bindings (FStar_Util.for_all (fun lb -> (FStar_Absyn_Util.is_smt_lemma lb.FStar_Absyn_Syntax.lbtyp))))) then begin
(encode_top_level_vals env bindings quals)
end else begin
(

let _50_2997 = (FStar_All.pipe_right bindings (FStar_List.fold_left (fun _50_2984 lb -> (match (_50_2984) with
| (toks, typs, decls, env) -> begin
(

let _50_2986 = if (FStar_Absyn_Util.is_smt_lemma lb.FStar_Absyn_Syntax.lbtyp) then begin
(Prims.raise Let_rec_unencodeable)
end else begin
()
end
in (

let t_norm = (let _145_2139 = (whnf env lb.FStar_Absyn_Syntax.lbtyp)
in (FStar_All.pipe_right _145_2139 FStar_Absyn_Util.compress_typ))
in (

let _50_2992 = (let _145_2140 = (FStar_Util.right lb.FStar_Absyn_Syntax.lbname)
in (declare_top_level_let env _145_2140 lb.FStar_Absyn_Syntax.lbtyp t_norm))
in (match (_50_2992) with
| (tok, decl, env) -> begin
(let _145_2143 = (let _145_2142 = (let _145_2141 = (FStar_Util.right lb.FStar_Absyn_Syntax.lbname)
in ((_145_2141), (tok)))
in (_145_2142)::toks)
in ((_145_2143), ((t_norm)::typs), ((decl)::decls), (env)))
end))))
end)) (([]), ([]), ([]), (env))))
in (match (_50_2997) with
| (toks, typs, decls, env) -> begin
(

let toks = (FStar_List.rev toks)
in (

let decls = (FStar_All.pipe_right (FStar_List.rev decls) FStar_List.flatten)
in (

let typs = (FStar_List.rev typs)
in if ((FStar_All.pipe_right quals (FStar_Util.for_some (fun _50_28 -> (match (_50_28) with
| FStar_Absyn_Syntax.HasMaskedEffect -> begin
true
end
| _50_3004 -> begin
false
end)))) || (FStar_All.pipe_right typs (FStar_Util.for_some (fun t -> ((FStar_Absyn_Util.is_lemma t) || (let _145_2146 = (FStar_Absyn_Util.is_pure_or_ghost_function t)
in (FStar_All.pipe_left Prims.op_Negation _145_2146))))))) then begin
((decls), (env))
end else begin
if (not (is_rec)) then begin
(match (((bindings), (typs), (toks))) with
| (({FStar_Absyn_Syntax.lbname = _50_3012; FStar_Absyn_Syntax.lbtyp = _50_3010; FStar_Absyn_Syntax.lbeff = _50_3008; FStar_Absyn_Syntax.lbdef = e})::[], (t_norm)::[], ((flid, (f, ftok)))::[]) -> begin
(

let _50_3028 = (destruct_bound_function flid t_norm e)
in (match (_50_3028) with
| (binders, body, formals, tres) -> begin
(

let _50_3035 = (encode_binders None binders env)
in (match (_50_3035) with
| (vars, guards, env', binder_decls, _50_3034) -> begin
(

let app = (match (vars) with
| [] -> begin
(FStar_ToSMT_Term.mkFreeV ((f), (FStar_ToSMT_Term.Term_sort)))
end
| _50_3038 -> begin
(let _145_2148 = (let _145_2147 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in ((f), (_145_2147)))
in (FStar_ToSMT_Term.mkApp _145_2148))
end)
in (

let _50_3042 = (encode_exp body env')
in (match (_50_3042) with
| (body, decls2) -> begin
(

let eqn = (let _145_2157 = (let _145_2156 = (let _145_2153 = (let _145_2152 = (let _145_2151 = (let _145_2150 = (FStar_ToSMT_Term.mk_and_l guards)
in (let _145_2149 = (FStar_ToSMT_Term.mkEq ((app), (body)))
in ((_145_2150), (_145_2149))))
in (FStar_ToSMT_Term.mkImp _145_2151))
in ((((app)::[])::[]), (vars), (_145_2152)))
in (FStar_ToSMT_Term.mkForall _145_2153))
in (let _145_2155 = (let _145_2154 = (FStar_Util.format1 "Equation for %s" flid.FStar_Ident.str)
in Some (_145_2154))
in ((_145_2156), (_145_2155))))
in FStar_ToSMT_Term.Assume (_145_2157))
in (((FStar_List.append decls (FStar_List.append binder_decls (FStar_List.append decls2 ((eqn)::[]))))), (env)))
end)))
end))
end))
end
| _50_3045 -> begin
(FStar_All.failwith "Impossible")
end)
end else begin
(

let fuel = (let _145_2158 = (varops.fresh "fuel")
in ((_145_2158), (FStar_ToSMT_Term.Fuel_sort)))
in (

let fuel_tm = (FStar_ToSMT_Term.mkFreeV fuel)
in (

let env0 = env
in (

let _50_3062 = (FStar_All.pipe_right toks (FStar_List.fold_left (fun _50_3051 _50_3056 -> (match (((_50_3051), (_50_3056))) with
| ((gtoks, env), (flid, (f, ftok))) -> begin
(

let g = (varops.new_fvar flid)
in (

let gtok = (varops.new_fvar flid)
in (

let env = (let _145_2163 = (let _145_2162 = (FStar_ToSMT_Term.mkApp ((g), ((fuel_tm)::[])))
in (FStar_All.pipe_left (fun _145_2161 -> Some (_145_2161)) _145_2162))
in (push_free_var env flid gtok _145_2163))
in (((((flid), (f), (ftok), (g), (gtok)))::gtoks), (env)))))
end)) (([]), (env))))
in (match (_50_3062) with
| (gtoks, env) -> begin
(

let gtoks = (FStar_List.rev gtoks)
in (

let encode_one_binding = (fun env0 _50_3071 t_norm _50_3080 -> (match (((_50_3071), (_50_3080))) with
| ((flid, f, ftok, g, gtok), {FStar_Absyn_Syntax.lbname = _50_3079; FStar_Absyn_Syntax.lbtyp = _50_3077; FStar_Absyn_Syntax.lbeff = _50_3075; FStar_Absyn_Syntax.lbdef = e}) -> begin
(

let _50_3085 = (destruct_bound_function flid t_norm e)
in (match (_50_3085) with
| (binders, body, formals, tres) -> begin
(

let _50_3092 = (encode_binders None binders env)
in (match (_50_3092) with
| (vars, guards, env', binder_decls, _50_3091) -> begin
(

let decl_g = (let _145_2174 = (let _145_2173 = (let _145_2172 = (FStar_List.map Prims.snd vars)
in (FStar_ToSMT_Term.Fuel_sort)::_145_2172)
in ((g), (_145_2173), (FStar_ToSMT_Term.Term_sort), (Some ("Fuel-instrumented function name"))))
in FStar_ToSMT_Term.DeclFun (_145_2174))
in (

let env0 = (push_zfuel_name env0 flid g)
in (

let decl_g_tok = FStar_ToSMT_Term.DeclFun (((gtok), ([]), (FStar_ToSMT_Term.Term_sort), (Some ("Token for fuel-instrumented partial applications"))))
in (

let vars_tm = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (

let app = (FStar_ToSMT_Term.mkApp ((f), (vars_tm)))
in (

let gsapp = (let _145_2177 = (let _145_2176 = (let _145_2175 = (FStar_ToSMT_Term.mkApp (("SFuel"), ((fuel_tm)::[])))
in (_145_2175)::vars_tm)
in ((g), (_145_2176)))
in (FStar_ToSMT_Term.mkApp _145_2177))
in (

let gmax = (let _145_2180 = (let _145_2179 = (let _145_2178 = (FStar_ToSMT_Term.mkApp (("MaxFuel"), ([])))
in (_145_2178)::vars_tm)
in ((g), (_145_2179)))
in (FStar_ToSMT_Term.mkApp _145_2180))
in (

let _50_3102 = (encode_exp body env')
in (match (_50_3102) with
| (body_tm, decls2) -> begin
(

let eqn_g = (let _145_2189 = (let _145_2188 = (let _145_2185 = (let _145_2184 = (let _145_2183 = (let _145_2182 = (FStar_ToSMT_Term.mk_and_l guards)
in (let _145_2181 = (FStar_ToSMT_Term.mkEq ((gsapp), (body_tm)))
in ((_145_2182), (_145_2181))))
in (FStar_ToSMT_Term.mkImp _145_2183))
in ((((gsapp)::[])::[]), ((fuel)::vars), (_145_2184)))
in (FStar_ToSMT_Term.mkForall _145_2185))
in (let _145_2187 = (let _145_2186 = (FStar_Util.format1 "Equation for fuel-instrumented recursive function: %s" flid.FStar_Ident.str)
in Some (_145_2186))
in ((_145_2188), (_145_2187))))
in FStar_ToSMT_Term.Assume (_145_2189))
in (

let eqn_f = (let _145_2193 = (let _145_2192 = (let _145_2191 = (let _145_2190 = (FStar_ToSMT_Term.mkEq ((app), (gmax)))
in ((((app)::[])::[]), (vars), (_145_2190)))
in (FStar_ToSMT_Term.mkForall _145_2191))
in ((_145_2192), (Some ("Correspondence of recursive function to instrumented version"))))
in FStar_ToSMT_Term.Assume (_145_2193))
in (

let eqn_g' = (let _145_2202 = (let _145_2201 = (let _145_2200 = (let _145_2199 = (let _145_2198 = (let _145_2197 = (let _145_2196 = (let _145_2195 = (let _145_2194 = (FStar_ToSMT_Term.n_fuel (Prims.parse_int "0"))
in (_145_2194)::vars_tm)
in ((g), (_145_2195)))
in (FStar_ToSMT_Term.mkApp _145_2196))
in ((gsapp), (_145_2197)))
in (FStar_ToSMT_Term.mkEq _145_2198))
in ((((gsapp)::[])::[]), ((fuel)::vars), (_145_2199)))
in (FStar_ToSMT_Term.mkForall _145_2200))
in ((_145_2201), (Some ("Fuel irrelevance"))))
in FStar_ToSMT_Term.Assume (_145_2202))
in (

let _50_3125 = (

let _50_3112 = (encode_binders None formals env0)
in (match (_50_3112) with
| (vars, v_guards, env, binder_decls, _50_3111) -> begin
(

let vars_tm = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in (

let gapp = (FStar_ToSMT_Term.mkApp ((g), ((fuel_tm)::vars_tm)))
in (

let tok_corr = (

let tok_app = (let _145_2203 = (FStar_ToSMT_Term.mkFreeV ((gtok), (FStar_ToSMT_Term.Term_sort)))
in (mk_ApplyE _145_2203 ((fuel)::vars)))
in (let _145_2207 = (let _145_2206 = (let _145_2205 = (let _145_2204 = (FStar_ToSMT_Term.mkEq ((tok_app), (gapp)))
in ((((tok_app)::[])::[]), ((fuel)::vars), (_145_2204)))
in (FStar_ToSMT_Term.mkForall _145_2205))
in ((_145_2206), (Some ("Fuel token correspondence"))))
in FStar_ToSMT_Term.Assume (_145_2207)))
in (

let _50_3122 = (

let _50_3119 = (encode_typ_pred None tres env gapp)
in (match (_50_3119) with
| (g_typing, d3) -> begin
(let _145_2215 = (let _145_2214 = (let _145_2213 = (let _145_2212 = (let _145_2211 = (let _145_2210 = (let _145_2209 = (let _145_2208 = (FStar_ToSMT_Term.mk_and_l v_guards)
in ((_145_2208), (g_typing)))
in (FStar_ToSMT_Term.mkImp _145_2209))
in ((((gapp)::[])::[]), ((fuel)::vars), (_145_2210)))
in (FStar_ToSMT_Term.mkForall _145_2211))
in ((_145_2212), (None)))
in FStar_ToSMT_Term.Assume (_145_2213))
in (_145_2214)::[])
in ((d3), (_145_2215)))
end))
in (match (_50_3122) with
| (aux_decls, typing_corr) -> begin
(((FStar_List.append binder_decls aux_decls)), ((FStar_List.append typing_corr ((tok_corr)::[]))))
end)))))
end))
in (match (_50_3125) with
| (aux_decls, g_typing) -> begin
(((FStar_List.append binder_decls (FStar_List.append decls2 (FStar_List.append aux_decls ((decl_g)::(decl_g_tok)::[]))))), ((FStar_List.append ((eqn_g)::(eqn_g')::(eqn_f)::[]) g_typing)), (env0))
end)))))
end)))))))))
end))
end))
end))
in (

let _50_3141 = (let _145_2218 = (FStar_List.zip3 gtoks typs bindings)
in (FStar_List.fold_left (fun _50_3129 _50_3133 -> (match (((_50_3129), (_50_3133))) with
| ((decls, eqns, env0), (gtok, ty, bs)) -> begin
(

let _50_3137 = (encode_one_binding env0 gtok ty bs)
in (match (_50_3137) with
| (decls', eqns', env0) -> begin
(((decls')::decls), ((FStar_List.append eqns' eqns)), (env0))
end))
end)) (((decls)::[]), ([]), (env0)) _145_2218))
in (match (_50_3141) with
| (decls, eqns, env0) -> begin
(

let _50_3150 = (let _145_2220 = (FStar_All.pipe_right decls FStar_List.flatten)
in (FStar_All.pipe_right _145_2220 (FStar_List.partition (fun _50_29 -> (match (_50_29) with
| FStar_ToSMT_Term.DeclFun (_50_3144) -> begin
true
end
| _50_3147 -> begin
false
end)))))
in (match (_50_3150) with
| (prefix_decls, rest) -> begin
(

let eqns = (FStar_List.rev eqns)
in (((FStar_List.append prefix_decls (FStar_List.append rest eqns))), (env0)))
end))
end))))
end)))))
end
end)))
end))
end
end)
with
| Let_rec_unencodeable -> begin
(

let msg = (let _145_2223 = (FStar_All.pipe_right bindings (FStar_List.map (fun lb -> (FStar_Absyn_Print.lbname_to_string lb.FStar_Absyn_Syntax.lbname))))
in (FStar_All.pipe_right _145_2223 (FStar_String.concat " and ")))
in (

let decl = FStar_ToSMT_Term.Caption ((Prims.strcat "let rec unencodeable: Skipping: " msg))
in (((decl)::[]), (env))))
end))
end
| (FStar_Absyn_Syntax.Sig_pragma (_)) | (FStar_Absyn_Syntax.Sig_main (_)) | (FStar_Absyn_Syntax.Sig_new_effect (_)) | (FStar_Absyn_Syntax.Sig_effect_abbrev (_)) | (FStar_Absyn_Syntax.Sig_kind_abbrev (_)) | (FStar_Absyn_Syntax.Sig_sub_effect (_)) -> begin
(([]), (env))
end)))))
and declare_top_level_let : env_t  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.typ  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  ((Prims.string * FStar_ToSMT_Term.term Prims.option) * FStar_ToSMT_Term.decl Prims.list * env_t) = (fun env x t t_norm -> (match ((try_lookup_lid env x)) with
| None -> begin
(

let _50_3177 = (encode_free_var env x t t_norm [])
in (match (_50_3177) with
| (decls, env) -> begin
(

let _50_3182 = (lookup_lid env x)
in (match (_50_3182) with
| (n, x', _50_3181) -> begin
((((n), (x'))), (decls), (env))
end))
end))
end
| Some (n, x, _50_3186) -> begin
((((n), (x))), ([]), (env))
end))
and encode_smt_lemma : env_t  ->  FStar_Ident.lident  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  FStar_ToSMT_Term.decl Prims.list = (fun env lid t -> (

let _50_3194 = (encode_function_type_as_formula None None t env)
in (match (_50_3194) with
| (form, decls) -> begin
(FStar_List.append decls ((FStar_ToSMT_Term.Assume (((form), (Some ((Prims.strcat "Lemma: " lid.FStar_Ident.str))))))::[]))
end)))
and encode_free_var : env_t  ->  FStar_Ident.lident  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  FStar_Absyn_Syntax.qualifier Prims.list  ->  (FStar_ToSMT_Term.decl Prims.list * env_t) = (fun env lid tt t_norm quals -> if ((let _145_2236 = (FStar_Absyn_Util.is_pure_or_ghost_function t_norm)
in (FStar_All.pipe_left Prims.op_Negation _145_2236)) || (FStar_Absyn_Util.is_lemma t_norm)) then begin
(

let _50_3203 = (new_term_constant_and_tok_from_lid env lid)
in (match (_50_3203) with
| (vname, vtok, env) -> begin
(

let arg_sorts = (match (t_norm.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_fun (binders, _50_3206) -> begin
(FStar_All.pipe_right binders (FStar_List.map (fun _50_30 -> (match (_50_30) with
| (FStar_Util.Inl (_50_3211), _50_3214) -> begin
FStar_ToSMT_Term.Type_sort
end
| _50_3217 -> begin
FStar_ToSMT_Term.Term_sort
end))))
end
| _50_3219 -> begin
[]
end)
in (

let d = FStar_ToSMT_Term.DeclFun (((vname), (arg_sorts), (FStar_ToSMT_Term.Term_sort), (Some ("Uninterpreted function symbol for impure function"))))
in (

let dd = FStar_ToSMT_Term.DeclFun (((vtok), ([]), (FStar_ToSMT_Term.Term_sort), (Some ("Uninterpreted name for impure function"))))
in (((d)::(dd)::[]), (env)))))
end))
end else begin
if (prims.is lid) then begin
(

let vname = (varops.new_fvar lid)
in (

let definition = (prims.mk lid vname)
in (

let env = (push_free_var env lid vname None)
in ((definition), (env)))))
end else begin
(

let encode_non_total_function_typ = (lid.FStar_Ident.nsstr <> "Prims")
in (

let _50_3236 = (match ((FStar_Absyn_Util.function_formals t_norm)) with
| Some (args, comp) -> begin
if encode_non_total_function_typ then begin
(let _145_2238 = (FStar_Tc_Util.pure_or_ghost_pre_and_post env.tcenv comp)
in ((args), (_145_2238)))
end else begin
((args), (((None), ((FStar_Absyn_Util.comp_result comp)))))
end
end
| None -> begin
(([]), (((None), (t_norm))))
end)
in (match (_50_3236) with
| (formals, (pre_opt, res_t)) -> begin
(

let _50_3240 = (new_term_constant_and_tok_from_lid env lid)
in (match (_50_3240) with
| (vname, vtok, env) -> begin
(

let vtok_tm = (match (formals) with
| [] -> begin
(FStar_ToSMT_Term.mkFreeV ((vname), (FStar_ToSMT_Term.Term_sort)))
end
| _50_3243 -> begin
(FStar_ToSMT_Term.mkApp ((vtok), ([])))
end)
in (

let mk_disc_proj_axioms = (fun guard encoded_res_t vapp vars -> (FStar_All.pipe_right quals (FStar_List.collect (fun _50_31 -> (match (_50_31) with
| FStar_Absyn_Syntax.Discriminator (d) -> begin
(

let _50_3259 = (FStar_Util.prefix vars)
in (match (_50_3259) with
| (_50_3254, (xxsym, _50_3257)) -> begin
(

let xx = (FStar_ToSMT_Term.mkFreeV ((xxsym), (FStar_ToSMT_Term.Term_sort)))
in (let _145_2255 = (let _145_2254 = (let _145_2253 = (let _145_2252 = (let _145_2251 = (let _145_2250 = (let _145_2249 = (let _145_2248 = (FStar_ToSMT_Term.mk_tester (escape d.FStar_Ident.str) xx)
in (FStar_All.pipe_left FStar_ToSMT_Term.boxBool _145_2248))
in ((vapp), (_145_2249)))
in (FStar_ToSMT_Term.mkEq _145_2250))
in ((((vapp)::[])::[]), (vars), (_145_2251)))
in (FStar_ToSMT_Term.mkForall _145_2252))
in ((_145_2253), (Some ("Discriminator equation"))))
in FStar_ToSMT_Term.Assume (_145_2254))
in (_145_2255)::[]))
end))
end
| FStar_Absyn_Syntax.Projector (d, FStar_Util.Inr (f)) -> begin
(

let _50_3272 = (FStar_Util.prefix vars)
in (match (_50_3272) with
| (_50_3267, (xxsym, _50_3270)) -> begin
(

let xx = (FStar_ToSMT_Term.mkFreeV ((xxsym), (FStar_ToSMT_Term.Term_sort)))
in (

let prim_app = (let _145_2257 = (let _145_2256 = (mk_term_projector_name d f)
in ((_145_2256), ((xx)::[])))
in (FStar_ToSMT_Term.mkApp _145_2257))
in (let _145_2262 = (let _145_2261 = (let _145_2260 = (let _145_2259 = (let _145_2258 = (FStar_ToSMT_Term.mkEq ((vapp), (prim_app)))
in ((((vapp)::[])::[]), (vars), (_145_2258)))
in (FStar_ToSMT_Term.mkForall _145_2259))
in ((_145_2260), (Some ("Projector equation"))))
in FStar_ToSMT_Term.Assume (_145_2261))
in (_145_2262)::[])))
end))
end
| _50_3276 -> begin
[]
end)))))
in (

let _50_3283 = (encode_binders None formals env)
in (match (_50_3283) with
| (vars, guards, env', decls1, _50_3282) -> begin
(

let _50_3292 = (match (pre_opt) with
| None -> begin
(let _145_2263 = (FStar_ToSMT_Term.mk_and_l guards)
in ((_145_2263), (decls1)))
end
| Some (p) -> begin
(

let _50_3289 = (encode_formula p env')
in (match (_50_3289) with
| (g, ds) -> begin
(let _145_2264 = (FStar_ToSMT_Term.mk_and_l ((g)::guards))
in ((_145_2264), ((FStar_List.append decls1 ds))))
end))
end)
in (match (_50_3292) with
| (guard, decls1) -> begin
(

let vtok_app = (mk_ApplyE vtok_tm vars)
in (

let vapp = (let _145_2266 = (let _145_2265 = (FStar_List.map FStar_ToSMT_Term.mkFreeV vars)
in ((vname), (_145_2265)))
in (FStar_ToSMT_Term.mkApp _145_2266))
in (

let _50_3323 = (

let vname_decl = (let _145_2269 = (let _145_2268 = (FStar_All.pipe_right formals (FStar_List.map (fun _50_32 -> (match (_50_32) with
| (FStar_Util.Inl (_50_3297), _50_3300) -> begin
FStar_ToSMT_Term.Type_sort
end
| _50_3303 -> begin
FStar_ToSMT_Term.Term_sort
end))))
in ((vname), (_145_2268), (FStar_ToSMT_Term.Term_sort), (None)))
in FStar_ToSMT_Term.DeclFun (_145_2269))
in (

let _50_3310 = (

let env = (

let _50_3305 = env
in {bindings = _50_3305.bindings; depth = _50_3305.depth; tcenv = _50_3305.tcenv; warn = _50_3305.warn; cache = _50_3305.cache; nolabels = _50_3305.nolabels; use_zfuel_name = _50_3305.use_zfuel_name; encode_non_total_function_typ = encode_non_total_function_typ})
in if (not ((head_normal env tt))) then begin
(encode_typ_pred None tt env vtok_tm)
end else begin
(encode_typ_pred None t_norm env vtok_tm)
end)
in (match (_50_3310) with
| (tok_typing, decls2) -> begin
(

let tok_typing = FStar_ToSMT_Term.Assume (((tok_typing), (Some ("function token typing"))))
in (

let _50_3320 = (match (formals) with
| [] -> begin
(let _145_2273 = (let _145_2272 = (let _145_2271 = (FStar_ToSMT_Term.mkFreeV ((vname), (FStar_ToSMT_Term.Term_sort)))
in (FStar_All.pipe_left (fun _145_2270 -> Some (_145_2270)) _145_2271))
in (push_free_var env lid vname _145_2272))
in (((FStar_List.append decls2 ((tok_typing)::[]))), (_145_2273)))
end
| _50_3314 -> begin
(

let vtok_decl = FStar_ToSMT_Term.DeclFun (((vtok), ([]), (FStar_ToSMT_Term.Term_sort), (None)))
in (

let vtok_fresh = (let _145_2274 = (varops.next_id ())
in (FStar_ToSMT_Term.fresh_token ((vtok), (FStar_ToSMT_Term.Term_sort)) _145_2274))
in (

let name_tok_corr = (let _145_2278 = (let _145_2277 = (let _145_2276 = (let _145_2275 = (FStar_ToSMT_Term.mkEq ((vtok_app), (vapp)))
in ((((vtok_app)::[])::[]), (vars), (_145_2275)))
in (FStar_ToSMT_Term.mkForall _145_2276))
in ((_145_2277), (None)))
in FStar_ToSMT_Term.Assume (_145_2278))
in (((FStar_List.append decls2 ((vtok_decl)::(vtok_fresh)::(name_tok_corr)::(tok_typing)::[]))), (env)))))
end)
in (match (_50_3320) with
| (tok_decl, env) -> begin
(((vname_decl)::tok_decl), (env))
end)))
end)))
in (match (_50_3323) with
| (decls2, env) -> begin
(

let _50_3331 = (

let res_t = (FStar_Absyn_Util.compress_typ res_t)
in (

let _50_3327 = (encode_typ_term res_t env')
in (match (_50_3327) with
| (encoded_res_t, decls) -> begin
(let _145_2279 = (FStar_ToSMT_Term.mk_HasType vapp encoded_res_t)
in ((encoded_res_t), (_145_2279), (decls)))
end)))
in (match (_50_3331) with
| (encoded_res_t, ty_pred, decls3) -> begin
(

let typingAx = (let _145_2283 = (let _145_2282 = (let _145_2281 = (let _145_2280 = (FStar_ToSMT_Term.mkImp ((guard), (ty_pred)))
in ((((vapp)::[])::[]), (vars), (_145_2280)))
in (FStar_ToSMT_Term.mkForall _145_2281))
in ((_145_2282), (Some ("free var typing"))))
in FStar_ToSMT_Term.Assume (_145_2283))
in (

let g = (let _145_2287 = (let _145_2286 = (let _145_2285 = (let _145_2284 = (mk_disc_proj_axioms guard encoded_res_t vapp vars)
in (typingAx)::_145_2284)
in (FStar_List.append decls3 _145_2285))
in (FStar_List.append decls2 _145_2286))
in (FStar_List.append decls1 _145_2287))
in ((g), (env))))
end))
end))))
end))
end))))
end))
end)))
end
end)
and encode_signature : env_t  ->  FStar_Absyn_Syntax.sigelt Prims.list  ->  (FStar_ToSMT_Term.decl Prims.list * env_t) = (fun env ses -> (FStar_All.pipe_right ses (FStar_List.fold_left (fun _50_3338 se -> (match (_50_3338) with
| (g, env) -> begin
(

let _50_3342 = (encode_sigelt env se)
in (match (_50_3342) with
| (g', env) -> begin
(((FStar_List.append g g')), (env))
end))
end)) (([]), (env)))))


let encode_env_bindings : env_t  ->  FStar_Tc_Env.binding Prims.list  ->  (FStar_ToSMT_Term.decl Prims.list * env_t) = (fun env bindings -> (

let encode_binding = (fun b _50_3349 -> (match (_50_3349) with
| (decls, env) -> begin
(match (b) with
| FStar_Tc_Env.Binding_var (x, t0) -> begin
(

let _50_3357 = (new_term_constant env x)
in (match (_50_3357) with
| (xxsym, xx, env') -> begin
(

let t1 = (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.DeltaHard)::(FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.EtaArgs)::(FStar_Tc_Normalize.Simplify)::[]) env.tcenv t0)
in (

let _50_3359 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env.tcenv) (FStar_Options.Other ("Encoding"))) then begin
(let _145_2302 = (FStar_Absyn_Print.strBvd x)
in (let _145_2301 = (FStar_Absyn_Print.typ_to_string t0)
in (let _145_2300 = (FStar_Absyn_Print.typ_to_string t1)
in (FStar_Util.print3 "Normalized %s : %s to %s\n" _145_2302 _145_2301 _145_2300))))
end else begin
()
end
in (

let _50_3363 = (encode_typ_pred None t1 env xx)
in (match (_50_3363) with
| (t, decls') -> begin
(

let caption = if (FStar_Options.log_queries ()) then begin
(let _145_2306 = (let _145_2305 = (FStar_Absyn_Print.strBvd x)
in (let _145_2304 = (FStar_Absyn_Print.typ_to_string t0)
in (let _145_2303 = (FStar_Absyn_Print.typ_to_string t1)
in (FStar_Util.format3 "%s : %s (%s)" _145_2305 _145_2304 _145_2303))))
in Some (_145_2306))
end else begin
None
end
in (

let g = (FStar_List.append ((FStar_ToSMT_Term.DeclFun (((xxsym), ([]), (FStar_ToSMT_Term.Term_sort), (caption))))::[]) (FStar_List.append decls' ((FStar_ToSMT_Term.Assume (((t), (None))))::[])))
in (((FStar_List.append decls g)), (env'))))
end))))
end))
end
| FStar_Tc_Env.Binding_typ (a, k) -> begin
(

let _50_3373 = (new_typ_constant env a)
in (match (_50_3373) with
| (aasym, aa, env') -> begin
(

let _50_3376 = (encode_knd k env aa)
in (match (_50_3376) with
| (k, decls') -> begin
(

let g = (let _145_2311 = (let _145_2310 = (let _145_2309 = (let _145_2308 = (let _145_2307 = (FStar_Absyn_Print.strBvd a)
in Some (_145_2307))
in ((aasym), ([]), (FStar_ToSMT_Term.Type_sort), (_145_2308)))
in FStar_ToSMT_Term.DeclFun (_145_2309))
in (_145_2310)::[])
in (FStar_List.append _145_2311 (FStar_List.append decls' ((FStar_ToSMT_Term.Assume (((k), (None))))::[]))))
in (((FStar_List.append decls g)), (env')))
end))
end))
end
| FStar_Tc_Env.Binding_lid (x, t) -> begin
(

let t_norm = (whnf env t)
in (

let _50_3385 = (encode_free_var env x t t_norm [])
in (match (_50_3385) with
| (g, env') -> begin
(((FStar_List.append decls g)), (env'))
end)))
end
| FStar_Tc_Env.Binding_sig (se) -> begin
(

let _50_3390 = (encode_sigelt env se)
in (match (_50_3390) with
| (g, env') -> begin
(((FStar_List.append decls g)), (env'))
end))
end)
end))
in (FStar_List.fold_right encode_binding bindings (([]), (env)))))


let encode_labels = (fun labs -> (

let prefix = (FStar_All.pipe_right labs (FStar_List.map (fun _50_3397 -> (match (_50_3397) with
| (l, _50_3394, _50_3396) -> begin
FStar_ToSMT_Term.DeclFun ((((Prims.fst l)), ([]), (FStar_ToSMT_Term.Bool_sort), (None)))
end))))
in (

let suffix = (FStar_All.pipe_right labs (FStar_List.collect (fun _50_3404 -> (match (_50_3404) with
| (l, _50_3401, _50_3403) -> begin
(let _145_2319 = (FStar_All.pipe_left (fun _145_2315 -> FStar_ToSMT_Term.Echo (_145_2315)) (Prims.fst l))
in (let _145_2318 = (let _145_2317 = (let _145_2316 = (FStar_ToSMT_Term.mkFreeV l)
in FStar_ToSMT_Term.Eval (_145_2316))
in (_145_2317)::[])
in (_145_2319)::_145_2318))
end))))
in ((prefix), (suffix)))))


let last_env : env_t Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let init_env : FStar_Tc_Env.env  ->  Prims.unit = (fun tcenv -> (let _145_2324 = (let _145_2323 = (let _145_2322 = (FStar_Util.smap_create (Prims.parse_int "100"))
in {bindings = []; depth = (Prims.parse_int "0"); tcenv = tcenv; warn = true; cache = _145_2322; nolabels = false; use_zfuel_name = false; encode_non_total_function_typ = true})
in (_145_2323)::[])
in (FStar_ST.op_Colon_Equals last_env _145_2324)))


let get_env : FStar_Tc_Env.env  ->  env_t = (fun tcenv -> (match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "No env; call init first!")
end
| (e)::_50_3410 -> begin
(

let _50_3413 = e
in {bindings = _50_3413.bindings; depth = _50_3413.depth; tcenv = tcenv; warn = _50_3413.warn; cache = _50_3413.cache; nolabels = _50_3413.nolabels; use_zfuel_name = _50_3413.use_zfuel_name; encode_non_total_function_typ = _50_3413.encode_non_total_function_typ})
end))


let set_env : env_t  ->  Prims.unit = (fun env -> (match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "Empty env stack")
end
| (_50_3419)::tl -> begin
(FStar_ST.op_Colon_Equals last_env ((env)::tl))
end))


let push_env : Prims.unit  ->  Prims.unit = (fun _50_3421 -> (match (()) with
| () -> begin
(match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "Empty env stack")
end
| (hd)::tl -> begin
(

let refs = (FStar_Util.smap_copy hd.cache)
in (

let top = (

let _50_3427 = hd
in {bindings = _50_3427.bindings; depth = _50_3427.depth; tcenv = _50_3427.tcenv; warn = _50_3427.warn; cache = refs; nolabels = _50_3427.nolabels; use_zfuel_name = _50_3427.use_zfuel_name; encode_non_total_function_typ = _50_3427.encode_non_total_function_typ})
in (FStar_ST.op_Colon_Equals last_env ((top)::(hd)::tl))))
end)
end))


let pop_env : Prims.unit  ->  Prims.unit = (fun _50_3430 -> (match (()) with
| () -> begin
(match ((FStar_ST.read last_env)) with
| [] -> begin
(FStar_All.failwith "Popping an empty stack")
end
| (_50_3434)::tl -> begin
(FStar_ST.op_Colon_Equals last_env tl)
end)
end))


let mark_env : Prims.unit  ->  Prims.unit = (fun _50_3436 -> (match (()) with
| () -> begin
(push_env ())
end))


let reset_mark_env : Prims.unit  ->  Prims.unit = (fun _50_3437 -> (match (()) with
| () -> begin
(pop_env ())
end))


let commit_mark_env : Prims.unit  ->  Prims.unit = (fun _50_3438 -> (match (()) with
| () -> begin
(match ((FStar_ST.read last_env)) with
| (hd)::(_50_3441)::tl -> begin
(FStar_ST.op_Colon_Equals last_env ((hd)::tl))
end
| _50_3446 -> begin
(FStar_All.failwith "Impossible")
end)
end))


let init : FStar_Tc_Env.env  ->  Prims.unit = (fun tcenv -> (

let _50_3448 = (init_env tcenv)
in (

let _50_3450 = (FStar_ToSMT_Z3.init ())
in (FStar_ToSMT_Z3.giveZ3 ((FStar_ToSMT_Term.DefPrelude)::[])))))


let push : Prims.string  ->  Prims.unit = (fun msg -> (

let _50_3453 = (push_env ())
in (

let _50_3455 = (varops.push ())
in (FStar_ToSMT_Z3.push msg))))


let pop : Prims.string  ->  Prims.unit = (fun msg -> (

let _50_3458 = (let _145_2345 = (pop_env ())
in (FStar_All.pipe_left Prims.ignore _145_2345))
in (

let _50_3460 = (varops.pop ())
in (FStar_ToSMT_Z3.pop msg))))


let mark : Prims.string  ->  Prims.unit = (fun msg -> (

let _50_3463 = (mark_env ())
in (

let _50_3465 = (varops.mark ())
in (FStar_ToSMT_Z3.mark msg))))


let reset_mark : Prims.string  ->  Prims.unit = (fun msg -> (

let _50_3468 = (reset_mark_env ())
in (

let _50_3470 = (varops.reset_mark ())
in (FStar_ToSMT_Z3.reset_mark msg))))


let commit_mark = (fun msg -> (

let _50_3473 = (commit_mark_env ())
in (

let _50_3475 = (varops.commit_mark ())
in (FStar_ToSMT_Z3.commit_mark msg))))


let encode_sig : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.sigelt  ->  Prims.unit = (fun tcenv se -> (

let caption = (fun decls -> if (FStar_Options.log_queries ()) then begin
(let _145_2359 = (let _145_2358 = (let _145_2357 = (FStar_Absyn_Print.sigelt_to_string_short se)
in (Prims.strcat "encoding sigelt " _145_2357))
in FStar_ToSMT_Term.Caption (_145_2358))
in (_145_2359)::decls)
end else begin
decls
end)
in (

let env = (get_env tcenv)
in (

let _50_3484 = (encode_sigelt env se)
in (match (_50_3484) with
| (decls, env) -> begin
(

let _50_3485 = (set_env env)
in (let _145_2360 = (caption decls)
in (FStar_ToSMT_Z3.giveZ3 _145_2360)))
end)))))


let encode_modul : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.modul  ->  Prims.unit = (fun tcenv modul -> (

let name = (FStar_Util.format2 "%s %s" (if modul.FStar_Absyn_Syntax.is_interface then begin
"interface"
end else begin
"module"
end) modul.FStar_Absyn_Syntax.name.FStar_Ident.str)
in (

let _50_3490 = if (FStar_Tc_Env.debug tcenv FStar_Options.Low) then begin
(let _145_2365 = (FStar_All.pipe_right (FStar_List.length modul.FStar_Absyn_Syntax.exports) FStar_Util.string_of_int)
in (FStar_Util.print2 "Encoding externals for %s ... %s exports\n" name _145_2365))
end else begin
()
end
in (

let env = (get_env tcenv)
in (

let _50_3497 = (encode_signature (

let _50_3493 = env
in {bindings = _50_3493.bindings; depth = _50_3493.depth; tcenv = _50_3493.tcenv; warn = false; cache = _50_3493.cache; nolabels = _50_3493.nolabels; use_zfuel_name = _50_3493.use_zfuel_name; encode_non_total_function_typ = _50_3493.encode_non_total_function_typ}) modul.FStar_Absyn_Syntax.exports)
in (match (_50_3497) with
| (decls, env) -> begin
(

let caption = (fun decls -> if (FStar_Options.log_queries ()) then begin
(

let msg = (Prims.strcat "Externals for " name)
in (FStar_List.append ((FStar_ToSMT_Term.Caption (msg))::decls) ((FStar_ToSMT_Term.Caption ((Prims.strcat "End " msg)))::[])))
end else begin
decls
end)
in (

let _50_3503 = (set_env (

let _50_3501 = env
in {bindings = _50_3501.bindings; depth = _50_3501.depth; tcenv = _50_3501.tcenv; warn = true; cache = _50_3501.cache; nolabels = _50_3501.nolabels; use_zfuel_name = _50_3501.use_zfuel_name; encode_non_total_function_typ = _50_3501.encode_non_total_function_typ}))
in (

let _50_3505 = if (FStar_Tc_Env.debug tcenv FStar_Options.Low) then begin
(FStar_Util.print1 "Done encoding externals for %s\n" name)
end else begin
()
end
in (

let decls = (caption decls)
in (FStar_ToSMT_Z3.giveZ3 decls)))))
end))))))


let solve : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  Prims.unit = (fun tcenv q -> (

let _50_3510 = (let _145_2374 = (let _145_2373 = (let _145_2372 = (FStar_Tc_Env.get_range tcenv)
in (FStar_All.pipe_left FStar_Range.string_of_range _145_2372))
in (FStar_Util.format1 "Starting query at %s" _145_2373))
in (push _145_2374))
in (

let pop = (fun _50_3513 -> (match (()) with
| () -> begin
(let _145_2379 = (let _145_2378 = (let _145_2377 = (FStar_Tc_Env.get_range tcenv)
in (FStar_All.pipe_left FStar_Range.string_of_range _145_2377))
in (FStar_Util.format1 "Ending query at %s" _145_2378))
in (pop _145_2379))
end))
in (

let _50_3572 = (

let env = (get_env tcenv)
in (

let bindings = (FStar_Tc_Env.fold_env tcenv (fun bs b -> (b)::bs) [])
in (

let _50_3546 = (

let rec aux = (fun bindings -> (match (bindings) with
| (FStar_Tc_Env.Binding_var (x, t))::rest -> begin
(

let _50_3528 = (aux rest)
in (match (_50_3528) with
| (out, rest) -> begin
(

let t = (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.DeltaHard)::(FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.EtaArgs)::(FStar_Tc_Normalize.Simplify)::[]) env.tcenv t)
in (let _145_2385 = (let _145_2384 = (FStar_Absyn_Syntax.v_binder (FStar_Absyn_Util.bvd_to_bvar_s x t))
in (_145_2384)::out)
in ((_145_2385), (rest))))
end))
end
| (FStar_Tc_Env.Binding_typ (a, k))::rest -> begin
(

let _50_3538 = (aux rest)
in (match (_50_3538) with
| (out, rest) -> begin
(let _145_2387 = (let _145_2386 = (FStar_Absyn_Syntax.t_binder (FStar_Absyn_Util.bvd_to_bvar_s a k))
in (_145_2386)::out)
in ((_145_2387), (rest)))
end))
end
| _50_3540 -> begin
(([]), (bindings))
end))
in (

let _50_3543 = (aux bindings)
in (match (_50_3543) with
| (closing, bindings) -> begin
(let _145_2388 = (FStar_Absyn_Util.close_forall (FStar_List.rev closing) q)
in ((_145_2388), (bindings)))
end)))
in (match (_50_3546) with
| (q, bindings) -> begin
(

let _50_3555 = (let _145_2390 = (FStar_List.filter (fun _50_33 -> (match (_50_33) with
| FStar_Tc_Env.Binding_sig (_50_3549) -> begin
false
end
| _50_3552 -> begin
true
end)) bindings)
in (encode_env_bindings env _145_2390))
in (match (_50_3555) with
| (env_decls, env) -> begin
(

let _50_3556 = if (FStar_Tc_Env.debug tcenv FStar_Options.Low) then begin
(let _145_2391 = (FStar_Absyn_Print.formula_to_string q)
in (FStar_Util.print1 "Encoding query formula: %s\n" _145_2391))
end else begin
()
end
in (

let _50_3561 = (encode_formula_with_labels q env)
in (match (_50_3561) with
| (phi, labels, qdecls) -> begin
(

let _50_3564 = (encode_labels labels)
in (match (_50_3564) with
| (label_prefix, label_suffix) -> begin
(

let query_prelude = (FStar_List.append env_decls (FStar_List.append label_prefix qdecls))
in (

let qry = (let _145_2393 = (let _145_2392 = (FStar_ToSMT_Term.mkNot phi)
in ((_145_2392), (Some ("query"))))
in FStar_ToSMT_Term.Assume (_145_2393))
in (

let suffix = (FStar_List.append label_suffix ((FStar_ToSMT_Term.Echo ("Done!"))::[]))
in ((query_prelude), (labels), (qry), (suffix)))))
end))
end)))
end))
end))))
in (match (_50_3572) with
| (prefix, labels, qry, suffix) -> begin
(match (qry) with
| FStar_ToSMT_Term.Assume ({FStar_ToSMT_Term.tm = FStar_ToSMT_Term.App (FStar_ToSMT_Term.False, _50_3579); FStar_ToSMT_Term.hash = _50_3576; FStar_ToSMT_Term.freevars = _50_3574}, _50_3584) -> begin
(

let _50_3587 = (pop ())
in ())
end
| _50_3590 when tcenv.FStar_Tc_Env.admit -> begin
(

let _50_3591 = (pop ())
in ())
end
| FStar_ToSMT_Term.Assume (q, _50_3595) -> begin
(

let fresh = ((FStar_String.length q.FStar_ToSMT_Term.hash) >= (Prims.parse_int "2048"))
in (

let _50_3599 = (FStar_ToSMT_Z3.giveZ3 prefix)
in (

let with_fuel = (fun p _50_3605 -> (match (_50_3605) with
| (n, i) -> begin
(let _145_2416 = (let _145_2415 = (let _145_2400 = (let _145_2399 = (FStar_Util.string_of_int n)
in (let _145_2398 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "<fuel=\'%s\' ifuel=\'%s\'>" _145_2399 _145_2398)))
in FStar_ToSMT_Term.Caption (_145_2400))
in (let _145_2414 = (let _145_2413 = (let _145_2405 = (let _145_2404 = (let _145_2403 = (let _145_2402 = (FStar_ToSMT_Term.mkApp (("MaxFuel"), ([])))
in (let _145_2401 = (FStar_ToSMT_Term.n_fuel n)
in ((_145_2402), (_145_2401))))
in (FStar_ToSMT_Term.mkEq _145_2403))
in ((_145_2404), (None)))
in FStar_ToSMT_Term.Assume (_145_2405))
in (let _145_2412 = (let _145_2411 = (let _145_2410 = (let _145_2409 = (let _145_2408 = (let _145_2407 = (FStar_ToSMT_Term.mkApp (("MaxIFuel"), ([])))
in (let _145_2406 = (FStar_ToSMT_Term.n_fuel i)
in ((_145_2407), (_145_2406))))
in (FStar_ToSMT_Term.mkEq _145_2408))
in ((_145_2409), (None)))
in FStar_ToSMT_Term.Assume (_145_2410))
in (_145_2411)::(p)::(FStar_ToSMT_Term.CheckSat)::[])
in (_145_2413)::_145_2412))
in (_145_2415)::_145_2414))
in (FStar_List.append _145_2416 suffix))
end))
in (

let check = (fun p -> (

let initial_config = (let _145_2420 = (FStar_Options.initial_fuel ())
in (let _145_2419 = (FStar_Options.initial_ifuel ())
in ((_145_2420), (_145_2419))))
in (

let alt_configs = (let _145_2439 = (let _145_2438 = if ((FStar_Options.max_ifuel ()) > (FStar_Options.initial_ifuel ())) then begin
(let _145_2423 = (let _145_2422 = (FStar_Options.initial_fuel ())
in (let _145_2421 = (FStar_Options.max_ifuel ())
in ((_145_2422), (_145_2421))))
in (_145_2423)::[])
end else begin
[]
end
in (let _145_2437 = (let _145_2436 = if (((FStar_Options.max_fuel ()) / (Prims.parse_int "2")) > (FStar_Options.initial_fuel ())) then begin
(let _145_2426 = (let _145_2425 = ((FStar_Options.max_fuel ()) / (Prims.parse_int "2"))
in (let _145_2424 = (FStar_Options.max_ifuel ())
in ((_145_2425), (_145_2424))))
in (_145_2426)::[])
end else begin
[]
end
in (let _145_2435 = (let _145_2434 = if (((FStar_Options.max_fuel ()) > (FStar_Options.initial_fuel ())) && ((FStar_Options.max_ifuel ()) > (FStar_Options.initial_ifuel ()))) then begin
(let _145_2429 = (let _145_2428 = (FStar_Options.max_fuel ())
in (let _145_2427 = (FStar_Options.max_ifuel ())
in ((_145_2428), (_145_2427))))
in (_145_2429)::[])
end else begin
[]
end
in (let _145_2433 = (let _145_2432 = if ((FStar_Options.min_fuel ()) < (FStar_Options.initial_fuel ())) then begin
(let _145_2431 = (let _145_2430 = (FStar_Options.min_fuel ())
in ((_145_2430), ((Prims.parse_int "1"))))
in (_145_2431)::[])
end else begin
[]
end
in (_145_2432)::[])
in (_145_2434)::_145_2433))
in (_145_2436)::_145_2435))
in (_145_2438)::_145_2437))
in (FStar_List.flatten _145_2439))
in (

let report = (fun errs -> (

let errs = (match (errs) with
| [] -> begin
((("Unknown assertion failed"), (FStar_Absyn_Syntax.dummyRange)))::[]
end
| _50_3614 -> begin
errs
end)
in (

let _50_3616 = if ((FStar_Options.print_fuels ()) || (FStar_Options.hint_info ())) then begin
(let _145_2447 = (let _145_2442 = (FStar_Tc_Env.get_range tcenv)
in (FStar_Range.string_of_range _145_2442))
in (let _145_2446 = (let _145_2443 = (FStar_Options.max_fuel ())
in (FStar_All.pipe_right _145_2443 FStar_Util.string_of_int))
in (let _145_2445 = (let _145_2444 = (FStar_Options.max_ifuel ())
in (FStar_All.pipe_right _145_2444 FStar_Util.string_of_int))
in (FStar_Util.print3 "(%s) Query failed with maximum fuel %s and ifuel %s\n" _145_2447 _145_2446 _145_2445))))
end else begin
()
end
in (FStar_Tc_Errors.add_errors tcenv errs))))
in (

let rec try_alt_configs = (fun p errs _50_34 -> (match (_50_34) with
| [] -> begin
(report errs)
end
| (mi)::[] -> begin
(match (errs) with
| [] -> begin
(let _145_2458 = (with_fuel p mi)
in (FStar_ToSMT_Z3.ask fresh labels _145_2458 (cb mi p [])))
end
| _50_3628 -> begin
(report errs)
end)
end
| (mi)::tl -> begin
(let _145_2460 = (with_fuel p mi)
in (FStar_ToSMT_Z3.ask fresh labels _145_2460 (fun _50_3634 -> (match (_50_3634) with
| (ok, errs') -> begin
(match (errs) with
| [] -> begin
(cb mi p tl ((ok), (errs')))
end
| _50_3637 -> begin
(cb mi p tl ((ok), (errs)))
end)
end))))
end))
and cb = (fun _50_3640 p alt _50_3645 -> (match (((_50_3640), (_50_3645))) with
| ((prev_fuel, prev_ifuel), (ok, errs)) -> begin
if ok then begin
if ((FStar_Options.print_fuels ()) || (FStar_Options.hint_info ())) then begin
(let _145_2468 = (let _145_2465 = (FStar_Tc_Env.get_range tcenv)
in (FStar_Range.string_of_range _145_2465))
in (let _145_2467 = (FStar_Util.string_of_int prev_fuel)
in (let _145_2466 = (FStar_Util.string_of_int prev_ifuel)
in (FStar_Util.print3 "(%s) Query succeeded with fuel %s and ifuel %s\n" _145_2468 _145_2467 _145_2466))))
end else begin
()
end
end else begin
(try_alt_configs p errs alt)
end
end))
in (let _145_2469 = (with_fuel p initial_config)
in (FStar_ToSMT_Z3.ask fresh labels _145_2469 (cb initial_config p alt_configs))))))))
in (

let process_query = (fun q -> if ((FStar_Options.split_cases ()) > (Prims.parse_int "0")) then begin
(

let _50_3650 = (let _145_2475 = (FStar_Options.split_cases ())
in (FStar_ToSMT_SplitQueryCases.can_handle_query _145_2475 q))
in (match (_50_3650) with
| (b, cb) -> begin
if b then begin
(FStar_ToSMT_SplitQueryCases.handle_query cb check)
end else begin
(check q)
end
end))
end else begin
(check q)
end)
in (

let _50_3651 = if (FStar_Options.admit_smt_queries ()) then begin
()
end else begin
(process_query qry)
end
in (pop ())))))))
end
| _50_3654 -> begin
(Prims.raise Bad_form)
end)
end)))))


let is_trivial : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  Prims.bool = (fun tcenv q -> (

let env = (get_env tcenv)
in (

let _50_3658 = (push "query")
in (

let _50_3665 = (encode_formula_with_labels q env)
in (match (_50_3665) with
| (f, _50_3662, _50_3664) -> begin
(

let _50_3666 = (pop "query")
in (match (f.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.True, _50_3670) -> begin
true
end
| _50_3674 -> begin
false
end))
end)))))


let solver : FStar_Tc_Env.solver_t = {FStar_Tc_Env.init = init; FStar_Tc_Env.push = push; FStar_Tc_Env.pop = pop; FStar_Tc_Env.mark = mark; FStar_Tc_Env.reset_mark = reset_mark; FStar_Tc_Env.commit_mark = commit_mark; FStar_Tc_Env.encode_modul = encode_modul; FStar_Tc_Env.encode_sig = encode_sig; FStar_Tc_Env.solve = solve; FStar_Tc_Env.is_trivial = is_trivial; FStar_Tc_Env.finish = FStar_ToSMT_Z3.finish; FStar_Tc_Env.refresh = FStar_ToSMT_Z3.refresh}


let dummy : FStar_Tc_Env.solver_t = {FStar_Tc_Env.init = (fun _50_3675 -> ()); FStar_Tc_Env.push = (fun _50_3677 -> ()); FStar_Tc_Env.pop = (fun _50_3679 -> ()); FStar_Tc_Env.mark = (fun _50_3681 -> ()); FStar_Tc_Env.reset_mark = (fun _50_3683 -> ()); FStar_Tc_Env.commit_mark = (fun _50_3685 -> ()); FStar_Tc_Env.encode_modul = (fun _50_3687 _50_3689 -> ()); FStar_Tc_Env.encode_sig = (fun _50_3691 _50_3693 -> ()); FStar_Tc_Env.solve = (fun _50_3695 _50_3697 -> ()); FStar_Tc_Env.is_trivial = (fun _50_3699 _50_3701 -> false); FStar_Tc_Env.finish = (fun _50_3703 -> ()); FStar_Tc_Env.refresh = (fun _50_3704 -> ())}




