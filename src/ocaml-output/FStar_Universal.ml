
open Prims

let module_or_interface_name : FStar_Syntax_Syntax.modul  ->  (Prims.bool * FStar_Ident.lident) = (fun m -> ((m.FStar_Syntax_Syntax.is_interface), (m.FStar_Syntax_Syntax.name)))


let parse : FStar_Parser_Env.env  ->  Prims.string Prims.option  ->  Prims.string  ->  (FStar_Parser_Env.env * FStar_Syntax_Syntax.modul Prims.list) = (fun env pre_fn fn -> (

let ast = (FStar_Parser_Driver.parse_file fn)
in (

let ast = (match (pre_fn) with
| None -> begin
ast
end
| Some (pre_fn) -> begin
(

let pre_ast = (FStar_Parser_Driver.parse_file pre_fn)
in (match (((pre_ast), (ast))) with
| ((FStar_Parser_AST.Interface (lid1, decls1, _95_13))::[], (FStar_Parser_AST.Module (lid2, decls2))::[]) when (FStar_Ident.lid_equals lid1 lid2) -> begin
(let _192_11 = (let _192_10 = (let _192_9 = (FStar_Parser_Interleave.interleave decls1 decls2)
in ((lid1), (_192_9)))
in FStar_Parser_AST.Module (_192_10))
in (_192_11)::[])
end
| _95_24 -> begin
(Prims.raise (FStar_Syntax_Syntax.Err ("mismatch between pre-module and module\n")))
end))
end)
in (FStar_Parser_ToSyntax.desugar_file env ast))))


let tc_prims : Prims.unit  ->  ((FStar_Syntax_Syntax.modul * Prims.int) * FStar_Parser_Env.env * FStar_TypeChecker_Env.env) = (fun _95_26 -> (match (()) with
| () -> begin
(

let solver = if (FStar_Options.lax ()) then begin
FStar_SMTEncoding_Solver.dummy
end else begin
FStar_SMTEncoding_Solver.solver
end
in (

let env = (FStar_TypeChecker_Env.initial_env FStar_TypeChecker_TcTerm.type_of_tot_term FStar_TypeChecker_TcTerm.universe_of solver FStar_Syntax_Const.prims_lid)
in (

let _95_29 = (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.init env)
in (

let prims_filename = (FStar_Options.prims ())
in (

let _95_34 = (let _192_14 = (FStar_Parser_Env.empty_env ())
in (parse _192_14 None prims_filename))
in (match (_95_34) with
| (dsenv, prims_mod) -> begin
(

let _95_40 = (FStar_Util.record_time (fun _95_35 -> (match (()) with
| () -> begin
(let _192_16 = (FStar_List.hd prims_mod)
in (FStar_TypeChecker_Tc.check_module env _192_16))
end)))
in (match (_95_40) with
| ((prims_mod, env), elapsed_time) -> begin
((((prims_mod), (elapsed_time))), (dsenv), (env))
end))
end))))))
end))


let tc_one_fragment : FStar_Syntax_Syntax.modul Prims.option  ->  FStar_Parser_Env.env  ->  FStar_TypeChecker_Env.env  ->  FStar_Parser_ParseIt.input_frag  ->  (FStar_Syntax_Syntax.modul Prims.option * FStar_Parser_Env.env * FStar_TypeChecker_Env.env) Prims.option = (fun curmod dsenv env frag -> try
(match (()) with
| () -> begin
(match ((FStar_Parser_Driver.parse_fragment frag)) with
| FStar_Parser_Driver.Empty -> begin
Some (((curmod), (dsenv), (env)))
end
| FStar_Parser_Driver.Modul (ast_modul) -> begin
(

let _95_66 = (FStar_Parser_ToSyntax.desugar_partial_modul curmod dsenv ast_modul)
in (match (_95_66) with
| (dsenv, modul) -> begin
(

let env = (match (curmod) with
| None -> begin
env
end
| Some (_95_69) -> begin
(Prims.raise (FStar_Syntax_Syntax.Err ("Interactive mode only supports a single module at the top-level")))
end)
in (

let _95_76 = (FStar_TypeChecker_Tc.tc_partial_modul env modul)
in (match (_95_76) with
| (modul, _95_74, env) -> begin
Some (((Some (modul)), (dsenv), (env)))
end)))
end))
end
| FStar_Parser_Driver.Decls (ast_decls) -> begin
(

let _95_81 = (FStar_Parser_ToSyntax.desugar_decls dsenv ast_decls)
in (match (_95_81) with
| (dsenv, decls) -> begin
(match (curmod) with
| None -> begin
(

let _95_83 = (FStar_Util.print_error "fragment without an enclosing module")
in (FStar_All.exit (Prims.parse_int "1")))
end
| Some (modul) -> begin
(

let _95_91 = (FStar_TypeChecker_Tc.tc_more_partial_modul env modul decls)
in (match (_95_91) with
| (modul, _95_89, env) -> begin
Some (((Some (modul)), (dsenv), (env)))
end))
end)
end))
end)
end)
with
| FStar_Syntax_Syntax.Error (msg, r) when (not ((FStar_Options.trace_error ()))) -> begin
(

let _95_52 = (FStar_TypeChecker_Errors.add_errors env ((((msg), (r)))::[]))
in None)
end
| FStar_Syntax_Syntax.Err (msg) when (not ((FStar_Options.trace_error ()))) -> begin
(

let _95_56 = (FStar_TypeChecker_Errors.add_errors env ((((msg), (FStar_Range.dummyRange)))::[]))
in None)
end
| e when (not ((FStar_Options.trace_error ()))) -> begin
(Prims.raise e)
end)


let tc_one_file : FStar_Parser_Env.env  ->  FStar_TypeChecker_Env.env  ->  Prims.string Prims.option  ->  Prims.string  ->  ((FStar_Syntax_Syntax.modul * Prims.int) Prims.list * FStar_Parser_Env.env * FStar_TypeChecker_Env.env) = (fun dsenv env pre_fn fn -> (

let _95_98 = (parse dsenv pre_fn fn)
in (match (_95_98) with
| (dsenv, fmods) -> begin
(

let check_mods = (fun _95_100 -> (match (()) with
| () -> begin
(

let _95_113 = (FStar_All.pipe_right fmods (FStar_List.fold_left (fun _95_103 m -> (match (_95_103) with
| (env, all_mods) -> begin
(

let _95_110 = (FStar_Util.record_time (fun _95_105 -> (match (()) with
| () -> begin
(FStar_TypeChecker_Tc.check_module env m)
end)))
in (match (_95_110) with
| ((m, env), elapsed_ms) -> begin
((env), ((((m), (elapsed_ms)))::all_mods))
end))
end)) ((env), ([]))))
in (match (_95_113) with
| (env, all_mods) -> begin
(((FStar_List.rev all_mods)), (dsenv), (env))
end))
end))
in (match (fmods) with
| (m)::[] when ((FStar_Options.should_verify m.FStar_Syntax_Syntax.name.FStar_Ident.str) && ((FStar_Options.record_hints ()) || (FStar_Options.use_hints ()))) -> begin
(FStar_SMTEncoding_Solver.with_hints_db fn check_mods)
end
| _95_117 -> begin
(check_mods ())
end))
end)))


let needs_interleaving : Prims.string  ->  Prims.string  ->  Prims.bool = (fun intf impl -> (

let m1 = (FStar_Parser_Dep.lowercase_module_name intf)
in (

let m2 = (FStar_Parser_Dep.lowercase_module_name impl)
in (((m1 = m2) && ((FStar_Util.get_file_extension intf) = "fsti")) && ((FStar_Util.get_file_extension impl) = "fst")))))


let pop_context : (FStar_Parser_Env.env * FStar_TypeChecker_Env.env)  ->  Prims.string  ->  Prims.unit = (fun _95_124 msg -> (match (_95_124) with
| (dsenv, env) -> begin
(

let _95_126 = (let _192_48 = (FStar_Parser_Env.pop dsenv)
in (FStar_All.pipe_right _192_48 Prims.ignore))
in (

let _95_128 = (let _192_49 = (FStar_TypeChecker_Env.pop env msg)
in (FStar_All.pipe_right _192_49 Prims.ignore))
in (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.refresh ())))
end))


let push_context : (FStar_Parser_Env.env * FStar_TypeChecker_Env.env)  ->  Prims.string  ->  (FStar_Parser_Env.env * FStar_TypeChecker_Env.env) = (fun _95_132 msg -> (match (_95_132) with
| (dsenv, env) -> begin
(

let dsenv = (FStar_Parser_Env.push dsenv)
in (

let env = (FStar_TypeChecker_Env.push env msg)
in ((dsenv), (env))))
end))


let tc_one_file_and_intf : Prims.string Prims.option  ->  Prims.string  ->  FStar_Parser_Env.env  ->  FStar_TypeChecker_Env.env  ->  ((FStar_Syntax_Syntax.modul * Prims.int) Prims.list * FStar_Parser_Env.env * FStar_TypeChecker_Env.env) = (fun intf impl dsenv env -> (

let _95_140 = (FStar_Syntax_Syntax.reset_gensym ())
in (match (intf) with
| None -> begin
(tc_one_file dsenv env None impl)
end
| Some (_95_144) when ((FStar_Options.codegen ()) <> None) -> begin
(

let _95_146 = if (not ((FStar_Options.lax ()))) then begin
(Prims.raise (FStar_Syntax_Syntax.Err ("Verification and code generation are no supported together with partial modules (i.e, *.fsti); use --lax to extract code separately")))
end else begin
()
end
in (tc_one_file dsenv env intf impl))
end
| Some (iname) -> begin
(

let _95_150 = if (FStar_Options.debug_any ()) then begin
(FStar_Util.print1 "Interleaving iface+module: %s\n" iname)
end else begin
()
end
in (

let caption = (Prims.strcat "interface: " iname)
in (

let _95_155 = (push_context ((dsenv), (env)) caption)
in (match (_95_155) with
| (dsenv', env') -> begin
(

let _95_160 = (tc_one_file dsenv' env' intf impl)
in (match (_95_160) with
| (_95_157, dsenv', env') -> begin
(

let _95_161 = (pop_context ((dsenv'), (env')) caption)
in (tc_one_file dsenv env None iname))
end))
end))))
end)))


type uenv =
(FStar_Parser_Env.env * FStar_TypeChecker_Env.env)


let tc_one_file_from_remaining : Prims.string Prims.list  ->  uenv  ->  (Prims.string Prims.list * (FStar_Syntax_Syntax.modul * Prims.int) Prims.list * (FStar_Parser_Env.env * FStar_TypeChecker_Env.env)) = (fun remaining uenv -> (

let _95_167 = uenv
in (match (_95_167) with
| (dsenv, env) -> begin
(

let _95_182 = (match (remaining) with
| (intf)::(impl)::remaining when (needs_interleaving intf impl) -> begin
(let _192_66 = (tc_one_file_and_intf (Some (intf)) impl dsenv env)
in ((remaining), (_192_66)))
end
| (intf_or_impl)::remaining -> begin
(let _192_67 = (tc_one_file_and_intf None intf_or_impl dsenv env)
in ((remaining), (_192_67)))
end
| [] -> begin
(([]), ((([]), (dsenv), (env))))
end)
in (match (_95_182) with
| (remaining, (nmods, dsenv, env)) -> begin
((remaining), (nmods), (((dsenv), (env))))
end))
end)))


let rec tc_fold_interleave : ((FStar_Syntax_Syntax.modul * Prims.int) Prims.list * uenv)  ->  Prims.string Prims.list  ->  ((FStar_Syntax_Syntax.modul * Prims.int) Prims.list * uenv) = (fun acc remaining -> (match (remaining) with
| [] -> begin
acc
end
| _95_187 -> begin
(

let _95_190 = acc
in (match (_95_190) with
| (mods, uenv) -> begin
(

let _95_196 = (tc_one_file_from_remaining remaining uenv)
in (match (_95_196) with
| (remaining, nmods, (dsenv, env)) -> begin
(tc_fold_interleave (((FStar_List.append mods nmods)), (((dsenv), (env)))) remaining)
end))
end))
end))


let batch_mode_tc_no_prims : FStar_Parser_Env.env  ->  FStar_TypeChecker_Env.env  ->  Prims.string Prims.list  ->  ((FStar_Syntax_Syntax.modul * Prims.int) Prims.list * FStar_Parser_Env.env * FStar_TypeChecker_Env.env) = (fun dsenv env filenames -> (

let _95_204 = (tc_fold_interleave (([]), (((dsenv), (env)))) filenames)
in (match (_95_204) with
| (all_mods, (dsenv, env)) -> begin
(

let _95_205 = if ((FStar_Options.interactive ()) && ((FStar_TypeChecker_Errors.get_err_count ()) = (Prims.parse_int "0"))) then begin
(env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.refresh ())
end else begin
(env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.finish ())
end
in ((all_mods), (dsenv), (env)))
end)))


let batch_mode_tc : Prims.string Prims.list  ->  ((FStar_Syntax_Syntax.modul * Prims.int) Prims.list * FStar_Parser_Env.env * FStar_TypeChecker_Env.env) = (fun filenames -> (

let _95_211 = (tc_prims ())
in (match (_95_211) with
| (prims_mod, dsenv, env) -> begin
(

let _95_216 = if ((not ((FStar_Options.explicit_deps ()))) && (FStar_Options.debug_any ())) then begin
(

let _95_212 = (FStar_Util.print_endline "Auto-deps kicked in; here\'s some info.")
in (

let _95_214 = (FStar_Util.print1 "Here\'s the list of filenames we will process: %s\n" (FStar_String.concat " " filenames))
in (let _192_81 = (let _192_80 = (FStar_Options.verify_module ())
in (FStar_String.concat " " _192_80))
in (FStar_Util.print1 "Here\'s the list of modules we will verify: %s\n" _192_81))))
end else begin
()
end
in (

let _95_221 = (batch_mode_tc_no_prims dsenv env filenames)
in (match (_95_221) with
| (all_mods, dsenv, env) -> begin
(((prims_mod)::all_mods), (dsenv), (env))
end)))
end)))


let tc_prims_interactive : Prims.unit  ->  (FStar_Parser_Env.env * FStar_TypeChecker_Env.env) = (fun _95_222 -> (match (()) with
| () -> begin
(

let _95_227 = (tc_prims ())
in (match (_95_227) with
| (_95_224, dsenv, env) -> begin
((dsenv), (env))
end))
end))


let tc_one_file_interactive = (fun remaining uenv -> (

let _95_232 = uenv
in (match (_95_232) with
| (dsenv, env) -> begin
(

let _95_258 = (match (remaining) with
| (intf)::(impl)::remaining when (needs_interleaving intf impl) -> begin
(

let _95_242 = (tc_one_file_and_intf (Some (intf)) impl dsenv env)
in (match (_95_242) with
| (_95_239, dsenv, env) -> begin
((((Some (intf)), (impl))), (dsenv), (env), (remaining))
end))
end
| (intf_or_impl)::remaining -> begin
(

let _95_250 = (tc_one_file_and_intf None intf_or_impl dsenv env)
in (match (_95_250) with
| (_95_247, dsenv, env) -> begin
((((None), (intf_or_impl))), (dsenv), (env), (remaining))
end))
end
| [] -> begin
(failwith "Impossible")
end)
in (match (_95_258) with
| ((intf, impl), dsenv, env, remaining) -> begin
((((intf), (impl))), (((dsenv), (env))), (None), (remaining))
end))
end)))


let interactive_tc : ((FStar_Parser_Env.env * FStar_TypeChecker_Env.env), FStar_Syntax_Syntax.modul Prims.option) FStar_Interactive.interactive_tc = (

let pop = (fun _95_262 msg -> (match (_95_262) with
| (dsenv, env) -> begin
(

let _95_264 = (pop_context ((dsenv), (env)) msg)
in (FStar_Options.pop ()))
end))
in (

let push = (fun _95_269 lax restore_cmd_line_options msg -> (match (_95_269) with
| (dsenv, env) -> begin
(

let env = (

let _95_273 = env
in {FStar_TypeChecker_Env.solver = _95_273.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _95_273.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _95_273.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _95_273.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _95_273.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _95_273.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _95_273.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _95_273.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _95_273.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _95_273.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _95_273.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _95_273.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _95_273.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _95_273.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _95_273.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _95_273.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _95_273.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _95_273.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = lax; FStar_TypeChecker_Env.lax_universes = _95_273.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = _95_273.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _95_273.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = _95_273.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = _95_273.FStar_TypeChecker_Env.qname_and_index})
in (

let res = (push_context ((dsenv), (env)) msg)
in (

let _95_277 = (FStar_Options.push ())
in (

let _95_279 = if restore_cmd_line_options then begin
(let _192_98 = (FStar_Options.restore_cmd_line_options false)
in (FStar_All.pipe_right _192_98 Prims.ignore))
end else begin
()
end
in res))))
end))
in (

let mark = (fun _95_284 -> (match (_95_284) with
| (dsenv, env) -> begin
(

let dsenv = (FStar_Parser_Env.mark dsenv)
in (

let env = (FStar_TypeChecker_Env.mark env)
in (

let _95_287 = (FStar_Options.push ())
in ((dsenv), (env)))))
end))
in (

let reset_mark = (fun _95_292 -> (match (_95_292) with
| (dsenv, env) -> begin
(

let dsenv = (FStar_Parser_Env.reset_mark dsenv)
in (

let env = (FStar_TypeChecker_Env.reset_mark env)
in (

let _95_295 = (FStar_Options.pop ())
in ((dsenv), (env)))))
end))
in (

let cleanup = (fun _95_300 -> (match (_95_300) with
| (dsenv, env) -> begin
(FStar_TypeChecker_Env.cleanup_interactive env)
end))
in (

let commit_mark = (fun _95_304 -> (match (_95_304) with
| (dsenv, env) -> begin
(

let dsenv = (FStar_Parser_Env.commit_mark dsenv)
in (

let env = (FStar_TypeChecker_Env.commit_mark env)
in ((dsenv), (env))))
end))
in (

let check_frag = (fun _95_310 curmod text -> (match (_95_310) with
| (dsenv, env) -> begin
try
(match (()) with
| () -> begin
(match ((tc_one_fragment curmod dsenv env text)) with
| Some (m, dsenv, env) -> begin
(let _192_115 = (let _192_114 = (FStar_TypeChecker_Errors.get_err_count ())
in ((m), (((dsenv), (env))), (_192_114)))
in Some (_192_115))
end
| _95_334 -> begin
None
end)
end)
with
| FStar_Syntax_Syntax.Error (msg, r) when (not ((FStar_Options.trace_error ()))) -> begin
(

let _95_320 = (FStar_TypeChecker_Errors.add_errors env ((((msg), (r)))::[]))
in None)
end
| FStar_Syntax_Syntax.Err (msg) when (not ((FStar_Options.trace_error ()))) -> begin
(

let _95_324 = (let _192_119 = (let _192_118 = (let _192_117 = (FStar_TypeChecker_Env.get_range env)
in ((msg), (_192_117)))
in (_192_118)::[])
in (FStar_TypeChecker_Errors.add_errors env _192_119))
in None)
end
end))
in (

let report_fail = (fun _95_336 -> (match (()) with
| () -> begin
(

let _95_337 = (let _192_122 = (FStar_TypeChecker_Errors.report_all ())
in (FStar_All.pipe_right _192_122 Prims.ignore))
in (FStar_ST.op_Colon_Equals FStar_TypeChecker_Errors.num_errs (Prims.parse_int "0")))
end))
in {FStar_Interactive.pop = pop; FStar_Interactive.push = push; FStar_Interactive.mark = mark; FStar_Interactive.reset_mark = reset_mark; FStar_Interactive.commit_mark = commit_mark; FStar_Interactive.check_frag = check_frag; FStar_Interactive.report_fail = report_fail; FStar_Interactive.tc_prims = tc_prims_interactive; FStar_Interactive.tc_one_file = tc_one_file_interactive; FStar_Interactive.cleanup = cleanup}))))))))




