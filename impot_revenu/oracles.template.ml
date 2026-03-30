(* This is a template file following the expected interface and declarations to
 * implement the corresponding Catala module.
 *
 * You should replace all `raise (Error (Impossible))` place-holders with your
 * implementation and rename it to remove the ".template" suffix. *)

[@@@ocaml.warning "-4-26-27-32-33-34-37-41-42-69"]

open Catala_runtime


module DeficitAnterieur = struct
  type t = { annee: integer; valeur: money; }
  let rtype = Value.Struct {
    name = "Oracles.D\195\169ficitAnt\195\169rieur";
    fields = fun t -> [
      "annee", Value.embed (Value.Integer) t.annee;
      "valeur", Value.embed (Value.Money) t.valeur;
    ]
  }
end

module ResultatProRataArrondiEuroBranchement = struct
  type t = {
    valeur_proratisee_1: money;
    valeur_proratisee_2: money;
    valeur_proratisee_3: money;
    valeur_proratisee_4: money;
    valeur_proratisee_5: money;
    valeur_proratisee_6: money;
    valeur_proratisee_7: money;
    valeur_proratisee_8: money;
    valeur_proratisee_9: money;
    valeurs_proratisees_liste_1: money array;
    valeurs_proratisees_liste_2: money array;
    valeurs_proratisees_liste_3: money array;
    valeurs_proratisees_liste_4: money array;
    valeurs_proratisees_liste_5: money array;
    valeurs_proratisees_liste_6: money array;
    valeurs_proratisees_liste_7: money array;
    valeurs_proratisees_liste_8: money array;
    valeurs_proratisees_liste_9: money array;
  }
  let rtype = Value.Struct {
    name = "Oracles.R\195\169sultatProRataArrondiEuroBranchement";
    fields = fun t -> [
      "valeur_proratisee_1", Value.embed (Value.Money) t.valeur_proratisee_1;
      "valeur_proratisee_2", Value.embed (Value.Money) t.valeur_proratisee_2;
      "valeur_proratisee_3", Value.embed (Value.Money) t.valeur_proratisee_3;
      "valeur_proratisee_4", Value.embed (Value.Money) t.valeur_proratisee_4;
      "valeur_proratisee_5", Value.embed (Value.Money) t.valeur_proratisee_5;
      "valeur_proratisee_6", Value.embed (Value.Money) t.valeur_proratisee_6;
      "valeur_proratisee_7", Value.embed (Value.Money) t.valeur_proratisee_7;
      "valeur_proratisee_8", Value.embed (Value.Money) t.valeur_proratisee_8;
      "valeur_proratisee_9", Value.embed (Value.Money) t.valeur_proratisee_9;
      "valeurs_proratisees_liste_1", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_1;
      "valeurs_proratisees_liste_2", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_2;
      "valeurs_proratisees_liste_3", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_3;
      "valeurs_proratisees_liste_4", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_4;
      "valeurs_proratisees_liste_5", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_5;
      "valeurs_proratisees_liste_6", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_6;
      "valeurs_proratisees_liste_7", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_7;
      "valeurs_proratisees_liste_8", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_8;
      "valeurs_proratisees_liste_9", Value.embed (Value.Array(Value.embed (Value.Money))) t.valeurs_proratisees_liste_9;
    ]
  }
end

module ResultatImputation = struct
  type t = {
    revenu_impute: money;
    deficits_anterieurs_restants: DeficitAnterieur.t array;
  }
  let rtype = Value.Struct {
    name = "Oracles.R\195\169sultatImputation";
    fields = fun t -> [
      "revenu_impute", Value.embed (Value.Money) t.revenu_impute;
      "deficits_anterieurs_restants", Value.embed (Value.Array(Value.embed (DeficitAnterieur.rtype))) t.deficits_anterieurs_restants;
    ]
  }
end


(* Toplevel def loc *)
let loc : code_location array =
  [|{filename="impot_revenu/oracles.catala_fr";
     start_line=29; start_column=13; end_line=29; end_column=53;
     law_headings=["Imputation des déficits antérieurs"]};
    {filename="impot_revenu/oracles.catala_fr";
     start_line=73; start_column=13; end_line=73; end_column=33;
     law_headings=["Calcul de pro-rata"]};
    {filename="impot_revenu/oracles.catala_fr";
     start_line=81; start_column=13; end_line=81; end_column=40;
     law_headings=["Calcul de pro-rata"]};
    {filename="impot_revenu/oracles.catala_fr";
     start_line=109; start_column=13; end_line=109; end_column=45;
     law_headings=["Calcul de pro-rata"]}|]

(* Toplevel def imputation_aux_déficits_les_plus_anciens *)
let imputation_aux_deficits_les_plus_anciens : money ->
                                                 (DeficitAnterieur.t array) ->
                                                 ResultatImputation.t =
  fun (_: money) (_: DeficitAnterieur.t array) -> raise
    (Error (Impossible, [loc.(0)], None))

(* Toplevel def prorata_arrondi_euro *)
let prorata_arrondi_euro : money -> (money array) -> (money array) =
  fun (_: money) (_: money array) -> raise
    (Error (Impossible, [loc.(1)], None))

(* Toplevel def prorata_arrondi_euro_listes *)
let prorata_arrondi_euro_listes : money -> ((money array) array) ->
                                    ((money array) array) =
  fun (_: money) (_: (money array) array) -> raise
    (Error (Impossible, [loc.(2)], None))

(* Toplevel def prorata_arrondi_euro_branchement *)
let prorata_arrondi_euro_branchement : money -> (money) Optional.t ->
                                         (money) Optional.t ->
                                         (money) Optional.t ->
                                         (money) Optional.t ->
                                         (money) Optional.t ->
                                         (money) Optional.t ->
                                         (money) Optional.t ->
                                         (money) Optional.t ->
                                         (money) Optional.t ->
                                         (money array) -> (money array) ->
                                         (money array) -> (money array) ->
                                         (money array) -> (money array) ->
                                         (money array) -> (money array) ->
                                         (money array) ->
                                         ResultatProRataArrondiEuroBranchement.t =
  fun (_: money) (_: (money) Optional.t) (_: (money) Optional.t)
    (_: (money) Optional.t) (_: (money) Optional.t) (_: (money) Optional.t)
    (_: (money) Optional.t) (_: (money) Optional.t) (_: (money) Optional.t)
    (_: (money) Optional.t) (_: money array) (_: money array)
    (_: money array) (_: money array) (_: money array) (_: money array)
    (_: money array) (_: money array) (_: money array) -> raise
    (Error (Impossible, [loc.(3)], None))

let () =
  Catala_runtime.register_module "Oracles"
    [ "imputation_aux_d\195\169ficits_les_plus_anciens",
        Stdlib.Obj.repr (imputation_aux_deficits_les_plus_anciens);
      "prorata_arrondi_euro", Stdlib.Obj.repr (prorata_arrondi_euro);
      "prorata_arrondi_euro_listes",
        Stdlib.Obj.repr (prorata_arrondi_euro_listes);
      "prorata_arrondi_euro_branchement",
        Stdlib.Obj.repr (prorata_arrondi_euro_branchement) ]
    "*external*"
