
open Prims

type decl =
| DGlobal of (flag Prims.list * lident * typ * expr)
| DFunction of (cc Prims.option * flag Prims.list * typ * lident * binder Prims.list * expr)
| DTypeAlias of (lident * Prims.int * typ)
| DTypeFlat of (lident * fields_t)
| DExternal of (cc Prims.option * lident * typ)
| DTypeVariant of (lident * branches_t) 
 and cc =
| StdCall
| CDecl
| FastCall 
 and flag =
| Private 
 and expr =
| EBound of var
| EQualified of lident
| EConstant of constant
| EUnit
| EApp of (expr * expr Prims.list)
| ELet of (binder * expr * expr)
| EIfThenElse of (expr * expr * expr)
| ESequence of expr Prims.list
| EAssign of (expr * expr)
| EBufCreate of (expr * expr)
| EBufRead of (expr * expr)
| EBufWrite of (expr * expr * expr)
| EBufSub of (expr * expr)
| EBufBlit of (expr * expr * expr * expr * expr)
| EMatch of (expr * branches)
| EOp of (op * width)
| ECast of (expr * typ)
| EPushFrame
| EPopFrame
| EBool of Prims.bool
| EAny
| EAbort
| EReturn of expr
| EFlat of (lident * (ident * expr) Prims.list)
| EField of (lident * expr * ident)
| EWhile of (expr * expr)
| EBufCreateL of expr Prims.list
| ETuple of expr Prims.list
| ECons of (lident * ident * expr Prims.list)
| EBufFill of (expr * expr * expr) 
 and op =
| Add
| AddW
| Sub
| SubW
| Div
| DivW
| Mult
| MultW
| Mod
| BOr
| BAnd
| BXor
| BShiftL
| BShiftR
| BNot
| Eq
| Neq
| Lt
| Lte
| Gt
| Gte
| And
| Or
| Xor
| Not 
 and pattern =
| PUnit
| PBool of Prims.bool
| PVar of binder
| PCons of (ident * pattern Prims.list)
| PTuple of pattern Prims.list
| PRecord of (ident * pattern) Prims.list 
 and width =
| UInt8
| UInt16
| UInt32
| UInt64
| Int8
| Int16
| Int32
| Int64
| Bool
| Int
| UInt 
 and binder =
{name : ident; typ : typ; mut : Prims.bool} 
 and typ =
| TInt of width
| TBuf of typ
| TUnit
| TQualified of lident
| TBool
| TAny
| TArrow of (typ * typ)
| TZ
| TBound of Prims.int
| TApp of (lident * typ Prims.list)
| TTuple of typ Prims.list 
 and program =
decl Prims.list 
 and fields_t =
(ident * (typ * Prims.bool)) Prims.list 
 and branches_t =
(ident * fields_t) Prims.list 
 and branches =
branch Prims.list 
 and branch =
(pattern * expr) 
 and constant =
(width * Prims.string) 
 and var =
Prims.int 
 and ident =
Prims.string 
 and lident =
(ident Prims.list * ident)


let is_DGlobal = (fun _discr_ -> (match (_discr_) with
| DGlobal (_) -> begin
true
end
| _ -> begin
false
end))


let is_DFunction = (fun _discr_ -> (match (_discr_) with
| DFunction (_) -> begin
true
end
| _ -> begin
false
end))


let is_DTypeAlias = (fun _discr_ -> (match (_discr_) with
| DTypeAlias (_) -> begin
true
end
| _ -> begin
false
end))


let is_DTypeFlat = (fun _discr_ -> (match (_discr_) with
| DTypeFlat (_) -> begin
true
end
| _ -> begin
false
end))


let is_DExternal = (fun _discr_ -> (match (_discr_) with
| DExternal (_) -> begin
true
end
| _ -> begin
false
end))


let is_DTypeVariant = (fun _discr_ -> (match (_discr_) with
| DTypeVariant (_) -> begin
true
end
| _ -> begin
false
end))


let is_StdCall = (fun _discr_ -> (match (_discr_) with
| StdCall (_) -> begin
true
end
| _ -> begin
false
end))


let is_CDecl = (fun _discr_ -> (match (_discr_) with
| CDecl (_) -> begin
true
end
| _ -> begin
false
end))


let is_FastCall = (fun _discr_ -> (match (_discr_) with
| FastCall (_) -> begin
true
end
| _ -> begin
false
end))


let is_Private = (fun _discr_ -> (match (_discr_) with
| Private (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBound = (fun _discr_ -> (match (_discr_) with
| EBound (_) -> begin
true
end
| _ -> begin
false
end))


let is_EQualified = (fun _discr_ -> (match (_discr_) with
| EQualified (_) -> begin
true
end
| _ -> begin
false
end))


let is_EConstant = (fun _discr_ -> (match (_discr_) with
| EConstant (_) -> begin
true
end
| _ -> begin
false
end))


let is_EUnit = (fun _discr_ -> (match (_discr_) with
| EUnit (_) -> begin
true
end
| _ -> begin
false
end))


let is_EApp = (fun _discr_ -> (match (_discr_) with
| EApp (_) -> begin
true
end
| _ -> begin
false
end))


let is_ELet = (fun _discr_ -> (match (_discr_) with
| ELet (_) -> begin
true
end
| _ -> begin
false
end))


let is_EIfThenElse = (fun _discr_ -> (match (_discr_) with
| EIfThenElse (_) -> begin
true
end
| _ -> begin
false
end))


let is_ESequence = (fun _discr_ -> (match (_discr_) with
| ESequence (_) -> begin
true
end
| _ -> begin
false
end))


let is_EAssign = (fun _discr_ -> (match (_discr_) with
| EAssign (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBufCreate = (fun _discr_ -> (match (_discr_) with
| EBufCreate (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBufRead = (fun _discr_ -> (match (_discr_) with
| EBufRead (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBufWrite = (fun _discr_ -> (match (_discr_) with
| EBufWrite (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBufSub = (fun _discr_ -> (match (_discr_) with
| EBufSub (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBufBlit = (fun _discr_ -> (match (_discr_) with
| EBufBlit (_) -> begin
true
end
| _ -> begin
false
end))


let is_EMatch = (fun _discr_ -> (match (_discr_) with
| EMatch (_) -> begin
true
end
| _ -> begin
false
end))


let is_EOp = (fun _discr_ -> (match (_discr_) with
| EOp (_) -> begin
true
end
| _ -> begin
false
end))


let is_ECast = (fun _discr_ -> (match (_discr_) with
| ECast (_) -> begin
true
end
| _ -> begin
false
end))


let is_EPushFrame = (fun _discr_ -> (match (_discr_) with
| EPushFrame (_) -> begin
true
end
| _ -> begin
false
end))


let is_EPopFrame = (fun _discr_ -> (match (_discr_) with
| EPopFrame (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBool = (fun _discr_ -> (match (_discr_) with
| EBool (_) -> begin
true
end
| _ -> begin
false
end))


let is_EAny = (fun _discr_ -> (match (_discr_) with
| EAny (_) -> begin
true
end
| _ -> begin
false
end))


let is_EAbort = (fun _discr_ -> (match (_discr_) with
| EAbort (_) -> begin
true
end
| _ -> begin
false
end))


let is_EReturn = (fun _discr_ -> (match (_discr_) with
| EReturn (_) -> begin
true
end
| _ -> begin
false
end))


let is_EFlat = (fun _discr_ -> (match (_discr_) with
| EFlat (_) -> begin
true
end
| _ -> begin
false
end))


let is_EField = (fun _discr_ -> (match (_discr_) with
| EField (_) -> begin
true
end
| _ -> begin
false
end))


let is_EWhile = (fun _discr_ -> (match (_discr_) with
| EWhile (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBufCreateL = (fun _discr_ -> (match (_discr_) with
| EBufCreateL (_) -> begin
true
end
| _ -> begin
false
end))


let is_ETuple = (fun _discr_ -> (match (_discr_) with
| ETuple (_) -> begin
true
end
| _ -> begin
false
end))


let is_ECons = (fun _discr_ -> (match (_discr_) with
| ECons (_) -> begin
true
end
| _ -> begin
false
end))


let is_EBufFill = (fun _discr_ -> (match (_discr_) with
| EBufFill (_) -> begin
true
end
| _ -> begin
false
end))


let is_Add = (fun _discr_ -> (match (_discr_) with
| Add (_) -> begin
true
end
| _ -> begin
false
end))


let is_AddW = (fun _discr_ -> (match (_discr_) with
| AddW (_) -> begin
true
end
| _ -> begin
false
end))


let is_Sub = (fun _discr_ -> (match (_discr_) with
| Sub (_) -> begin
true
end
| _ -> begin
false
end))


let is_SubW = (fun _discr_ -> (match (_discr_) with
| SubW (_) -> begin
true
end
| _ -> begin
false
end))


let is_Div = (fun _discr_ -> (match (_discr_) with
| Div (_) -> begin
true
end
| _ -> begin
false
end))


let is_DivW = (fun _discr_ -> (match (_discr_) with
| DivW (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mult = (fun _discr_ -> (match (_discr_) with
| Mult (_) -> begin
true
end
| _ -> begin
false
end))


let is_MultW = (fun _discr_ -> (match (_discr_) with
| MultW (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mod = (fun _discr_ -> (match (_discr_) with
| Mod (_) -> begin
true
end
| _ -> begin
false
end))


let is_BOr = (fun _discr_ -> (match (_discr_) with
| BOr (_) -> begin
true
end
| _ -> begin
false
end))


let is_BAnd = (fun _discr_ -> (match (_discr_) with
| BAnd (_) -> begin
true
end
| _ -> begin
false
end))


let is_BXor = (fun _discr_ -> (match (_discr_) with
| BXor (_) -> begin
true
end
| _ -> begin
false
end))


let is_BShiftL = (fun _discr_ -> (match (_discr_) with
| BShiftL (_) -> begin
true
end
| _ -> begin
false
end))


let is_BShiftR = (fun _discr_ -> (match (_discr_) with
| BShiftR (_) -> begin
true
end
| _ -> begin
false
end))


let is_BNot = (fun _discr_ -> (match (_discr_) with
| BNot (_) -> begin
true
end
| _ -> begin
false
end))


let is_Eq = (fun _discr_ -> (match (_discr_) with
| Eq (_) -> begin
true
end
| _ -> begin
false
end))


let is_Neq = (fun _discr_ -> (match (_discr_) with
| Neq (_) -> begin
true
end
| _ -> begin
false
end))


let is_Lt = (fun _discr_ -> (match (_discr_) with
| Lt (_) -> begin
true
end
| _ -> begin
false
end))


let is_Lte = (fun _discr_ -> (match (_discr_) with
| Lte (_) -> begin
true
end
| _ -> begin
false
end))


let is_Gt = (fun _discr_ -> (match (_discr_) with
| Gt (_) -> begin
true
end
| _ -> begin
false
end))


let is_Gte = (fun _discr_ -> (match (_discr_) with
| Gte (_) -> begin
true
end
| _ -> begin
false
end))


let is_And = (fun _discr_ -> (match (_discr_) with
| And (_) -> begin
true
end
| _ -> begin
false
end))


let is_Or = (fun _discr_ -> (match (_discr_) with
| Or (_) -> begin
true
end
| _ -> begin
false
end))


let is_Xor = (fun _discr_ -> (match (_discr_) with
| Xor (_) -> begin
true
end
| _ -> begin
false
end))


let is_Not = (fun _discr_ -> (match (_discr_) with
| Not (_) -> begin
true
end
| _ -> begin
false
end))


let is_PUnit = (fun _discr_ -> (match (_discr_) with
| PUnit (_) -> begin
true
end
| _ -> begin
false
end))


let is_PBool = (fun _discr_ -> (match (_discr_) with
| PBool (_) -> begin
true
end
| _ -> begin
false
end))


let is_PVar = (fun _discr_ -> (match (_discr_) with
| PVar (_) -> begin
true
end
| _ -> begin
false
end))


let is_PCons = (fun _discr_ -> (match (_discr_) with
| PCons (_) -> begin
true
end
| _ -> begin
false
end))


let is_PTuple = (fun _discr_ -> (match (_discr_) with
| PTuple (_) -> begin
true
end
| _ -> begin
false
end))


let is_PRecord = (fun _discr_ -> (match (_discr_) with
| PRecord (_) -> begin
true
end
| _ -> begin
false
end))


let is_UInt8 = (fun _discr_ -> (match (_discr_) with
| UInt8 (_) -> begin
true
end
| _ -> begin
false
end))


let is_UInt16 = (fun _discr_ -> (match (_discr_) with
| UInt16 (_) -> begin
true
end
| _ -> begin
false
end))


let is_UInt32 = (fun _discr_ -> (match (_discr_) with
| UInt32 (_) -> begin
true
end
| _ -> begin
false
end))


let is_UInt64 = (fun _discr_ -> (match (_discr_) with
| UInt64 (_) -> begin
true
end
| _ -> begin
false
end))


let is_Int8 = (fun _discr_ -> (match (_discr_) with
| Int8 (_) -> begin
true
end
| _ -> begin
false
end))


let is_Int16 = (fun _discr_ -> (match (_discr_) with
| Int16 (_) -> begin
true
end
| _ -> begin
false
end))


let is_Int32 = (fun _discr_ -> (match (_discr_) with
| Int32 (_) -> begin
true
end
| _ -> begin
false
end))


let is_Int64 = (fun _discr_ -> (match (_discr_) with
| Int64 (_) -> begin
true
end
| _ -> begin
false
end))


let is_Bool = (fun _discr_ -> (match (_discr_) with
| Bool (_) -> begin
true
end
| _ -> begin
false
end))


let is_Int = (fun _discr_ -> (match (_discr_) with
| Int (_) -> begin
true
end
| _ -> begin
false
end))


let is_UInt = (fun _discr_ -> (match (_discr_) with
| UInt (_) -> begin
true
end
| _ -> begin
false
end))


let is_Mkbinder : binder  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkbinder"))))


let is_TInt = (fun _discr_ -> (match (_discr_) with
| TInt (_) -> begin
true
end
| _ -> begin
false
end))


let is_TBuf = (fun _discr_ -> (match (_discr_) with
| TBuf (_) -> begin
true
end
| _ -> begin
false
end))


let is_TUnit = (fun _discr_ -> (match (_discr_) with
| TUnit (_) -> begin
true
end
| _ -> begin
false
end))


let is_TQualified = (fun _discr_ -> (match (_discr_) with
| TQualified (_) -> begin
true
end
| _ -> begin
false
end))


let is_TBool = (fun _discr_ -> (match (_discr_) with
| TBool (_) -> begin
true
end
| _ -> begin
false
end))


let is_TAny = (fun _discr_ -> (match (_discr_) with
| TAny (_) -> begin
true
end
| _ -> begin
false
end))


let is_TArrow = (fun _discr_ -> (match (_discr_) with
| TArrow (_) -> begin
true
end
| _ -> begin
false
end))


let is_TZ = (fun _discr_ -> (match (_discr_) with
| TZ (_) -> begin
true
end
| _ -> begin
false
end))


let is_TBound = (fun _discr_ -> (match (_discr_) with
| TBound (_) -> begin
true
end
| _ -> begin
false
end))


let is_TApp = (fun _discr_ -> (match (_discr_) with
| TApp (_) -> begin
true
end
| _ -> begin
false
end))


let is_TTuple = (fun _discr_ -> (match (_discr_) with
| TTuple (_) -> begin
true
end
| _ -> begin
false
end))


let ___DGlobal____0 = (fun projectee -> (match (projectee) with
| DGlobal (_81_14) -> begin
_81_14
end))


let ___DFunction____0 = (fun projectee -> (match (projectee) with
| DFunction (_81_17) -> begin
_81_17
end))


let ___DTypeAlias____0 = (fun projectee -> (match (projectee) with
| DTypeAlias (_81_20) -> begin
_81_20
end))


let ___DTypeFlat____0 = (fun projectee -> (match (projectee) with
| DTypeFlat (_81_23) -> begin
_81_23
end))


let ___DExternal____0 = (fun projectee -> (match (projectee) with
| DExternal (_81_26) -> begin
_81_26
end))


let ___DTypeVariant____0 = (fun projectee -> (match (projectee) with
| DTypeVariant (_81_29) -> begin
_81_29
end))


let ___EBound____0 = (fun projectee -> (match (projectee) with
| EBound (_81_32) -> begin
_81_32
end))


let ___EQualified____0 = (fun projectee -> (match (projectee) with
| EQualified (_81_35) -> begin
_81_35
end))


let ___EConstant____0 = (fun projectee -> (match (projectee) with
| EConstant (_81_38) -> begin
_81_38
end))


let ___EApp____0 = (fun projectee -> (match (projectee) with
| EApp (_81_41) -> begin
_81_41
end))


let ___ELet____0 = (fun projectee -> (match (projectee) with
| ELet (_81_44) -> begin
_81_44
end))


let ___EIfThenElse____0 = (fun projectee -> (match (projectee) with
| EIfThenElse (_81_47) -> begin
_81_47
end))


let ___ESequence____0 = (fun projectee -> (match (projectee) with
| ESequence (_81_50) -> begin
_81_50
end))


let ___EAssign____0 = (fun projectee -> (match (projectee) with
| EAssign (_81_53) -> begin
_81_53
end))


let ___EBufCreate____0 = (fun projectee -> (match (projectee) with
| EBufCreate (_81_56) -> begin
_81_56
end))


let ___EBufRead____0 = (fun projectee -> (match (projectee) with
| EBufRead (_81_59) -> begin
_81_59
end))


let ___EBufWrite____0 = (fun projectee -> (match (projectee) with
| EBufWrite (_81_62) -> begin
_81_62
end))


let ___EBufSub____0 = (fun projectee -> (match (projectee) with
| EBufSub (_81_65) -> begin
_81_65
end))


let ___EBufBlit____0 = (fun projectee -> (match (projectee) with
| EBufBlit (_81_68) -> begin
_81_68
end))


let ___EMatch____0 = (fun projectee -> (match (projectee) with
| EMatch (_81_71) -> begin
_81_71
end))


let ___EOp____0 = (fun projectee -> (match (projectee) with
| EOp (_81_74) -> begin
_81_74
end))


let ___ECast____0 = (fun projectee -> (match (projectee) with
| ECast (_81_77) -> begin
_81_77
end))


let ___EBool____0 = (fun projectee -> (match (projectee) with
| EBool (_81_80) -> begin
_81_80
end))


let ___EReturn____0 = (fun projectee -> (match (projectee) with
| EReturn (_81_83) -> begin
_81_83
end))


let ___EFlat____0 = (fun projectee -> (match (projectee) with
| EFlat (_81_86) -> begin
_81_86
end))


let ___EField____0 = (fun projectee -> (match (projectee) with
| EField (_81_89) -> begin
_81_89
end))


let ___EWhile____0 = (fun projectee -> (match (projectee) with
| EWhile (_81_92) -> begin
_81_92
end))


let ___EBufCreateL____0 = (fun projectee -> (match (projectee) with
| EBufCreateL (_81_95) -> begin
_81_95
end))


let ___ETuple____0 = (fun projectee -> (match (projectee) with
| ETuple (_81_98) -> begin
_81_98
end))


let ___ECons____0 = (fun projectee -> (match (projectee) with
| ECons (_81_101) -> begin
_81_101
end))


let ___EBufFill____0 = (fun projectee -> (match (projectee) with
| EBufFill (_81_104) -> begin
_81_104
end))


let ___PBool____0 = (fun projectee -> (match (projectee) with
| PBool (_81_107) -> begin
_81_107
end))


let ___PVar____0 = (fun projectee -> (match (projectee) with
| PVar (_81_110) -> begin
_81_110
end))


let ___PCons____0 = (fun projectee -> (match (projectee) with
| PCons (_81_113) -> begin
_81_113
end))


let ___PTuple____0 = (fun projectee -> (match (projectee) with
| PTuple (_81_116) -> begin
_81_116
end))


let ___PRecord____0 = (fun projectee -> (match (projectee) with
| PRecord (_81_119) -> begin
_81_119
end))


let ___TInt____0 = (fun projectee -> (match (projectee) with
| TInt (_81_123) -> begin
_81_123
end))


let ___TBuf____0 = (fun projectee -> (match (projectee) with
| TBuf (_81_126) -> begin
_81_126
end))


let ___TQualified____0 = (fun projectee -> (match (projectee) with
| TQualified (_81_129) -> begin
_81_129
end))


let ___TArrow____0 = (fun projectee -> (match (projectee) with
| TArrow (_81_132) -> begin
_81_132
end))


let ___TBound____0 = (fun projectee -> (match (projectee) with
| TBound (_81_135) -> begin
_81_135
end))


let ___TApp____0 = (fun projectee -> (match (projectee) with
| TApp (_81_138) -> begin
_81_138
end))


let ___TTuple____0 = (fun projectee -> (match (projectee) with
| TTuple (_81_141) -> begin
_81_141
end))


type version =
Prims.int


let current_version : version = (Prims.parse_int "17")


type file =
(Prims.string * program)


type binary_format =
(version * file Prims.list)


let fst3 = (fun _81_147 -> (match (_81_147) with
| (x, _81_144, _81_146) -> begin
x
end))


let snd3 = (fun _81_153 -> (match (_81_153) with
| (_81_149, x, _81_152) -> begin
x
end))


let thd3 = (fun _81_159 -> (match (_81_159) with
| (_81_155, _81_157, x) -> begin
x
end))


let mk_width : Prims.string  ->  width Prims.option = (fun _81_1 -> (match (_81_1) with
| "UInt8" -> begin
Some (UInt8)
end
| "UInt16" -> begin
Some (UInt16)
end
| "UInt32" -> begin
Some (UInt32)
end
| "UInt64" -> begin
Some (UInt64)
end
| "Int8" -> begin
Some (Int8)
end
| "Int16" -> begin
Some (Int16)
end
| "Int32" -> begin
Some (Int32)
end
| "Int64" -> begin
Some (Int64)
end
| _81_170 -> begin
None
end))


let mk_bool_op : Prims.string  ->  op Prims.option = (fun _81_2 -> (match (_81_2) with
| "op_Negation" -> begin
Some (Not)
end
| "op_AmpAmp" -> begin
Some (And)
end
| "op_BarBar" -> begin
Some (Or)
end
| "op_Equality" -> begin
Some (Eq)
end
| "op_disEquality" -> begin
Some (Neq)
end
| _81_178 -> begin
None
end))


let is_bool_op : Prims.string  ->  Prims.bool = (fun op -> ((mk_bool_op op) <> None))


let mk_op : Prims.string  ->  op Prims.option = (fun _81_3 -> (match (_81_3) with
| ("add") | ("op_Plus_Hat") -> begin
Some (Add)
end
| ("add_mod") | ("op_Plus_Percent_Hat") -> begin
Some (AddW)
end
| ("sub") | ("op_Subtraction_Hat") -> begin
Some (Sub)
end
| ("sub_mod") | ("op_Subtraction_Percent_Hat") -> begin
Some (SubW)
end
| ("mul") | ("op_Star_Hat") -> begin
Some (Mult)
end
| ("mul_mod") | ("op_Star_Percent_Hat") -> begin
Some (MultW)
end
| ("div") | ("op_Slash_Hat") -> begin
Some (Div)
end
| ("div_mod") | ("op_Slash_Percent_Hat") -> begin
Some (DivW)
end
| ("rem") | ("op_Percent_Hat") -> begin
Some (Mod)
end
| ("logor") | ("op_Bar_Hat") -> begin
Some (BOr)
end
| ("logxor") | ("op_Hat_Hat") -> begin
Some (BXor)
end
| ("logand") | ("op_Amp_Hat") -> begin
Some (BAnd)
end
| "lognot" -> begin
Some (BNot)
end
| ("shift_right") | ("op_Greater_Greater_Hat") -> begin
Some (BShiftR)
end
| ("shift_left") | ("op_Less_Less_Hat") -> begin
Some (BShiftL)
end
| ("eq") | ("op_Equals_Hat") -> begin
Some (Eq)
end
| ("op_Greater_Hat") | ("gt") -> begin
Some (Gt)
end
| ("op_Greater_Equals_Hat") | ("gte") -> begin
Some (Gte)
end
| ("op_Less_Hat") | ("lt") -> begin
Some (Lt)
end
| ("op_Less_Equals_Hat") | ("lte") -> begin
Some (Lte)
end
| _81_221 -> begin
None
end))


let is_op : Prims.string  ->  Prims.bool = (fun op -> ((mk_op op) <> None))


let is_machine_int : Prims.string  ->  Prims.bool = (fun m -> ((mk_width m) <> None))


type env =
{names : name Prims.list; names_t : Prims.string Prims.list; module_name : Prims.string Prims.list} 
 and name =
{pretty : Prims.string; mut : Prims.bool}


let is_Mkenv : env  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkenv"))))


let is_Mkname : name  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkname"))))


let empty : Prims.string Prims.list  ->  env = (fun module_name -> {names = []; names_t = []; module_name = module_name})


let extend : env  ->  Prims.string  ->  Prims.bool  ->  env = (fun env x is_mut -> (

let _81_235 = env
in {names = ({pretty = x; mut = is_mut})::env.names; names_t = _81_235.names_t; module_name = _81_235.module_name}))


let extend_t : env  ->  Prims.string  ->  env = (fun env x -> (

let _81_239 = env
in {names = _81_239.names; names_t = (x)::env.names_t; module_name = _81_239.module_name}))


let find_name : env  ->  Prims.string  ->  name = (fun env x -> (match ((FStar_List.tryFind (fun name -> (name.pretty = x)) env.names)) with
| Some (name) -> begin
name
end
| None -> begin
(FStar_All.failwith "internal error: name not found")
end))


let is_mutable : env  ->  Prims.string  ->  Prims.bool = (fun env x -> (let _176_716 = (find_name env x)
in _176_716.mut))


let find : env  ->  Prims.string  ->  Prims.int = (fun env x -> try
(match (()) with
| () -> begin
(FStar_List.index (fun name -> (name.pretty = x)) env.names)
end)
with
| _81_255 -> begin
(let _176_724 = (FStar_Util.format1 "Internal error: name not found %s\n" x)
in (FStar_All.failwith _176_724))
end)


let find_t : env  ->  Prims.string  ->  Prims.int = (fun env x -> try
(match (()) with
| () -> begin
(FStar_List.index (fun name -> (name = x)) env.names_t)
end)
with
| _81_265 -> begin
(let _176_732 = (FStar_Util.format1 "Internal error: name not found %s\n" x)
in (FStar_All.failwith _176_732))
end)


let add_binders = (fun env binders -> (FStar_List.fold_left (fun env _81_278 -> (match (_81_278) with
| ((name, _81_274), _81_277) -> begin
(extend env name false)
end)) env binders))


let rec translate : FStar_Extraction_ML_Syntax.mllib  ->  file Prims.list = (fun _81_280 -> (match (_81_280) with
| FStar_Extraction_ML_Syntax.MLLib (modules) -> begin
(FStar_List.filter_map (fun m -> (

let m_name = (

let _81_289 = m
in (match (_81_289) with
| ((prefix, final), _81_286, _81_288) -> begin
(FStar_String.concat "." (FStar_List.append prefix ((final)::[])))
end))
in try
(match (()) with
| () -> begin
(

let _81_299 = (FStar_Util.print1 "Attempting to translate module %s\n" m_name)
in (let _176_764 = (translate_module m)
in Some (_176_764)))
end)
with
| e -> begin
(

let _81_295 = (let _176_766 = (FStar_Util.print_exn e)
in (FStar_Util.print2 "Unable to translate module: %s because:\n  %s\n" m_name _176_766))
in None)
end)) modules)
end))
and translate_module : ((Prims.string Prims.list * Prims.string) * (FStar_Extraction_ML_Syntax.mlsig * FStar_Extraction_ML_Syntax.mlmodule) Prims.option * FStar_Extraction_ML_Syntax.mllib)  ->  file = (fun _81_305 -> (match (_81_305) with
| (module_name, modul, _81_304) -> begin
(

let module_name = (FStar_List.append (Prims.fst module_name) (((Prims.snd module_name))::[]))
in (

let program = (match (modul) with
| Some (_signature, decls) -> begin
(FStar_List.filter_map (translate_decl (empty module_name)) decls)
end
| _81_312 -> begin
(FStar_All.failwith "Unexpected standalone interface or nested modules")
end)
in (((FStar_String.concat "_" module_name)), (program))))
end))
and translate_decl : env  ->  FStar_Extraction_ML_Syntax.mlmodule1  ->  decl Prims.option = (fun env d -> (match (d) with
| (FStar_Extraction_ML_Syntax.MLM_Let (flavor, flags, ({FStar_Extraction_ML_Syntax.mllb_name = (name, _); FStar_Extraction_ML_Syntax.mllb_tysc = Some ([], t0); FStar_Extraction_ML_Syntax.mllb_add_unit = _; FStar_Extraction_ML_Syntax.mllb_def = {FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Fun (args, body); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}; FStar_Extraction_ML_Syntax.print_typ = _})::[])) | (FStar_Extraction_ML_Syntax.MLM_Let (flavor, flags, ({FStar_Extraction_ML_Syntax.mllb_name = (name, _); FStar_Extraction_ML_Syntax.mllb_tysc = Some ([], t0); FStar_Extraction_ML_Syntax.mllb_add_unit = _; FStar_Extraction_ML_Syntax.mllb_def = {FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Coerce ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Fun (args, body); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}, _, _); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}; FStar_Extraction_ML_Syntax.print_typ = _})::[])) -> begin
(

let assumed = (FStar_Util.for_some (fun _81_4 -> (match (_81_4) with
| FStar_Extraction_ML_Syntax.Assumed -> begin
true
end
| _81_378 -> begin
false
end)) flags)
in (

let flags = if (FStar_Util.for_some (fun _81_5 -> (match (_81_5) with
| FStar_Extraction_ML_Syntax.Private -> begin
true
end
| _81_383 -> begin
false
end)) flags) then begin
(Private)::[]
end else begin
[]
end
in (

let env = if (flavor = FStar_Extraction_ML_Syntax.Rec) then begin
(extend env name false)
end else begin
env
end
in (

let rec find_return_type = (fun _81_6 -> (match (_81_6) with
| FStar_Extraction_ML_Syntax.MLTY_Fun (_81_389, _81_391, t) -> begin
(find_return_type t)
end
| t -> begin
t
end))
in (

let t = (let _176_774 = (find_return_type t0)
in (translate_type env _176_774))
in (

let binders = (translate_binders env args)
in (

let env = (add_binders env args)
in (

let name = ((env.module_name), (name))
in if assumed then begin
(let _176_777 = (let _176_776 = (let _176_775 = (translate_type env t0)
in ((None), (name), (_176_775)))
in DExternal (_176_776))
in Some (_176_777))
end else begin
try
(match (()) with
| () -> begin
(

let body = (translate_expr env body)
in Some (DFunction (((None), (flags), (t), (name), (binders), (body)))))
end)
with
| e -> begin
(

let _81_404 = (let _176_780 = (FStar_Util.print_exn e)
in (FStar_Util.print2 "Warning: writing a stub for %s (%s)\n" (Prims.snd name) _176_780))
in Some (DFunction (((None), (flags), (t), (name), (binders), (EAbort)))))
end
end))))))))
end
| FStar_Extraction_ML_Syntax.MLM_Let (flavor, flags, ({FStar_Extraction_ML_Syntax.mllb_name = (name, _81_422); FStar_Extraction_ML_Syntax.mllb_tysc = Some ([], t); FStar_Extraction_ML_Syntax.mllb_add_unit = _81_415; FStar_Extraction_ML_Syntax.mllb_def = expr; FStar_Extraction_ML_Syntax.print_typ = _81_412})::[]) -> begin
(

let flags = if (FStar_Util.for_some (fun _81_7 -> (match (_81_7) with
| FStar_Extraction_ML_Syntax.Private -> begin
true
end
| _81_431 -> begin
false
end)) flags) then begin
(Private)::[]
end else begin
[]
end
in (

let t = (translate_type env t)
in (

let name = ((env.module_name), (name))
in try
(match (()) with
| () -> begin
(

let expr = (translate_expr env expr)
in Some (DGlobal (((flags), (name), (t), (expr)))))
end)
with
| e -> begin
(

let _81_439 = (let _176_784 = (FStar_Util.print_exn e)
in (FStar_Util.print2 "Warning: not translating definition for %s (%s)\n" (Prims.snd name) _176_784))
in Some (DGlobal (((flags), (name), (t), (EAny)))))
end)))
end
| FStar_Extraction_ML_Syntax.MLM_Let (_81_445, _81_447, ({FStar_Extraction_ML_Syntax.mllb_name = (name, _81_459); FStar_Extraction_ML_Syntax.mllb_tysc = ts; FStar_Extraction_ML_Syntax.mllb_add_unit = _81_455; FStar_Extraction_ML_Syntax.mllb_def = _81_453; FStar_Extraction_ML_Syntax.print_typ = _81_451})::_81_449) -> begin
(

let _81_465 = (FStar_Util.print1 "Warning: not translating definition for %s (and possibly others)\n" name)
in (

let _81_472 = (match (ts) with
| Some (idents, t) -> begin
(let _176_787 = (let _176_785 = (FStar_List.map Prims.fst idents)
in (FStar_String.concat ", " _176_785))
in (let _176_786 = (FStar_Extraction_ML_Code.string_of_mlty (([]), ("")) t)
in (FStar_Util.print2 "Type scheme is: forall %s. %s\n" _176_787 _176_786)))
end
| None -> begin
()
end)
in None))
end
| FStar_Extraction_ML_Syntax.MLM_Let (_81_475) -> begin
(FStar_All.failwith "impossible")
end
| FStar_Extraction_ML_Syntax.MLM_Loc (_81_478) -> begin
None
end
| FStar_Extraction_ML_Syntax.MLM_Ty (((assumed, name, _mangled_name, args, Some (FStar_Extraction_ML_Syntax.MLTD_Abbrev (t))))::[]) -> begin
(

let name = ((env.module_name), (name))
in (

let env = (FStar_List.fold_left (fun env _81_495 -> (match (_81_495) with
| (name, _81_494) -> begin
(extend_t env name)
end)) env args)
in if assumed then begin
None
end else begin
(let _176_792 = (let _176_791 = (let _176_790 = (translate_type env t)
in ((name), ((FStar_List.length args)), (_176_790)))
in DTypeAlias (_176_791))
in Some (_176_792))
end))
end
| FStar_Extraction_ML_Syntax.MLM_Ty (((_81_498, name, _mangled_name, [], Some (FStar_Extraction_ML_Syntax.MLTD_Record (fields))))::[]) -> begin
(

let name = ((env.module_name), (name))
in (let _176_798 = (let _176_797 = (let _176_796 = (FStar_List.map (fun _81_511 -> (match (_81_511) with
| (f, t) -> begin
(let _176_795 = (let _176_794 = (translate_type env t)
in ((_176_794), (false)))
in ((f), (_176_795)))
end)) fields)
in ((name), (_176_796)))
in DTypeFlat (_176_797))
in Some (_176_798)))
end
| FStar_Extraction_ML_Syntax.MLM_Ty (((_81_513, name, _mangled_name, [], Some (FStar_Extraction_ML_Syntax.MLTD_DType (branches))))::[]) -> begin
(

let name = ((env.module_name), (name))
in (let _176_811 = (let _176_810 = (let _176_809 = (FStar_List.mapi (fun i _81_527 -> (match (_81_527) with
| (cons, ts) -> begin
(let _176_808 = (FStar_List.mapi (fun j t -> (let _176_807 = (let _176_804 = (FStar_Util.string_of_int i)
in (let _176_803 = (FStar_Util.string_of_int j)
in (FStar_Util.format2 "x%s%s" _176_804 _176_803)))
in (let _176_806 = (let _176_805 = (translate_type env t)
in ((_176_805), (false)))
in ((_176_807), (_176_806))))) ts)
in ((cons), (_176_808)))
end)) branches)
in ((name), (_176_809)))
in DTypeVariant (_176_810))
in Some (_176_811)))
end
| FStar_Extraction_ML_Syntax.MLM_Ty (((_81_533, name, _mangled_name, _81_537, _81_539))::_81_531) -> begin
(

let _81_543 = (FStar_Util.print1 "Warning: not translating definition for %s (and possibly others)\n" name)
in None)
end
| FStar_Extraction_ML_Syntax.MLM_Ty ([]) -> begin
(

let _81_547 = (FStar_Util.print_string "Impossible!! Empty block of mutually recursive type declarations")
in None)
end
| FStar_Extraction_ML_Syntax.MLM_Top (_81_550) -> begin
(FStar_All.failwith "todo: translate_decl [MLM_Top]")
end
| FStar_Extraction_ML_Syntax.MLM_Exn (_81_553) -> begin
(FStar_All.failwith "todo: translate_decl [MLM_Exn]")
end))
and translate_type : env  ->  FStar_Extraction_ML_Syntax.mlty  ->  typ = (fun env t -> (match (t) with
| (FStar_Extraction_ML_Syntax.MLTY_Tuple ([])) | (FStar_Extraction_ML_Syntax.MLTY_Top) -> begin
TUnit
end
| FStar_Extraction_ML_Syntax.MLTY_Var (name, _81_562) -> begin
(let _176_814 = (find_t env name)
in TBound (_176_814))
end
| FStar_Extraction_ML_Syntax.MLTY_Fun (t1, _81_567, t2) -> begin
(let _176_817 = (let _176_816 = (translate_type env t1)
in (let _176_815 = (translate_type env t2)
in ((_176_816), (_176_815))))
in TArrow (_176_817))
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "Prims.unit") -> begin
TUnit
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "Prims.bool") -> begin
TBool
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.UInt8.t") -> begin
TInt (UInt8)
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.UInt16.t") -> begin
TInt (UInt16)
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.UInt32.t") -> begin
TInt (UInt32)
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.UInt64.t") -> begin
TInt (UInt64)
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Int8.t") -> begin
TInt (Int8)
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Int16.t") -> begin
TInt (Int16)
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Int32.t") -> begin
TInt (Int32)
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Int64.t") -> begin
TInt (Int64)
end
| FStar_Extraction_ML_Syntax.MLTY_Named ((arg)::[], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.buffer") -> begin
(let _176_818 = (translate_type env arg)
in TBuf (_176_818))
end
| FStar_Extraction_ML_Syntax.MLTY_Named ((_81_617)::[], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Ghost.erased") -> begin
TAny
end
| FStar_Extraction_ML_Syntax.MLTY_Named ([], (path, type_name)) -> begin
TQualified (((path), (type_name)))
end
| FStar_Extraction_ML_Syntax.MLTY_Named (args, (("Prims")::[], t)) when (FStar_Util.starts_with t "tuple") -> begin
(let _176_819 = (FStar_List.map (translate_type env) args)
in TTuple (_176_819))
end
| FStar_Extraction_ML_Syntax.MLTY_Named (args, (path, type_name)) -> begin
(let _176_821 = (let _176_820 = (FStar_List.map (translate_type env) args)
in ((((path), (type_name))), (_176_820)))
in TApp (_176_821))
end
| FStar_Extraction_ML_Syntax.MLTY_Tuple (ts) -> begin
(let _176_822 = (FStar_List.map (translate_type env) ts)
in TTuple (_176_822))
end))
and translate_binders : env  ->  (FStar_Extraction_ML_Syntax.mlident * FStar_Extraction_ML_Syntax.mlty) Prims.list  ->  binder Prims.list = (fun env args -> (FStar_List.map (translate_binder env) args))
and translate_binder : env  ->  (FStar_Extraction_ML_Syntax.mlident * FStar_Extraction_ML_Syntax.mlty)  ->  binder = (fun env _81_651 -> (match (_81_651) with
| ((name, _81_648), typ) -> begin
(let _176_827 = (translate_type env typ)
in {name = name; typ = _176_827; mut = false})
end))
and translate_expr : env  ->  FStar_Extraction_ML_Syntax.mlexpr  ->  expr = (fun env e -> (match (e.FStar_Extraction_ML_Syntax.expr) with
| FStar_Extraction_ML_Syntax.MLE_Tuple ([]) -> begin
EUnit
end
| FStar_Extraction_ML_Syntax.MLE_Const (c) -> begin
(translate_constant c)
end
| FStar_Extraction_ML_Syntax.MLE_Var (name, _81_660) -> begin
(let _176_830 = (find env name)
in EBound (_176_830))
end
| FStar_Extraction_ML_Syntax.MLE_Name (("FStar")::(m)::[], op) when ((is_machine_int m) && (is_op op)) -> begin
(let _176_833 = (let _176_832 = (FStar_Util.must (mk_op op))
in (let _176_831 = (FStar_Util.must (mk_width m))
in ((_176_832), (_176_831))))
in EOp (_176_833))
end
| FStar_Extraction_ML_Syntax.MLE_Name (("Prims")::[], op) when (is_bool_op op) -> begin
(let _176_835 = (let _176_834 = (FStar_Util.must (mk_bool_op op))
in ((_176_834), (Bool)))
in EOp (_176_835))
end
| FStar_Extraction_ML_Syntax.MLE_Name (n) -> begin
EQualified (n)
end
| FStar_Extraction_ML_Syntax.MLE_Let ((flavor, flags, ({FStar_Extraction_ML_Syntax.mllb_name = (name, _81_687); FStar_Extraction_ML_Syntax.mllb_tysc = Some ([], typ); FStar_Extraction_ML_Syntax.mllb_add_unit = add_unit; FStar_Extraction_ML_Syntax.mllb_def = body; FStar_Extraction_ML_Syntax.print_typ = print})::[]), continuation) -> begin
(

let is_mut = (FStar_Util.for_some (fun _81_8 -> (match (_81_8) with
| FStar_Extraction_ML_Syntax.Mutable -> begin
true
end
| _81_698 -> begin
false
end)) flags)
in (

let _81_722 = if is_mut then begin
(let _176_840 = (match (typ) with
| FStar_Extraction_ML_Syntax.MLTY_Named ((t)::[], p) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.ST.stackref") -> begin
t
end
| _81_706 -> begin
(let _176_838 = (let _176_837 = (FStar_Extraction_ML_Code.string_of_mlty (([]), ("")) typ)
in (FStar_Util.format1 "unexpected: bad desugaring of Mutable (typ is %s)" _176_837))
in (FStar_All.failwith _176_838))
end)
in (let _176_839 = (match (body) with
| {FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_App (_81_712, (body)::[]); FStar_Extraction_ML_Syntax.mlty = _81_710; FStar_Extraction_ML_Syntax.loc = _81_708} -> begin
body
end
| _81_719 -> begin
(FStar_All.failwith "unexpected: bad desugaring of Mutable")
end)
in ((_176_840), (_176_839))))
end else begin
((typ), (body))
end
in (match (_81_722) with
| (typ, body) -> begin
(

let binder = (let _176_841 = (translate_type env typ)
in {name = name; typ = _176_841; mut = is_mut})
in (

let body = (translate_expr env body)
in (

let env = (extend env name is_mut)
in (

let continuation = (translate_expr env continuation)
in ELet (((binder), (body), (continuation)))))))
end)))
end
| FStar_Extraction_ML_Syntax.MLE_Match (expr, branches) -> begin
(let _176_844 = (let _176_843 = (translate_expr env expr)
in (let _176_842 = (translate_branches env branches)
in ((_176_843), (_176_842))))
in EMatch (_176_844))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_734; FStar_Extraction_ML_Syntax.loc = _81_732}, ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Var (v, _81_744); FStar_Extraction_ML_Syntax.mlty = _81_741; FStar_Extraction_ML_Syntax.loc = _81_739})::[]) when (((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.ST.op_Bang") && (is_mutable env v)) -> begin
(let _176_845 = (find env v)
in EBound (_176_845))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_754; FStar_Extraction_ML_Syntax.loc = _81_752}, ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Var (v, _81_765); FStar_Extraction_ML_Syntax.mlty = _81_762; FStar_Extraction_ML_Syntax.loc = _81_760})::(e)::[]) when (((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.ST.op_Colon_Equals") && (is_mutable env v)) -> begin
(let _176_849 = (let _176_848 = (let _176_846 = (find env v)
in EBound (_176_846))
in (let _176_847 = (translate_expr env e)
in ((_176_848), (_176_847))))
in EAssign (_176_849))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_775; FStar_Extraction_ML_Syntax.loc = _81_773}, (e1)::(e2)::[]) when (((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.index") || ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.op_Array_Access")) -> begin
(let _176_852 = (let _176_851 = (translate_expr env e1)
in (let _176_850 = (translate_expr env e2)
in ((_176_851), (_176_850))))
in EBufRead (_176_852))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_787; FStar_Extraction_ML_Syntax.loc = _81_785}, (e1)::(e2)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.create") -> begin
(let _176_855 = (let _176_854 = (translate_expr env e1)
in (let _176_853 = (translate_expr env e2)
in ((_176_854), (_176_853))))
in EBufCreate (_176_855))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_799; FStar_Extraction_ML_Syntax.loc = _81_797}, (e2)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.createL") -> begin
(

let rec list_elements = (fun acc e2 -> (match (e2.FStar_Extraction_ML_Syntax.expr) with
| FStar_Extraction_ML_Syntax.MLE_CTor ((("Prims")::[], "Cons"), (hd)::(tl)::[]) -> begin
(list_elements ((hd)::acc) tl)
end
| FStar_Extraction_ML_Syntax.MLE_CTor ((("Prims")::[], "Nil"), []) -> begin
(FStar_List.rev acc)
end
| _81_827 -> begin
(FStar_All.failwith "Argument of FStar.Buffer.createL is not a string literal!")
end))
in (

let list_elements = (list_elements [])
in (let _176_862 = (let _176_861 = (list_elements e2)
in (FStar_List.map (translate_expr env) _176_861))
in EBufCreateL (_176_862))))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_832; FStar_Extraction_ML_Syntax.loc = _81_830}, (e1)::(e2)::(_e3)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.sub") -> begin
(let _176_865 = (let _176_864 = (translate_expr env e1)
in (let _176_863 = (translate_expr env e2)
in ((_176_864), (_176_863))))
in EBufSub (_176_865))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_845; FStar_Extraction_ML_Syntax.loc = _81_843}, (e1)::(e2)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.offset") -> begin
(let _176_868 = (let _176_867 = (translate_expr env e1)
in (let _176_866 = (translate_expr env e2)
in ((_176_867), (_176_866))))
in EBufSub (_176_868))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_857; FStar_Extraction_ML_Syntax.loc = _81_855}, (e1)::(e2)::(e3)::[]) when (((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.upd") || ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.op_Array_Assignment")) -> begin
(let _176_872 = (let _176_871 = (translate_expr env e1)
in (let _176_870 = (translate_expr env e2)
in (let _176_869 = (translate_expr env e3)
in ((_176_871), (_176_870), (_176_869)))))
in EBufWrite (_176_872))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_870; FStar_Extraction_ML_Syntax.loc = _81_868}, (_81_875)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.ST.push_frame") -> begin
EPushFrame
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_882; FStar_Extraction_ML_Syntax.loc = _81_880}, (_81_887)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.ST.pop_frame") -> begin
EPopFrame
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_894; FStar_Extraction_ML_Syntax.loc = _81_892}, (e1)::(e2)::(e3)::(e4)::(e5)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.blit") -> begin
(let _176_878 = (let _176_877 = (translate_expr env e1)
in (let _176_876 = (translate_expr env e2)
in (let _176_875 = (translate_expr env e3)
in (let _176_874 = (translate_expr env e4)
in (let _176_873 = (translate_expr env e5)
in ((_176_877), (_176_876), (_176_875), (_176_874), (_176_873)))))))
in EBufBlit (_176_878))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_909; FStar_Extraction_ML_Syntax.loc = _81_907}, (e1)::(e2)::(e3)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.Buffer.fill") -> begin
(let _176_882 = (let _176_881 = (translate_expr env e1)
in (let _176_880 = (translate_expr env e2)
in (let _176_879 = (translate_expr env e3)
in ((_176_881), (_176_880), (_176_879)))))
in EBufFill (_176_882))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_922; FStar_Extraction_ML_Syntax.loc = _81_920}, (_81_927)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "FStar.ST.get") -> begin
ECast (((EConstant (((UInt8), ("0")))), (TAny)))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (p); FStar_Extraction_ML_Syntax.mlty = _81_934; FStar_Extraction_ML_Syntax.loc = _81_932}, (e)::[]) when ((FStar_Extraction_ML_Syntax.string_of_mlpath p) = "Obj.repr") -> begin
(let _176_884 = (let _176_883 = (translate_expr env e)
in ((_176_883), (TAny)))
in ECast (_176_884))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (("FStar")::(m)::[], op); FStar_Extraction_ML_Syntax.mlty = _81_945; FStar_Extraction_ML_Syntax.loc = _81_943}, args) when ((is_machine_int m) && (is_op op)) -> begin
(let _176_886 = (FStar_Util.must (mk_width m))
in (let _176_885 = (FStar_Util.must (mk_op op))
in (mk_op_app env _176_886 _176_885 args)))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (("Prims")::[], op); FStar_Extraction_ML_Syntax.mlty = _81_959; FStar_Extraction_ML_Syntax.loc = _81_957}, args) when (is_bool_op op) -> begin
(let _176_887 = (FStar_Util.must (mk_bool_op op))
in (mk_op_app env Bool _176_887 args))
end
| (FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (("FStar")::(m)::[], "int_to_t"); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}, ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_Int (c, None)); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _})::[])) | (FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (("FStar")::(m)::[], "uint_to_t"); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _}, ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Const (FStar_Extraction_ML_Syntax.MLC_Int (c, None)); FStar_Extraction_ML_Syntax.mlty = _; FStar_Extraction_ML_Syntax.loc = _})::[])) when (is_machine_int m) -> begin
(let _176_889 = (let _176_888 = (FStar_Util.must (mk_width m))
in ((_176_888), (c)))
in EConstant (_176_889))
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (("FStar")::("Int")::("Cast")::[], c); FStar_Extraction_ML_Syntax.mlty = _81_1018; FStar_Extraction_ML_Syntax.loc = _81_1016}, (arg)::[]) -> begin
(

let is_known_type = ((((((((FStar_Util.starts_with c "uint8") || (FStar_Util.starts_with c "uint16")) || (FStar_Util.starts_with c "uint32")) || (FStar_Util.starts_with c "uint64")) || (FStar_Util.starts_with c "int8")) || (FStar_Util.starts_with c "int16")) || (FStar_Util.starts_with c "int32")) || (FStar_Util.starts_with c "int64"))
in if ((FStar_Util.ends_with c "uint64") && is_known_type) then begin
(let _176_891 = (let _176_890 = (translate_expr env arg)
in ((_176_890), (TInt (UInt64))))
in ECast (_176_891))
end else begin
if ((FStar_Util.ends_with c "uint32") && is_known_type) then begin
(let _176_893 = (let _176_892 = (translate_expr env arg)
in ((_176_892), (TInt (UInt32))))
in ECast (_176_893))
end else begin
if ((FStar_Util.ends_with c "uint16") && is_known_type) then begin
(let _176_895 = (let _176_894 = (translate_expr env arg)
in ((_176_894), (TInt (UInt16))))
in ECast (_176_895))
end else begin
if ((FStar_Util.ends_with c "uint8") && is_known_type) then begin
(let _176_897 = (let _176_896 = (translate_expr env arg)
in ((_176_896), (TInt (UInt8))))
in ECast (_176_897))
end else begin
if ((FStar_Util.ends_with c "int64") && is_known_type) then begin
(let _176_899 = (let _176_898 = (translate_expr env arg)
in ((_176_898), (TInt (Int64))))
in ECast (_176_899))
end else begin
if ((FStar_Util.ends_with c "int32") && is_known_type) then begin
(let _176_901 = (let _176_900 = (translate_expr env arg)
in ((_176_900), (TInt (Int32))))
in ECast (_176_901))
end else begin
if ((FStar_Util.ends_with c "int16") && is_known_type) then begin
(let _176_903 = (let _176_902 = (translate_expr env arg)
in ((_176_902), (TInt (Int16))))
in ECast (_176_903))
end else begin
if ((FStar_Util.ends_with c "int8") && is_known_type) then begin
(let _176_905 = (let _176_904 = (translate_expr env arg)
in ((_176_904), (TInt (Int8))))
in ECast (_176_905))
end else begin
(let _176_908 = (let _176_907 = (let _176_906 = (translate_expr env arg)
in (_176_906)::[])
in ((EQualified (((("FStar")::("Int")::("Cast")::[]), (c)))), (_176_907)))
in EApp (_176_908))
end
end
end
end
end
end
end
end)
end
| FStar_Extraction_ML_Syntax.MLE_App ({FStar_Extraction_ML_Syntax.expr = FStar_Extraction_ML_Syntax.MLE_Name (path, function_name); FStar_Extraction_ML_Syntax.mlty = _81_1035; FStar_Extraction_ML_Syntax.loc = _81_1033}, args) -> begin
(let _176_910 = (let _176_909 = (FStar_List.map (translate_expr env) args)
in ((EQualified (((path), (function_name)))), (_176_909)))
in EApp (_176_910))
end
| FStar_Extraction_ML_Syntax.MLE_Coerce (e, t_from, t_to) -> begin
(let _176_913 = (let _176_912 = (translate_expr env e)
in (let _176_911 = (translate_type env t_to)
in ((_176_912), (_176_911))))
in ECast (_176_913))
end
| FStar_Extraction_ML_Syntax.MLE_Record (_81_1050, fields) -> begin
(let _176_918 = (let _176_917 = (assert_lid e.FStar_Extraction_ML_Syntax.mlty)
in (let _176_916 = (FStar_List.map (fun _81_1056 -> (match (_81_1056) with
| (field, expr) -> begin
(let _176_915 = (translate_expr env expr)
in ((field), (_176_915)))
end)) fields)
in ((_176_917), (_176_916))))
in EFlat (_176_918))
end
| FStar_Extraction_ML_Syntax.MLE_Proj (e, path) -> begin
(let _176_921 = (let _176_920 = (assert_lid e.FStar_Extraction_ML_Syntax.mlty)
in (let _176_919 = (translate_expr env e)
in ((_176_920), (_176_919), ((Prims.snd path)))))
in EField (_176_921))
end
| FStar_Extraction_ML_Syntax.MLE_Let (_81_1062) -> begin
(FStar_All.failwith "todo: translate_expr [MLE_Let]")
end
| FStar_Extraction_ML_Syntax.MLE_App (head, _81_1066) -> begin
(let _176_923 = (let _176_922 = (FStar_Extraction_ML_Code.string_of_mlexpr (([]), ("")) head)
in (FStar_Util.format1 "todo: translate_expr [MLE_App] (head is: %s)" _176_922))
in (FStar_All.failwith _176_923))
end
| FStar_Extraction_ML_Syntax.MLE_Seq (seqs) -> begin
(let _176_924 = (FStar_List.map (translate_expr env) seqs)
in ESequence (_176_924))
end
| FStar_Extraction_ML_Syntax.MLE_Tuple (es) -> begin
(let _176_925 = (FStar_List.map (translate_expr env) es)
in ETuple (_176_925))
end
| FStar_Extraction_ML_Syntax.MLE_CTor ((_81_1074, cons), es) -> begin
(let _176_928 = (let _176_927 = (assert_lid e.FStar_Extraction_ML_Syntax.mlty)
in (let _176_926 = (FStar_List.map (translate_expr env) es)
in ((_176_927), (cons), (_176_926))))
in ECons (_176_928))
end
| FStar_Extraction_ML_Syntax.MLE_Fun (_81_1081) -> begin
(FStar_All.failwith "todo: translate_expr [MLE_Fun]")
end
| FStar_Extraction_ML_Syntax.MLE_If (_81_1084) -> begin
(FStar_All.failwith "todo: translate_expr [MLE_If]")
end
| FStar_Extraction_ML_Syntax.MLE_Raise (_81_1087) -> begin
(FStar_All.failwith "todo: translate_expr [MLE_Raise]")
end
| FStar_Extraction_ML_Syntax.MLE_Try (_81_1090) -> begin
(FStar_All.failwith "todo: translate_expr [MLE_Try]")
end
| FStar_Extraction_ML_Syntax.MLE_Coerce (_81_1093) -> begin
(FStar_All.failwith "todo: translate_expr [MLE_Coerce]")
end))
and assert_lid : FStar_Extraction_ML_Syntax.mlty  ->  lident = (fun t -> (match (t) with
| FStar_Extraction_ML_Syntax.MLTY_Named ([], lid) -> begin
lid
end
| _81_1101 -> begin
(FStar_All.failwith "invalid argument: assert_lid")
end))
and translate_branches : env  ->  FStar_Extraction_ML_Syntax.mlbranch Prims.list  ->  branches = (fun env branches -> (FStar_List.map (translate_branch env) branches))
and translate_branch : env  ->  FStar_Extraction_ML_Syntax.mlbranch  ->  (pattern * expr) = (fun env _81_1108 -> (match (_81_1108) with
| (pat, guard, expr) -> begin
if (guard = None) then begin
(

let _81_1111 = (translate_pat env pat)
in (match (_81_1111) with
| (env, pat) -> begin
(let _176_934 = (translate_expr env expr)
in ((pat), (_176_934)))
end))
end else begin
(FStar_All.failwith "todo: translate_branch")
end
end))
and translate_pat : env  ->  FStar_Extraction_ML_Syntax.mlpattern  ->  (env * pattern) = (fun env p -> (match (p) with
| FStar_Extraction_ML_Syntax.MLP_Const (FStar_Extraction_ML_Syntax.MLC_Unit) -> begin
((env), (PUnit))
end
| FStar_Extraction_ML_Syntax.MLP_Const (FStar_Extraction_ML_Syntax.MLC_Bool (b)) -> begin
((env), (PBool (b)))
end
| FStar_Extraction_ML_Syntax.MLP_Var (name, _81_1121) -> begin
(

let env = (extend env name false)
in ((env), (PVar ({name = name; typ = TAny; mut = false}))))
end
| FStar_Extraction_ML_Syntax.MLP_Wild -> begin
(

let env = (extend env "_" false)
in ((env), (PVar ({name = "_"; typ = TAny; mut = false}))))
end
| FStar_Extraction_ML_Syntax.MLP_CTor ((_81_1128, cons), ps) -> begin
(

let _81_1143 = (FStar_List.fold_left (fun _81_1136 p -> (match (_81_1136) with
| (env, acc) -> begin
(

let _81_1140 = (translate_pat env p)
in (match (_81_1140) with
| (env, p) -> begin
((env), ((p)::acc))
end))
end)) ((env), ([])) ps)
in (match (_81_1143) with
| (env, ps) -> begin
((env), (PCons (((cons), ((FStar_List.rev ps))))))
end))
end
| FStar_Extraction_ML_Syntax.MLP_Record (_81_1145, ps) -> begin
(

let _81_1160 = (FStar_List.fold_left (fun _81_1151 _81_1154 -> (match (((_81_1151), (_81_1154))) with
| ((env, acc), (field, p)) -> begin
(

let _81_1157 = (translate_pat env p)
in (match (_81_1157) with
| (env, p) -> begin
((env), ((((field), (p)))::acc))
end))
end)) ((env), ([])) ps)
in (match (_81_1160) with
| (env, ps) -> begin
((env), (PRecord ((FStar_List.rev ps))))
end))
end
| FStar_Extraction_ML_Syntax.MLP_Tuple (ps) -> begin
(

let _81_1172 = (FStar_List.fold_left (fun _81_1165 p -> (match (_81_1165) with
| (env, acc) -> begin
(

let _81_1169 = (translate_pat env p)
in (match (_81_1169) with
| (env, p) -> begin
((env), ((p)::acc))
end))
end)) ((env), ([])) ps)
in (match (_81_1172) with
| (env, ps) -> begin
((env), (PTuple ((FStar_List.rev ps))))
end))
end
| FStar_Extraction_ML_Syntax.MLP_Const (_81_1174) -> begin
(FStar_All.failwith "todo: translate_pat [MLP_Const]")
end
| FStar_Extraction_ML_Syntax.MLP_Branch (_81_1177) -> begin
(FStar_All.failwith "todo: translate_pat [MLP_Branch]")
end))
and translate_constant : FStar_Extraction_ML_Syntax.mlconstant  ->  expr = (fun c -> (match (c) with
| FStar_Extraction_ML_Syntax.MLC_Unit -> begin
EUnit
end
| FStar_Extraction_ML_Syntax.MLC_Bool (b) -> begin
EBool (b)
end
| FStar_Extraction_ML_Syntax.MLC_Int (s, Some (_81_1185)) -> begin
(FStar_All.failwith "impossible: machine integer not desugared to a function call")
end
| FStar_Extraction_ML_Syntax.MLC_Float (_81_1190) -> begin
(FStar_All.failwith "todo: translate_expr [MLC_Float]")
end
| FStar_Extraction_ML_Syntax.MLC_Char (_81_1193) -> begin
(FStar_All.failwith "todo: translate_expr [MLC_Char]")
end
| FStar_Extraction_ML_Syntax.MLC_String (_81_1196) -> begin
(FStar_All.failwith "todo: translate_expr [MLC_String]")
end
| FStar_Extraction_ML_Syntax.MLC_Bytes (_81_1199) -> begin
(FStar_All.failwith "todo: translate_expr [MLC_Bytes]")
end
| FStar_Extraction_ML_Syntax.MLC_Int (_81_1202, None) -> begin
(FStar_All.failwith "todo: translate_expr [MLC_Int]")
end))
and mk_op_app : env  ->  width  ->  op  ->  FStar_Extraction_ML_Syntax.mlexpr Prims.list  ->  expr = (fun env w op args -> (let _176_949 = (let _176_948 = (FStar_List.map (translate_expr env) args)
in ((EOp (((op), (w)))), (_176_948)))
in EApp (_176_949)))




