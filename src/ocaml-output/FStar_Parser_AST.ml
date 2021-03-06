
open Prims

type level =
| Un
| Expr
| Type
| Kind
| Formula


let is_Un = (fun _discr_ -> (match (_discr_) with
| Un (_) -> begin
true
end
| _ -> begin
false
end))


let is_Expr = (fun _discr_ -> (match (_discr_) with
| Expr (_) -> begin
true
end
| _ -> begin
false
end))


let is_Type = (fun _discr_ -> (match (_discr_) with
| Type (_) -> begin
true
end
| _ -> begin
false
end))


let is_Kind = (fun _discr_ -> (match (_discr_) with
| Kind (_) -> begin
true
end
| _ -> begin
false
end))


let is_Formula = (fun _discr_ -> (match (_discr_) with
| Formula (_) -> begin
true
end
| _ -> begin
false
end))


type imp =
| FsTypApp
| Hash
| UnivApp
| Nothing


let is_FsTypApp = (fun _discr_ -> (match (_discr_) with
| FsTypApp (_) -> begin
true
end
| _ -> begin
false
end))


let is_Hash = (fun _discr_ -> (match (_discr_) with
| Hash (_) -> begin
true
end
| _ -> begin
false
end))


let is_UnivApp = (fun _discr_ -> (match (_discr_) with
| UnivApp (_) -> begin
true
end
| _ -> begin
false
end))


let is_Nothing = (fun _discr_ -> (match (_discr_) with
| Nothing (_) -> begin
true
end
| _ -> begin
false
end))


type arg_qualifier =
| Implicit
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


type aqual =
arg_qualifier Prims.option


type let_qualifier =
| NoLetQualifier
| Rec
| Mutable


let is_NoLetQualifier = (fun _discr_ -> (match (_discr_) with
| NoLetQualifier (_) -> begin
true
end
| _ -> begin
false
end))


let is_Rec = (fun _discr_ -> (match (_discr_) with
| Rec (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mutable = (fun _discr_ -> (match (_discr_) with
| Mutable (_) -> begin
true
end
| _ -> begin
false
end))


type term' =
| Wild
| Const of FStar_Const.sconst
| Op of (Prims.string * term Prims.list)
| Tvar of FStar_Ident.ident
| Uvar of FStar_Ident.ident
| Var of FStar_Ident.lid
| Name of FStar_Ident.lid
| Projector of (FStar_Ident.lid * FStar_Ident.ident)
| Construct of (FStar_Ident.lid * (term * imp) Prims.list)
| Abs of (pattern Prims.list * term)
| App of (term * term * imp)
| Let of (let_qualifier * (pattern * term) Prims.list * term)
| LetOpen of (FStar_Ident.lid * term)
| Seq of (term * term)
| If of (term * term * term)
| Match of (term * branch Prims.list)
| TryWith of (term * branch Prims.list)
| Ascribed of (term * term)
| Record of (term Prims.option * (FStar_Ident.lid * term) Prims.list)
| Project of (term * FStar_Ident.lid)
| Product of (binder Prims.list * term)
| Sum of (binder Prims.list * term)
| QForall of (binder Prims.list * term Prims.list Prims.list * term)
| QExists of (binder Prims.list * term Prims.list Prims.list * term)
| Refine of (binder * term)
| NamedTyp of (FStar_Ident.ident * term)
| Paren of term
| Requires of (term * Prims.string Prims.option)
| Ensures of (term * Prims.string Prims.option)
| Labeled of (term * Prims.string * Prims.bool)
| Assign of (FStar_Ident.ident * term)
| Discrim of FStar_Ident.lid
| Attributes of term Prims.list 
 and term =
{tm : term'; range : FStar_Range.range; level : level} 
 and binder' =
| Variable of FStar_Ident.ident
| TVariable of FStar_Ident.ident
| Annotated of (FStar_Ident.ident * term)
| TAnnotated of (FStar_Ident.ident * term)
| NoName of term 
 and binder =
{b : binder'; brange : FStar_Range.range; blevel : level; aqual : aqual} 
 and pattern' =
| PatWild
| PatConst of FStar_Const.sconst
| PatApp of (pattern * pattern Prims.list)
| PatVar of (FStar_Ident.ident * arg_qualifier Prims.option)
| PatName of FStar_Ident.lid
| PatTvar of (FStar_Ident.ident * arg_qualifier Prims.option)
| PatList of pattern Prims.list
| PatTuple of (pattern Prims.list * Prims.bool)
| PatRecord of (FStar_Ident.lid * pattern) Prims.list
| PatAscribed of (pattern * term)
| PatOr of pattern Prims.list
| PatOp of Prims.string 
 and pattern =
{pat : pattern'; prange : FStar_Range.range} 
 and branch =
(pattern * term Prims.option * term)


let is_Wild = (fun _discr_ -> (match (_discr_) with
| Wild (_) -> begin
true
end
| _ -> begin
false
end))


let is_Const = (fun _discr_ -> (match (_discr_) with
| Const (_) -> begin
true
end
| _ -> begin
false
end))


let is_Op = (fun _discr_ -> (match (_discr_) with
| Op (_) -> begin
true
end
| _ -> begin
false
end))


let is_Tvar = (fun _discr_ -> (match (_discr_) with
| Tvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Uvar = (fun _discr_ -> (match (_discr_) with
| Uvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_Var = (fun _discr_ -> (match (_discr_) with
| Var (_) -> begin
true
end
| _ -> begin
false
end))


let is_Name = (fun _discr_ -> (match (_discr_) with
| Name (_) -> begin
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


let is_Construct = (fun _discr_ -> (match (_discr_) with
| Construct (_) -> begin
true
end
| _ -> begin
false
end))


let is_Abs = (fun _discr_ -> (match (_discr_) with
| Abs (_) -> begin
true
end
| _ -> begin
false
end))


let is_App = (fun _discr_ -> (match (_discr_) with
| App (_) -> begin
true
end
| _ -> begin
false
end))


let is_Let = (fun _discr_ -> (match (_discr_) with
| Let (_) -> begin
true
end
| _ -> begin
false
end))


let is_LetOpen = (fun _discr_ -> (match (_discr_) with
| LetOpen (_) -> begin
true
end
| _ -> begin
false
end))


let is_Seq = (fun _discr_ -> (match (_discr_) with
| Seq (_) -> begin
true
end
| _ -> begin
false
end))


let is_If = (fun _discr_ -> (match (_discr_) with
| If (_) -> begin
true
end
| _ -> begin
false
end))


let is_Match = (fun _discr_ -> (match (_discr_) with
| Match (_) -> begin
true
end
| _ -> begin
false
end))


let is_TryWith = (fun _discr_ -> (match (_discr_) with
| TryWith (_) -> begin
true
end
| _ -> begin
false
end))


let is_Ascribed = (fun _discr_ -> (match (_discr_) with
| Ascribed (_) -> begin
true
end
| _ -> begin
false
end))


let is_Record = (fun _discr_ -> (match (_discr_) with
| Record (_) -> begin
true
end
| _ -> begin
false
end))


let is_Project = (fun _discr_ -> (match (_discr_) with
| Project (_) -> begin
true
end
| _ -> begin
false
end))


let is_Product = (fun _discr_ -> (match (_discr_) with
| Product (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sum = (fun _discr_ -> (match (_discr_) with
| Sum (_) -> begin
true
end
| _ -> begin
false
end))


let is_QForall = (fun _discr_ -> (match (_discr_) with
| QForall (_) -> begin
true
end
| _ -> begin
false
end))


let is_QExists = (fun _discr_ -> (match (_discr_) with
| QExists (_) -> begin
true
end
| _ -> begin
false
end))


let is_Refine = (fun _discr_ -> (match (_discr_) with
| Refine (_) -> begin
true
end
| _ -> begin
false
end))


let is_NamedTyp = (fun _discr_ -> (match (_discr_) with
| NamedTyp (_) -> begin
true
end
| _ -> begin
false
end))


let is_Paren = (fun _discr_ -> (match (_discr_) with
| Paren (_) -> begin
true
end
| _ -> begin
false
end))


let is_Requires = (fun _discr_ -> (match (_discr_) with
| Requires (_) -> begin
true
end
| _ -> begin
false
end))


let is_Ensures = (fun _discr_ -> (match (_discr_) with
| Ensures (_) -> begin
true
end
| _ -> begin
false
end))


let is_Labeled = (fun _discr_ -> (match (_discr_) with
| Labeled (_) -> begin
true
end
| _ -> begin
false
end))


let is_Assign = (fun _discr_ -> (match (_discr_) with
| Assign (_) -> begin
true
end
| _ -> begin
false
end))


let is_Discrim = (fun _discr_ -> (match (_discr_) with
| Discrim (_) -> begin
true
end
| _ -> begin
false
end))


let is_Attributes = (fun _discr_ -> (match (_discr_) with
| Attributes (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mkterm : term  ->  Prims.bool = (Obj.magic ((fun _ -> (failwith "Not yet implemented:is_Mkterm"))))


let is_Variable = (fun _discr_ -> (match (_discr_) with
| Variable (_) -> begin
true
end
| _ -> begin
false
end))


let is_TVariable = (fun _discr_ -> (match (_discr_) with
| TVariable (_) -> begin
true
end
| _ -> begin
false
end))


let is_Annotated = (fun _discr_ -> (match (_discr_) with
| Annotated (_) -> begin
true
end
| _ -> begin
false
end))


let is_TAnnotated = (fun _discr_ -> (match (_discr_) with
| TAnnotated (_) -> begin
true
end
| _ -> begin
false
end))


let is_NoName = (fun _discr_ -> (match (_discr_) with
| NoName (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mkbinder : binder  ->  Prims.bool = (Obj.magic ((fun _ -> (failwith "Not yet implemented:is_Mkbinder"))))


let is_PatWild = (fun _discr_ -> (match (_discr_) with
| PatWild (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatConst = (fun _discr_ -> (match (_discr_) with
| PatConst (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatApp = (fun _discr_ -> (match (_discr_) with
| PatApp (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatVar = (fun _discr_ -> (match (_discr_) with
| PatVar (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatName = (fun _discr_ -> (match (_discr_) with
| PatName (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatTvar = (fun _discr_ -> (match (_discr_) with
| PatTvar (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatList = (fun _discr_ -> (match (_discr_) with
| PatList (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatTuple = (fun _discr_ -> (match (_discr_) with
| PatTuple (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatRecord = (fun _discr_ -> (match (_discr_) with
| PatRecord (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatAscribed = (fun _discr_ -> (match (_discr_) with
| PatAscribed (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatOr = (fun _discr_ -> (match (_discr_) with
| PatOr (_) -> begin
true
end
| _ -> begin
false
end))


let is_PatOp = (fun _discr_ -> (match (_discr_) with
| PatOp (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mkpattern : pattern  ->  Prims.bool = (Obj.magic ((fun _ -> (failwith "Not yet implemented:is_Mkpattern"))))


let ___Const____0 = (fun projectee -> (match (projectee) with
| Const (_61_21) -> begin
_61_21
end))


let ___Op____0 = (fun projectee -> (match (projectee) with
| Op (_61_24) -> begin
_61_24
end))


let ___Tvar____0 = (fun projectee -> (match (projectee) with
| Tvar (_61_27) -> begin
_61_27
end))


let ___Uvar____0 = (fun projectee -> (match (projectee) with
| Uvar (_61_30) -> begin
_61_30
end))


let ___Var____0 = (fun projectee -> (match (projectee) with
| Var (_61_33) -> begin
_61_33
end))


let ___Name____0 = (fun projectee -> (match (projectee) with
| Name (_61_36) -> begin
_61_36
end))


let ___Projector____0 = (fun projectee -> (match (projectee) with
| Projector (_61_39) -> begin
_61_39
end))


let ___Construct____0 = (fun projectee -> (match (projectee) with
| Construct (_61_42) -> begin
_61_42
end))


let ___Abs____0 = (fun projectee -> (match (projectee) with
| Abs (_61_45) -> begin
_61_45
end))


let ___App____0 = (fun projectee -> (match (projectee) with
| App (_61_48) -> begin
_61_48
end))


let ___Let____0 = (fun projectee -> (match (projectee) with
| Let (_61_51) -> begin
_61_51
end))


let ___LetOpen____0 = (fun projectee -> (match (projectee) with
| LetOpen (_61_54) -> begin
_61_54
end))


let ___Seq____0 = (fun projectee -> (match (projectee) with
| Seq (_61_57) -> begin
_61_57
end))


let ___If____0 = (fun projectee -> (match (projectee) with
| If (_61_60) -> begin
_61_60
end))


let ___Match____0 = (fun projectee -> (match (projectee) with
| Match (_61_63) -> begin
_61_63
end))


let ___TryWith____0 = (fun projectee -> (match (projectee) with
| TryWith (_61_66) -> begin
_61_66
end))


let ___Ascribed____0 = (fun projectee -> (match (projectee) with
| Ascribed (_61_69) -> begin
_61_69
end))


let ___Record____0 = (fun projectee -> (match (projectee) with
| Record (_61_72) -> begin
_61_72
end))


let ___Project____0 = (fun projectee -> (match (projectee) with
| Project (_61_75) -> begin
_61_75
end))


let ___Product____0 = (fun projectee -> (match (projectee) with
| Product (_61_78) -> begin
_61_78
end))


let ___Sum____0 = (fun projectee -> (match (projectee) with
| Sum (_61_81) -> begin
_61_81
end))


let ___QForall____0 = (fun projectee -> (match (projectee) with
| QForall (_61_84) -> begin
_61_84
end))


let ___QExists____0 = (fun projectee -> (match (projectee) with
| QExists (_61_87) -> begin
_61_87
end))


let ___Refine____0 = (fun projectee -> (match (projectee) with
| Refine (_61_90) -> begin
_61_90
end))


let ___NamedTyp____0 = (fun projectee -> (match (projectee) with
| NamedTyp (_61_93) -> begin
_61_93
end))


let ___Paren____0 = (fun projectee -> (match (projectee) with
| Paren (_61_96) -> begin
_61_96
end))


let ___Requires____0 = (fun projectee -> (match (projectee) with
| Requires (_61_99) -> begin
_61_99
end))


let ___Ensures____0 = (fun projectee -> (match (projectee) with
| Ensures (_61_102) -> begin
_61_102
end))


let ___Labeled____0 = (fun projectee -> (match (projectee) with
| Labeled (_61_105) -> begin
_61_105
end))


let ___Assign____0 = (fun projectee -> (match (projectee) with
| Assign (_61_108) -> begin
_61_108
end))


let ___Discrim____0 = (fun projectee -> (match (projectee) with
| Discrim (_61_111) -> begin
_61_111
end))


let ___Attributes____0 = (fun projectee -> (match (projectee) with
| Attributes (_61_114) -> begin
_61_114
end))


let ___Variable____0 = (fun projectee -> (match (projectee) with
| Variable (_61_118) -> begin
_61_118
end))


let ___TVariable____0 = (fun projectee -> (match (projectee) with
| TVariable (_61_121) -> begin
_61_121
end))


let ___Annotated____0 = (fun projectee -> (match (projectee) with
| Annotated (_61_124) -> begin
_61_124
end))


let ___TAnnotated____0 = (fun projectee -> (match (projectee) with
| TAnnotated (_61_127) -> begin
_61_127
end))


let ___NoName____0 = (fun projectee -> (match (projectee) with
| NoName (_61_130) -> begin
_61_130
end))


let ___PatConst____0 = (fun projectee -> (match (projectee) with
| PatConst (_61_134) -> begin
_61_134
end))


let ___PatApp____0 = (fun projectee -> (match (projectee) with
| PatApp (_61_137) -> begin
_61_137
end))


let ___PatVar____0 = (fun projectee -> (match (projectee) with
| PatVar (_61_140) -> begin
_61_140
end))


let ___PatName____0 = (fun projectee -> (match (projectee) with
| PatName (_61_143) -> begin
_61_143
end))


let ___PatTvar____0 = (fun projectee -> (match (projectee) with
| PatTvar (_61_146) -> begin
_61_146
end))


let ___PatList____0 = (fun projectee -> (match (projectee) with
| PatList (_61_149) -> begin
_61_149
end))


let ___PatTuple____0 = (fun projectee -> (match (projectee) with
| PatTuple (_61_152) -> begin
_61_152
end))


let ___PatRecord____0 = (fun projectee -> (match (projectee) with
| PatRecord (_61_155) -> begin
_61_155
end))


let ___PatAscribed____0 = (fun projectee -> (match (projectee) with
| PatAscribed (_61_158) -> begin
_61_158
end))


let ___PatOr____0 = (fun projectee -> (match (projectee) with
| PatOr (_61_161) -> begin
_61_161
end))


let ___PatOp____0 = (fun projectee -> (match (projectee) with
| PatOp (_61_164) -> begin
_61_164
end))


type knd =
term


type typ =
term


type expr =
term


type fsdoc =
(Prims.string * (Prims.string * Prims.string) Prims.list)


type tycon =
| TyconAbstract of (FStar_Ident.ident * binder Prims.list * knd Prims.option)
| TyconAbbrev of (FStar_Ident.ident * binder Prims.list * knd Prims.option * term)
| TyconRecord of (FStar_Ident.ident * binder Prims.list * knd Prims.option * (FStar_Ident.ident * term * fsdoc Prims.option) Prims.list)
| TyconVariant of (FStar_Ident.ident * binder Prims.list * knd Prims.option * (FStar_Ident.ident * term Prims.option * fsdoc Prims.option * Prims.bool) Prims.list)


let is_TyconAbstract = (fun _discr_ -> (match (_discr_) with
| TyconAbstract (_) -> begin
true
end
| _ -> begin
false
end))


let is_TyconAbbrev = (fun _discr_ -> (match (_discr_) with
| TyconAbbrev (_) -> begin
true
end
| _ -> begin
false
end))


let is_TyconRecord = (fun _discr_ -> (match (_discr_) with
| TyconRecord (_) -> begin
true
end
| _ -> begin
false
end))


let is_TyconVariant = (fun _discr_ -> (match (_discr_) with
| TyconVariant (_) -> begin
true
end
| _ -> begin
false
end))


let ___TyconAbstract____0 = (fun projectee -> (match (projectee) with
| TyconAbstract (_61_168) -> begin
_61_168
end))


let ___TyconAbbrev____0 = (fun projectee -> (match (projectee) with
| TyconAbbrev (_61_171) -> begin
_61_171
end))


let ___TyconRecord____0 = (fun projectee -> (match (projectee) with
| TyconRecord (_61_174) -> begin
_61_174
end))


let ___TyconVariant____0 = (fun projectee -> (match (projectee) with
| TyconVariant (_61_177) -> begin
_61_177
end))


type qualifier =
| Private
| Abstract
| Noeq
| Unopteq
| Assumption
| DefaultEffect
| TotalEffect
| Effect
| New
| Inline
| Visible
| Unfold_for_unification_and_vcgen
| Inline_for_extraction
| Irreducible
| NoExtract
| Reifiable
| Reflectable
| Opaque
| Logic


let is_Private = (fun _discr_ -> (match (_discr_) with
| Private (_) -> begin
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


let is_Noeq = (fun _discr_ -> (match (_discr_) with
| Noeq (_) -> begin
true
end
| _ -> begin
false
end))


let is_Unopteq = (fun _discr_ -> (match (_discr_) with
| Unopteq (_) -> begin
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


let is_Effect = (fun _discr_ -> (match (_discr_) with
| Effect (_) -> begin
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


let is_Inline = (fun _discr_ -> (match (_discr_) with
| Inline (_) -> begin
true
end
| _ -> begin
false
end))


let is_Visible = (fun _discr_ -> (match (_discr_) with
| Visible (_) -> begin
true
end
| _ -> begin
false
end))


let is_Unfold_for_unification_and_vcgen = (fun _discr_ -> (match (_discr_) with
| Unfold_for_unification_and_vcgen (_) -> begin
true
end
| _ -> begin
false
end))


let is_Inline_for_extraction = (fun _discr_ -> (match (_discr_) with
| Inline_for_extraction (_) -> begin
true
end
| _ -> begin
false
end))


let is_Irreducible = (fun _discr_ -> (match (_discr_) with
| Irreducible (_) -> begin
true
end
| _ -> begin
false
end))


let is_NoExtract = (fun _discr_ -> (match (_discr_) with
| NoExtract (_) -> begin
true
end
| _ -> begin
false
end))


let is_Reifiable = (fun _discr_ -> (match (_discr_) with
| Reifiable (_) -> begin
true
end
| _ -> begin
false
end))


let is_Reflectable = (fun _discr_ -> (match (_discr_) with
| Reflectable (_) -> begin
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


type qualifiers =
qualifier Prims.list


type attributes_ =
term Prims.list


type decoration =
| Qualifier of qualifier
| DeclAttributes of term Prims.list
| Doc of fsdoc


let is_Qualifier = (fun _discr_ -> (match (_discr_) with
| Qualifier (_) -> begin
true
end
| _ -> begin
false
end))


let is_DeclAttributes = (fun _discr_ -> (match (_discr_) with
| DeclAttributes (_) -> begin
true
end
| _ -> begin
false
end))


let is_Doc = (fun _discr_ -> (match (_discr_) with
| Doc (_) -> begin
true
end
| _ -> begin
false
end))


let ___Qualifier____0 = (fun projectee -> (match (projectee) with
| Qualifier (_61_180) -> begin
_61_180
end))


let ___DeclAttributes____0 = (fun projectee -> (match (projectee) with
| DeclAttributes (_61_183) -> begin
_61_183
end))


let ___Doc____0 = (fun projectee -> (match (projectee) with
| Doc (_61_186) -> begin
_61_186
end))


type lift_op =
| NonReifiableLift of term
| ReifiableLift of (term * term)
| LiftForFree of term


let is_NonReifiableLift = (fun _discr_ -> (match (_discr_) with
| NonReifiableLift (_) -> begin
true
end
| _ -> begin
false
end))


let is_ReifiableLift = (fun _discr_ -> (match (_discr_) with
| ReifiableLift (_) -> begin
true
end
| _ -> begin
false
end))


let is_LiftForFree = (fun _discr_ -> (match (_discr_) with
| LiftForFree (_) -> begin
true
end
| _ -> begin
false
end))


let ___NonReifiableLift____0 = (fun projectee -> (match (projectee) with
| NonReifiableLift (_61_189) -> begin
_61_189
end))


let ___ReifiableLift____0 = (fun projectee -> (match (projectee) with
| ReifiableLift (_61_192) -> begin
_61_192
end))


let ___LiftForFree____0 = (fun projectee -> (match (projectee) with
| LiftForFree (_61_195) -> begin
_61_195
end))


type lift =
{msource : FStar_Ident.lid; mdest : FStar_Ident.lid; lift_op : lift_op}


let is_Mklift : lift  ->  Prims.bool = (Obj.magic ((fun _ -> (failwith "Not yet implemented:is_Mklift"))))


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
| SetOptions (_61_202) -> begin
_61_202
end))


let ___ResetOptions____0 = (fun projectee -> (match (projectee) with
| ResetOptions (_61_205) -> begin
_61_205
end))


type decl' =
| TopLevelModule of FStar_Ident.lid
| Open of FStar_Ident.lid
| ModuleAbbrev of (FStar_Ident.ident * FStar_Ident.lid)
| TopLevelLet of (let_qualifier * (pattern * term) Prims.list)
| Main of term
| Tycon of (Prims.bool * (tycon * fsdoc Prims.option) Prims.list)
| Val of (FStar_Ident.ident * term)
| Exception of (FStar_Ident.ident * term Prims.option)
| NewEffect of effect_decl
| NewEffectForFree of effect_decl
| SubEffect of lift
| Pragma of pragma
| Fsdoc of fsdoc
| KindAbbrev of (FStar_Ident.ident * binder Prims.list * knd)
| Assume of (FStar_Ident.ident * term) 
 and decl =
{d : decl'; drange : FStar_Range.range; doc : fsdoc Prims.option; quals : qualifiers; attrs : attributes_} 
 and effect_decl =
| DefineEffect of (FStar_Ident.ident * binder Prims.list * term * decl Prims.list * decl Prims.list)
| RedefineEffect of (FStar_Ident.ident * binder Prims.list * term)


let is_TopLevelModule = (fun _discr_ -> (match (_discr_) with
| TopLevelModule (_) -> begin
true
end
| _ -> begin
false
end))


let is_Open = (fun _discr_ -> (match (_discr_) with
| Open (_) -> begin
true
end
| _ -> begin
false
end))


let is_ModuleAbbrev = (fun _discr_ -> (match (_discr_) with
| ModuleAbbrev (_) -> begin
true
end
| _ -> begin
false
end))


let is_TopLevelLet = (fun _discr_ -> (match (_discr_) with
| TopLevelLet (_) -> begin
true
end
| _ -> begin
false
end))


let is_Main = (fun _discr_ -> (match (_discr_) with
| Main (_) -> begin
true
end
| _ -> begin
false
end))


let is_Tycon = (fun _discr_ -> (match (_discr_) with
| Tycon (_) -> begin
true
end
| _ -> begin
false
end))


let is_Val = (fun _discr_ -> (match (_discr_) with
| Val (_) -> begin
true
end
| _ -> begin
false
end))


let is_Exception = (fun _discr_ -> (match (_discr_) with
| Exception (_) -> begin
true
end
| _ -> begin
false
end))


let is_NewEffect = (fun _discr_ -> (match (_discr_) with
| NewEffect (_) -> begin
true
end
| _ -> begin
false
end))


let is_NewEffectForFree = (fun _discr_ -> (match (_discr_) with
| NewEffectForFree (_) -> begin
true
end
| _ -> begin
false
end))


let is_SubEffect = (fun _discr_ -> (match (_discr_) with
| SubEffect (_) -> begin
true
end
| _ -> begin
false
end))


let is_Pragma = (fun _discr_ -> (match (_discr_) with
| Pragma (_) -> begin
true
end
| _ -> begin
false
end))


let is_Fsdoc = (fun _discr_ -> (match (_discr_) with
| Fsdoc (_) -> begin
true
end
| _ -> begin
false
end))


let is_KindAbbrev = (fun _discr_ -> (match (_discr_) with
| KindAbbrev (_) -> begin
true
end
| _ -> begin
false
end))


let is_Assume = (fun _discr_ -> (match (_discr_) with
| Assume (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mkdecl : decl  ->  Prims.bool = (Obj.magic ((fun _ -> (failwith "Not yet implemented:is_Mkdecl"))))


let is_DefineEffect = (fun _discr_ -> (match (_discr_) with
| DefineEffect (_) -> begin
true
end
| _ -> begin
false
end))


let is_RedefineEffect = (fun _discr_ -> (match (_discr_) with
| RedefineEffect (_) -> begin
true
end
| _ -> begin
false
end))


let ___TopLevelModule____0 = (fun projectee -> (match (projectee) with
| TopLevelModule (_61_213) -> begin
_61_213
end))


let ___Open____0 = (fun projectee -> (match (projectee) with
| Open (_61_216) -> begin
_61_216
end))


let ___ModuleAbbrev____0 = (fun projectee -> (match (projectee) with
| ModuleAbbrev (_61_219) -> begin
_61_219
end))


let ___TopLevelLet____0 = (fun projectee -> (match (projectee) with
| TopLevelLet (_61_222) -> begin
_61_222
end))


let ___Main____0 = (fun projectee -> (match (projectee) with
| Main (_61_225) -> begin
_61_225
end))


let ___Tycon____0 = (fun projectee -> (match (projectee) with
| Tycon (_61_228) -> begin
_61_228
end))


let ___Val____0 = (fun projectee -> (match (projectee) with
| Val (_61_231) -> begin
_61_231
end))


let ___Exception____0 = (fun projectee -> (match (projectee) with
| Exception (_61_234) -> begin
_61_234
end))


let ___NewEffect____0 = (fun projectee -> (match (projectee) with
| NewEffect (_61_237) -> begin
_61_237
end))


let ___NewEffectForFree____0 = (fun projectee -> (match (projectee) with
| NewEffectForFree (_61_240) -> begin
_61_240
end))


let ___SubEffect____0 = (fun projectee -> (match (projectee) with
| SubEffect (_61_243) -> begin
_61_243
end))


let ___Pragma____0 = (fun projectee -> (match (projectee) with
| Pragma (_61_246) -> begin
_61_246
end))


let ___Fsdoc____0 = (fun projectee -> (match (projectee) with
| Fsdoc (_61_249) -> begin
_61_249
end))


let ___KindAbbrev____0 = (fun projectee -> (match (projectee) with
| KindAbbrev (_61_252) -> begin
_61_252
end))


let ___Assume____0 = (fun projectee -> (match (projectee) with
| Assume (_61_255) -> begin
_61_255
end))


let ___DefineEffect____0 = (fun projectee -> (match (projectee) with
| DefineEffect (_61_259) -> begin
_61_259
end))


let ___RedefineEffect____0 = (fun projectee -> (match (projectee) with
| RedefineEffect (_61_262) -> begin
_61_262
end))


type modul =
| Module of (FStar_Ident.lid * decl Prims.list)
| Interface of (FStar_Ident.lid * decl Prims.list * Prims.bool)


let is_Module = (fun _discr_ -> (match (_discr_) with
| Module (_) -> begin
true
end
| _ -> begin
false
end))


let is_Interface = (fun _discr_ -> (match (_discr_) with
| Interface (_) -> begin
true
end
| _ -> begin
false
end))


let ___Module____0 = (fun projectee -> (match (projectee) with
| Module (_61_265) -> begin
_61_265
end))


let ___Interface____0 = (fun projectee -> (match (projectee) with
| Interface (_61_268) -> begin
_61_268
end))


type file =
modul Prims.list


type inputFragment =
(file, decl Prims.list) FStar_Util.either


let check_id : FStar_Ident.ident  ->  Prims.unit = (fun id -> if (FStar_Options.universes ()) then begin
(

let first_char = (FStar_String.substring id.FStar_Ident.idText (Prims.parse_int "0") (Prims.parse_int "1"))
in if ((FStar_String.lowercase first_char) = first_char) then begin
()
end else begin
(let _158_1202 = (let _158_1201 = (let _158_1200 = (FStar_Util.format1 "Invalid identifer \'%s\'; expected a symbol that begins with a lower-case character" id.FStar_Ident.idText)
in ((_158_1200), (id.FStar_Ident.idRange)))
in FStar_Syntax_Syntax.Error (_158_1201))
in (Prims.raise _158_1202))
end)
end else begin
()
end)


let at_most_one = (fun s r l -> (match (l) with
| (x)::[] -> begin
Some (x)
end
| [] -> begin
None
end
| _61_278 -> begin
(let _158_1208 = (let _158_1207 = (let _158_1206 = (FStar_Util.format1 "At most one %s is allowed on declarations" s)
in ((_158_1206), (r)))
in FStar_Syntax_Syntax.Error (_158_1207))
in (Prims.raise _158_1208))
end))


let mk_decl : decl'  ->  FStar_Range.range  ->  decoration Prims.list  ->  decl = (fun d r decorations -> (

let doc = (let _158_1216 = (FStar_List.choose (fun _61_1 -> (match (_61_1) with
| Doc (d) -> begin
Some (d)
end
| _61_286 -> begin
None
end)) decorations)
in (at_most_one "fsdoc" r _158_1216))
in (

let attributes_ = (let _158_1218 = (FStar_List.choose (fun _61_2 -> (match (_61_2) with
| DeclAttributes (a) -> begin
Some (a)
end
| _61_292 -> begin
None
end)) decorations)
in (at_most_one "attribute set" r _158_1218))
in (

let attributes_ = (FStar_Util.dflt [] attributes_)
in (

let qualifiers = (FStar_List.choose (fun _61_3 -> (match (_61_3) with
| Qualifier (q) -> begin
Some (q)
end
| _61_299 -> begin
None
end)) decorations)
in {d = d; drange = r; doc = doc; quals = qualifiers; attrs = attributes_})))))


let mk_binder : binder'  ->  FStar_Range.range  ->  level  ->  aqual  ->  binder = (fun b r l i -> {b = b; brange = r; blevel = l; aqual = i})


let mk_term : term'  ->  FStar_Range.range  ->  level  ->  term = (fun t r l -> {tm = t; range = r; level = l})


let mk_uminus : term  ->  FStar_Range.range  ->  level  ->  term = (fun t r l -> (

let t = (match (t.tm) with
| Const (FStar_Const.Const_int (s, Some (FStar_Const.Signed, width))) -> begin
Const (FStar_Const.Const_int ((((Prims.strcat "-" s)), (Some (((FStar_Const.Signed), (width)))))))
end
| _61_320 -> begin
Op ((("-"), ((t)::[])))
end)
in (mk_term t r l)))


let mk_pattern : pattern'  ->  FStar_Range.range  ->  pattern = (fun p r -> {pat = p; prange = r})


let un_curry_abs : pattern Prims.list  ->  term  ->  term' = (fun ps body -> (match (body.tm) with
| Abs (p', body') -> begin
Abs ((((FStar_List.append ps p')), (body')))
end
| _61_331 -> begin
Abs (((ps), (body)))
end))


let mk_function : branch Prims.list  ->  FStar_Range.range  ->  FStar_Range.range  ->  term = (fun branches r1 r2 -> (

let x = if (FStar_Options.universes ()) then begin
(

let i = (FStar_Syntax_Syntax.next_id ())
in (FStar_Ident.gen r1))
end else begin
(FStar_Absyn_Util.genident (Some (r1)))
end
in (let _158_1261 = (let _158_1260 = (let _158_1259 = (let _158_1258 = (let _158_1257 = (let _158_1256 = (let _158_1255 = (let _158_1254 = (FStar_Ident.lid_of_ids ((x)::[]))
in Var (_158_1254))
in (mk_term _158_1255 r1 Expr))
in ((_158_1256), (branches)))
in Match (_158_1257))
in (mk_term _158_1258 r2 Expr))
in ((((mk_pattern (PatVar (((x), (None)))) r1))::[]), (_158_1259)))
in Abs (_158_1260))
in (mk_term _158_1261 r2 Expr))))


let un_function : pattern  ->  term  ->  (pattern * term) Prims.option = (fun p tm -> (match (((p.pat), (tm.tm))) with
| (PatVar (_61_340), Abs (pats, body)) -> begin
Some ((((mk_pattern (PatApp (((p), (pats)))) p.prange)), (body)))
end
| _61_348 -> begin
None
end))


let lid_with_range : FStar_Ident.lident  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun lid r -> (let _158_1270 = (FStar_Ident.path_of_lid lid)
in (FStar_Ident.lid_of_path _158_1270 r)))


let consPat : FStar_Range.range  ->  pattern  ->  pattern  ->  pattern' = (fun r hd tl -> PatApp ((((mk_pattern (PatName (FStar_Absyn_Const.cons_lid)) r)), ((hd)::(tl)::[]))))


let consTerm : FStar_Range.range  ->  term  ->  term  ->  term = (fun r hd tl -> (mk_term (Construct (((FStar_Absyn_Const.cons_lid), ((((hd), (Nothing)))::(((tl), (Nothing)))::[])))) r Expr))


let lexConsTerm : FStar_Range.range  ->  term  ->  term  ->  term = (fun r hd tl -> (mk_term (Construct (((FStar_Absyn_Const.lexcons_lid), ((((hd), (Nothing)))::(((tl), (Nothing)))::[])))) r Expr))


let mkConsList : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (

let nil = (mk_term (Construct (((FStar_Absyn_Const.nil_lid), ([])))) r Expr)
in (FStar_List.fold_right (fun e tl -> (consTerm r e tl)) elts nil)))


let mkLexList : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (

let nil = (mk_term (Construct (((FStar_Absyn_Const.lextop_lid), ([])))) r Expr)
in (FStar_List.fold_right (fun e tl -> (lexConsTerm r e tl)) elts nil)))


let mkApp : term  ->  (term * imp) Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (match (args) with
| [] -> begin
t
end
| _61_375 -> begin
(match (t.tm) with
| Name (s) -> begin
(mk_term (Construct (((s), (args)))) r Un)
end
| _61_379 -> begin
(FStar_List.fold_left (fun t _61_383 -> (match (_61_383) with
| (a, imp) -> begin
(mk_term (App (((t), (a), (imp)))) r Un)
end)) t args)
end)
end))


let mkRefSet : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (

let univs = (FStar_Options.universes ())
in (

let _61_390 = if univs then begin
((FStar_Absyn_Const.tset_empty), (FStar_Absyn_Const.tset_singleton), (FStar_Absyn_Const.tset_union))
end else begin
((FStar_Absyn_Const.set_empty), (FStar_Absyn_Const.set_singleton), (FStar_Absyn_Const.set_union))
end
in (match (_61_390) with
| (empty_lid, singleton_lid, union_lid) -> begin
(

let empty = (mk_term (Var ((FStar_Ident.set_lid_range empty_lid r))) r Expr)
in (

let ref_constr = (mk_term (Var ((FStar_Ident.set_lid_range FStar_Absyn_Const.heap_ref r))) r Expr)
in (

let singleton = (mk_term (Var ((FStar_Ident.set_lid_range singleton_lid r))) r Expr)
in (

let union = (mk_term (Var ((FStar_Ident.set_lid_range union_lid r))) r Expr)
in (FStar_List.fold_right (fun e tl -> (

let e = (mkApp ref_constr ((((e), (Nothing)))::[]) r)
in (

let single_e = (mkApp singleton ((((e), (Nothing)))::[]) r)
in (mkApp union ((((single_e), (Nothing)))::(((tl), (Nothing)))::[]) r)))) elts empty)))))
end))))


let mkExplicitApp : term  ->  term Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (match (args) with
| [] -> begin
t
end
| _61_404 -> begin
(match (t.tm) with
| Name (s) -> begin
(let _158_1324 = (let _158_1323 = (let _158_1322 = (FStar_List.map (fun a -> ((a), (Nothing))) args)
in ((s), (_158_1322)))
in Construct (_158_1323))
in (mk_term _158_1324 r Un))
end
| _61_409 -> begin
(FStar_List.fold_left (fun t a -> (mk_term (App (((t), (a), (Nothing)))) r Un)) t args)
end)
end))


let mkAdmitMagic : FStar_Range.range  ->  term = (fun r -> (

let unit_const = (mk_term (Const (FStar_Const.Const_unit)) r Expr)
in (

let admit = (

let admit_name = (mk_term (Var ((FStar_Ident.set_lid_range FStar_Absyn_Const.admit_lid r))) r Expr)
in (mkExplicitApp admit_name ((unit_const)::[]) r))
in (

let magic = (

let magic_name = (mk_term (Var ((FStar_Ident.set_lid_range FStar_Absyn_Const.magic_lid r))) r Expr)
in (mkExplicitApp magic_name ((unit_const)::[]) r))
in (

let admit_magic = (mk_term (Seq (((admit), (magic)))) r Expr)
in admit_magic)))))


let mkWildAdmitMagic = (fun r -> (let _158_1330 = (mkAdmitMagic r)
in (((mk_pattern PatWild r)), (None), (_158_1330))))


let focusBranches = (fun branches r -> (

let should_filter = (FStar_Util.for_some Prims.fst branches)
in if should_filter then begin
(

let _61_423 = (FStar_Tc_Errors.warn r "Focusing on only some cases")
in (

let focussed = (let _158_1333 = (FStar_List.filter Prims.fst branches)
in (FStar_All.pipe_right _158_1333 (FStar_List.map Prims.snd)))
in (let _158_1335 = (let _158_1334 = (mkWildAdmitMagic r)
in (_158_1334)::[])
in (FStar_List.append focussed _158_1335))))
end else begin
(FStar_All.pipe_right branches (FStar_List.map Prims.snd))
end))


let focusLetBindings = (fun lbs r -> (

let should_filter = (FStar_Util.for_some Prims.fst lbs)
in if should_filter then begin
(

let _61_429 = (FStar_Tc_Errors.warn r "Focusing on only some cases in this (mutually) recursive definition")
in (FStar_List.map (fun _61_433 -> (match (_61_433) with
| (f, lb) -> begin
if f then begin
lb
end else begin
(let _158_1339 = (mkAdmitMagic r)
in (((Prims.fst lb)), (_158_1339)))
end
end)) lbs))
end else begin
(FStar_All.pipe_right lbs (FStar_List.map Prims.snd))
end))


let mkFsTypApp : term  ->  term Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (let _158_1347 = (FStar_List.map (fun a -> ((a), (FsTypApp))) args)
in (mkApp t _158_1347 r)))


let mkTuple : term Prims.list  ->  FStar_Range.range  ->  term = (fun args r -> (

let cons = if (FStar_Options.universes ()) then begin
(FStar_Syntax_Util.mk_tuple_data_lid (FStar_List.length args) r)
end else begin
(FStar_Absyn_Util.mk_tuple_data_lid (FStar_List.length args) r)
end
in (let _158_1353 = (FStar_List.map (fun x -> ((x), (Nothing))) args)
in (mkApp (mk_term (Name (cons)) r Expr) _158_1353 r))))


let mkDTuple : term Prims.list  ->  FStar_Range.range  ->  term = (fun args r -> (

let cons = if (FStar_Options.universes ()) then begin
(FStar_Syntax_Util.mk_dtuple_data_lid (FStar_List.length args) r)
end else begin
(FStar_Absyn_Util.mk_dtuple_data_lid (FStar_List.length args) r)
end
in (let _158_1359 = (FStar_List.map (fun x -> ((x), (Nothing))) args)
in (mkApp (mk_term (Name (cons)) r Expr) _158_1359 r))))


let mkRefinedBinder : FStar_Ident.ident  ->  term  ->  Prims.bool  ->  term Prims.option  ->  FStar_Range.range  ->  aqual  ->  binder = (fun id t should_bind_var refopt m implicit -> (

let b = (mk_binder (Annotated (((id), (t)))) m Type implicit)
in (match (refopt) with
| None -> begin
b
end
| Some (phi) -> begin
if should_bind_var then begin
(mk_binder (Annotated (((id), ((mk_term (Refine (((b), (phi)))) m Type))))) m Type implicit)
end else begin
(

let x = (FStar_Ident.gen t.range)
in (

let b = (mk_binder (Annotated (((x), (t)))) m Type implicit)
in (mk_binder (Annotated (((id), ((mk_term (Refine (((b), (phi)))) m Type))))) m Type implicit)))
end
end)))


let mkRefinedPattern : pattern  ->  term  ->  Prims.bool  ->  term Prims.option  ->  FStar_Range.range  ->  FStar_Range.range  ->  pattern = (fun pat t should_bind_pat phi_opt t_range range -> (

let t = (match (phi_opt) with
| None -> begin
t
end
| Some (phi) -> begin
if should_bind_pat then begin
(match (pat.pat) with
| PatVar (x, _61_469) -> begin
(mk_term (Refine ((((mk_binder (Annotated (((x), (t)))) t_range Type None)), (phi)))) range Type)
end
| _61_473 -> begin
(

let x = (FStar_Ident.gen t_range)
in (

let phi = (

let x_var = (let _158_1385 = (let _158_1384 = (FStar_Ident.lid_of_ids ((x)::[]))
in Var (_158_1384))
in (mk_term _158_1385 phi.range Formula))
in (

let pat_branch = ((pat), (None), (phi))
in (

let otherwise_branch = (let _158_1388 = (let _158_1387 = (let _158_1386 = (FStar_Ident.lid_of_path (("False")::[]) phi.range)
in Name (_158_1386))
in (mk_term _158_1387 phi.range Formula))
in (((mk_pattern PatWild phi.range)), (None), (_158_1388)))
in (mk_term (Match (((x_var), ((pat_branch)::(otherwise_branch)::[])))) phi.range Formula))))
in (mk_term (Refine ((((mk_binder (Annotated (((x), (t)))) t_range Type None)), (phi)))) range Type)))
end)
end else begin
(

let x = (FStar_Ident.gen t.range)
in (mk_term (Refine ((((mk_binder (Annotated (((x), (t)))) t_range Type None)), (phi)))) range Type))
end
end)
in (mk_pattern (PatAscribed (((pat), (t)))) range)))


let rec extract_named_refinement : term  ->  (FStar_Ident.ident * term * term Prims.option) Prims.option = (fun t1 -> (match (t1.tm) with
| NamedTyp (x, t) -> begin
Some (((x), (t), (None)))
end
| Refine ({b = Annotated (x, t); brange = _61_491; blevel = _61_489; aqual = _61_487}, t') -> begin
Some (((x), (t), (Some (t'))))
end
| Paren (t) -> begin
(extract_named_refinement t)
end
| _61_503 -> begin
None
end))


let as_frag : decl  ->  decl Prims.list  ->  (modul Prims.list, decl Prims.list) FStar_Util.either = (fun d ds -> (

let rec as_mlist = (fun out _61_512 ds -> (match (_61_512) with
| ((m_name, m_decl), cur) -> begin
(match (ds) with
| [] -> begin
(FStar_List.rev ((Module (((m_name), ((m_decl)::(FStar_List.rev cur)))))::out))
end
| (d)::ds -> begin
(match (d.d) with
| TopLevelModule (m') -> begin
(as_mlist ((Module (((m_name), ((m_decl)::(FStar_List.rev cur)))))::out) ((((m'), (d))), ([])) ds)
end
| _61_521 -> begin
(as_mlist out ((((m_name), (m_decl))), ((d)::cur)) ds)
end)
end)
end))
in (match (d.d) with
| TopLevelModule (m) -> begin
(

let ms = (as_mlist [] ((((m), (d))), ([])) ds)
in (

let _61_536 = (match ((FStar_List.tl ms)) with
| (Module (m', _61_529))::_61_526 -> begin
(

let msg = "Support for more than one module in a file is deprecated"
in (let _158_1401 = (FStar_Range.string_of_range (FStar_Ident.range_of_lid m'))
in (FStar_Util.print2_warning "%s (Warning): %s\n" _158_1401 msg)))
end
| _61_535 -> begin
()
end)
in FStar_Util.Inl (ms)))
end
| _61_539 -> begin
(

let ds = (d)::ds
in (

let _61_555 = (FStar_List.iter (fun _61_4 -> (match (_61_4) with
| {d = TopLevelModule (_61_550); drange = r; doc = _61_547; quals = _61_545; attrs = _61_543} -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected module declaration"), (r)))))
end
| _61_554 -> begin
()
end)) ds)
in FStar_Util.Inr (ds)))
end)))


let compile_op : Prims.int  ->  Prims.string  ->  Prims.string = (fun arity s -> (

let name_of_char = (fun _61_5 -> (match (_61_5) with
| '&' -> begin
"Amp"
end
| '@' -> begin
"At"
end
| '+' -> begin
"Plus"
end
| '-' when (arity = (Prims.parse_int "1")) -> begin
"Minus"
end
| '-' -> begin
"Subtraction"
end
| '/' -> begin
"Slash"
end
| '<' -> begin
"Less"
end
| '=' -> begin
"Equals"
end
| '>' -> begin
"Greater"
end
| '_' -> begin
"Underscore"
end
| '|' -> begin
"Bar"
end
| '!' -> begin
"Bang"
end
| '^' -> begin
"Hat"
end
| '%' -> begin
"Percent"
end
| '*' -> begin
"Star"
end
| '?' -> begin
"Question"
end
| ':' -> begin
"Colon"
end
| _61_578 -> begin
"UNKNOWN"
end))
in (match (s) with
| ".[]<-" -> begin
"op_String_Assignment"
end
| ".()<-" -> begin
"op_Array_Assignment"
end
| ".[]" -> begin
"op_String_Access"
end
| ".()" -> begin
"op_Array_Access"
end
| _61_585 -> begin
(let _158_1411 = (let _158_1410 = (let _158_1409 = (FStar_String.list_of_string s)
in (FStar_List.map name_of_char _158_1409))
in (FStar_String.concat "_" _158_1410))
in (Prims.strcat "op_" _158_1411))
end)))


let compile_op' : Prims.string  ->  Prims.string = (fun s -> (compile_op (~- ((Prims.parse_int "1"))) s))


let string_of_fsdoc : (Prims.string * (Prims.string * Prims.string) Prims.list)  ->  Prims.string = (fun _61_589 -> (match (_61_589) with
| (comment, keywords) -> begin
(let _158_1418 = (let _158_1417 = (FStar_List.map (fun _61_592 -> (match (_61_592) with
| (k, v) -> begin
(Prims.strcat k (Prims.strcat "->" v))
end)) keywords)
in (FStar_String.concat "," _158_1417))
in (Prims.strcat comment _158_1418))
end))


let string_of_let_qualifier : let_qualifier  ->  Prims.string = (fun _61_6 -> (match (_61_6) with
| NoLetQualifier -> begin
""
end
| Rec -> begin
"rec"
end
| Mutable -> begin
"mutable"
end))


let to_string_l = (fun sep f l -> (let _158_1427 = (FStar_List.map f l)
in (FStar_String.concat sep _158_1427)))


let imp_to_string : imp  ->  Prims.string = (fun _61_7 -> (match (_61_7) with
| Hash -> begin
"#"
end
| _61_603 -> begin
""
end))


let rec term_to_string : term  ->  Prims.string = (fun x -> (match (x.tm) with
| Wild -> begin
"_"
end
| Requires (t, _61_608) -> begin
(let _158_1435 = (term_to_string t)
in (FStar_Util.format1 "(requires %s)" _158_1435))
end
| Ensures (t, _61_613) -> begin
(let _158_1436 = (term_to_string t)
in (FStar_Util.format1 "(ensures %s)" _158_1436))
end
| Labeled (t, l, _61_619) -> begin
(let _158_1437 = (term_to_string t)
in (FStar_Util.format2 "(labeled %s %s)" l _158_1437))
end
| Const (c) -> begin
(FStar_Absyn_Print.const_to_string c)
end
| Op (s, xs) -> begin
(let _158_1440 = (let _158_1439 = (FStar_List.map (fun x -> (FStar_All.pipe_right x term_to_string)) xs)
in (FStar_String.concat ", " _158_1439))
in (FStar_Util.format2 "%s(%s)" s _158_1440))
end
| (Tvar (id)) | (Uvar (id)) -> begin
id.FStar_Ident.idText
end
| (Var (l)) | (Name (l)) -> begin
l.FStar_Ident.str
end
| Construct (l, args) -> begin
(let _158_1443 = (to_string_l " " (fun _61_641 -> (match (_61_641) with
| (a, imp) -> begin
(let _158_1442 = (term_to_string a)
in (FStar_Util.format2 "%s%s" (imp_to_string imp) _158_1442))
end)) args)
in (FStar_Util.format2 "(%s %s)" l.FStar_Ident.str _158_1443))
end
| Abs (pats, t) -> begin
(let _158_1445 = (to_string_l " " pat_to_string pats)
in (let _158_1444 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "(fun %s -> %s)" _158_1445 _158_1444)))
end
| App (t1, t2, imp) -> begin
(let _158_1447 = (FStar_All.pipe_right t1 term_to_string)
in (let _158_1446 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format3 "%s %s%s" _158_1447 (imp_to_string imp) _158_1446)))
end
| Let (Rec, lbs, body) -> begin
(let _158_1452 = (to_string_l " and " (fun _61_658 -> (match (_61_658) with
| (p, b) -> begin
(let _158_1450 = (FStar_All.pipe_right p pat_to_string)
in (let _158_1449 = (FStar_All.pipe_right b term_to_string)
in (FStar_Util.format2 "%s=%s" _158_1450 _158_1449)))
end)) lbs)
in (let _158_1451 = (FStar_All.pipe_right body term_to_string)
in (FStar_Util.format2 "let rec %s in %s" _158_1452 _158_1451)))
end
| Let (q, ((pat, tm))::[], body) -> begin
(let _158_1455 = (FStar_All.pipe_right pat pat_to_string)
in (let _158_1454 = (FStar_All.pipe_right tm term_to_string)
in (let _158_1453 = (FStar_All.pipe_right body term_to_string)
in (FStar_Util.format4 "let %s %s = %s in %s" (string_of_let_qualifier q) _158_1455 _158_1454 _158_1453))))
end
| Seq (t1, t2) -> begin
(let _158_1457 = (FStar_All.pipe_right t1 term_to_string)
in (let _158_1456 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format2 "%s; %s" _158_1457 _158_1456)))
end
| If (t1, t2, t3) -> begin
(let _158_1460 = (FStar_All.pipe_right t1 term_to_string)
in (let _158_1459 = (FStar_All.pipe_right t2 term_to_string)
in (let _158_1458 = (FStar_All.pipe_right t3 term_to_string)
in (FStar_Util.format3 "if %s then %s else %s" _158_1460 _158_1459 _158_1458))))
end
| Match (t, branches) -> begin
(let _158_1467 = (FStar_All.pipe_right t term_to_string)
in (let _158_1466 = (to_string_l " | " (fun _61_683 -> (match (_61_683) with
| (p, w, e) -> begin
(let _158_1465 = (FStar_All.pipe_right p pat_to_string)
in (let _158_1464 = (match (w) with
| None -> begin
""
end
| Some (e) -> begin
(let _158_1462 = (term_to_string e)
in (FStar_Util.format1 "when %s" _158_1462))
end)
in (let _158_1463 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format3 "%s %s -> %s" _158_1465 _158_1464 _158_1463))))
end)) branches)
in (FStar_Util.format2 "match %s with %s" _158_1467 _158_1466)))
end
| Ascribed (t1, t2) -> begin
(let _158_1469 = (FStar_All.pipe_right t1 term_to_string)
in (let _158_1468 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format2 "(%s : %s)" _158_1469 _158_1468)))
end
| Record (Some (e), fields) -> begin
(let _158_1473 = (FStar_All.pipe_right e term_to_string)
in (let _158_1472 = (to_string_l " " (fun _61_698 -> (match (_61_698) with
| (l, e) -> begin
(let _158_1471 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format2 "%s=%s" l.FStar_Ident.str _158_1471))
end)) fields)
in (FStar_Util.format2 "{%s with %s}" _158_1473 _158_1472)))
end
| Record (None, fields) -> begin
(let _158_1476 = (to_string_l " " (fun _61_705 -> (match (_61_705) with
| (l, e) -> begin
(let _158_1475 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format2 "%s=%s" l.FStar_Ident.str _158_1475))
end)) fields)
in (FStar_Util.format1 "{%s}" _158_1476))
end
| Project (e, l) -> begin
(let _158_1477 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format2 "%s.%s" _158_1477 l.FStar_Ident.str))
end
| Product ([], t) -> begin
(term_to_string t)
end
| Product ((b)::(hd)::tl, t) -> begin
(term_to_string (mk_term (Product ((((b)::[]), ((mk_term (Product ((((hd)::tl), (t)))) x.range x.level))))) x.range x.level))
end
| Product ((b)::[], t) when (x.level = Type) -> begin
(let _158_1479 = (FStar_All.pipe_right b binder_to_string)
in (let _158_1478 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s -> %s" _158_1479 _158_1478)))
end
| Product ((b)::[], t) when (x.level = Kind) -> begin
(let _158_1481 = (FStar_All.pipe_right b binder_to_string)
in (let _158_1480 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s => %s" _158_1481 _158_1480)))
end
| Sum (binders, t) -> begin
(let _158_1484 = (let _158_1482 = (FStar_All.pipe_right binders (FStar_List.map binder_to_string))
in (FStar_All.pipe_right _158_1482 (FStar_String.concat " * ")))
in (let _158_1483 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s * %s" _158_1484 _158_1483)))
end
| QForall (bs, pats, t) -> begin
(let _158_1487 = (to_string_l " " binder_to_string bs)
in (let _158_1486 = (to_string_l " \\/ " (to_string_l "; " term_to_string) pats)
in (let _158_1485 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format3 "forall %s.{:pattern %s} %s" _158_1487 _158_1486 _158_1485))))
end
| QExists (bs, pats, t) -> begin
(let _158_1490 = (to_string_l " " binder_to_string bs)
in (let _158_1489 = (to_string_l " \\/ " (to_string_l "; " term_to_string) pats)
in (let _158_1488 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format3 "exists %s.{:pattern %s} %s" _158_1490 _158_1489 _158_1488))))
end
| Refine (b, t) -> begin
(let _158_1492 = (FStar_All.pipe_right b binder_to_string)
in (let _158_1491 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:{%s}" _158_1492 _158_1491)))
end
| NamedTyp (x, t) -> begin
(let _158_1493 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:%s" x.FStar_Ident.idText _158_1493))
end
| Paren (t) -> begin
(let _158_1494 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format1 "(%s)" _158_1494))
end
| Product (bs, t) -> begin
(let _158_1497 = (let _158_1495 = (FStar_All.pipe_right bs (FStar_List.map binder_to_string))
in (FStar_All.pipe_right _158_1495 (FStar_String.concat ",")))
in (let _158_1496 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "Unidentified product: [%s] %s" _158_1497 _158_1496)))
end
| t -> begin
"_"
end))
and binder_to_string : binder  ->  Prims.string = (fun x -> (

let s = (match (x.b) with
| Variable (i) -> begin
i.FStar_Ident.idText
end
| TVariable (i) -> begin
(FStar_Util.format1 "%s:_" i.FStar_Ident.idText)
end
| (TAnnotated (i, t)) | (Annotated (i, t)) -> begin
(let _158_1499 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:%s" i.FStar_Ident.idText _158_1499))
end
| NoName (t) -> begin
(FStar_All.pipe_right t term_to_string)
end)
in (let _158_1500 = (aqual_to_string x.aqual)
in (FStar_Util.format2 "%s%s" _158_1500 s))))
and aqual_to_string : aqual  ->  Prims.string = (fun _61_8 -> (match (_61_8) with
| Some (Equality) -> begin
"$"
end
| Some (Implicit) -> begin
"#"
end
| _61_781 -> begin
""
end))
and pat_to_string : pattern  ->  Prims.string = (fun x -> (match (x.pat) with
| PatWild -> begin
"_"
end
| PatConst (c) -> begin
(FStar_Absyn_Print.const_to_string c)
end
| PatApp (p, ps) -> begin
(let _158_1504 = (FStar_All.pipe_right p pat_to_string)
in (let _158_1503 = (to_string_l " " pat_to_string ps)
in (FStar_Util.format2 "(%s %s)" _158_1504 _158_1503)))
end
| (PatTvar (i, aq)) | (PatVar (i, aq)) -> begin
(let _158_1505 = (aqual_to_string aq)
in (FStar_Util.format2 "%s%s" _158_1505 i.FStar_Ident.idText))
end
| PatName (l) -> begin
l.FStar_Ident.str
end
| PatList (l) -> begin
(let _158_1506 = (to_string_l "; " pat_to_string l)
in (FStar_Util.format1 "[%s]" _158_1506))
end
| PatTuple (l, false) -> begin
(let _158_1507 = (to_string_l ", " pat_to_string l)
in (FStar_Util.format1 "(%s)" _158_1507))
end
| PatTuple (l, true) -> begin
(let _158_1508 = (to_string_l ", " pat_to_string l)
in (FStar_Util.format1 "(|%s|)" _158_1508))
end
| PatRecord (l) -> begin
(let _158_1511 = (to_string_l "; " (fun _61_812 -> (match (_61_812) with
| (f, e) -> begin
(let _158_1510 = (FStar_All.pipe_right e pat_to_string)
in (FStar_Util.format2 "%s=%s" f.FStar_Ident.str _158_1510))
end)) l)
in (FStar_Util.format1 "{%s}" _158_1511))
end
| PatOr (l) -> begin
(to_string_l "|\n " pat_to_string l)
end
| PatOp (op) -> begin
(FStar_Util.format1 "(%s)" op)
end
| PatAscribed (p, t) -> begin
(let _158_1513 = (FStar_All.pipe_right p pat_to_string)
in (let _158_1512 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "(%s:%s)" _158_1513 _158_1512)))
end))


let rec head_id_of_pat : pattern  ->  FStar_Ident.lid Prims.list = (fun p -> (match (p.pat) with
| PatName (l) -> begin
(l)::[]
end
| PatVar (i, _61_826) -> begin
(let _158_1516 = (FStar_Ident.lid_of_ids ((i)::[]))
in (_158_1516)::[])
end
| PatApp (p, _61_831) -> begin
(head_id_of_pat p)
end
| PatAscribed (p, _61_836) -> begin
(head_id_of_pat p)
end
| _61_840 -> begin
[]
end))


let lids_of_let = (fun defs -> (FStar_All.pipe_right defs (FStar_List.collect (fun _61_845 -> (match (_61_845) with
| (p, _61_844) -> begin
(head_id_of_pat p)
end)))))


let id_of_tycon : tycon  ->  Prims.string = (fun _61_9 -> (match (_61_9) with
| (TyconAbstract (i, _, _)) | (TyconAbbrev (i, _, _, _)) | (TyconRecord (i, _, _, _)) | (TyconVariant (i, _, _, _)) -> begin
i.FStar_Ident.idText
end))


let decl_to_string : decl  ->  Prims.string = (fun d -> (match (d.d) with
| TopLevelModule (l) -> begin
(Prims.strcat "module " l.FStar_Ident.str)
end
| Open (l) -> begin
(Prims.strcat "open " l.FStar_Ident.str)
end
| ModuleAbbrev (i, l) -> begin
(FStar_Util.format2 "module %s = %s" i.FStar_Ident.idText l.FStar_Ident.str)
end
| KindAbbrev (i, _61_889, _61_891) -> begin
(Prims.strcat "kind " i.FStar_Ident.idText)
end
| TopLevelLet (_61_895, pats) -> begin
(let _158_1526 = (let _158_1525 = (let _158_1524 = (lids_of_let pats)
in (FStar_All.pipe_right _158_1524 (FStar_List.map (fun l -> l.FStar_Ident.str))))
in (FStar_All.pipe_right _158_1525 (FStar_String.concat ", ")))
in (Prims.strcat "let " _158_1526))
end
| Main (_61_901) -> begin
"main ..."
end
| Assume (i, _61_905) -> begin
(Prims.strcat "assume " i.FStar_Ident.idText)
end
| Tycon (_61_909, tys) -> begin
(let _158_1529 = (let _158_1528 = (FStar_All.pipe_right tys (FStar_List.map (fun _61_916 -> (match (_61_916) with
| (x, _61_915) -> begin
(id_of_tycon x)
end))))
in (FStar_All.pipe_right _158_1528 (FStar_String.concat ", ")))
in (Prims.strcat "type " _158_1529))
end
| Val (i, _61_919) -> begin
(Prims.strcat "val " i.FStar_Ident.idText)
end
| Exception (i, _61_924) -> begin
(Prims.strcat "exception " i.FStar_Ident.idText)
end
| (NewEffect (DefineEffect (i, _, _, _, _))) | (NewEffect (RedefineEffect (i, _, _))) -> begin
(Prims.strcat "new_effect " i.FStar_Ident.idText)
end
| (NewEffectForFree (DefineEffect (i, _, _, _, _))) | (NewEffectForFree (RedefineEffect (i, _, _))) -> begin
(Prims.strcat "new_effect_for_free " i.FStar_Ident.idText)
end
| SubEffect (_61_966) -> begin
"sub_effect"
end
| Pragma (_61_969) -> begin
"pragma"
end
| Fsdoc (_61_972) -> begin
"fsdoc"
end))


let modul_to_string : modul  ->  Prims.string = (fun m -> (match (m) with
| (Module (_, decls)) | (Interface (_, decls, _)) -> begin
(let _158_1532 = (FStar_All.pipe_right decls (FStar_List.map decl_to_string))
in (FStar_All.pipe_right _158_1532 (FStar_String.concat "\n")))
end))


let error = (fun msg tm r -> (

let tm = (FStar_All.pipe_right tm term_to_string)
in (

let tm = if ((FStar_String.length tm) >= (Prims.parse_int "80")) then begin
(let _158_1536 = (FStar_Util.substring tm (Prims.parse_int "0") (Prims.parse_int "77"))
in (Prims.strcat _158_1536 "..."))
end else begin
tm
end
in if (FStar_Options.universes ()) then begin
(Prims.raise (FStar_Syntax_Syntax.Error ((((Prims.strcat msg (Prims.strcat "\n" tm))), (r)))))
end else begin
(Prims.raise (FStar_Absyn_Syntax.Error ((((Prims.strcat msg (Prims.strcat "\n" tm))), (r)))))
end)))




