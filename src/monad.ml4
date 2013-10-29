(*let unfold_apps f xs : Glob_term.glob_constr =
  List.fold_left (fun f x -> Glob_term.GApp (Loc.ghost, f, [ x ])) f xs

let rec monadise (e : Glob_term.glob_constr) : Constr.t =
  match e with
  | Glob_term.GApp (loc, f, xs) ->
    if List.length xs <> 1 then
      monadise (unfold_apps f xs)
    else
      let f = monadise f in
      let x = monadise (List.hd xs) in
      let type_of = Typing.type_of (Global.env ()) Evd.empty in
      (match Typeclasses.class_of_constr (type_of x) with
      | None -> Constr.mkApp (f, [|x|])
      | Some _ -> failwith "TODO")
  | _ -> e*)

(** Syntax extension do add a "Monadic" command to define new monadic terms. *)
VERNAC COMMAND EXTEND Monadic CLASSIFIED AS SIDEFF
| [ "Monadic" ident(name) ":=" constr(value) ] -> [
  (*Pp.msg_info (Pp.str "1");
  let value = Constrintern.intern_constr Evd.empty (Global.env ()) value in
  failwith "gre";
  let value = monadise value in*)
  let value = Constrintern.interp_constr Evd.empty (Global.env ()) value in
  let _ = Declare.declare_definition name (Future.from_val (value, Declareops.no_seff)) in
  () ]
END
