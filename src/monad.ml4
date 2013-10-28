

(** Syntax extension do add a "Monadic" command to define new monadic terms. *)
VERNAC COMMAND EXTEND Monadic CLASSIFIED AS SIDEFF
| [ "Monadic" ident(name) ":=" constr(value) ] -> [
  let value = Constrintern.interp_constr Evd.empty (Global.env ()) value in
  let _ = Declare.declare_definition name (Future.from_val (value, Declareops.no_seff)) in
  () ]
END
