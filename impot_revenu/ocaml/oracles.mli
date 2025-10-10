open Catala_runtime

[@@@ocaml.warning "-4-26-27-32-41-42"]

module DeficitAnterieur : sig
  type t = { annee : integer; valeur : money }

  val embed : t -> runtime_value
end

module ResultatProRataArrondiEuroBranchement : sig
  type t = {
    valeur_proratisee_1 : money;
    valeur_proratisee_2 : money;
    valeur_proratisee_3 : money;
    valeur_proratisee_4 : money;
    valeur_proratisee_5 : money;
    valeur_proratisee_6 : money;
    valeur_proratisee_7 : money;
    valeur_proratisee_8 : money;
    valeur_proratisee_9 : money;
    valeurs_proratisees_liste_1 : money array;
    valeurs_proratisees_liste_2 : money array;
    valeurs_proratisees_liste_3 : money array;
    valeurs_proratisees_liste_4 : money array;
    valeurs_proratisees_liste_5 : money array;
    valeurs_proratisees_liste_6 : money array;
    valeurs_proratisees_liste_7 : money array;
    valeurs_proratisees_liste_8 : money array;
    valeurs_proratisees_liste_9 : money array;
  }

  val embed : t -> runtime_value
end

module ResultatImputation : sig
  type t = {
    revenu_impute : money;
    deficits_anterieurs_restants : DeficitAnterieur.t array;
  }

  val embed : t -> runtime_value
end

val imputation_aux_deficits_les_plus_anciens :
  money -> DeficitAnterieur.t array -> ResultatImputation.t
(** Toplevel definition imputation_aux_déficits_les_plus_anciens *)

val prorata_arrondi_euro : money -> money array -> money array
(** Toplevel definition prorata_arrondi_euro *)

val prorata_arrondi_euro_listes :
  money -> money array array -> money array array
(** Toplevel definition prorata_arrondi_euro_listes *)

val prorata_arrondi_euro_branchement :
  money ->
  money Optional.t ->
  money Optional.t ->
  money Optional.t ->
  money Optional.t ->
  money Optional.t ->
  money Optional.t ->
  money Optional.t ->
  money Optional.t ->
  money Optional.t ->
  money array ->
  money array ->
  money array ->
  money array ->
  money array ->
  money array ->
  money array ->
  money array ->
  money array ->
  ResultatProRataArrondiEuroBranchement.t
(** Toplevel definition prorata_arrondi_euro_branchement *)
