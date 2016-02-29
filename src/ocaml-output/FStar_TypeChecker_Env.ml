
open Prims
# 28 "FStar.TypeChecker.Env.fst"
type binding =
| Binding_var of FStar_Syntax_Syntax.bv
| Binding_lid of (FStar_Ident.lident * FStar_Syntax_Syntax.tscheme)
| Binding_sig of (FStar_Ident.lident Prims.list * FStar_Syntax_Syntax.sigelt)
| Binding_univ of FStar_Syntax_Syntax.univ_name
| Binding_sig_inst of (FStar_Ident.lident Prims.list * FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes)

# 31 "FStar.TypeChecker.Env.fst"
let is_Binding_var = (fun _discr_ -> (match (_discr_) with
| Binding_var (_) -> begin
true
end
| _ -> begin
false
end))

# 32 "FStar.TypeChecker.Env.fst"
let is_Binding_lid = (fun _discr_ -> (match (_discr_) with
| Binding_lid (_) -> begin
true
end
| _ -> begin
false
end))

# 33 "FStar.TypeChecker.Env.fst"
let is_Binding_sig = (fun _discr_ -> (match (_discr_) with
| Binding_sig (_) -> begin
true
end
| _ -> begin
false
end))

# 34 "FStar.TypeChecker.Env.fst"
let is_Binding_univ = (fun _discr_ -> (match (_discr_) with
| Binding_univ (_) -> begin
true
end
| _ -> begin
false
end))

# 35 "FStar.TypeChecker.Env.fst"
let is_Binding_sig_inst = (fun _discr_ -> (match (_discr_) with
| Binding_sig_inst (_) -> begin
true
end
| _ -> begin
false
end))

# 31 "FStar.TypeChecker.Env.fst"
let ___Binding_var____0 : binding  ->  FStar_Syntax_Syntax.bv = (fun projectee -> (match (projectee) with
| Binding_var (_65_15) -> begin
_65_15
end))

# 32 "FStar.TypeChecker.Env.fst"
let ___Binding_lid____0 : binding  ->  (FStar_Ident.lident * FStar_Syntax_Syntax.tscheme) = (fun projectee -> (match (projectee) with
| Binding_lid (_65_18) -> begin
_65_18
end))

# 33 "FStar.TypeChecker.Env.fst"
let ___Binding_sig____0 : binding  ->  (FStar_Ident.lident Prims.list * FStar_Syntax_Syntax.sigelt) = (fun projectee -> (match (projectee) with
| Binding_sig (_65_21) -> begin
_65_21
end))

# 34 "FStar.TypeChecker.Env.fst"
let ___Binding_univ____0 : binding  ->  FStar_Syntax_Syntax.univ_name = (fun projectee -> (match (projectee) with
| Binding_univ (_65_24) -> begin
_65_24
end))

# 35 "FStar.TypeChecker.Env.fst"
let ___Binding_sig_inst____0 : binding  ->  (FStar_Ident.lident Prims.list * FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes) = (fun projectee -> (match (projectee) with
| Binding_sig_inst (_65_27) -> begin
_65_27
end))

# 35 "FStar.TypeChecker.Env.fst"
type delta_level =
| NoDelta
| OnlyInline
| Unfold

# 38 "FStar.TypeChecker.Env.fst"
let is_NoDelta = (fun _discr_ -> (match (_discr_) with
| NoDelta (_) -> begin
true
end
| _ -> begin
false
end))

# 39 "FStar.TypeChecker.Env.fst"
let is_OnlyInline = (fun _discr_ -> (match (_discr_) with
| OnlyInline (_) -> begin
true
end
| _ -> begin
false
end))

# 40 "FStar.TypeChecker.Env.fst"
let is_Unfold = (fun _discr_ -> (match (_discr_) with
| Unfold (_) -> begin
true
end
| _ -> begin
false
end))

# 40 "FStar.TypeChecker.Env.fst"
type mlift =
FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ

# 42 "FStar.TypeChecker.Env.fst"
type edge =
{msource : FStar_Ident.lident; mtarget : FStar_Ident.lident; mlift : FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ}

# 44 "FStar.TypeChecker.Env.fst"
let is_Mkedge : edge  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkedge"))))

# 48 "FStar.TypeChecker.Env.fst"
type effects =
{decls : FStar_Syntax_Syntax.eff_decl Prims.list; order : edge Prims.list; joins : (FStar_Ident.lident * FStar_Ident.lident * FStar_Ident.lident * mlift * mlift) Prims.list}

# 49 "FStar.TypeChecker.Env.fst"
let is_Mkeffects : effects  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkeffects"))))

# 53 "FStar.TypeChecker.Env.fst"
type cached_elt =
((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ), (FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes Prims.option)) FStar_Util.either

# 54 "FStar.TypeChecker.Env.fst"
type env =
{solver : solver_t; range : FStar_Range.range; curmodule : FStar_Ident.lident; gamma : binding Prims.list; gamma_cache : cached_elt FStar_Util.smap; modules : FStar_Syntax_Syntax.modul Prims.list; expected_typ : FStar_Syntax_Syntax.typ Prims.option; sigtab : FStar_Syntax_Syntax.sigelt FStar_Util.smap Prims.list; is_pattern : Prims.bool; instantiate_imp : Prims.bool; effects : effects; generalize : Prims.bool; letrecs : (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.typ) Prims.list; top_level : Prims.bool; check_uvars : Prims.bool; use_eq : Prims.bool; is_iface : Prims.bool; admit : Prims.bool; default_effects : (FStar_Ident.lident * FStar_Ident.lident) Prims.list; type_of : env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ * guard_t); universe_of : env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.universe; use_bv_sorts : Prims.bool} 
 and solver_t =
{init : env  ->  Prims.unit; push : Prims.string  ->  Prims.unit; pop : Prims.string  ->  Prims.unit; mark : Prims.string  ->  Prims.unit; reset_mark : Prims.string  ->  Prims.unit; commit_mark : Prims.string  ->  Prims.unit; encode_modul : env  ->  FStar_Syntax_Syntax.modul  ->  Prims.unit; encode_sig : env  ->  FStar_Syntax_Syntax.sigelt  ->  Prims.unit; solve : env  ->  FStar_Syntax_Syntax.typ  ->  Prims.unit; is_trivial : env  ->  FStar_Syntax_Syntax.typ  ->  Prims.bool; finish : Prims.unit  ->  Prims.unit; refresh : Prims.unit  ->  Prims.unit} 
 and guard_t =
{guard_f : FStar_TypeChecker_Common.guard_formula; deferred : FStar_TypeChecker_Common.deferred; univ_ineqs : FStar_TypeChecker_Common.univ_ineq Prims.list; implicits : (env * FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * FStar_Range.range) Prims.list}

# 55 "FStar.TypeChecker.Env.fst"
let is_Mkenv : env  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkenv"))))

# 79 "FStar.TypeChecker.Env.fst"
let is_Mksolver_t : solver_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mksolver_t"))))

# 93 "FStar.TypeChecker.Env.fst"
let is_Mkguard_t : guard_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkguard_t"))))

# 98 "FStar.TypeChecker.Env.fst"
type env_t =
env

# 99 "FStar.TypeChecker.Env.fst"
type implicits =
(env * FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * FStar_Range.range) Prims.list

# 100 "FStar.TypeChecker.Env.fst"
type sigtable =
FStar_Syntax_Syntax.sigelt FStar_Util.smap

# 162 "FStar.TypeChecker.Env.fst"
let visible_at : delta_level  ->  FStar_Syntax_Syntax.qualifier  ->  Prims.bool = (fun d q -> (match ((d, q)) with
| ((NoDelta, _)) | ((OnlyInline, FStar_Syntax_Syntax.Inline)) | ((Unfold, FStar_Syntax_Syntax.Inline)) | ((Unfold, FStar_Syntax_Syntax.Unfoldable)) -> begin
true
end
| _65_94 -> begin
false
end))

# 169 "FStar.TypeChecker.Env.fst"
let glb_delta : delta_level  ->  delta_level  ->  delta_level = (fun d1 d2 -> (match ((d1, d2)) with
| ((NoDelta, _)) | ((_, NoDelta)) -> begin
NoDelta
end
| ((OnlyInline, _)) | ((_, OnlyInline)) -> begin
OnlyInline
end
| (Unfold, Unfold) -> begin
Unfold
end))

# 176 "FStar.TypeChecker.Env.fst"
let default_table_size : Prims.int = 200

# 179 "FStar.TypeChecker.Env.fst"
let new_sigtab = (fun _65_116 -> (match (()) with
| () -> begin
(FStar_Util.smap_create default_table_size)
end))

# 180 "FStar.TypeChecker.Env.fst"
let initial_env : (env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ * guard_t))  ->  solver_t  ->  FStar_Ident.lident  ->  env = (fun tc solver module_lid -> (let _146_376 = (FStar_Util.smap_create 100)
in (let _146_375 = (let _146_372 = (new_sigtab ())
in (_146_372)::[])
in {solver = solver; range = FStar_Range.dummyRange; curmodule = module_lid; gamma = []; gamma_cache = _146_376; modules = []; expected_typ = None; sigtab = _146_375; is_pattern = false; instantiate_imp = true; effects = {decls = []; order = []; joins = []}; generalize = true; letrecs = []; top_level = false; check_uvars = false; use_eq = false; is_iface = false; admit = false; default_effects = []; type_of = tc; universe_of = (fun g e -> FStar_Syntax_Syntax.U_zero); use_bv_sorts = false})))

# 205 "FStar.TypeChecker.Env.fst"
let sigtab : env  ->  FStar_Syntax_Syntax.sigelt FStar_Util.smap = (fun env -> (FStar_List.hd env.sigtab))

# 208 "FStar.TypeChecker.Env.fst"
let push : env  ->  Prims.string  ->  env = (fun env msg -> (
# 210 "FStar.TypeChecker.Env.fst"
let _65_125 = (env.solver.push msg)
in (
# 211 "FStar.TypeChecker.Env.fst"
let _65_127 = env
in (let _146_385 = (let _146_384 = (let _146_383 = (sigtab env)
in (FStar_Util.smap_copy _146_383))
in (_146_384)::env.sigtab)
in {solver = _65_127.solver; range = _65_127.range; curmodule = _65_127.curmodule; gamma = _65_127.gamma; gamma_cache = _65_127.gamma_cache; modules = _65_127.modules; expected_typ = _65_127.expected_typ; sigtab = _146_385; is_pattern = _65_127.is_pattern; instantiate_imp = _65_127.instantiate_imp; effects = _65_127.effects; generalize = _65_127.generalize; letrecs = _65_127.letrecs; top_level = _65_127.top_level; check_uvars = _65_127.check_uvars; use_eq = _65_127.use_eq; is_iface = _65_127.is_iface; admit = _65_127.admit; default_effects = _65_127.default_effects; type_of = _65_127.type_of; universe_of = _65_127.universe_of; use_bv_sorts = _65_127.use_bv_sorts}))))

# 211 "FStar.TypeChecker.Env.fst"
let mark : env  ->  env = (fun env -> (
# 213 "FStar.TypeChecker.Env.fst"
let _65_130 = (env.solver.mark "USER MARK")
in (
# 214 "FStar.TypeChecker.Env.fst"
let _65_132 = env
in (let _146_390 = (let _146_389 = (let _146_388 = (sigtab env)
in (FStar_Util.smap_copy _146_388))
in (_146_389)::env.sigtab)
in {solver = _65_132.solver; range = _65_132.range; curmodule = _65_132.curmodule; gamma = _65_132.gamma; gamma_cache = _65_132.gamma_cache; modules = _65_132.modules; expected_typ = _65_132.expected_typ; sigtab = _146_390; is_pattern = _65_132.is_pattern; instantiate_imp = _65_132.instantiate_imp; effects = _65_132.effects; generalize = _65_132.generalize; letrecs = _65_132.letrecs; top_level = _65_132.top_level; check_uvars = _65_132.check_uvars; use_eq = _65_132.use_eq; is_iface = _65_132.is_iface; admit = _65_132.admit; default_effects = _65_132.default_effects; type_of = _65_132.type_of; universe_of = _65_132.universe_of; use_bv_sorts = _65_132.use_bv_sorts}))))

# 214 "FStar.TypeChecker.Env.fst"
let commit_mark : env  ->  env = (fun env -> (
# 216 "FStar.TypeChecker.Env.fst"
let _65_135 = (env.solver.commit_mark "USER MARK")
in (
# 217 "FStar.TypeChecker.Env.fst"
let sigtab = (match (env.sigtab) with
| hd::_65_139::tl -> begin
(hd)::tl
end
| _65_144 -> begin
(FStar_All.failwith "Impossible")
end)
in (
# 220 "FStar.TypeChecker.Env.fst"
let _65_146 = env
in {solver = _65_146.solver; range = _65_146.range; curmodule = _65_146.curmodule; gamma = _65_146.gamma; gamma_cache = _65_146.gamma_cache; modules = _65_146.modules; expected_typ = _65_146.expected_typ; sigtab = sigtab; is_pattern = _65_146.is_pattern; instantiate_imp = _65_146.instantiate_imp; effects = _65_146.effects; generalize = _65_146.generalize; letrecs = _65_146.letrecs; top_level = _65_146.top_level; check_uvars = _65_146.check_uvars; use_eq = _65_146.use_eq; is_iface = _65_146.is_iface; admit = _65_146.admit; default_effects = _65_146.default_effects; type_of = _65_146.type_of; universe_of = _65_146.universe_of; use_bv_sorts = _65_146.use_bv_sorts}))))

# 220 "FStar.TypeChecker.Env.fst"
let reset_mark : env  ->  env = (fun env -> (
# 222 "FStar.TypeChecker.Env.fst"
let _65_149 = (env.solver.reset_mark "USER MARK")
in (
# 223 "FStar.TypeChecker.Env.fst"
let _65_151 = env
in (let _146_395 = (FStar_List.tl env.sigtab)
in {solver = _65_151.solver; range = _65_151.range; curmodule = _65_151.curmodule; gamma = _65_151.gamma; gamma_cache = _65_151.gamma_cache; modules = _65_151.modules; expected_typ = _65_151.expected_typ; sigtab = _146_395; is_pattern = _65_151.is_pattern; instantiate_imp = _65_151.instantiate_imp; effects = _65_151.effects; generalize = _65_151.generalize; letrecs = _65_151.letrecs; top_level = _65_151.top_level; check_uvars = _65_151.check_uvars; use_eq = _65_151.use_eq; is_iface = _65_151.is_iface; admit = _65_151.admit; default_effects = _65_151.default_effects; type_of = _65_151.type_of; universe_of = _65_151.universe_of; use_bv_sorts = _65_151.use_bv_sorts}))))

# 223 "FStar.TypeChecker.Env.fst"
let pop : env  ->  Prims.string  ->  env = (fun env msg -> (match (env.sigtab) with
| ([]) | (_::[]) -> begin
(FStar_All.failwith "Too many pops")
end
| _65_161::tl -> begin
(
# 228 "FStar.TypeChecker.Env.fst"
let _65_163 = (env.solver.pop msg)
in (
# 229 "FStar.TypeChecker.Env.fst"
let _65_165 = env
in {solver = _65_165.solver; range = _65_165.range; curmodule = _65_165.curmodule; gamma = _65_165.gamma; gamma_cache = _65_165.gamma_cache; modules = _65_165.modules; expected_typ = _65_165.expected_typ; sigtab = tl; is_pattern = _65_165.is_pattern; instantiate_imp = _65_165.instantiate_imp; effects = _65_165.effects; generalize = _65_165.generalize; letrecs = _65_165.letrecs; top_level = _65_165.top_level; check_uvars = _65_165.check_uvars; use_eq = _65_165.use_eq; is_iface = _65_165.is_iface; admit = _65_165.admit; default_effects = _65_165.default_effects; type_of = _65_165.type_of; universe_of = _65_165.universe_of; use_bv_sorts = _65_165.use_bv_sorts}))
end))

# 229 "FStar.TypeChecker.Env.fst"
let debug : env  ->  FStar_Options.debug_level_t  ->  Prims.bool = (fun env l -> ((let _146_405 = (FStar_ST.read FStar_Options.debug)
in (FStar_All.pipe_right _146_405 (FStar_Util.for_some (fun x -> ((env.curmodule.FStar_Ident.str = "") || (env.curmodule.FStar_Ident.str = x)))))) && (FStar_Options.debug_level_geq l)))

# 236 "FStar.TypeChecker.Env.fst"
let set_range : env  ->  FStar_Range.range  ->  env = (fun e r -> if (r = FStar_Range.dummyRange) then begin
e
end else begin
(
# 237 "FStar.TypeChecker.Env.fst"
let _65_172 = e
in {solver = _65_172.solver; range = r; curmodule = _65_172.curmodule; gamma = _65_172.gamma; gamma_cache = _65_172.gamma_cache; modules = _65_172.modules; expected_typ = _65_172.expected_typ; sigtab = _65_172.sigtab; is_pattern = _65_172.is_pattern; instantiate_imp = _65_172.instantiate_imp; effects = _65_172.effects; generalize = _65_172.generalize; letrecs = _65_172.letrecs; top_level = _65_172.top_level; check_uvars = _65_172.check_uvars; use_eq = _65_172.use_eq; is_iface = _65_172.is_iface; admit = _65_172.admit; default_effects = _65_172.default_effects; type_of = _65_172.type_of; universe_of = _65_172.universe_of; use_bv_sorts = _65_172.use_bv_sorts})
end)

# 237 "FStar.TypeChecker.Env.fst"
let get_range : env  ->  FStar_Range.range = (fun e -> e.range)

# 238 "FStar.TypeChecker.Env.fst"
let modules : env  ->  FStar_Syntax_Syntax.modul Prims.list = (fun env -> env.modules)

# 243 "FStar.TypeChecker.Env.fst"
let current_module : env  ->  FStar_Ident.lident = (fun env -> env.curmodule)

# 244 "FStar.TypeChecker.Env.fst"
let set_current_module : env  ->  FStar_Ident.lident  ->  env = (fun env lid -> (
# 245 "FStar.TypeChecker.Env.fst"
let _65_179 = env
in {solver = _65_179.solver; range = _65_179.range; curmodule = lid; gamma = _65_179.gamma; gamma_cache = _65_179.gamma_cache; modules = _65_179.modules; expected_typ = _65_179.expected_typ; sigtab = _65_179.sigtab; is_pattern = _65_179.is_pattern; instantiate_imp = _65_179.instantiate_imp; effects = _65_179.effects; generalize = _65_179.generalize; letrecs = _65_179.letrecs; top_level = _65_179.top_level; check_uvars = _65_179.check_uvars; use_eq = _65_179.use_eq; is_iface = _65_179.is_iface; admit = _65_179.admit; default_effects = _65_179.default_effects; type_of = _65_179.type_of; universe_of = _65_179.universe_of; use_bv_sorts = _65_179.use_bv_sorts}))

# 245 "FStar.TypeChecker.Env.fst"
let has_interface : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (FStar_All.pipe_right env.modules (FStar_Util.for_some (fun m -> (m.FStar_Syntax_Syntax.is_interface && (FStar_Ident.lid_equals m.FStar_Syntax_Syntax.name l))))))

# 246 "FStar.TypeChecker.Env.fst"
let find_in_sigtab : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.sigelt Prims.option = (fun env lid -> (let _146_429 = (sigtab env)
in (FStar_Util.smap_try_find _146_429 (FStar_Ident.text_of_lid lid))))

# 247 "FStar.TypeChecker.Env.fst"
let name_not_found : FStar_Ident.lid  ->  Prims.string = (fun l -> (FStar_Util.format1 "Name \"%s\" not found" l.FStar_Ident.str))

# 250 "FStar.TypeChecker.Env.fst"
let variable_not_found : FStar_Syntax_Syntax.bv  ->  Prims.string = (fun v -> (let _146_434 = (FStar_Syntax_Print.bv_to_string v)
in (FStar_Util.format1 "Variable \"%s\" not found" _146_434)))

# 253 "FStar.TypeChecker.Env.fst"
let new_u_univ = (fun _65_188 -> (let _146_436 = (FStar_Unionfind.fresh None)
in FStar_Syntax_Syntax.U_unif (_146_436)))

# 256 "FStar.TypeChecker.Env.fst"
let inst_tscheme_with : FStar_Syntax_Syntax.tscheme  ->  FStar_Syntax_Syntax.universes  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) = (fun ts us -> (match ((ts, us)) with
| (([], t), []) -> begin
([], t)
end
| ((formals, t), _65_201) -> begin
(
# 263 "FStar.TypeChecker.Env.fst"
let _65_203 = ()
in (
# 264 "FStar.TypeChecker.Env.fst"
let n = ((FStar_List.length formals) - 1)
in (
# 265 "FStar.TypeChecker.Env.fst"
let vs = (FStar_All.pipe_right us (FStar_List.mapi (fun i u -> FStar_Syntax_Syntax.UN (((n - i), u)))))
in (let _146_443 = (FStar_Syntax_Subst.subst vs t)
in (us, _146_443)))))
end))

# 266 "FStar.TypeChecker.Env.fst"
let inst_tscheme : FStar_Syntax_Syntax.tscheme  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) = (fun _65_1 -> (match (_65_1) with
| ([], t) -> begin
([], t)
end
| (us, t) -> begin
(
# 272 "FStar.TypeChecker.Env.fst"
let us' = (FStar_All.pipe_right us (FStar_List.map (fun _65_216 -> (new_u_univ ()))))
in (inst_tscheme_with (us, t) us'))
end))

# 273 "FStar.TypeChecker.Env.fst"
let inst_effect_fun_with : FStar_Syntax_Syntax.universes  ->  env  ->  FStar_Syntax_Syntax.eff_decl  ->  FStar_Syntax_Syntax.tscheme  ->  FStar_Syntax_Syntax.term = (fun insts env ed _65_224 -> (match (_65_224) with
| (us, t) -> begin
(match (ed.FStar_Syntax_Syntax.binders) with
| [] -> begin
(
# 278 "FStar.TypeChecker.Env.fst"
let univs = (FStar_List.append ed.FStar_Syntax_Syntax.univs us)
in (
# 279 "FStar.TypeChecker.Env.fst"
let _65_227 = if ((FStar_List.length insts) <> (FStar_List.length univs)) then begin
(let _146_459 = (let _146_458 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length univs))
in (let _146_457 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length insts))
in (let _146_456 = (FStar_Syntax_Print.lid_to_string ed.FStar_Syntax_Syntax.mname)
in (let _146_455 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format4 "Expected %s instantiations; got %s; failed universe instantiation in effect %s\n\t%s\n" _146_458 _146_457 _146_456 _146_455)))))
in (FStar_All.failwith _146_459))
end else begin
()
end
in (let _146_460 = (inst_tscheme_with ((FStar_List.append ed.FStar_Syntax_Syntax.univs us), t) insts)
in (Prims.snd _146_460))))
end
| _65_230 -> begin
(let _146_462 = (let _146_461 = (FStar_Syntax_Print.lid_to_string ed.FStar_Syntax_Syntax.mname)
in (FStar_Util.format1 "Unexpected use of an uninstantiated effect: %s\n" _146_461))
in (FStar_All.failwith _146_462))
end)
end))

# 284 "FStar.TypeChecker.Env.fst"
type tri =
| Yes
| No
| Maybe

# 287 "FStar.TypeChecker.Env.fst"
let is_Yes = (fun _discr_ -> (match (_discr_) with
| Yes (_) -> begin
true
end
| _ -> begin
false
end))

# 288 "FStar.TypeChecker.Env.fst"
let is_No = (fun _discr_ -> (match (_discr_) with
| No (_) -> begin
true
end
| _ -> begin
false
end))

# 289 "FStar.TypeChecker.Env.fst"
let is_Maybe = (fun _discr_ -> (match (_discr_) with
| Maybe (_) -> begin
true
end
| _ -> begin
false
end))

# 289 "FStar.TypeChecker.Env.fst"
let in_cur_mod : env  ->  FStar_Ident.lident  ->  tri = (fun env l -> (
# 292 "FStar.TypeChecker.Env.fst"
let cur = (current_module env)
in if (l.FStar_Ident.nsstr = cur.FStar_Ident.str) then begin
Yes
end else begin
if (FStar_Util.starts_with l.FStar_Ident.nsstr cur.FStar_Ident.str) then begin
(
# 295 "FStar.TypeChecker.Env.fst"
let lns = (FStar_List.append l.FStar_Ident.ns ((l.FStar_Ident.ident)::[]))
in (
# 296 "FStar.TypeChecker.Env.fst"
let cur = (FStar_List.append cur.FStar_Ident.ns ((cur.FStar_Ident.ident)::[]))
in (
# 297 "FStar.TypeChecker.Env.fst"
let rec aux = (fun c l -> (match ((c, l)) with
| ([], _65_241) -> begin
Maybe
end
| (_65_244, []) -> begin
No
end
| (hd::tl, hd'::tl') when (hd.FStar_Ident.idText = hd'.FStar_Ident.idText) -> begin
(aux tl tl')
end
| _65_255 -> begin
No
end))
in (aux cur lns))))
end else begin
No
end
end))

# 303 "FStar.TypeChecker.Env.fst"
let lookup_qname : env  ->  FStar_Ident.lident  ->  ((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ), (FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes Prims.option)) FStar_Util.either Prims.option = (fun env lid -> (
# 306 "FStar.TypeChecker.Env.fst"
let cur_mod = (in_cur_mod env lid)
in (
# 307 "FStar.TypeChecker.Env.fst"
let cache = (fun t -> (
# 307 "FStar.TypeChecker.Env.fst"
let _65_261 = (FStar_Util.smap_add env.gamma_cache lid.FStar_Ident.str t)
in Some (t)))
in (
# 308 "FStar.TypeChecker.Env.fst"
let found = if (cur_mod <> No) then begin
(match ((FStar_Util.smap_try_find env.gamma_cache lid.FStar_Ident.str)) with
| None -> begin
(FStar_Util.find_map env.gamma (fun _65_2 -> (match (_65_2) with
| Binding_lid (l, t) -> begin
if (FStar_Ident.lid_equals lid l) then begin
(let _146_482 = (let _146_481 = (inst_tscheme t)
in FStar_Util.Inl (_146_481))
in Some (_146_482))
end else begin
None
end
end
| Binding_sig (_65_270, FStar_Syntax_Syntax.Sig_bundle (ses, _65_273, _65_275, _65_277)) -> begin
(FStar_Util.find_map ses (fun se -> if (let _146_484 = (FStar_Syntax_Util.lids_of_sigelt se)
in (FStar_All.pipe_right _146_484 (FStar_Util.for_some (FStar_Ident.lid_equals lid)))) then begin
(cache (FStar_Util.Inr ((se, None))))
end else begin
None
end))
end
| Binding_sig (lids, s) -> begin
(
# 319 "FStar.TypeChecker.Env.fst"
let maybe_cache = (fun t -> (match (s) with
| FStar_Syntax_Syntax.Sig_declare_typ (_65_290) -> begin
Some (t)
end
| _65_293 -> begin
(cache t)
end))
in if (FStar_All.pipe_right lids (FStar_Util.for_some (FStar_Ident.lid_equals lid))) then begin
(maybe_cache (FStar_Util.Inr ((s, None))))
end else begin
None
end)
end
| Binding_sig_inst (lids, s, us) -> begin
if (FStar_All.pipe_right lids (FStar_Util.for_some (FStar_Ident.lid_equals lid))) then begin
Some (FStar_Util.Inr ((s, Some (us))))
end else begin
None
end
end
| _65_300 -> begin
None
end)))
end
| se -> begin
se
end)
end else begin
None
end
in if (FStar_Util.is_some found) then begin
found
end else begin
if ((cur_mod <> Yes) || (has_interface env env.curmodule)) then begin
(match ((find_in_sigtab env lid)) with
| Some (se) -> begin
Some (FStar_Util.Inr ((se, None)))
end
| None -> begin
None
end)
end else begin
None
end
end))))

# 334 "FStar.TypeChecker.Env.fst"
let lid_exists : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (match ((lookup_qname env l)) with
| None -> begin
false
end
| Some (_65_310) -> begin
true
end))

# 338 "FStar.TypeChecker.Env.fst"
let rec add_sigelt : env  ->  FStar_Syntax_Syntax.sigelt  ->  Prims.unit = (fun env se -> (match (se) with
| FStar_Syntax_Syntax.Sig_bundle (ses, _65_316, _65_318, _65_320) -> begin
(add_sigelts env ses)
end
| _65_324 -> begin
(
# 343 "FStar.TypeChecker.Env.fst"
let lids = (FStar_Syntax_Util.lids_of_sigelt se)
in (FStar_List.iter (fun l -> (let _146_498 = (sigtab env)
in (FStar_Util.smap_add _146_498 l.FStar_Ident.str se))) lids))
end))
and add_sigelts : env  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  Prims.unit = (fun env ses -> (FStar_All.pipe_right ses (FStar_List.iter (add_sigelt env))))

# 347 "FStar.TypeChecker.Env.fst"
let try_lookup_bv : env  ->  FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.term Prims.option = (fun env bv -> (FStar_Util.find_map env.gamma (fun _65_3 -> (match (_65_3) with
| Binding_var (id) when (FStar_Syntax_Syntax.bv_eq id bv) -> begin
Some (id.FStar_Syntax_Syntax.sort)
end
| _65_335 -> begin
None
end))))

# 356 "FStar.TypeChecker.Env.fst"
let lookup_univ : env  ->  FStar_Syntax_Syntax.univ_name  ->  Prims.bool = (fun env x -> (FStar_All.pipe_right (FStar_List.find (fun _65_4 -> (match (_65_4) with
| Binding_univ (y) -> begin
(x.FStar_Ident.idText = y.FStar_Ident.idText)
end
| _65_342 -> begin
false
end)) env.gamma) FStar_Option.isSome))

# 362 "FStar.TypeChecker.Env.fst"
let lookup_type_of_let : FStar_Syntax_Syntax.sigelt  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) Prims.option = (fun se lid -> (match (se) with
| FStar_Syntax_Syntax.Sig_let ((_65_346, lb::[]), _65_351, _65_353, _65_355) -> begin
(let _146_518 = (inst_tscheme (lb.FStar_Syntax_Syntax.lbunivs, lb.FStar_Syntax_Syntax.lbtyp))
in Some (_146_518))
end
| FStar_Syntax_Syntax.Sig_let ((_65_359, lbs), _65_363, _65_365, _65_367) -> begin
(FStar_Util.find_map lbs (fun lb -> (match (lb.FStar_Syntax_Syntax.lbname) with
| FStar_Util.Inl (_65_372) -> begin
(FStar_All.failwith "impossible")
end
| FStar_Util.Inr (lid') -> begin
if (FStar_Ident.lid_equals lid lid') then begin
(let _146_520 = (inst_tscheme (lb.FStar_Syntax_Syntax.lbunivs, lb.FStar_Syntax_Syntax.lbtyp))
in Some (_146_520))
end else begin
None
end
end)))
end
| _65_377 -> begin
None
end))

# 376 "FStar.TypeChecker.Env.fst"
let lookup_bv : env  ->  FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.typ = (fun env bv -> (match ((try_lookup_bv env bv)) with
| None -> begin
(let _146_528 = (let _146_527 = (let _146_526 = (variable_not_found bv)
in (let _146_525 = (FStar_Syntax_Syntax.range_of_bv bv)
in (_146_526, _146_525)))
in FStar_Syntax_Syntax.Error (_146_527))
in (Prims.raise _146_528))
end
| Some (t) -> begin
t
end))

# 381 "FStar.TypeChecker.Env.fst"
let effect_signature : FStar_Syntax_Syntax.sigelt  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) Prims.option = (fun se -> (match (se) with
| FStar_Syntax_Syntax.Sig_new_effect (ne, _65_386) -> begin
(let _146_534 = (let _146_533 = (let _146_532 = (let _146_531 = (FStar_Syntax_Syntax.mk_Total ne.FStar_Syntax_Syntax.signature)
in (FStar_Syntax_Util.arrow ne.FStar_Syntax_Syntax.binders _146_531))
in (ne.FStar_Syntax_Syntax.univs, _146_532))
in (inst_tscheme _146_533))
in Some (_146_534))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (lid, us, binders, _65_393, _65_395, _65_397) -> begin
(let _146_538 = (let _146_537 = (let _146_536 = (let _146_535 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Syntax.teff)
in (FStar_Syntax_Util.arrow binders _146_535))
in (us, _146_536))
in (inst_tscheme _146_537))
in Some (_146_538))
end
| _65_401 -> begin
None
end))

# 391 "FStar.TypeChecker.Env.fst"
let try_lookup_effect_lid : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term Prims.option = (fun env ftv -> (match ((lookup_qname env ftv)) with
| Some (FStar_Util.Inr (se, None)) -> begin
(match ((effect_signature se)) with
| None -> begin
None
end
| Some (_65_411, t) -> begin
Some (t)
end)
end
| _65_416 -> begin
None
end))

# 400 "FStar.TypeChecker.Env.fst"
let try_lookup_lid : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) Prims.option = (fun env lid -> (
# 403 "FStar.TypeChecker.Env.fst"
let mapper = (fun _65_5 -> (match (_65_5) with
| FStar_Util.Inl (t) -> begin
Some (t)
end
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_datacon (_65_423, uvs, t, _65_427, _65_429, _65_431, _65_433, _65_435), None) -> begin
(let _146_549 = (inst_tscheme (uvs, t))
in Some (_146_549))
end
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_declare_typ (l, uvs, t, qs, _65_446), None) -> begin
if ((in_cur_mod env l) = Yes) then begin
if ((FStar_All.pipe_right qs (FStar_List.contains FStar_Syntax_Syntax.Assumption)) || env.is_iface) then begin
(let _146_550 = (inst_tscheme (uvs, t))
in Some (_146_550))
end else begin
None
end
end else begin
(let _146_551 = (inst_tscheme (uvs, t))
in Some (_146_551))
end
end
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (lid, uvs, tps, k, _65_457, _65_459, _65_461, _65_463), None) -> begin
(match (tps) with
| [] -> begin
(let _146_553 = (inst_tscheme (uvs, k))
in (FStar_All.pipe_left (fun _146_552 -> Some (_146_552)) _146_553))
end
| _65_471 -> begin
(let _146_558 = (let _146_557 = (let _146_556 = (let _146_555 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.arrow tps _146_555))
in (uvs, _146_556))
in (inst_tscheme _146_557))
in (FStar_All.pipe_left (fun _146_554 -> Some (_146_554)) _146_558))
end)
end
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (lid, uvs, tps, k, _65_477, _65_479, _65_481, _65_483), Some (us)) -> begin
(match (tps) with
| [] -> begin
(let _146_560 = (inst_tscheme_with (uvs, k) us)
in (FStar_All.pipe_left (fun _146_559 -> Some (_146_559)) _146_560))
end
| _65_492 -> begin
(let _146_565 = (let _146_564 = (let _146_563 = (let _146_562 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.arrow tps _146_562))
in (uvs, _146_563))
in (inst_tscheme_with _146_564 us))
in (FStar_All.pipe_left (fun _146_561 -> Some (_146_561)) _146_565))
end)
end
| FStar_Util.Inr (se) -> begin
(match (se) with
| (FStar_Syntax_Syntax.Sig_let (_65_496), None) -> begin
(lookup_type_of_let (Prims.fst se) lid)
end
| _65_501 -> begin
(effect_signature (Prims.fst se))
end)
end))
in (match ((let _146_566 = (lookup_qname env lid)
in (FStar_Util.bind_opt _146_566 mapper))) with
| Some (us, t) -> begin
Some ((us, (
# 437 "FStar.TypeChecker.Env.fst"
let _65_507 = t
in {FStar_Syntax_Syntax.n = _65_507.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.tk = _65_507.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = (FStar_Ident.range_of_lid lid); FStar_Syntax_Syntax.vars = _65_507.FStar_Syntax_Syntax.vars})))
end
| None -> begin
None
end)))

# 438 "FStar.TypeChecker.Env.fst"
let lookup_lid : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) = (fun env l -> (match ((try_lookup_lid env l)) with
| None -> begin
(let _146_573 = (let _146_572 = (let _146_571 = (name_not_found l)
in (_146_571, (FStar_Ident.range_of_lid l)))
in FStar_Syntax_Syntax.Error (_146_572))
in (Prims.raise _146_573))
end
| Some (x) -> begin
x
end))

# 443 "FStar.TypeChecker.Env.fst"
let lookup_val_decl : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_declare_typ (_65_518, uvs, t, _65_522, _65_524), None)) -> begin
(inst_tscheme (uvs, t))
end
| _65_532 -> begin
(let _146_580 = (let _146_579 = (let _146_578 = (name_not_found lid)
in (_146_578, (FStar_Ident.range_of_lid lid)))
in FStar_Syntax_Syntax.Error (_146_579))
in (Prims.raise _146_580))
end))

# 448 "FStar.TypeChecker.Env.fst"
let lookup_datacon : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_datacon (_65_536, uvs, t, _65_540, _65_542, _65_544, _65_546, _65_548), None)) -> begin
(inst_tscheme (uvs, t))
end
| _65_556 -> begin
(let _146_587 = (let _146_586 = (let _146_585 = (name_not_found lid)
in (_146_585, (FStar_Ident.range_of_lid lid)))
in FStar_Syntax_Syntax.Error (_146_586))
in (Prims.raise _146_587))
end))

# 453 "FStar.TypeChecker.Env.fst"
let lookup_definition : delta_level  ->  env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.term) Prims.option = (fun delta_level env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (se, None)) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_let ((_65_566, lbs), _65_570, _65_572, quals) when (FStar_Util.for_some (visible_at delta_level) quals) -> begin
(FStar_Util.find_map lbs (fun lb -> (
# 461 "FStar.TypeChecker.Env.fst"
let lid' = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in if (FStar_Ident.lid_equals lid lid') then begin
(let _146_596 = (let _146_595 = (FStar_Syntax_Util.unascribe lb.FStar_Syntax_Syntax.lbdef)
in (lb.FStar_Syntax_Syntax.lbunivs, _146_595))
in Some (_146_596))
end else begin
None
end)))
end
| _65_579 -> begin
None
end)
end
| _65_581 -> begin
None
end))

# 467 "FStar.TypeChecker.Env.fst"
let lookup_effect_lid : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term = (fun env ftv -> (match ((try_lookup_effect_lid env ftv)) with
| None -> begin
(let _146_603 = (let _146_602 = (let _146_601 = (name_not_found ftv)
in (_146_601, (FStar_Ident.range_of_lid ftv)))
in FStar_Syntax_Syntax.Error (_146_602))
in (Prims.raise _146_603))
end
| Some (k) -> begin
k
end))

# 472 "FStar.TypeChecker.Env.fst"
let lookup_projector : env  ->  FStar_Ident.lident  ->  Prims.int  ->  FStar_Ident.lident = (fun env lid i -> (
# 475 "FStar.TypeChecker.Env.fst"
let fail = (fun _65_591 -> (match (()) with
| () -> begin
(let _146_614 = (let _146_613 = (FStar_Util.string_of_int i)
in (let _146_612 = (FStar_Syntax_Print.lid_to_string lid)
in (FStar_Util.format2 "Impossible: projecting field #%s from constructor %s is undefined" _146_613 _146_612)))
in (FStar_All.failwith _146_614))
end))
in (
# 476 "FStar.TypeChecker.Env.fst"
let _65_595 = (lookup_datacon env lid)
in (match (_65_595) with
| (_65_593, t) -> begin
(match ((let _146_615 = (FStar_Syntax_Subst.compress t)
in _146_615.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, _65_598) -> begin
if ((i < 0) || (i >= (FStar_List.length binders))) then begin
(fail ())
end else begin
(
# 481 "FStar.TypeChecker.Env.fst"
let b = (FStar_List.nth binders i)
in (let _146_616 = (FStar_Syntax_Util.mk_field_projector_name lid (Prims.fst b) i)
in (FStar_All.pipe_right _146_616 Prims.fst)))
end
end
| _65_603 -> begin
(fail ())
end)
end))))

# 483 "FStar.TypeChecker.Env.fst"
let try_lookup_val_decl : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.tscheme * FStar_Syntax_Syntax.qualifier Prims.list) Prims.option = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_declare_typ (_65_607, uvs, t, q, _65_612), None)) -> begin
Some (((uvs, t), q))
end
| _65_620 -> begin
None
end))

# 488 "FStar.TypeChecker.Env.fst"
let lookup_effect_abbrev : env  ->  FStar_Syntax_Syntax.universe  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.comp) Prims.option = (fun env univ lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_effect_abbrev (lid, univs, binders, c, quals, _65_630), None)) -> begin
if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _65_6 -> (match (_65_6) with
| FStar_Syntax_Syntax.Irreducible -> begin
true
end
| _65_640 -> begin
false
end)))) then begin
None
end else begin
(
# 495 "FStar.TypeChecker.Env.fst"
let insts = if (FStar_Ident.lid_equals lid FStar_Syntax_Const.effect_Lemma_lid) then begin
(univ)::(FStar_Syntax_Syntax.U_zero)::(FStar_Syntax_Syntax.U_zero)::[]
end else begin
(univ)::[]
end
in (match ((binders, univs)) with
| ([], _65_644) -> begin
(FStar_All.failwith "Unexpected effect abbreviation with no arguments")
end
| (_65_647, _65_654::_65_651::_65_649) when (not ((FStar_Ident.lid_equals lid FStar_Syntax_Const.effect_Lemma_lid))) -> begin
(let _146_630 = (let _146_629 = (FStar_Syntax_Print.lid_to_string lid)
in (let _146_628 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length univs))
in (FStar_Util.format2 "Unexpected effect abbreviation %s; polymorphic in %s universes" _146_629 _146_628)))
in (FStar_All.failwith _146_630))
end
| _65_658 -> begin
(
# 503 "FStar.TypeChecker.Env.fst"
let _65_662 = (let _146_632 = (let _146_631 = (FStar_Syntax_Util.arrow binders c)
in (univs, _146_631))
in (inst_tscheme_with _146_632 insts))
in (match (_65_662) with
| (_65_660, t) -> begin
(match ((let _146_633 = (FStar_Syntax_Subst.compress t)
in _146_633.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
Some ((binders, c))
end
| _65_668 -> begin
(FStar_All.failwith "Impossible")
end)
end))
end))
end
end
| _65_670 -> begin
None
end))

# 510 "FStar.TypeChecker.Env.fst"
let datacons_of_typ : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.list = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (_65_674, _65_676, _65_678, _65_680, _65_682, dcs, _65_685, _65_687), _65_691)) -> begin
dcs
end
| _65_696 -> begin
[]
end))

# 515 "FStar.TypeChecker.Env.fst"
let typ_of_datacon : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_datacon (_65_700, _65_702, _65_704, l, _65_707, _65_709, _65_711, _65_713), _65_717)) -> begin
l
end
| _65_722 -> begin
(let _146_643 = (let _146_642 = (FStar_Syntax_Print.lid_to_string lid)
in (FStar_Util.format1 "Not a datacon: %s" _146_642))
in (FStar_All.failwith _146_643))
end))

# 520 "FStar.TypeChecker.Env.fst"
let is_datacon : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_datacon (_65_726, _65_728, _65_730, _65_732, _65_734, _65_736, _65_738, _65_740), _65_744)) -> begin
true
end
| _65_749 -> begin
false
end))

# 525 "FStar.TypeChecker.Env.fst"
let is_record : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (_65_753, _65_755, _65_757, _65_759, _65_761, _65_763, tags, _65_766), _65_770)) -> begin
(FStar_Util.for_some (fun _65_7 -> (match (_65_7) with
| (FStar_Syntax_Syntax.RecordType (_)) | (FStar_Syntax_Syntax.RecordConstructor (_)) -> begin
true
end
| _65_782 -> begin
false
end)) tags)
end
| _65_784 -> begin
false
end))

# 531 "FStar.TypeChecker.Env.fst"
let is_projector : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (match ((lookup_qname env l)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_declare_typ (_65_788, _65_790, _65_792, quals, _65_795), _65_799)) -> begin
(FStar_Util.for_some (fun _65_8 -> (match (_65_8) with
| FStar_Syntax_Syntax.Projector (_65_805) -> begin
true
end
| _65_808 -> begin
false
end)) quals)
end
| _65_810 -> begin
false
end))

# 537 "FStar.TypeChecker.Env.fst"
let interpreted_symbols : FStar_Ident.lident Prims.list = (FStar_Syntax_Const.op_Eq)::(FStar_Syntax_Const.op_notEq)::(FStar_Syntax_Const.op_LT)::(FStar_Syntax_Const.op_LTE)::(FStar_Syntax_Const.op_GT)::(FStar_Syntax_Const.op_GTE)::(FStar_Syntax_Const.op_Subtraction)::(FStar_Syntax_Const.op_Minus)::(FStar_Syntax_Const.op_Addition)::(FStar_Syntax_Const.op_Multiply)::(FStar_Syntax_Const.op_Division)::(FStar_Syntax_Const.op_Modulus)::(FStar_Syntax_Const.op_And)::(FStar_Syntax_Const.op_Or)::(FStar_Syntax_Const.op_Negation)::[]

# 554 "FStar.TypeChecker.Env.fst"
let is_interpreted : env  ->  FStar_Syntax_Syntax.term  ->  Prims.bool = (fun env head -> (match ((let _146_662 = (FStar_Syntax_Util.un_uinst head)
in _146_662.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar (fv, _65_815) -> begin
(FStar_Util.for_some (FStar_Ident.lid_equals fv.FStar_Syntax_Syntax.v) interpreted_symbols)
end
| _65_819 -> begin
false
end))

# 560 "FStar.TypeChecker.Env.fst"
let effect_decl_opt : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.eff_decl Prims.option = (fun env l -> (FStar_All.pipe_right env.effects.decls (FStar_Util.find_opt (fun d -> (FStar_Ident.lid_equals d.FStar_Syntax_Syntax.mname l)))))

# 566 "FStar.TypeChecker.Env.fst"
let get_effect_decl : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.eff_decl = (fun env l -> (match ((effect_decl_opt env l)) with
| None -> begin
(let _146_674 = (let _146_673 = (let _146_672 = (name_not_found l)
in (_146_672, (FStar_Ident.range_of_lid l)))
in FStar_Syntax_Syntax.Error (_146_673))
in (Prims.raise _146_674))
end
| Some (md) -> begin
md
end))

# 571 "FStar.TypeChecker.Env.fst"
let join : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  (FStar_Ident.lident * mlift * mlift) = (fun env l1 l2 -> if (FStar_Ident.lid_equals l1 l2) then begin
(l1, (fun t wp -> wp), (fun t wp -> wp))
end else begin
if (((FStar_Ident.lid_equals l1 FStar_Syntax_Const.effect_GTot_lid) && (FStar_Ident.lid_equals l2 FStar_Syntax_Const.effect_Tot_lid)) || ((FStar_Ident.lid_equals l2 FStar_Syntax_Const.effect_GTot_lid) && (FStar_Ident.lid_equals l1 FStar_Syntax_Const.effect_Tot_lid))) then begin
(FStar_Syntax_Const.effect_GTot_lid, (fun t wp -> wp), (fun t wp -> wp))
end else begin
(match ((FStar_All.pipe_right env.effects.joins (FStar_Util.find_opt (fun _65_847 -> (match (_65_847) with
| (m1, m2, _65_842, _65_844, _65_846) -> begin
((FStar_Ident.lid_equals l1 m1) && (FStar_Ident.lid_equals l2 m2))
end))))) with
| None -> begin
(let _146_750 = (let _146_749 = (let _146_748 = (let _146_747 = (FStar_Syntax_Print.lid_to_string l1)
in (let _146_746 = (FStar_Syntax_Print.lid_to_string l2)
in (FStar_Util.format2 "Effects %s and %s cannot be composed" _146_747 _146_746)))
in (_146_748, env.range))
in FStar_Syntax_Syntax.Error (_146_749))
in (Prims.raise _146_750))
end
| Some (_65_850, _65_852, m3, j1, j2) -> begin
(m3, j1, j2)
end)
end
end)

# 581 "FStar.TypeChecker.Env.fst"
let monad_leq : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  edge Prims.option = (fun env l1 l2 -> if ((FStar_Ident.lid_equals l1 l2) || ((FStar_Ident.lid_equals l1 FStar_Syntax_Const.effect_Tot_lid) && (FStar_Ident.lid_equals l2 FStar_Syntax_Const.effect_GTot_lid))) then begin
Some ({msource = l1; mtarget = l2; mlift = (fun t wp -> wp)})
end else begin
(FStar_All.pipe_right env.effects.order (FStar_Util.find_opt (fun e -> ((FStar_Ident.lid_equals l1 e.msource) && (FStar_Ident.lid_equals l2 e.mtarget)))))
end)

# 587 "FStar.TypeChecker.Env.fst"
let wp_sig_aux : FStar_Syntax_Syntax.eff_decl Prims.list  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun decls m -> (match ((FStar_All.pipe_right decls (FStar_Util.find_opt (fun d -> (FStar_Ident.lid_equals d.FStar_Syntax_Syntax.mname m))))) with
| None -> begin
(let _146_765 = (FStar_Util.format1 "Impossible: declaration for monad %s not found" m.FStar_Ident.str)
in (FStar_All.failwith _146_765))
end
| Some (md) -> begin
(
# 593 "FStar.TypeChecker.Env.fst"
let _65_873 = (inst_tscheme (md.FStar_Syntax_Syntax.univs, md.FStar_Syntax_Syntax.signature))
in (match (_65_873) with
| (_65_871, s) -> begin
(
# 594 "FStar.TypeChecker.Env.fst"
let s = (FStar_Syntax_Subst.compress s)
in (match ((md.FStar_Syntax_Syntax.binders, s.FStar_Syntax_Syntax.n)) with
| ([], FStar_Syntax_Syntax.Tm_arrow ((a, _65_886)::(wp, _65_882)::(wlp, _65_878)::[], c)) when (FStar_Syntax_Syntax.is_teff (FStar_Syntax_Util.comp_result c)) -> begin
(a, wp.FStar_Syntax_Syntax.sort)
end
| _65_894 -> begin
(FStar_All.failwith "Impossible")
end))
end))
end))

# 597 "FStar.TypeChecker.Env.fst"
let wp_signature : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun env m -> (wp_sig_aux env.effects.decls m))

# 599 "FStar.TypeChecker.Env.fst"
let default_effect : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env l -> (FStar_Util.find_map env.default_effects (fun _65_901 -> (match (_65_901) with
| (l', m) -> begin
if (FStar_Ident.lid_equals l l') then begin
Some (m)
end else begin
None
end
end))))

# 601 "FStar.TypeChecker.Env.fst"
let build_lattice : env  ->  FStar_Syntax_Syntax.sigelt  ->  env = (fun env se -> (match (se) with
| FStar_Syntax_Syntax.Sig_effect_abbrev (l, _65_906, _65_908, c, quals, r) -> begin
(match ((FStar_Util.find_map quals (fun _65_9 -> (match (_65_9) with
| FStar_Syntax_Syntax.DefaultEffect (n) -> begin
n
end
| _65_918 -> begin
None
end)))) with
| None -> begin
env
end
| Some (e) -> begin
(
# 607 "FStar.TypeChecker.Env.fst"
let _65_922 = env
in {solver = _65_922.solver; range = _65_922.range; curmodule = _65_922.curmodule; gamma = _65_922.gamma; gamma_cache = _65_922.gamma_cache; modules = _65_922.modules; expected_typ = _65_922.expected_typ; sigtab = _65_922.sigtab; is_pattern = _65_922.is_pattern; instantiate_imp = _65_922.instantiate_imp; effects = _65_922.effects; generalize = _65_922.generalize; letrecs = _65_922.letrecs; top_level = _65_922.top_level; check_uvars = _65_922.check_uvars; use_eq = _65_922.use_eq; is_iface = _65_922.is_iface; admit = _65_922.admit; default_effects = ((e, l))::env.default_effects; type_of = _65_922.type_of; universe_of = _65_922.universe_of; use_bv_sorts = _65_922.use_bv_sorts})
end)
end
| FStar_Syntax_Syntax.Sig_new_effect (ne, _65_926) -> begin
(
# 610 "FStar.TypeChecker.Env.fst"
let effects = (
# 610 "FStar.TypeChecker.Env.fst"
let _65_929 = env.effects
in {decls = (ne)::env.effects.decls; order = _65_929.order; joins = _65_929.joins})
in (
# 611 "FStar.TypeChecker.Env.fst"
let _65_932 = env
in {solver = _65_932.solver; range = _65_932.range; curmodule = _65_932.curmodule; gamma = _65_932.gamma; gamma_cache = _65_932.gamma_cache; modules = _65_932.modules; expected_typ = _65_932.expected_typ; sigtab = _65_932.sigtab; is_pattern = _65_932.is_pattern; instantiate_imp = _65_932.instantiate_imp; effects = effects; generalize = _65_932.generalize; letrecs = _65_932.letrecs; top_level = _65_932.top_level; check_uvars = _65_932.check_uvars; use_eq = _65_932.use_eq; is_iface = _65_932.is_iface; admit = _65_932.admit; default_effects = _65_932.default_effects; type_of = _65_932.type_of; universe_of = _65_932.universe_of; use_bv_sorts = _65_932.use_bv_sorts}))
end
| FStar_Syntax_Syntax.Sig_sub_effect (sub, _65_936) -> begin
(
# 614 "FStar.TypeChecker.Env.fst"
let compose_edges = (fun e1 e2 -> {msource = e1.msource; mtarget = e2.mtarget; mlift = (fun r wp1 -> (let _146_786 = (e1.mlift r wp1)
in (e2.mlift r _146_786)))})
in (
# 619 "FStar.TypeChecker.Env.fst"
let mk_lift = (fun lift_t r wp1 -> (
# 620 "FStar.TypeChecker.Env.fst"
let _65_951 = (inst_tscheme lift_t)
in (match (_65_951) with
| (_65_949, lift_t) -> begin
(let _146_798 = (let _146_797 = (let _146_796 = (let _146_795 = (FStar_Syntax_Syntax.as_arg r)
in (let _146_794 = (let _146_793 = (FStar_Syntax_Syntax.as_arg wp1)
in (_146_793)::[])
in (_146_795)::_146_794))
in (lift_t, _146_796))
in FStar_Syntax_Syntax.Tm_app (_146_797))
in (FStar_Syntax_Syntax.mk _146_798 None wp1.FStar_Syntax_Syntax.pos))
end)))
in (
# 623 "FStar.TypeChecker.Env.fst"
let edge = {msource = sub.FStar_Syntax_Syntax.source; mtarget = sub.FStar_Syntax_Syntax.target; mlift = (mk_lift sub.FStar_Syntax_Syntax.lift)}
in (
# 627 "FStar.TypeChecker.Env.fst"
let id_edge = (fun l -> {msource = sub.FStar_Syntax_Syntax.source; mtarget = sub.FStar_Syntax_Syntax.target; mlift = (fun t wp -> wp)})
in (
# 632 "FStar.TypeChecker.Env.fst"
let print_mlift = (fun l -> (
# 633 "FStar.TypeChecker.Env.fst"
let arg = (let _146_815 = (FStar_Ident.lid_of_path (("ARG")::[]) FStar_Range.dummyRange)
in (FStar_Syntax_Syntax.lid_as_fv _146_815 None))
in (
# 634 "FStar.TypeChecker.Env.fst"
let wp = (let _146_816 = (FStar_Ident.lid_of_path (("WP")::[]) FStar_Range.dummyRange)
in (FStar_Syntax_Syntax.lid_as_fv _146_816 None))
in (let _146_817 = (l arg wp)
in (FStar_Syntax_Print.term_to_string _146_817)))))
in (
# 636 "FStar.TypeChecker.Env.fst"
let order = (edge)::env.effects.order
in (
# 638 "FStar.TypeChecker.Env.fst"
let ms = (FStar_All.pipe_right env.effects.decls (FStar_List.map (fun e -> e.FStar_Syntax_Syntax.mname)))
in (
# 640 "FStar.TypeChecker.Env.fst"
let find_edge = (fun order _65_968 -> (match (_65_968) with
| (i, j) -> begin
if (FStar_Ident.lid_equals i j) then begin
(FStar_All.pipe_right (id_edge i) (fun _146_823 -> Some (_146_823)))
end else begin
(FStar_All.pipe_right order (FStar_Util.find_opt (fun e -> ((FStar_Ident.lid_equals e.msource i) && (FStar_Ident.lid_equals e.mtarget j)))))
end
end))
in (
# 649 "FStar.TypeChecker.Env.fst"
let order = (FStar_All.pipe_right ms (FStar_List.fold_left (fun order k -> (let _146_831 = (FStar_All.pipe_right ms (FStar_List.collect (fun i -> if (FStar_Ident.lid_equals i k) then begin
[]
end else begin
(FStar_All.pipe_right ms (FStar_List.collect (fun j -> if (FStar_Ident.lid_equals j k) then begin
[]
end else begin
(match ((let _146_830 = (find_edge order (i, k))
in (let _146_829 = (find_edge order (k, j))
in (_146_830, _146_829)))) with
| (Some (e1), Some (e2)) -> begin
((compose_edges e1 e2))::[]
end
| _65_980 -> begin
[]
end)
end)))
end)))
in (FStar_List.append order _146_831))) order))
in (
# 660 "FStar.TypeChecker.Env.fst"
let order = (FStar_Util.remove_dups (fun e1 e2 -> ((FStar_Ident.lid_equals e1.msource e2.msource) && (FStar_Ident.lid_equals e1.mtarget e2.mtarget))) order)
in (
# 662 "FStar.TypeChecker.Env.fst"
let joins = (FStar_All.pipe_right ms (FStar_List.collect (fun i -> (FStar_All.pipe_right ms (FStar_List.collect (fun j -> (
# 665 "FStar.TypeChecker.Env.fst"
let join_opt = (FStar_All.pipe_right ms (FStar_List.fold_left (fun bopt k -> (match ((let _146_923 = (find_edge order (i, k))
in (let _146_922 = (find_edge order (j, k))
in (_146_923, _146_922)))) with
| (Some (ik), Some (jk)) -> begin
(match (bopt) with
| None -> begin
Some ((k, ik, jk))
end
| Some (ub, _65_997, _65_999) -> begin
if ((let _146_924 = (find_edge order (k, ub))
in (FStar_Util.is_some _146_924)) && (not ((let _146_925 = (find_edge order (ub, k))
in (FStar_Util.is_some _146_925))))) then begin
Some ((k, ik, jk))
end else begin
bopt
end
end)
end
| _65_1003 -> begin
bopt
end)) None))
in (match (join_opt) with
| None -> begin
[]
end
| Some (k, e1, e2) -> begin
((i, j, k, e1.mlift, e2.mlift))::[]
end))))))))
in (
# 682 "FStar.TypeChecker.Env.fst"
let effects = (
# 682 "FStar.TypeChecker.Env.fst"
let _65_1012 = env.effects
in {decls = _65_1012.decls; order = order; joins = joins})
in (
# 685 "FStar.TypeChecker.Env.fst"
let _65_1015 = env
in {solver = _65_1015.solver; range = _65_1015.range; curmodule = _65_1015.curmodule; gamma = _65_1015.gamma; gamma_cache = _65_1015.gamma_cache; modules = _65_1015.modules; expected_typ = _65_1015.expected_typ; sigtab = _65_1015.sigtab; is_pattern = _65_1015.is_pattern; instantiate_imp = _65_1015.instantiate_imp; effects = effects; generalize = _65_1015.generalize; letrecs = _65_1015.letrecs; top_level = _65_1015.top_level; check_uvars = _65_1015.check_uvars; use_eq = _65_1015.use_eq; is_iface = _65_1015.is_iface; admit = _65_1015.admit; default_effects = _65_1015.default_effects; type_of = _65_1015.type_of; universe_of = _65_1015.universe_of; use_bv_sorts = _65_1015.use_bv_sorts})))))))))))))
end
| _65_1018 -> begin
env
end))

# 687 "FStar.TypeChecker.Env.fst"
let push_sigelt : env  ->  FStar_Syntax_Syntax.sigelt  ->  env = (fun env s -> (let _146_974 = (
# 692 "FStar.TypeChecker.Env.fst"
let _65_1021 = env
in (let _146_973 = (let _146_972 = (let _146_971 = (let _146_970 = (FStar_Syntax_Util.lids_of_sigelt s)
in (_146_970, s))
in Binding_sig (_146_971))
in (_146_972)::env.gamma)
in {solver = _65_1021.solver; range = _65_1021.range; curmodule = _65_1021.curmodule; gamma = _146_973; gamma_cache = _65_1021.gamma_cache; modules = _65_1021.modules; expected_typ = _65_1021.expected_typ; sigtab = _65_1021.sigtab; is_pattern = _65_1021.is_pattern; instantiate_imp = _65_1021.instantiate_imp; effects = _65_1021.effects; generalize = _65_1021.generalize; letrecs = _65_1021.letrecs; top_level = _65_1021.top_level; check_uvars = _65_1021.check_uvars; use_eq = _65_1021.use_eq; is_iface = _65_1021.is_iface; admit = _65_1021.admit; default_effects = _65_1021.default_effects; type_of = _65_1021.type_of; universe_of = _65_1021.universe_of; use_bv_sorts = _65_1021.use_bv_sorts}))
in (build_lattice _146_974 s)))

# 692 "FStar.TypeChecker.Env.fst"
let push_sigelt_inst : env  ->  FStar_Syntax_Syntax.sigelt  ->  FStar_Syntax_Syntax.universes  ->  env = (fun env s us -> (let _146_985 = (
# 694 "FStar.TypeChecker.Env.fst"
let _65_1026 = env
in (let _146_984 = (let _146_983 = (let _146_982 = (let _146_981 = (FStar_Syntax_Util.lids_of_sigelt s)
in (_146_981, s, us))
in Binding_sig_inst (_146_982))
in (_146_983)::env.gamma)
in {solver = _65_1026.solver; range = _65_1026.range; curmodule = _65_1026.curmodule; gamma = _146_984; gamma_cache = _65_1026.gamma_cache; modules = _65_1026.modules; expected_typ = _65_1026.expected_typ; sigtab = _65_1026.sigtab; is_pattern = _65_1026.is_pattern; instantiate_imp = _65_1026.instantiate_imp; effects = _65_1026.effects; generalize = _65_1026.generalize; letrecs = _65_1026.letrecs; top_level = _65_1026.top_level; check_uvars = _65_1026.check_uvars; use_eq = _65_1026.use_eq; is_iface = _65_1026.is_iface; admit = _65_1026.admit; default_effects = _65_1026.default_effects; type_of = _65_1026.type_of; universe_of = _65_1026.universe_of; use_bv_sorts = _65_1026.use_bv_sorts}))
in (build_lattice _146_985 s)))

# 694 "FStar.TypeChecker.Env.fst"
let push_local_binding : env  ->  binding  ->  env = (fun env b -> (
# 696 "FStar.TypeChecker.Env.fst"
let _65_1030 = env
in {solver = _65_1030.solver; range = _65_1030.range; curmodule = _65_1030.curmodule; gamma = (b)::env.gamma; gamma_cache = _65_1030.gamma_cache; modules = _65_1030.modules; expected_typ = _65_1030.expected_typ; sigtab = _65_1030.sigtab; is_pattern = _65_1030.is_pattern; instantiate_imp = _65_1030.instantiate_imp; effects = _65_1030.effects; generalize = _65_1030.generalize; letrecs = _65_1030.letrecs; top_level = _65_1030.top_level; check_uvars = _65_1030.check_uvars; use_eq = _65_1030.use_eq; is_iface = _65_1030.is_iface; admit = _65_1030.admit; default_effects = _65_1030.default_effects; type_of = _65_1030.type_of; universe_of = _65_1030.universe_of; use_bv_sorts = _65_1030.use_bv_sorts}))

# 696 "FStar.TypeChecker.Env.fst"
let push_bv : env  ->  FStar_Syntax_Syntax.bv  ->  env = (fun env x -> (push_local_binding env (Binding_var (x))))

# 698 "FStar.TypeChecker.Env.fst"
let push_binders : env  ->  FStar_Syntax_Syntax.binders  ->  env = (fun env bs -> (FStar_List.fold_left (fun env _65_1040 -> (match (_65_1040) with
| (x, _65_1039) -> begin
(push_bv env x)
end)) env bs))

# 701 "FStar.TypeChecker.Env.fst"
let binding_of_lb : FStar_Syntax_Syntax.lbname  ->  (FStar_Ident.ident Prims.list * FStar_Syntax_Syntax.term)  ->  binding = (fun x t -> (match (x) with
| FStar_Util.Inl (x) -> begin
(
# 705 "FStar.TypeChecker.Env.fst"
let _65_1045 = ()
in (
# 706 "FStar.TypeChecker.Env.fst"
let x = (
# 706 "FStar.TypeChecker.Env.fst"
let _65_1047 = x
in {FStar_Syntax_Syntax.ppname = _65_1047.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _65_1047.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = (Prims.snd t)})
in Binding_var (x)))
end
| FStar_Util.Inr (lid) -> begin
Binding_lid ((lid, t))
end))

# 709 "FStar.TypeChecker.Env.fst"
let push_let_binding : env  ->  FStar_Syntax_Syntax.lbname  ->  FStar_Syntax_Syntax.tscheme  ->  env = (fun env lb ts -> (push_local_binding env (binding_of_lb lb ts)))

# 712 "FStar.TypeChecker.Env.fst"
let push_module : env  ->  FStar_Syntax_Syntax.modul  ->  env = (fun env m -> (
# 714 "FStar.TypeChecker.Env.fst"
let _65_1057 = (add_sigelts env m.FStar_Syntax_Syntax.exports)
in (
# 715 "FStar.TypeChecker.Env.fst"
let _65_1059 = env
in {solver = _65_1059.solver; range = _65_1059.range; curmodule = _65_1059.curmodule; gamma = []; gamma_cache = _65_1059.gamma_cache; modules = (m)::env.modules; expected_typ = None; sigtab = _65_1059.sigtab; is_pattern = _65_1059.is_pattern; instantiate_imp = _65_1059.instantiate_imp; effects = _65_1059.effects; generalize = _65_1059.generalize; letrecs = _65_1059.letrecs; top_level = _65_1059.top_level; check_uvars = _65_1059.check_uvars; use_eq = _65_1059.use_eq; is_iface = _65_1059.is_iface; admit = _65_1059.admit; default_effects = _65_1059.default_effects; type_of = _65_1059.type_of; universe_of = _65_1059.universe_of; use_bv_sorts = _65_1059.use_bv_sorts})))

# 718 "FStar.TypeChecker.Env.fst"
let push_univ_vars : env  ->  FStar_Syntax_Syntax.univ_names  ->  env = (fun env xs -> (FStar_List.fold_left (fun env x -> (push_local_binding env (Binding_univ (x)))) env xs))

# 721 "FStar.TypeChecker.Env.fst"
let set_expected_typ : env  ->  FStar_Syntax_Syntax.typ  ->  env = (fun env t -> (
# 724 "FStar.TypeChecker.Env.fst"
let _65_1067 = env
in {solver = _65_1067.solver; range = _65_1067.range; curmodule = _65_1067.curmodule; gamma = _65_1067.gamma; gamma_cache = _65_1067.gamma_cache; modules = _65_1067.modules; expected_typ = Some (t); sigtab = _65_1067.sigtab; is_pattern = _65_1067.is_pattern; instantiate_imp = _65_1067.instantiate_imp; effects = _65_1067.effects; generalize = _65_1067.generalize; letrecs = _65_1067.letrecs; top_level = _65_1067.top_level; check_uvars = _65_1067.check_uvars; use_eq = false; is_iface = _65_1067.is_iface; admit = _65_1067.admit; default_effects = _65_1067.default_effects; type_of = _65_1067.type_of; universe_of = _65_1067.universe_of; use_bv_sorts = _65_1067.use_bv_sorts}))

# 724 "FStar.TypeChecker.Env.fst"
let expected_typ : env  ->  FStar_Syntax_Syntax.typ Prims.option = (fun env -> (match (env.expected_typ) with
| None -> begin
None
end
| Some (t) -> begin
Some (t)
end))

# 728 "FStar.TypeChecker.Env.fst"
let clear_expected_typ : env  ->  (env * FStar_Syntax_Syntax.typ Prims.option) = (fun env -> (let _146_1028 = (expected_typ env)
in ((
# 731 "FStar.TypeChecker.Env.fst"
let _65_1074 = env
in {solver = _65_1074.solver; range = _65_1074.range; curmodule = _65_1074.curmodule; gamma = _65_1074.gamma; gamma_cache = _65_1074.gamma_cache; modules = _65_1074.modules; expected_typ = None; sigtab = _65_1074.sigtab; is_pattern = _65_1074.is_pattern; instantiate_imp = _65_1074.instantiate_imp; effects = _65_1074.effects; generalize = _65_1074.generalize; letrecs = _65_1074.letrecs; top_level = _65_1074.top_level; check_uvars = _65_1074.check_uvars; use_eq = false; is_iface = _65_1074.is_iface; admit = _65_1074.admit; default_effects = _65_1074.default_effects; type_of = _65_1074.type_of; universe_of = _65_1074.universe_of; use_bv_sorts = _65_1074.use_bv_sorts}), _146_1028)))

# 731 "FStar.TypeChecker.Env.fst"
let finish_module : env  ->  FStar_Syntax_Syntax.modul  ->  env = (
# 734 "FStar.TypeChecker.Env.fst"
let empty_lid = (FStar_Ident.lid_of_ids (((FStar_Ident.id_of_text ""))::[]))
in (fun env m -> (
# 736 "FStar.TypeChecker.Env.fst"
let sigs = if (FStar_Ident.lid_equals m.FStar_Syntax_Syntax.name FStar_Syntax_Const.prims_lid) then begin
(FStar_All.pipe_right env.gamma (FStar_List.collect (fun _65_10 -> (match (_65_10) with
| Binding_sig (_65_1081, se) -> begin
(se)::[]
end
| _65_1086 -> begin
[]
end))))
end else begin
m.FStar_Syntax_Syntax.exports
end
in (
# 742 "FStar.TypeChecker.Env.fst"
let _65_1088 = (add_sigelts env sigs)
in (
# 743 "FStar.TypeChecker.Env.fst"
let _65_1090 = (FStar_Util.smap_clear env.gamma_cache)
in (
# 744 "FStar.TypeChecker.Env.fst"
let _65_1092 = env
in {solver = _65_1092.solver; range = _65_1092.range; curmodule = empty_lid; gamma = []; gamma_cache = _65_1092.gamma_cache; modules = (m)::env.modules; expected_typ = _65_1092.expected_typ; sigtab = _65_1092.sigtab; is_pattern = _65_1092.is_pattern; instantiate_imp = _65_1092.instantiate_imp; effects = _65_1092.effects; generalize = _65_1092.generalize; letrecs = _65_1092.letrecs; top_level = _65_1092.top_level; check_uvars = _65_1092.check_uvars; use_eq = _65_1092.use_eq; is_iface = _65_1092.is_iface; admit = _65_1092.admit; default_effects = _65_1092.default_effects; type_of = _65_1092.type_of; universe_of = _65_1092.universe_of; use_bv_sorts = _65_1092.use_bv_sorts}))))))

# 747 "FStar.TypeChecker.Env.fst"
let uvars_in_env : env  ->  FStar_Syntax_Syntax.uvars = (fun env -> (
# 753 "FStar.TypeChecker.Env.fst"
let no_uvs = (FStar_Syntax_Syntax.new_uv_set ())
in (
# 754 "FStar.TypeChecker.Env.fst"
let ext = (fun out uvs -> (FStar_Util.set_union out uvs))
in (
# 755 "FStar.TypeChecker.Env.fst"
let rec aux = (fun out g -> (match (g) with
| [] -> begin
out
end
| Binding_univ (_65_1105)::tl -> begin
(aux out tl)
end
| (Binding_lid (_, (_, t))::tl) | (Binding_var ({FStar_Syntax_Syntax.ppname = _; FStar_Syntax_Syntax.index = _; FStar_Syntax_Syntax.sort = t})::tl) -> begin
(let _146_1045 = (let _146_1044 = (FStar_Syntax_Free.uvars t)
in (ext out _146_1044))
in (aux _146_1045 tl))
end
| (Binding_sig (_)::_) | (Binding_sig_inst (_)::_) -> begin
out
end))
in (aux no_uvs env.gamma)))))

# 762 "FStar.TypeChecker.Env.fst"
let univ_vars : env  ->  FStar_Syntax_Syntax.universe_uvar FStar_Util.set = (fun env -> (
# 765 "FStar.TypeChecker.Env.fst"
let no_univs = FStar_Syntax_Syntax.no_universe_uvars
in (
# 766 "FStar.TypeChecker.Env.fst"
let ext = (fun out uvs -> (FStar_Util.set_union out uvs))
in (
# 767 "FStar.TypeChecker.Env.fst"
let rec aux = (fun out g -> (match (g) with
| [] -> begin
out
end
| (Binding_sig_inst (_)::tl) | (Binding_univ (_)::tl) -> begin
(aux out tl)
end
| (Binding_lid (_, (_, t))::tl) | (Binding_var ({FStar_Syntax_Syntax.ppname = _; FStar_Syntax_Syntax.index = _; FStar_Syntax_Syntax.sort = t})::tl) -> begin
(let _146_1057 = (let _146_1056 = (FStar_Syntax_Free.univs t)
in (ext out _146_1056))
in (aux _146_1057 tl))
end
| Binding_sig (_65_1175)::_65_1173 -> begin
out
end))
in (aux no_univs env.gamma)))))

# 774 "FStar.TypeChecker.Env.fst"
let bound_vars_of_bindings : binding Prims.list  ->  FStar_Syntax_Syntax.bv Prims.list = (fun bs -> (FStar_All.pipe_right bs (FStar_List.collect (fun _65_11 -> (match (_65_11) with
| Binding_var (x) -> begin
(x)::[]
end
| (Binding_lid (_)) | (Binding_sig (_)) | (Binding_univ (_)) | (Binding_sig_inst (_)) -> begin
[]
end)))))

# 782 "FStar.TypeChecker.Env.fst"
let binders_of_bindings : binding Prims.list  ->  FStar_Syntax_Syntax.binders = (fun bs -> (let _146_1064 = (let _146_1063 = (bound_vars_of_bindings bs)
in (FStar_All.pipe_right _146_1063 (FStar_List.map FStar_Syntax_Syntax.mk_binder)))
in (FStar_All.pipe_right _146_1064 FStar_List.rev)))

# 784 "FStar.TypeChecker.Env.fst"
let bound_vars : env  ->  FStar_Syntax_Syntax.bv Prims.list = (fun env -> (bound_vars_of_bindings env.gamma))

# 786 "FStar.TypeChecker.Env.fst"
let all_binders : env  ->  FStar_Syntax_Syntax.binders = (fun env -> (binders_of_bindings env.gamma))

# 788 "FStar.TypeChecker.Env.fst"
let fold_env = (fun env f a -> (FStar_List.fold_right (fun e a -> (f a e)) env.gamma a))

# 790 "FStar.TypeChecker.Env.fst"
let lidents : env  ->  FStar_Ident.lident Prims.list = (fun env -> (
# 793 "FStar.TypeChecker.Env.fst"
let keys = (FStar_List.fold_left (fun keys _65_12 -> (match (_65_12) with
| Binding_sig (lids, _65_1207) -> begin
(FStar_List.append lids keys)
end
| _65_1211 -> begin
keys
end)) [] env.gamma)
in (let _146_1088 = (sigtab env)
in (FStar_Util.smap_fold _146_1088 (fun _65_1213 v keys -> (let _146_1087 = (FStar_Syntax_Util.lids_of_sigelt v)
in (FStar_List.append _146_1087 keys))) keys))))

# 796 "FStar.TypeChecker.Env.fst"
let dummy_solver : solver_t = {init = (fun _65_1217 -> ()); push = (fun _65_1219 -> ()); pop = (fun _65_1221 -> ()); mark = (fun _65_1223 -> ()); reset_mark = (fun _65_1225 -> ()); commit_mark = (fun _65_1227 -> ()); encode_modul = (fun _65_1229 _65_1231 -> ()); encode_sig = (fun _65_1233 _65_1235 -> ()); solve = (fun _65_1237 _65_1239 -> ()); is_trivial = (fun _65_1241 _65_1243 -> false); finish = (fun _65_1245 -> ()); refresh = (fun _65_1246 -> ())}

# 813 "FStar.TypeChecker.Env.fst"
let no_solver_env : (env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ * guard_t))  ->  env = (fun tc -> (let _146_1117 = (FStar_Ident.lid_of_path (("dummy")::[]) FStar_Range.dummyRange)
in (initial_env tc dummy_solver _146_1117)))




