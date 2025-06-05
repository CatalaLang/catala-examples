open Runtime_ocaml.Runtime

[@@@ocaml.warning "-4-26-27-32-41-42"]


module DeficitAnterieur : sig
  type t = {annee: integer; valeur: money}
  val embed: t -> runtime_value
end

module ProRataArrondiEuro : sig
  type t = {valeurs_proratisees: money array}
  val embed: t -> runtime_value
end

module ProRataArrondiEuroListes : sig
  type t = {valeurs_proratisees: (money array) array}
  val embed: t -> runtime_value
end

module ProRataArrondiEuroBranchement : sig
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
    valeurs_proratisees_liste_9: money array
  }
  val embed: t -> runtime_value
end

module ImputationAuxDeficitsLesPlusAnciens : sig
  type t = {
    revenu_impute: money;
    deficits_anterieurs_restants: DeficitAnterieur.t array
  }
  val embed: t -> runtime_value
end

module ImputationAuxDeficitsLesPlusAnciens_in : sig
  type t = {
    revenu_declare_in: money;
    deficits_anterieurs_in: DeficitAnterieur.t array
  }
  val embed: t -> runtime_value
end

module ProRataArrondiEuro_in : sig
  type t = {montant_a_distribuer_in: money; bases_prorata_in: money array}
  val embed: t -> runtime_value
end

module ProRataArrondiEuroListes_in : sig
  type t = {
    montant_a_distribuer_in: money;
    bases_prorata_in: (money array) array
  }
  val embed: t -> runtime_value
end

module ProRataArrondiEuroBranchement_in : sig
  type t = {
    montant_a_distribuer_in: money;
    base_prorata_1_in: ((money * source_position)) Eoption.t;
    base_prorata_2_in: ((money * source_position)) Eoption.t;
    base_prorata_3_in: ((money * source_position)) Eoption.t;
    base_prorata_4_in: ((money * source_position)) Eoption.t;
    base_prorata_5_in: ((money * source_position)) Eoption.t;
    base_prorata_6_in: ((money * source_position)) Eoption.t;
    base_prorata_7_in: ((money * source_position)) Eoption.t;
    base_prorata_8_in: ((money * source_position)) Eoption.t;
    base_prorata_9_in: ((money * source_position)) Eoption.t;
    bases_prorata_liste_1_in: (((money array) * source_position)) Eoption.t;
    bases_prorata_liste_2_in: (((money array) * source_position)) Eoption.t;
    bases_prorata_liste_3_in: (((money array) * source_position)) Eoption.t;
    bases_prorata_liste_4_in: (((money array) * source_position)) Eoption.t;
    bases_prorata_liste_5_in: (((money array) * source_position)) Eoption.t;
    bases_prorata_liste_6_in: (((money array) * source_position)) Eoption.t;
    bases_prorata_liste_7_in: (((money array) * source_position)) Eoption.t;
    bases_prorata_liste_8_in: (((money array) * source_position)) Eoption.t;
    bases_prorata_liste_9_in: (((money array) * source_position)) Eoption.t
  }
  val embed: t -> runtime_value
end


(** Scope ImputationAuxDéficitsLesPlusAnciens *)
val imputation_aux_deficits_les_plus_anciens :
  ImputationAuxDeficitsLesPlusAnciens_in.t ->
  ImputationAuxDeficitsLesPlusAnciens.t

(** Scope ProRataArrondiEuro *)
val pro_rata_arrondi_euro : ProRataArrondiEuro_in.t -> ProRataArrondiEuro.t

(** Scope ProRataArrondiEuroListes *)
val pro_rata_arrondi_euro_listes :
  ProRataArrondiEuroListes_in.t -> ProRataArrondiEuroListes.t

(** Scope ProRataArrondiEuroBranchement *)
val pro_rata_arrondi_euro_branchement :
  ProRataArrondiEuroBranchement_in.t -> ProRataArrondiEuroBranchement.t
