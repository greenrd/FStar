
open Prims

let rec get_next_n_ite : Prims.int  ->  FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term)  ->  (Prims.bool * FStar_ToSMT_Term.term * FStar_ToSMT_Term.term * FStar_ToSMT_Term.term) = (fun n t negs f -> if (n <= (Prims.parse_int "0")) then begin
(let _144_14 = (f FStar_ToSMT_Term.mkTrue)
in ((true), (_144_14), (negs), (t)))
end else begin
(match (t.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.ITE, (g)::(t)::(e)::_49_7) -> begin
(let _144_19 = (let _144_16 = (let _144_15 = (FStar_ToSMT_Term.mkNot g)
in ((negs), (_144_15)))
in (FStar_ToSMT_Term.mkAnd _144_16))
in (get_next_n_ite (n - (Prims.parse_int "1")) e _144_19 (fun x -> (let _144_18 = (FStar_ToSMT_Term.mkITE ((g), (t), (x)))
in (f _144_18)))))
end
| FStar_ToSMT_Term.FreeV (_49_18) -> begin
(let _144_20 = (f FStar_ToSMT_Term.mkTrue)
in ((true), (_144_20), (negs), (t)))
end
| _49_21 -> begin
((false), (FStar_ToSMT_Term.mkFalse), (FStar_ToSMT_Term.mkFalse), (FStar_ToSMT_Term.mkFalse))
end)
end)


let rec is_ite_all_the_way : Prims.int  ->  FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term Prims.list  ->  (Prims.bool * FStar_ToSMT_Term.term Prims.list * FStar_ToSMT_Term.term) = (fun n t negs l -> if (n <= (Prims.parse_int "0")) then begin
(Prims.raise FStar_Util.Impos)
end else begin
(match (t.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.FreeV (_49_27) -> begin
(let _144_31 = (let _144_30 = (let _144_29 = (FStar_ToSMT_Term.mkNot t)
in ((negs), (_144_29)))
in (FStar_ToSMT_Term.mkAnd _144_30))
in ((true), (l), (_144_31)))
end
| _49_30 -> begin
(

let _49_36 = (get_next_n_ite n t negs (fun x -> x))
in (match (_49_36) with
| (b, t, negs', rest) -> begin
if b then begin
(let _144_34 = (let _144_33 = (FStar_ToSMT_Term.mkImp ((negs), (t)))
in (_144_33)::l)
in (is_ite_all_the_way n rest negs' _144_34))
end else begin
((false), ([]), (FStar_ToSMT_Term.mkFalse))
end
end))
end)
end)


let rec parse_query_for_split_cases : Prims.int  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term)  ->  (Prims.bool * ((FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term) * FStar_ToSMT_Term.term Prims.list * FStar_ToSMT_Term.term)) = (fun n t f -> (match (t.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.Quant (FStar_ToSMT_Term.Forall, l, opt, l', t) -> begin
(parse_query_for_split_cases n t (fun x -> (let _144_61 = (FStar_ToSMT_Term.mkForall'' ((l), (opt), (l'), (x)))
in (f _144_61))))
end
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.Imp, (t1)::(t2)::_49_50) -> begin
(

let r = (match (t2.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.Quant (FStar_ToSMT_Term.Forall, _49_59, _49_61, _49_63, _49_65) -> begin
(parse_query_for_split_cases n t2 (fun x -> (let _144_69 = (FStar_ToSMT_Term.mkImp ((t1), (x)))
in (f _144_69))))
end
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.ITE, _49_71) -> begin
(

let _49_77 = (is_ite_all_the_way n t2 FStar_ToSMT_Term.mkTrue [])
in (match (_49_77) with
| (b, l, negs) -> begin
((b), ((((fun x -> (let _144_78 = (FStar_ToSMT_Term.mkImp ((t1), (x)))
in (f _144_78)))), (l), (negs))))
end))
end
| _49_80 -> begin
((false), ((((fun _49_81 -> FStar_ToSMT_Term.mkFalse)), ([]), (FStar_ToSMT_Term.mkFalse))))
end)
in r)
end
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.ITE, _49_86) -> begin
(

let _49_92 = (is_ite_all_the_way n t FStar_ToSMT_Term.mkTrue [])
in (match (_49_92) with
| (b, l, negs) -> begin
((b), (((f), (l), (negs))))
end))
end
| _49_94 -> begin
((false), ((((fun _49_95 -> FStar_ToSMT_Term.mkFalse)), ([]), (FStar_ToSMT_Term.mkFalse))))
end))


let strip_not : FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term = (fun t -> (match (t.FStar_ToSMT_Term.tm) with
| FStar_ToSMT_Term.App (FStar_ToSMT_Term.Not, (hd)::_49_100) -> begin
hd
end
| _49_106 -> begin
t
end))


let rec check_split_cases : (FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term)  ->  FStar_ToSMT_Term.term Prims.list  ->  (FStar_ToSMT_Term.decl  ->  Prims.unit)  ->  Prims.unit = (fun f l check -> (FStar_List.iter (fun t -> (let _144_117 = (let _144_116 = (let _144_115 = (let _144_114 = (f t)
in (FStar_ToSMT_Term.mkNot _144_114))
in ((_144_115), (None)))
in FStar_ToSMT_Term.Assume (_144_116))
in (check _144_117))) (FStar_List.rev l)))


let check_exhaustiveness : (FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term)  ->  FStar_ToSMT_Term.term  ->  (FStar_ToSMT_Term.decl  ->  Prims.unit)  ->  Prims.unit = (fun f negs check -> (let _144_138 = (let _144_137 = (let _144_136 = (let _144_135 = (let _144_134 = (FStar_ToSMT_Term.mkNot negs)
in (f _144_134))
in (FStar_ToSMT_Term.mkNot _144_135))
in ((_144_136), (None)))
in FStar_ToSMT_Term.Assume (_144_137))
in (check _144_138)))


let can_handle_query : Prims.int  ->  FStar_ToSMT_Term.decl  ->  (Prims.bool * ((FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term) * FStar_ToSMT_Term.term Prims.list * FStar_ToSMT_Term.term)) = (fun n q -> (match (q) with
| FStar_ToSMT_Term.Assume (q', _49_118) -> begin
(parse_query_for_split_cases n (strip_not q') (fun x -> x))
end
| _49_123 -> begin
((false), ((((fun x -> x)), ([]), (FStar_ToSMT_Term.mkFalse))))
end))


let handle_query : ((FStar_ToSMT_Term.term  ->  FStar_ToSMT_Term.term) * FStar_ToSMT_Term.term Prims.list * FStar_ToSMT_Term.term)  ->  (FStar_ToSMT_Term.decl  ->  Prims.unit)  ->  Prims.unit = (fun _49_128 check -> (match (_49_128) with
| (f, l, negs) -> begin
(

let l = (check_split_cases f l check)
in (check_exhaustiveness f negs check))
end))




