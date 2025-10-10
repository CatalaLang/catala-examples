open Catala_runtime

[@@@ocaml.warning "-4-26-27-32-41-42"]

module DeficitAnterieur = struct
  type t = { annee : integer; valeur : money }

  let embed (x : t) : runtime_value =
    Struct
      ( "DeficitAnterieur",
        ["annee", embed_integer x.annee; "valeur", embed_money x.valeur] )
end

module ResultatProRataArrondiEuroBranchement = struct
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

  let embed (x : t) : runtime_value =
    Struct
      ( "ResultatProRataArrondiEuroBranchement",
        [
          "valeur_proratisee_1", embed_money x.valeur_proratisee_1;
          "valeur_proratisee_2", embed_money x.valeur_proratisee_2;
          "valeur_proratisee_3", embed_money x.valeur_proratisee_3;
          "valeur_proratisee_4", embed_money x.valeur_proratisee_4;
          "valeur_proratisee_5", embed_money x.valeur_proratisee_5;
          "valeur_proratisee_6", embed_money x.valeur_proratisee_6;
          "valeur_proratisee_7", embed_money x.valeur_proratisee_7;
          "valeur_proratisee_8", embed_money x.valeur_proratisee_8;
          "valeur_proratisee_9", embed_money x.valeur_proratisee_9;
          ( "valeurs_proratisees_liste_1",
            embed_array embed_money x.valeurs_proratisees_liste_1 );
          ( "valeurs_proratisees_liste_2",
            embed_array embed_money x.valeurs_proratisees_liste_2 );
          ( "valeurs_proratisees_liste_3",
            embed_array embed_money x.valeurs_proratisees_liste_3 );
          ( "valeurs_proratisees_liste_4",
            embed_array embed_money x.valeurs_proratisees_liste_4 );
          ( "valeurs_proratisees_liste_5",
            embed_array embed_money x.valeurs_proratisees_liste_5 );
          ( "valeurs_proratisees_liste_6",
            embed_array embed_money x.valeurs_proratisees_liste_6 );
          ( "valeurs_proratisees_liste_7",
            embed_array embed_money x.valeurs_proratisees_liste_7 );
          ( "valeurs_proratisees_liste_8",
            embed_array embed_money x.valeurs_proratisees_liste_8 );
          ( "valeurs_proratisees_liste_9",
            embed_array embed_money x.valeurs_proratisees_liste_9 );
        ] )
end

module ResultatImputation = struct
  type t = {
    revenu_impute : money;
    deficits_anterieurs_restants : DeficitAnterieur.t array;
  }

  let embed (x : t) : runtime_value =
    Struct
      ( "ResultatImputation",
        [
          "revenu_impute", embed_money x.revenu_impute;
          ( "deficits_anterieurs_restants",
            embed_array DeficitAnterieur.embed x.deficits_anterieurs_restants );
        ] )
end

let imputation_aux_deficits_les_plus_anciens
    (revenu_declare : money)
    (deficits_anterieurs : DeficitAnterieur.t array) : ResultatImputation.t =
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
  let revenu_impute, deficits_anterieurs_restants =
    aux revenu_declare
      (List.sort
         (fun (x : DeficitAnterieur.t) (y : DeficitAnterieur.t) ->
           Int.compare (integer_to_int x.annee) (integer_to_int y.annee))
         (Array.to_list deficits_anterieurs))
  in
  {
    ResultatImputation.revenu_impute;
    deficits_anterieurs_restants = Array.of_list deficits_anterieurs_restants;
  }

type direction_arrondi = Haut | Bas | Nul

let zero = decimal_of_float 0.0

let prorata_arrondi_euro
    (montant_a_distribuer : money)
    (bases_prorata : money array) : money array =
  if
    Array.exists
      (fun base -> o_lt_mon_mon base (money_of_units_int 0))
      bases_prorata
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
    (not (o_eq_mon_mon montant_a_distribuer (money_of_units_int 0)))
    && Array.for_all
         (fun base -> o_eq_mon_mon base (money_of_units_int 0))
         bases_prorata
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
  if money_round montant_a_distribuer <> montant_a_distribuer then
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
  let valeurs_proratisees_ : money array =
    let assiette_totale_prorata =
      Array.fold_left o_add_mon_mon (money_of_units_int 0) bases_prorata
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
                  (decimal_of_money montant_a_distribuer)
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
              with Catala_runtime.Error (Catala_runtime.DivisionByZero, _) ->
                Catala_runtime.decimal_of_float 0.0
          in
          let arrondi = decimal_round brut in
          ( money_of_decimal arrondi,
            if o_eq_rat_rat arrondi brut then Nul
            else if o_gt_rat_rat arrondi brut then Haut
            else Bas ))
        bases_prorata
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
              montant_a_distribuer))
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
  valeurs_proratisees_

(* Toplevel def prorata_arrondi_euro_listes *)
let prorata_arrondi_euro_listes
    (montant_a_distribuer : money)
    (bases_prorata : money array array) : money array array =
  let valeurs_proratisees : money array array =
    let resultat =
      prorata_arrondi_euro montant_a_distribuer
        (Array.of_list
           (List.flatten (List.map Array.to_list (Array.to_list bases_prorata))))
    in
    let array_sizes = Array.map Array.length bases_prorata in
    let _, resultat =
      Array.fold_left_map
        (fun acc size -> acc + size, Array.sub resultat acc size)
        0 array_sizes
    in
    resultat
  in
  valeurs_proratisees

(* Toplevel def prorata_arrondi_euro_branchement *)
let prorata_arrondi_euro_branchement
    (montant_a_distribuer : money)
    (base_prorata_1 : money Optional.t)
    (base_prorata_2 : money Optional.t)
    (base_prorata_3 : money Optional.t)
    (base_prorata_4 : money Optional.t)
    (base_prorata_5 : money Optional.t)
    (base_prorata_6 : money Optional.t)
    (base_prorata_7 : money Optional.t)
    (base_prorata_8 : money Optional.t)
    (base_prorata_9 : money Optional.t)
    (bases_prorata_liste_1 : money array)
    (bases_prorata_liste_2 : money array)
    (bases_prorata_liste_3 : money array)
    (bases_prorata_liste_4 : money array)
    (bases_prorata_liste_5 : money array)
    (bases_prorata_liste_6 : money array)
    (bases_prorata_liste_7 : money array)
    (bases_prorata_liste_8 : money array)
    (bases_prorata_liste_9 : money array) :
    ResultatProRataArrondiEuroBranchement.t =
  let base_prorata_1 =
    match base_prorata_1 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let base_prorata_2 =
    match base_prorata_2 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let base_prorata_3 =
    match base_prorata_3 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let base_prorata_4 =
    match base_prorata_4 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let base_prorata_5 =
    match base_prorata_5 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let base_prorata_6 =
    match base_prorata_6 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let base_prorata_7 =
    match base_prorata_7 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let base_prorata_8 =
    match base_prorata_8 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let base_prorata_9 =
    match base_prorata_9 with
    | Absent () -> money_of_units_int 0
    | Present x -> x
  in
  let bases_prorata =
    Array.make
      (9
      + Array.length bases_prorata_liste_1
      + Array.length bases_prorata_liste_2
      + Array.length bases_prorata_liste_3
      + Array.length bases_prorata_liste_4
      + Array.length bases_prorata_liste_5
      + Array.length bases_prorata_liste_6
      + Array.length bases_prorata_liste_7
      + Array.length bases_prorata_liste_8
      + Array.length bases_prorata_liste_9)
      (money_of_units_int 0)
  in
  bases_prorata.(0) <- base_prorata_1;
  bases_prorata.(1) <- base_prorata_2;
  bases_prorata.(2) <- base_prorata_3;
  bases_prorata.(3) <- base_prorata_4;
  bases_prorata.(4) <- base_prorata_5;
  bases_prorata.(5) <- base_prorata_6;
  bases_prorata.(6) <- base_prorata_7;
  bases_prorata.(7) <- base_prorata_8;
  bases_prorata.(8) <- base_prorata_9;
  let cursor = 9 in
  Array.blit bases_prorata_liste_1 0 bases_prorata cursor
    (Array.length bases_prorata_liste_1);
  let cursor = cursor + Array.length bases_prorata_liste_1 in
  Array.blit bases_prorata_liste_2 0 bases_prorata cursor
    (Array.length bases_prorata_liste_2);
  let cursor = cursor + Array.length bases_prorata_liste_2 in
  Array.blit bases_prorata_liste_3 0 bases_prorata cursor
    (Array.length bases_prorata_liste_3);
  let cursor = cursor + Array.length bases_prorata_liste_3 in
  Array.blit bases_prorata_liste_4 0 bases_prorata cursor
    (Array.length bases_prorata_liste_4);
  let cursor = cursor + Array.length bases_prorata_liste_4 in
  Array.blit bases_prorata_liste_5 0 bases_prorata cursor
    (Array.length bases_prorata_liste_5);
  let cursor = cursor + Array.length bases_prorata_liste_5 in
  Array.blit bases_prorata_liste_6 0 bases_prorata cursor
    (Array.length bases_prorata_liste_6);
  let cursor = cursor + Array.length bases_prorata_liste_6 in
  Array.blit bases_prorata_liste_7 0 bases_prorata cursor
    (Array.length bases_prorata_liste_7);
  let cursor = cursor + Array.length bases_prorata_liste_7 in
  Array.blit bases_prorata_liste_8 0 bases_prorata cursor
    (Array.length bases_prorata_liste_8);
  let cursor = cursor + Array.length bases_prorata_liste_8 in
  Array.blit bases_prorata_liste_9 0 bases_prorata cursor
    (Array.length bases_prorata_liste_9);
  let cursor = cursor + Array.length bases_prorata_liste_9 in
  Array.blit bases_prorata_liste_9 0 bases_prorata cursor
    (Array.length bases_prorata_liste_9);
  let valeurs_proratisees =
    prorata_arrondi_euro montant_a_distribuer bases_prorata
  in
  let valeur_proratisee_1 : money = valeurs_proratisees.(0) in
  let valeur_proratisee_2 : money = valeurs_proratisees.(1) in
  let valeur_proratisee_3 : money = valeurs_proratisees.(2) in
  let valeur_proratisee_4 : money = valeurs_proratisees.(3) in
  let valeur_proratisee_5 : money = valeurs_proratisees.(4) in
  let valeur_proratisee_6 : money = valeurs_proratisees.(5) in
  let valeur_proratisee_7 : money = valeurs_proratisees.(6) in
  let valeur_proratisee_8 : money = valeurs_proratisees.(7) in
  let valeur_proratisee_9 : money = valeurs_proratisees.(8) in
  let cursor = 9 in
  let valeurs_proratisees_liste_1 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_1)
  in
  let cursor = cursor + Array.length bases_prorata_liste_1 in
  let valeurs_proratisees_liste_2 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_2)
  in
  let cursor = cursor + Array.length bases_prorata_liste_2 in
  let valeurs_proratisees_liste_3 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_3)
  in
  let cursor = cursor + Array.length bases_prorata_liste_3 in
  let valeurs_proratisees_liste_4 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_4)
  in
  let cursor = cursor + Array.length bases_prorata_liste_4 in
  let valeurs_proratisees_liste_5 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_5)
  in
  let cursor = cursor + Array.length bases_prorata_liste_5 in
  let valeurs_proratisees_liste_6 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_6)
  in
  let cursor = cursor + Array.length bases_prorata_liste_6 in
  let valeurs_proratisees_liste_7 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_7)
  in
  let cursor = cursor + Array.length bases_prorata_liste_7 in
  let valeurs_proratisees_liste_8 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_8)
  in
  let cursor = cursor + Array.length bases_prorata_liste_8 in
  let valeurs_proratisees_liste_9 : money array =
    Array.sub valeurs_proratisees cursor (Array.length bases_prorata_liste_9)
  in
  {
    valeur_proratisee_1;
    valeur_proratisee_2;
    valeur_proratisee_3;
    valeur_proratisee_4;
    valeur_proratisee_5;
    valeur_proratisee_6;
    valeur_proratisee_7;
    valeur_proratisee_8;
    valeur_proratisee_9;
    valeurs_proratisees_liste_1;
    valeurs_proratisees_liste_2;
    valeurs_proratisees_liste_3;
    valeurs_proratisees_liste_4;
    valeurs_proratisees_liste_5;
    valeurs_proratisees_liste_6;
    valeurs_proratisees_liste_7;
    valeurs_proratisees_liste_8;
    valeurs_proratisees_liste_9;
  }

let () =
  Catala_runtime.register_module "Oracles"
    [
      ( "imputation_aux_d\195\169ficits_les_plus_anciens",
        Obj.repr imputation_aux_deficits_les_plus_anciens );
      "prorata_arrondi_euro", Obj.repr prorata_arrondi_euro;
      "prorata_arrondi_euro_listes", Obj.repr prorata_arrondi_euro_listes;
      ( "prorata_arrondi_euro_branchement",
        Obj.repr prorata_arrondi_euro_branchement );
    ]
    "*external*"
