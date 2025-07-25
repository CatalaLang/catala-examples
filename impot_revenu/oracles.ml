open Runtime_ocaml.Runtime

[@@@ocaml.warning "-4-26-27-32-41-42"]


module DeficitAnterieur = struct
  type t = {annee: integer; valeur: money}
  let embed (x: t) : runtime_value =
    Struct(
      "DeficitAnterieur",
      [("annee", embed_integer x.annee); ("valeur", embed_money x.valeur)]
    )
end

module ProRataArrondiEuro = struct
  type t = {valeurs_proratisees: money array}
  let embed (x: t) : runtime_value =
    Struct(
      "ProRataArrondiEuro",
      [("valeurs_proratisees",
        embed_array (embed_money) x.valeurs_proratisees)]
    )
end

module ProRataArrondiEuroListes = struct
  type t = {valeurs_proratisees: (money array) array}
  let embed (x: t) : runtime_value =
    Struct(
      "ProRataArrondiEuroListes",
      [("valeurs_proratisees",
        embed_array (embed_array (embed_money)) x.valeurs_proratisees)]
    )
end

module ProRataArrondiEuroBranchement = struct
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
  let embed (x: t) : runtime_value =
    Struct(
      "ProRataArrondiEuroBranchement",
      [("valeur_proratisee_1", embed_money x.valeur_proratisee_1);
       ("valeur_proratisee_2", embed_money x.valeur_proratisee_2);
       ("valeur_proratisee_3", embed_money x.valeur_proratisee_3);
       ("valeur_proratisee_4", embed_money x.valeur_proratisee_4);
       ("valeur_proratisee_5", embed_money x.valeur_proratisee_5);
       ("valeur_proratisee_6", embed_money x.valeur_proratisee_6);
       ("valeur_proratisee_7", embed_money x.valeur_proratisee_7);
       ("valeur_proratisee_8", embed_money x.valeur_proratisee_8);
       ("valeur_proratisee_9", embed_money x.valeur_proratisee_9);
       ("valeurs_proratisees_liste_1",
        embed_array (embed_money) x.valeurs_proratisees_liste_1);
       ("valeurs_proratisees_liste_2",
        embed_array (embed_money) x.valeurs_proratisees_liste_2);
       ("valeurs_proratisees_liste_3",
        embed_array (embed_money) x.valeurs_proratisees_liste_3);
       ("valeurs_proratisees_liste_4",
        embed_array (embed_money) x.valeurs_proratisees_liste_4);
       ("valeurs_proratisees_liste_5",
        embed_array (embed_money) x.valeurs_proratisees_liste_5);
       ("valeurs_proratisees_liste_6",
        embed_array (embed_money) x.valeurs_proratisees_liste_6);
       ("valeurs_proratisees_liste_7",
        embed_array (embed_money) x.valeurs_proratisees_liste_7);
       ("valeurs_proratisees_liste_8",
        embed_array (embed_money) x.valeurs_proratisees_liste_8);
       ("valeurs_proratisees_liste_9",
        embed_array (embed_money) x.valeurs_proratisees_liste_9)]
    )
end

module ImputationAuxDeficitsLesPlusAnciens = struct
  type t = {
    revenu_impute: money;
    deficits_anterieurs_restants: DeficitAnterieur.t array
  }
  let embed (x: t) : runtime_value =
    Struct(
      "ImputationAuxDeficitsLesPlusAnciens",
      [("revenu_impute", embed_money x.revenu_impute);
       ("deficits_anterieurs_restants",
        embed_array (DeficitAnterieur.embed) x.deficits_anterieurs_restants)]
    )
end

module ImputationAuxDeficitsLesPlusAnciens_in = struct
  type t = {
    revenu_declare_in: money;
    deficits_anterieurs_in: DeficitAnterieur.t array
  }
  let embed (x: t) : runtime_value =
    Struct(
      "ImputationAuxDeficitsLesPlusAnciens_in",
      [("revenu_declare_in", embed_money x.revenu_declare_in);
       ("deficits_anterieurs_in",
        embed_array (DeficitAnterieur.embed) x.deficits_anterieurs_in)]
    )
end

module ProRataArrondiEuro_in = struct
  type t = {montant_a_distribuer_in: money; bases_prorata_in: money array}
  let embed (x: t) : runtime_value =
    Struct(
      "ProRataArrondiEuro_in",
      [("montant_a_distribuer_in", embed_money x.montant_a_distribuer_in);
       ("bases_prorata_in", embed_array (embed_money) x.bases_prorata_in)]
    )
end

module ProRataArrondiEuroListes_in = struct
  type t = {
    montant_a_distribuer_in: money;
    bases_prorata_in: (money array) array
  }
  let embed (x: t) : runtime_value =
    Struct(
      "ProRataArrondiEuroListes_in",
      [("montant_a_distribuer_in", embed_money x.montant_a_distribuer_in);
       ("bases_prorata_in",
        embed_array (embed_array (embed_money)) x.bases_prorata_in)]
    )
end

module ProRataArrondiEuroBranchement_in = struct
  type t = {
    montant_a_distribuer_in: money;
    base_prorata_1_in: ((money * source_position)) Optional.t;
    base_prorata_2_in: ((money * source_position)) Optional.t;
    base_prorata_3_in: ((money * source_position)) Optional.t;
    base_prorata_4_in: ((money * source_position)) Optional.t;
    base_prorata_5_in: ((money * source_position)) Optional.t;
    base_prorata_6_in: ((money * source_position)) Optional.t;
    base_prorata_7_in: ((money * source_position)) Optional.t;
    base_prorata_8_in: ((money * source_position)) Optional.t;
    base_prorata_9_in: ((money * source_position)) Optional.t;
    bases_prorata_liste_1_in: (((money array) * source_position)) Optional.t;
    bases_prorata_liste_2_in: (((money array) * source_position)) Optional.t;
    bases_prorata_liste_3_in: (((money array) * source_position)) Optional.t;
    bases_prorata_liste_4_in: (((money array) * source_position)) Optional.t;
    bases_prorata_liste_5_in: (((money array) * source_position)) Optional.t;
    bases_prorata_liste_6_in: (((money array) * source_position)) Optional.t;
    bases_prorata_liste_7_in: (((money array) * source_position)) Optional.t;
    bases_prorata_liste_8_in: (((money array) * source_position)) Optional.t;
    bases_prorata_liste_9_in: (((money array) * source_position)) Optional.t
  }
  let embed (x: t) : runtime_value =
    Struct(
      "ProRataArrondiEuroBranchement_in",
      [("montant_a_distribuer_in", embed_money x.montant_a_distribuer_in);
       ("base_prorata_1_in", unembeddable x.base_prorata_1_in);
       ("base_prorata_2_in", unembeddable x.base_prorata_2_in);
       ("base_prorata_3_in", unembeddable x.base_prorata_3_in);
       ("base_prorata_4_in", unembeddable x.base_prorata_4_in);
       ("base_prorata_5_in", unembeddable x.base_prorata_5_in);
       ("base_prorata_6_in", unembeddable x.base_prorata_6_in);
       ("base_prorata_7_in", unembeddable x.base_prorata_7_in);
       ("base_prorata_8_in", unembeddable x.base_prorata_8_in);
       ("base_prorata_9_in", unembeddable x.base_prorata_9_in);
       ("bases_prorata_liste_1_in", unembeddable x.bases_prorata_liste_1_in);
       ("bases_prorata_liste_2_in", unembeddable x.bases_prorata_liste_2_in);
       ("bases_prorata_liste_3_in", unembeddable x.bases_prorata_liste_3_in);
       ("bases_prorata_liste_4_in", unembeddable x.bases_prorata_liste_4_in);
       ("bases_prorata_liste_5_in", unembeddable x.bases_prorata_liste_5_in);
       ("bases_prorata_liste_6_in", unembeddable x.bases_prorata_liste_6_in);
       ("bases_prorata_liste_7_in", unembeddable x.bases_prorata_liste_7_in);
       ("bases_prorata_liste_8_in", unembeddable x.bases_prorata_liste_8_in);
       ("bases_prorata_liste_9_in", unembeddable x.bases_prorata_liste_9_in)]
    )
end


let imputation_aux_deficits_les_plus_anciens
    (imputation_aux_deficits_les_plus_anciens_in :
      ImputationAuxDeficitsLesPlusAnciens_in.t) :
    ImputationAuxDeficitsLesPlusAnciens.t =
  let revenu_declare_ : money =
    imputation_aux_deficits_les_plus_anciens_in
      .ImputationAuxDeficitsLesPlusAnciens_in.revenu_declare_in
  in
  let deficits_anterieurs_ : DeficitAnterieur.t array =
    imputation_aux_deficits_les_plus_anciens_in
      .ImputationAuxDeficitsLesPlusAnciens_in.deficits_anterieurs_in
  in
  let rec aux
      (revenu_declare : money)
      (deficits_anterieurs : DeficitAnterieur.t list) =
    match deficits_anterieurs with
    | [] -> revenu_declare, []
    | hd :: tl ->
      if o_gt_mon_mon hd.valeur revenu_declare then
        ( money_of_units_int 0,
          { hd with valeur = o_sub_mon_mon hd.valeur revenu_declare } :: tl )
      else aux (o_sub_mon_mon revenu_declare hd.valeur) tl
  in
  let revenu_impute_, deficits_anterieurs_restants_ =
    aux revenu_declare_
      (List.sort
         (fun (x : DeficitAnterieur.t) (y : DeficitAnterieur.t) ->
           Int.compare (integer_to_int x.annee) (integer_to_int y.annee))
         (Array.to_list deficits_anterieurs_))
  in
  {
    ImputationAuxDeficitsLesPlusAnciens.revenu_impute = revenu_impute_;
    ImputationAuxDeficitsLesPlusAnciens.deficits_anterieurs_restants =
      Array.of_list deficits_anterieurs_restants_;
  }

type direction_arrondi = Haut | Bas | Nul

let zero = decimal_of_float 0.0

let pro_rata_arrondi_euro (pro_rata_arrondi_euro_in : ProRataArrondiEuro_in.t) :
    ProRataArrondiEuro.t =
  let montant_a_distribuer_ : money =
    pro_rata_arrondi_euro_in.ProRataArrondiEuro_in.montant_a_distribuer_in
  in
  if
    Array.exists
      (fun base -> o_lt_mon_mon base (money_of_units_int 0))
      pro_rata_arrondi_euro_in.ProRataArrondiEuro_in.bases_prorata_in
  then
    raise
      (Error
         ( AssertionFailed,
           [
             {
               filename = "oracles.catala_fr";
               start_line = 39;
               start_column = 5;
               end_line = 40;
               end_column = 27;
               law_headings = ["Calcul de pro-rata"];
             };
           ] ));
  if
    (not (o_eq_mon_mon montant_a_distribuer_ (money_of_units_int 0)))
    && Array.for_all
         (fun base -> o_eq_mon_mon base (money_of_units_int 0))
         pro_rata_arrondi_euro_in.ProRataArrondiEuro_in.bases_prorata_in
  then
    raise
      (Error
         ( AssertionFailed,
           [
             {
               filename = "oracles.catala_fr";
               start_line = 41;
               start_column = 5;
               end_line = 41;
               end_column = 55;
               law_headings = ["Calcul de pro-rata"];
             };
           ] ));
  if money_round montant_a_distribuer_ <> montant_a_distribuer_ then
    raise
      (Error
         ( AssertionFailed,
           [
             {
               filename = "oracles.catala_fr";
               start_line = 42;
               start_column = 5;
               end_line = 42;
               end_column = 61;
               law_headings = ["Calcul de pro-rata"];
             };
           ] ));
  let bases_prorata_ : money array =
    pro_rata_arrondi_euro_in.ProRataArrondiEuro_in.bases_prorata_in
  in
  let valeurs_proratisees_ : money array =
    let assiette_totale_prorata =
      Array.fold_left o_add_mon_mon (money_of_units_int 0) bases_prorata_
    in
    (* On calcule l'arrondi du pro-rata et on enregistre la direction *)
    let valeurs_proratisees_arrondies =
      Array.map
        (fun base_prorata ->
          let brut =
            let assiette_totale_rat =
              decimal_of_money assiette_totale_prorata
            in
            if o_eq_rat_rat assiette_totale_rat zero then zero
            else
              try
                o_mult_rat_rat
                  (decimal_of_money montant_a_distribuer_)
                  (o_div_rat_rat
                     {
                       filename = "oracles.catala_fr";
                       start_line = 0;
                       start_column = 0;
                       end_line = 0;
                       end_column = 0;
                       law_headings = [];
                     }
                     (decimal_of_money base_prorata)
                     (decimal_of_money assiette_totale_prorata))
              with
              | Runtime_ocaml.Runtime.Error
                  (Runtime_ocaml.Runtime.DivisionByZero, _)
              ->
                Runtime_ocaml.Runtime.decimal_of_float 0.0
          in
          let arrondi = decimal_round brut in
          ( money_of_decimal arrondi,
            if o_eq_rat_rat arrondi brut then Nul
            else if o_gt_rat_rat arrondi brut then Haut
            else Bas ))
        bases_prorata_
    in
    (* Puis on compte le décalage D entre les arrondis vers le bas et vers le
       haut : il y a D € de différence entre le montant à pro-ratiser et ces
       pro-rata arrondis. *)
    let nb_haut, nb_bas =
      Array.fold_left
        (fun (nb_haut, nb_bas) (_, direction) ->
          match direction with
          | Haut -> nb_haut + 1, nb_bas
          | Bas -> nb_haut, nb_bas + 1
          | Nul -> nb_haut, nb_bas)
        (0, 0) valeurs_proratisees_arrondies
    in
    let delta =
      int_of_float
        (money_to_float
           (o_sub_mon_mon
              (Array.fold_left
                 (fun x (y, _) -> o_add_mon_mon x y)
                 (money_of_units_int 0) valeurs_proratisees_arrondies)
              montant_a_distribuer_))
    in
    assert (not (delta > nb_haut || -delta > nb_bas));
    let _, valeurs_proratisees_ =
      Array.fold_left_map
        (fun ( nb_haut_restant,
               nb_bas_restant,
               delta_restant,
               nb_depuis_dernier_flip ) (valeur_proratisee_arrondie, direction) ->
          let new_nb_haut_restant, new_nb_bas_restant =
            match direction with
            | Haut -> nb_haut_restant - 1, nb_bas_restant
            | Bas -> nb_haut_restant, nb_bas_restant - 1
            | Nul -> nb_haut_restant, nb_bas_restant
          in
          match delta_restant with
          | 0 ->
            (* Il n'y a plus de D € à répartir, on ne change rien pour la
               suite. *)
            ( ( new_nb_haut_restant,
                new_nb_bas_restant,
                0,
                nb_depuis_dernier_flip + 1 ),
              valeur_proratisee_arrondie )
          | delta_restant ->
            let new_valeur_proratisee, delta_offset, new_nb_depuis_dernier_flip
                =
              match delta_restant > 0, direction with
              (* Si arrondi dans la direction opposée que le delta restant,
                 alors on ne peux pas compenser *)
              | false, Haut | true, Bas | _, Nul ->
                valeur_proratisee_arrondie, 0, nb_depuis_dernier_flip
              (* Si arrondi dans la même direction que le delta restant, alors
                 on flippe l'arrondi mais pas trop souvent. *)
              | false, Bas ->
                if -delta_restant * nb_depuis_dernier_flip > nb_bas_restant then
                  ( (* On a attendu sufisamment longtemps, on flip *)
                    o_add_mon_mon valeur_proratisee_arrondie
                      (money_of_units_int 1),
                    1,
                    1 )
                else
                  (* On ne flippe pas car il reste trop de hauts restants par
                     rapport au delta à flipper *)
                  valeur_proratisee_arrondie, 0, nb_depuis_dernier_flip + 1
              | true, Haut ->
                if delta_restant * nb_depuis_dernier_flip > nb_haut_restant then
                  ( (* On a attendu sufisamment longtemps, on flip *)
                    o_add_mon_mon valeur_proratisee_arrondie
                      (money_of_units_int (-1)),
                    -1,
                    1 )
                else
                  (* On ne flippe pas car il reste trop de bas restants par
                     rapport au delta à flipper *)
                  valeur_proratisee_arrondie, 0, nb_depuis_dernier_flip + 1
            in
            ( ( new_nb_haut_restant,
                new_nb_bas_restant,
                delta_restant + delta_offset,
                new_nb_depuis_dernier_flip ),
              new_valeur_proratisee ))
        (nb_haut, nb_bas, delta, 1)
        valeurs_proratisees_arrondies
    in
    valeurs_proratisees_
  in
  { ProRataArrondiEuro.valeurs_proratisees = valeurs_proratisees_ }

let pro_rata_arrondi_euro_listes
    (pro_rata_arrondi_euro_listes_in : ProRataArrondiEuroListes_in.t) :
    ProRataArrondiEuroListes.t =
  let montant_a_distribuer_ : money =
    pro_rata_arrondi_euro_listes_in
      .ProRataArrondiEuroListes_in.montant_a_distribuer_in
  in
  let bases_prorata_ : money array array =
    pro_rata_arrondi_euro_listes_in.ProRataArrondiEuroListes_in.bases_prorata_in
  in
  let valeurs_proratisees_ : money array array =
    let resultat =
      (pro_rata_arrondi_euro
         {
           montant_a_distribuer_in = montant_a_distribuer_;
           bases_prorata_in =
             Array.of_list
               (List.flatten
                  (List.map Array.to_list (Array.to_list bases_prorata_)));
         })
        .valeurs_proratisees
    in
    let array_sizes = Array.map Array.length bases_prorata_ in
    let _, resultat =
      Array.fold_left_map
        (fun acc size -> acc + size, Array.sub resultat acc size)
        0 array_sizes
    in
    resultat
  in
  { ProRataArrondiEuroListes.valeurs_proratisees = valeurs_proratisees_ }

let pro_rata_arrondi_euro_branchement
    (pro_rata_arrondi_euro_branchement_in : ProRataArrondiEuroBranchement_in.t)
    : ProRataArrondiEuroBranchement.t =
  let montant_a_distribuer_ : money =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.montant_a_distribuer_in
  in
  let base_prorata_1_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_1_in
  in
  let base_prorata_2_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_2_in
  in
  let base_prorata_3_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_3_in
  in
  let base_prorata_4_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_4_in
  in
  let base_prorata_5_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_5_in
  in
  let base_prorata_6_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_6_in
  in
  let base_prorata_7_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_7_in
  in
  let base_prorata_8_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_8_in
  in
  let base_prorata_9_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.base_prorata_9_in
  in
  let bases_prorata_liste_1_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_1_in
  in
  let bases_prorata_liste_2_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_2_in
  in
  let bases_prorata_liste_3_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_3_in
  in
  let bases_prorata_liste_4_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_4_in
  in
  let bases_prorata_liste_5_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_5_in
  in
  let bases_prorata_liste_6_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_6_in
  in
  let bases_prorata_liste_7_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_7_in
  in
  let bases_prorata_liste_8_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_8_in
  in
  let bases_prorata_liste_9_ =
    pro_rata_arrondi_euro_branchement_in
      .ProRataArrondiEuroBranchement_in.bases_prorata_liste_9_in
  in
  let base_prorata_1_ : money =
    match
      handle_exceptions
        [| base_prorata_1_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let base_prorata_2_ : money =
    match
      handle_exceptions
        [| base_prorata_2_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let base_prorata_3_ : money =
    match
      handle_exceptions
        [| base_prorata_3_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let base_prorata_4_ : money =
    match
      handle_exceptions
        [| base_prorata_4_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let base_prorata_5_ : money =
    match
      handle_exceptions
        [| base_prorata_5_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let base_prorata_6_ : money =
    match
      handle_exceptions
        [| base_prorata_6_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let base_prorata_7_ : money =
    match
      handle_exceptions
        [| base_prorata_7_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let base_prorata_8_ : money =
    match
      handle_exceptions
        [| base_prorata_8_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let base_prorata_9_ : money =
    match
      handle_exceptions
        [| base_prorata_9_ |]
    with
    | Absent _ -> money_of_units_int 0
    | Present (x, _) -> x
  in
  let bases_prorata_liste_1_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_1_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata_liste_2_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_2_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata_liste_3_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_3_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata_liste_4_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_4_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata_liste_5_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_5_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata_liste_6_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_6_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata_liste_7_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_7_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata_liste_8_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_8_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata_liste_9_ : money array =
    match
      handle_exceptions
        [| bases_prorata_liste_9_ |]
    with
    | Absent _ -> Array.make 0 (money_of_units_int 0)
    | Present (x, _) -> x
  in
  let bases_prorata =
    Array.make
      (9
      + Array.length bases_prorata_liste_1_
      + Array.length bases_prorata_liste_2_
      + Array.length bases_prorata_liste_3_
      + Array.length bases_prorata_liste_4_
      + Array.length bases_prorata_liste_5_
      + Array.length bases_prorata_liste_6_
      + Array.length bases_prorata_liste_7_
      + Array.length bases_prorata_liste_8_
      + Array.length bases_prorata_liste_9_)
      (money_of_units_int 0)
  in
  bases_prorata.(0) <- base_prorata_1_;
  bases_prorata.(1) <- base_prorata_2_;
  bases_prorata.(2) <- base_prorata_3_;
  bases_prorata.(3) <- base_prorata_4_;
  bases_prorata.(4) <- base_prorata_5_;
  bases_prorata.(5) <- base_prorata_6_;
  bases_prorata.(6) <- base_prorata_7_;
  bases_prorata.(7) <- base_prorata_8_;
  bases_prorata.(8) <- base_prorata_9_;
  let cursor = 9 in
  Array.blit bases_prorata_liste_1_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_1_);
  let cursor = cursor + Array.length bases_prorata_liste_1_ in
  Array.blit bases_prorata_liste_2_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_2_);
  let cursor = cursor + Array.length bases_prorata_liste_2_ in
  Array.blit bases_prorata_liste_3_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_3_);
  let cursor = cursor + Array.length bases_prorata_liste_3_ in
  Array.blit bases_prorata_liste_4_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_4_);
  let cursor = cursor + Array.length bases_prorata_liste_4_ in
  Array.blit bases_prorata_liste_5_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_5_);
  let cursor = cursor + Array.length bases_prorata_liste_5_ in
  Array.blit bases_prorata_liste_6_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_6_);
  let cursor = cursor + Array.length bases_prorata_liste_6_ in
  Array.blit bases_prorata_liste_7_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_7_);
  let cursor = cursor + Array.length bases_prorata_liste_7_ in
  Array.blit bases_prorata_liste_8_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_8_);
  let cursor = cursor + Array.length bases_prorata_liste_8_ in
  Array.blit bases_prorata_liste_9_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_9_);
  let cursor = cursor + Array.length bases_prorata_liste_9_ in
  Array.blit bases_prorata_liste_9_ 0 bases_prorata cursor
    (Array.length bases_prorata_liste_9_);
  let valeurs_proratisees =
    (pro_rata_arrondi_euro
       {
         montant_a_distribuer_in = montant_a_distribuer_;
         bases_prorata_in = bases_prorata;
       })
      .valeurs_proratisees
  in
  let valeur_proratisee_1_ : money = valeurs_proratisees.(0) in
  let valeur_proratisee_2_ : money = valeurs_proratisees.(1) in
  let valeur_proratisee_3_ : money = valeurs_proratisees.(2) in
  let valeur_proratisee_4_ : money = valeurs_proratisees.(3) in
  let valeur_proratisee_5_ : money = valeurs_proratisees.(4) in
  let valeur_proratisee_6_ : money = valeurs_proratisees.(5) in
  let valeur_proratisee_7_ : money = valeurs_proratisees.(6) in
  let valeur_proratisee_8_ : money = valeurs_proratisees.(7) in
  let valeur_proratisee_9_ : money = valeurs_proratisees.(8) in
  let cursor = 9 in
  let valeurs_proratisees_liste_1_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_1_)
  in
  let cursor = cursor + Array.length bases_prorata_liste_1_ in
  let valeurs_proratisees_liste_2_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_2_)
  in
  let cursor = cursor + Array.length bases_prorata_liste_2_ in
  let valeurs_proratisees_liste_3_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_3_)
  in
  let cursor = cursor + Array.length bases_prorata_liste_3_ in
  let valeurs_proratisees_liste_4_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_4_)
  in
  let cursor = cursor + Array.length bases_prorata_liste_4_ in
  let valeurs_proratisees_liste_5_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_5_)
  in
  let cursor = cursor + Array.length bases_prorata_liste_5_ in
  let valeurs_proratisees_liste_6_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_6_)
  in
  let cursor = cursor + Array.length bases_prorata_liste_6_ in
  let valeurs_proratisees_liste_7_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_7_)
  in
  let cursor = cursor + Array.length bases_prorata_liste_7_ in
  let valeurs_proratisees_liste_8_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_8_)
  in
  let cursor = cursor + Array.length bases_prorata_liste_8_ in
  let valeurs_proratisees_liste_9_ : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_9_)
  in
  {
    ProRataArrondiEuroBranchement.valeur_proratisee_1 = valeur_proratisee_1_;
    ProRataArrondiEuroBranchement.valeur_proratisee_2 = valeur_proratisee_2_;
    ProRataArrondiEuroBranchement.valeur_proratisee_3 = valeur_proratisee_3_;
    ProRataArrondiEuroBranchement.valeur_proratisee_4 = valeur_proratisee_4_;
    ProRataArrondiEuroBranchement.valeur_proratisee_5 = valeur_proratisee_5_;
    ProRataArrondiEuroBranchement.valeur_proratisee_6 = valeur_proratisee_6_;
    ProRataArrondiEuroBranchement.valeur_proratisee_7 = valeur_proratisee_7_;
    ProRataArrondiEuroBranchement.valeur_proratisee_8 = valeur_proratisee_8_;
    ProRataArrondiEuroBranchement.valeur_proratisee_9 = valeur_proratisee_9_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_1 =
      valeurs_proratisees_liste_1_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_2 =
      valeurs_proratisees_liste_2_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_3 =
      valeurs_proratisees_liste_3_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_4 =
      valeurs_proratisees_liste_4_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_5 =
      valeurs_proratisees_liste_5_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_6 =
      valeurs_proratisees_liste_6_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_7 =
      valeurs_proratisees_liste_7_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_8 =
      valeurs_proratisees_liste_8_;
    ProRataArrondiEuroBranchement.valeurs_proratisees_liste_9 =
      valeurs_proratisees_liste_9_;
  }

let () =
  Runtime_ocaml.Runtime.register_module "Oracles"
    [
      ( "ImputationAuxD\195\169ficitsLesPlusAnciens",
        Obj.repr imputation_aux_deficits_les_plus_anciens );
      "ProRataArrondiEuro", Obj.repr pro_rata_arrondi_euro;
      ( "ProRataArrondiEuroBranchement",
        Obj.repr pro_rata_arrondi_euro_branchement );
      "ProRataArrondiEuroListes", Obj.repr pro_rata_arrondi_euro_listes;
    ]
    "*external*"
