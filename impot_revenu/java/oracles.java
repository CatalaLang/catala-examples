/* This is a template file following the expected interface and declarations to
 * implement the corresponding Catala module.
 *
 * You should replace all `Error.Impossible` place-holders with your
 * implementation and rename it to remove the ".template" suffix. */

import catala.runtime.*;
import catala.runtime.exception.*;

public class Oracles {
    
    public static class DeficitAnterieur
        implements CatalaValue {
        
        public final CatalaInteger annee;
        public final CatalaMoney valeur;
        
        public DeficitAnterieur (final CatalaInteger annee,
                                 final CatalaMoney valeur) {
            this.annee = annee;
            this.valeur = valeur;
        }
        
        @Override
        public CatalaBool equalsTo(CatalaValue other) {
          if (other instanceof DeficitAnterieur v) {
              return this.annee.equalsTo(v.annee).and
                        (this.valeur.equalsTo(v.valeur));
          } else { return CatalaBool.FALSE; } 
        }
        
        @Override
        public String toString() {
            return "annee = " + this.annee.toString() + ", "
            + "valeur = " + this.valeur.toString();
        }
    }
    
    public static class ImputationAuxDeficitsLesPlusAnciens
        implements CatalaValue {
        
        public final CatalaMoney revenu_impute;
        public final CatalaArray<DeficitAnterieur> deficits_anterieurs_restants;
        
        public ImputationAuxDeficitsLesPlusAnciens
            (final CatalaMoney revenu_declare_in,
             final CatalaArray<DeficitAnterieur> deficits_anterieurs_in) {
            final CatalaMoney revenuDeclare = revenu_declare_in;
            final CatalaArray<DeficitAnterieur>
                deficitsAnterieurs = deficits_anterieurs_in;
            final CatalaMoney revenuImpute;
            CatalaOption<CatalaTuple> revenuImpute__1 = CatalaOption.none();
            if (revenuImpute__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 29, 12, 29, 25,
                      new String[]{"Imputation des déficits antérieurs"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = revenuImpute__1.get();
                revenuImpute = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaArray<DeficitAnterieur> deficitsAnterieursRestants;
            CatalaOption<CatalaTuple> deficitsAnterieursRestants__1 =
                CatalaOption.none();
            if (deficitsAnterieursRestants__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 30, 12, 30, 40,
                      new String[]{"Imputation des déficits antérieurs"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = deficitsAnterieursRestants__1.get();
                deficitsAnterieursRestants = CatalaValue.<CatalaArray<DeficitAnterieur>>cast
                   (arg.get(0));
            }
            this.revenu_impute = revenuImpute;
            this.deficits_anterieurs_restants = deficitsAnterieursRestants;
        }
        
        public static class ImputationAuxDeficitsLesPlusAnciensOut {
            public final CatalaMoney revenu_impute;
            public final CatalaArray<DeficitAnterieur> deficits_anterieurs_restants;
            public ImputationAuxDeficitsLesPlusAnciensOut (final CatalaMoney revenu_impute,
                                                           final CatalaArray<DeficitAnterieur> deficits_anterieurs_restants) {
                this.revenu_impute = revenu_impute;
                this.deficits_anterieurs_restants = deficits_anterieurs_restants;
            }
        }
        
        public ImputationAuxDeficitsLesPlusAnciens (ImputationAuxDeficitsLesPlusAnciensOut result) {
            this.revenu_impute = result.revenu_impute;
            this.deficits_anterieurs_restants = result.deficits_anterieurs_restants;
        }
        
        @Override
        public CatalaBool equalsTo(CatalaValue other) {
          if (other instanceof ImputationAuxDeficitsLesPlusAnciens v) {
              return this.revenu_impute.equalsTo(v.revenu_impute).and
                        (this.deficits_anterieurs_restants.equalsTo(v.deficits_anterieurs_restants));
          } else { return CatalaBool.FALSE; } 
        }
        
        @Override
        public String toString() {
            return "revenu_impute = " + this.revenu_impute.toString() + ", "
            + "deficits_anterieurs_restants = " + this.deficits_anterieurs_restants.toString();
        }
    }
    
    public static class ProRataArrondiEuro implements CatalaValue {
        
        public final CatalaArray<CatalaMoney> valeurs_proratisees;
        
        public ProRataArrondiEuro
            (final CatalaMoney montant_a_distribuer_in,
             final CatalaArray<CatalaMoney> bases_prorata_in) {
            final CatalaMoney montantADistribuer = montant_a_distribuer_in;
            final CatalaArray<CatalaMoney> basesProrata = bases_prorata_in;
            final CatalaArray<CatalaMoney> valeursProratisees;
            CatalaOption<CatalaTuple> valeursProratisees__1 =
                CatalaOption.none();
            if (valeursProratisees__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 73, 12, 73, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratisees__1.get();
                valeursProratisees = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            this.valeurs_proratisees = valeursProratisees;
        }
        
        public static class ProRataArrondiEuroOut {
            public final CatalaArray<CatalaMoney> valeurs_proratisees;
            public ProRataArrondiEuroOut (final CatalaArray<CatalaMoney> valeurs_proratisees) {
                this.valeurs_proratisees = valeurs_proratisees;
            }
        }
        
        public ProRataArrondiEuro (ProRataArrondiEuroOut result) {
            this.valeurs_proratisees = result.valeurs_proratisees;
        }
        
        @Override
        public CatalaBool equalsTo(CatalaValue other) {
          if (other instanceof ProRataArrondiEuro v) {
              return this.valeurs_proratisees.equalsTo(v.valeurs_proratisees);
          } else { return CatalaBool.FALSE; } 
        }
        
        @Override
        public String toString() {
            return "valeurs_proratisees = " + this.valeurs_proratisees.toString();
        }
    }
    
    public static class ProRataArrondiEuroListes implements CatalaValue {
        
        public final CatalaArray<CatalaArray<CatalaMoney>> valeurs_proratisees;
        
        public ProRataArrondiEuroListes
            (final CatalaMoney montant_a_distribuer_in,
             final CatalaArray<CatalaArray<CatalaMoney>> bases_prorata_in) {
            final CatalaMoney montantADistribuer = montant_a_distribuer_in;
            final CatalaArray<CatalaArray<CatalaMoney>>
                basesProrata = bases_prorata_in;
            final CatalaArray<CatalaArray<CatalaMoney>> valeursProratisees;
            CatalaOption<CatalaTuple> valeursProratisees__1 =
                CatalaOption.none();
            if (valeursProratisees__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 80, 12, 80, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratisees__1.get();
                valeursProratisees = CatalaValue.<CatalaArray<CatalaArray<CatalaMoney>>>cast
                   (arg.get(0));
            }
            this.valeurs_proratisees = valeursProratisees;
        }
        
        public static class ProRataArrondiEuroListesOut {
            public final CatalaArray<CatalaArray<CatalaMoney>> valeurs_proratisees;
            public ProRataArrondiEuroListesOut (final CatalaArray<CatalaArray<CatalaMoney>> valeurs_proratisees) {
                this.valeurs_proratisees = valeurs_proratisees;
            }
        }
        
        public ProRataArrondiEuroListes (ProRataArrondiEuroListesOut result) {
            this.valeurs_proratisees = result.valeurs_proratisees;
        }
        
        @Override
        public CatalaBool equalsTo(CatalaValue other) {
          if (other instanceof ProRataArrondiEuroListes v) {
              return this.valeurs_proratisees.equalsTo(v.valeurs_proratisees);
          } else { return CatalaBool.FALSE; } 
        }
        
        @Override
        public String toString() {
            return "valeurs_proratisees = " + this.valeurs_proratisees.toString();
        }
    }
    
    public static class ProRataArrondiEuroBranchement
        implements CatalaValue {
        
        public final CatalaMoney valeur_proratisee_1;
        public final CatalaMoney valeur_proratisee_2;
        public final CatalaMoney valeur_proratisee_3;
        public final CatalaMoney valeur_proratisee_4;
        public final CatalaMoney valeur_proratisee_5;
        public final CatalaMoney valeur_proratisee_6;
        public final CatalaMoney valeur_proratisee_7;
        public final CatalaMoney valeur_proratisee_8;
        public final CatalaMoney valeur_proratisee_9;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_1;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_2;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_3;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_4;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_5;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_6;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_7;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_8;
        public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_9;
        
        public ProRataArrondiEuroBranchement
            (final CatalaMoney montant_a_distribuer_in,
             final CatalaOption<CatalaTuple> base_prorata_1_in,
             final CatalaOption<CatalaTuple> base_prorata_2_in,
             final CatalaOption<CatalaTuple> base_prorata_3_in,
             final CatalaOption<CatalaTuple> base_prorata_4_in,
             final CatalaOption<CatalaTuple> base_prorata_5_in,
             final CatalaOption<CatalaTuple> base_prorata_6_in,
             final CatalaOption<CatalaTuple> base_prorata_7_in,
             final CatalaOption<CatalaTuple> base_prorata_8_in,
             final CatalaOption<CatalaTuple> base_prorata_9_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_1_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_2_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_3_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_4_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_5_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_6_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_7_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_8_in,
             final CatalaOption<CatalaTuple> bases_prorata_liste_9_in) {
            final CatalaMoney montantADistribuer = montant_a_distribuer_in;
            final CatalaOption<CatalaTuple> baseProrata1 = base_prorata_1_in;
            final CatalaOption<CatalaTuple> baseProrata2 = base_prorata_2_in;
            final CatalaOption<CatalaTuple> baseProrata3 = base_prorata_3_in;
            final CatalaOption<CatalaTuple> baseProrata4 = base_prorata_4_in;
            final CatalaOption<CatalaTuple> baseProrata5 = base_prorata_5_in;
            final CatalaOption<CatalaTuple> baseProrata6 = base_prorata_6_in;
            final CatalaOption<CatalaTuple> baseProrata7 = base_prorata_7_in;
            final CatalaOption<CatalaTuple> baseProrata8 = base_prorata_8_in;
            final CatalaOption<CatalaTuple> baseProrata9 = base_prorata_9_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe1 = bases_prorata_liste_1_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe2 = bases_prorata_liste_2_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe3 = bases_prorata_liste_3_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe4 = bases_prorata_liste_4_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe5 = bases_prorata_liste_5_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe6 = bases_prorata_liste_6_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe7 = bases_prorata_liste_7_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe8 = bases_prorata_liste_8_in;
            final CatalaOption<CatalaTuple>
                basesProrataListe9 = bases_prorata_liste_9_in;
            final CatalaMoney baseProrata11;
            final CatalaOption<CatalaTuple> baseProrata11__1;
            if (baseProrata1.isNone()) {
                final CatalaMoney baseProrata111;
                CatalaOption<CatalaTuple> baseProrata111__1 =
                    CatalaOption.none();
                if (baseProrata111__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 86, 12, 86, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata111__1.get();
                    baseProrata111 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 86, 12, 86, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata11__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata111, pos));
            } else {
                CatalaTuple x = baseProrata1.get();
                baseProrata11__1 = CatalaOption.some(x);
            }
            if (baseProrata11__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 86, 12, 86, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata11__1.get();
                baseProrata11 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaMoney baseProrata21;
            final CatalaOption<CatalaTuple> baseProrata21__1;
            if (baseProrata2.isNone()) {
                final CatalaMoney baseProrata211;
                CatalaOption<CatalaTuple> baseProrata211__1 =
                    CatalaOption.none();
                if (baseProrata211__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 87, 12, 87, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata211__1.get();
                    baseProrata211 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 87, 12, 87, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata21__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata211, pos));
            } else {
                CatalaTuple x = baseProrata2.get();
                baseProrata21__1 = CatalaOption.some(x);
            }
            if (baseProrata21__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 87, 12, 87, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata21__1.get();
                baseProrata21 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaMoney baseProrata31;
            final CatalaOption<CatalaTuple> baseProrata31__1;
            if (baseProrata3.isNone()) {
                final CatalaMoney baseProrata311;
                CatalaOption<CatalaTuple> baseProrata311__1 =
                    CatalaOption.none();
                if (baseProrata311__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 88, 12, 88, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata311__1.get();
                    baseProrata311 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 88, 12, 88, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata31__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata311, pos));
            } else {
                CatalaTuple x = baseProrata3.get();
                baseProrata31__1 = CatalaOption.some(x);
            }
            if (baseProrata31__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 88, 12, 88, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata31__1.get();
                baseProrata31 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaMoney baseProrata41;
            final CatalaOption<CatalaTuple> baseProrata41__1;
            if (baseProrata4.isNone()) {
                final CatalaMoney baseProrata411;
                CatalaOption<CatalaTuple> baseProrata411__1 =
                    CatalaOption.none();
                if (baseProrata411__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 89, 12, 89, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata411__1.get();
                    baseProrata411 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 89, 12, 89, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata41__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata411, pos));
            } else {
                CatalaTuple x = baseProrata4.get();
                baseProrata41__1 = CatalaOption.some(x);
            }
            if (baseProrata41__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 89, 12, 89, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata41__1.get();
                baseProrata41 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaMoney baseProrata51;
            final CatalaOption<CatalaTuple> baseProrata51__1;
            if (baseProrata5.isNone()) {
                final CatalaMoney baseProrata511;
                CatalaOption<CatalaTuple> baseProrata511__1 =
                    CatalaOption.none();
                if (baseProrata511__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 90, 12, 90, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata511__1.get();
                    baseProrata511 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 90, 12, 90, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata51__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata511, pos));
            } else {
                CatalaTuple x = baseProrata5.get();
                baseProrata51__1 = CatalaOption.some(x);
            }
            if (baseProrata51__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 90, 12, 90, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata51__1.get();
                baseProrata51 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaMoney baseProrata61;
            final CatalaOption<CatalaTuple> baseProrata61__1;
            if (baseProrata6.isNone()) {
                final CatalaMoney baseProrata611;
                CatalaOption<CatalaTuple> baseProrata611__1 =
                    CatalaOption.none();
                if (baseProrata611__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 91, 12, 91, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata611__1.get();
                    baseProrata611 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 91, 12, 91, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata61__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata611, pos));
            } else {
                CatalaTuple x = baseProrata6.get();
                baseProrata61__1 = CatalaOption.some(x);
            }
            if (baseProrata61__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 91, 12, 91, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata61__1.get();
                baseProrata61 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaMoney baseProrata71;
            final CatalaOption<CatalaTuple> baseProrata71__1;
            if (baseProrata7.isNone()) {
                final CatalaMoney baseProrata711;
                CatalaOption<CatalaTuple> baseProrata711__1 =
                    CatalaOption.none();
                if (baseProrata711__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 92, 12, 92, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata711__1.get();
                    baseProrata711 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 92, 12, 92, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata71__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata711, pos));
            } else {
                CatalaTuple x = baseProrata7.get();
                baseProrata71__1 = CatalaOption.some(x);
            }
            if (baseProrata71__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 92, 12, 92, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata71__1.get();
                baseProrata71 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaMoney baseProrata81;
            final CatalaOption<CatalaTuple> baseProrata81__1;
            if (baseProrata8.isNone()) {
                final CatalaMoney baseProrata811;
                CatalaOption<CatalaTuple> baseProrata811__1 =
                    CatalaOption.none();
                if (baseProrata811__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 93, 12, 93, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata811__1.get();
                    baseProrata811 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 93, 12, 93, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata81__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata811, pos));
            } else {
                CatalaTuple x = baseProrata8.get();
                baseProrata81__1 = CatalaOption.some(x);
            }
            if (baseProrata81__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 93, 12, 93, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata81__1.get();
                baseProrata81 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaMoney baseProrata91;
            final CatalaOption<CatalaTuple> baseProrata91__1;
            if (baseProrata9.isNone()) {
                final CatalaMoney baseProrata911;
                CatalaOption<CatalaTuple> baseProrata911__1 =
                    CatalaOption.none();
                if (baseProrata911__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 94, 12, 94, 26,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = baseProrata911__1.get();
                    baseProrata911 = CatalaValue.<CatalaMoney>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 94, 12, 94, 26,
                      new String[]{"Calcul de pro-rata"});
                baseProrata91__1 = CatalaOption.some
                                    (new CatalaTuple(baseProrata911, pos));
            } else {
                CatalaTuple x = baseProrata9.get();
                baseProrata91__1 = CatalaOption.some(x);
            }
            if (baseProrata91__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 94, 12, 94, 26,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = baseProrata91__1.get();
                baseProrata91 = CatalaValue.<CatalaMoney>cast(arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe11;
            final CatalaOption<CatalaTuple> basesProrataListe11__1;
            if (basesProrataListe1.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe111;
                CatalaOption<CatalaTuple> basesProrataListe111__1 =
                    CatalaOption.none();
                if (basesProrataListe111__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 95, 12, 95, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe111__1.get();
                    basesProrataListe111 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 95, 12, 95, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe11__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe111,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe1.get();
                basesProrataListe11__1 = CatalaOption.some(x);
            }
            if (basesProrataListe11__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 95, 12, 95, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe11__1.get();
                basesProrataListe11 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe21;
            final CatalaOption<CatalaTuple> basesProrataListe21__1;
            if (basesProrataListe2.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe211;
                CatalaOption<CatalaTuple> basesProrataListe211__1 =
                    CatalaOption.none();
                if (basesProrataListe211__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 96, 12, 96, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe211__1.get();
                    basesProrataListe211 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 96, 12, 96, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe21__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe211,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe2.get();
                basesProrataListe21__1 = CatalaOption.some(x);
            }
            if (basesProrataListe21__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 96, 12, 96, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe21__1.get();
                basesProrataListe21 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe31;
            final CatalaOption<CatalaTuple> basesProrataListe31__1;
            if (basesProrataListe3.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe311;
                CatalaOption<CatalaTuple> basesProrataListe311__1 =
                    CatalaOption.none();
                if (basesProrataListe311__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 97, 12, 97, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe311__1.get();
                    basesProrataListe311 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 97, 12, 97, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe31__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe311,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe3.get();
                basesProrataListe31__1 = CatalaOption.some(x);
            }
            if (basesProrataListe31__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 97, 12, 97, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe31__1.get();
                basesProrataListe31 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe41;
            final CatalaOption<CatalaTuple> basesProrataListe41__1;
            if (basesProrataListe4.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe411;
                CatalaOption<CatalaTuple> basesProrataListe411__1 =
                    CatalaOption.none();
                if (basesProrataListe411__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 98, 12, 98, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe411__1.get();
                    basesProrataListe411 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 98, 12, 98, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe41__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe411,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe4.get();
                basesProrataListe41__1 = CatalaOption.some(x);
            }
            if (basesProrataListe41__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 98, 12, 98, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe41__1.get();
                basesProrataListe41 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe51;
            final CatalaOption<CatalaTuple> basesProrataListe51__1;
            if (basesProrataListe5.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe511;
                CatalaOption<CatalaTuple> basesProrataListe511__1 =
                    CatalaOption.none();
                if (basesProrataListe511__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 99, 12, 99, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe511__1.get();
                    basesProrataListe511 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 99, 12, 99, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe51__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe511,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe5.get();
                basesProrataListe51__1 = CatalaOption.some(x);
            }
            if (basesProrataListe51__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 99, 12, 99, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe51__1.get();
                basesProrataListe51 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe61;
            final CatalaOption<CatalaTuple> basesProrataListe61__1;
            if (basesProrataListe6.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe611;
                CatalaOption<CatalaTuple> basesProrataListe611__1 =
                    CatalaOption.none();
                if (basesProrataListe611__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 100, 12, 100, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe611__1.get();
                    basesProrataListe611 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 100, 12, 100, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe61__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe611,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe6.get();
                basesProrataListe61__1 = CatalaOption.some(x);
            }
            if (basesProrataListe61__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 100, 12, 100, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe61__1.get();
                basesProrataListe61 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe71;
            final CatalaOption<CatalaTuple> basesProrataListe71__1;
            if (basesProrataListe7.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe711;
                CatalaOption<CatalaTuple> basesProrataListe711__1 =
                    CatalaOption.none();
                if (basesProrataListe711__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 101, 12, 101, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe711__1.get();
                    basesProrataListe711 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 101, 12, 101, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe71__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe711,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe7.get();
                basesProrataListe71__1 = CatalaOption.some(x);
            }
            if (basesProrataListe71__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 101, 12, 101, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe71__1.get();
                basesProrataListe71 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe81;
            final CatalaOption<CatalaTuple> basesProrataListe81__1;
            if (basesProrataListe8.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe811;
                CatalaOption<CatalaTuple> basesProrataListe811__1 =
                    CatalaOption.none();
                if (basesProrataListe811__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 102, 12, 102, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe811__1.get();
                    basesProrataListe811 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 102, 12, 102, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe81__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe811,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe8.get();
                basesProrataListe81__1 = CatalaOption.some(x);
            }
            if (basesProrataListe81__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 102, 12, 102, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe81__1.get();
                basesProrataListe81 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> basesProrataListe91;
            final CatalaOption<CatalaTuple> basesProrataListe91__1;
            if (basesProrataListe9.isNone()) {
                final CatalaArray<CatalaMoney> basesProrataListe911;
                CatalaOption<CatalaTuple> basesProrataListe911__1 =
                    CatalaOption.none();
                if (basesProrataListe911__1.isNone()) {
                    CatalaPosition pos =
                        new CatalaPosition
                         ("impot_revenu/oracles.catala_fr", 103, 12, 103, 33,
                          new String[]{"Calcul de pro-rata"});
                    throw new CatalaError(CatalaError.Error.NoValue, pos);
                } else {
                    CatalaTuple arg = basesProrataListe911__1.get();
                    basesProrataListe911 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                       (arg.get(0));
                }
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 103, 12, 103, 33,
                      new String[]{"Calcul de pro-rata"});
                basesProrataListe91__1 = CatalaOption.some
                                          (new CatalaTuple
                                            (basesProrataListe911,
                                             pos));
            } else {
                CatalaTuple x = basesProrataListe9.get();
                basesProrataListe91__1 = CatalaOption.some(x);
            }
            if (basesProrataListe91__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 103, 12, 103, 33,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = basesProrataListe91__1.get();
                basesProrataListe91 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee1;
            CatalaOption<CatalaTuple> valeurProratisee1__1 =
                CatalaOption.none();
            if (valeurProratisee1__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 105, 12, 105, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee1__1.get();
                valeurProratisee1 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee2;
            CatalaOption<CatalaTuple> valeurProratisee2__1 =
                CatalaOption.none();
            if (valeurProratisee2__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 106, 12, 106, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee2__1.get();
                valeurProratisee2 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee3;
            CatalaOption<CatalaTuple> valeurProratisee3__1 =
                CatalaOption.none();
            if (valeurProratisee3__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 107, 12, 107, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee3__1.get();
                valeurProratisee3 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee4;
            CatalaOption<CatalaTuple> valeurProratisee4__1 =
                CatalaOption.none();
            if (valeurProratisee4__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 108, 12, 108, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee4__1.get();
                valeurProratisee4 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee5;
            CatalaOption<CatalaTuple> valeurProratisee5__1 =
                CatalaOption.none();
            if (valeurProratisee5__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 109, 12, 109, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee5__1.get();
                valeurProratisee5 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee6;
            CatalaOption<CatalaTuple> valeurProratisee6__1 =
                CatalaOption.none();
            if (valeurProratisee6__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 110, 12, 110, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee6__1.get();
                valeurProratisee6 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee7;
            CatalaOption<CatalaTuple> valeurProratisee7__1 =
                CatalaOption.none();
            if (valeurProratisee7__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 111, 12, 111, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee7__1.get();
                valeurProratisee7 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee8;
            CatalaOption<CatalaTuple> valeurProratisee8__1 =
                CatalaOption.none();
            if (valeurProratisee8__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 112, 12, 112, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee8__1.get();
                valeurProratisee8 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaMoney valeurProratisee9;
            CatalaOption<CatalaTuple> valeurProratisee9__1 =
                CatalaOption.none();
            if (valeurProratisee9__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 113, 12, 113, 31,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeurProratisee9__1.get();
                valeurProratisee9 = CatalaValue.<CatalaMoney>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe1;
            CatalaOption<CatalaTuple> valeursProratiseesListe1__1 =
                CatalaOption.none();
            if (valeursProratiseesListe1__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 114, 12, 114, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe1__1.get();
                valeursProratiseesListe1 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe2;
            CatalaOption<CatalaTuple> valeursProratiseesListe2__1 =
                CatalaOption.none();
            if (valeursProratiseesListe2__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 115, 12, 115, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe2__1.get();
                valeursProratiseesListe2 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe3;
            CatalaOption<CatalaTuple> valeursProratiseesListe3__1 =
                CatalaOption.none();
            if (valeursProratiseesListe3__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 116, 12, 116, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe3__1.get();
                valeursProratiseesListe3 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe4;
            CatalaOption<CatalaTuple> valeursProratiseesListe4__1 =
                CatalaOption.none();
            if (valeursProratiseesListe4__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 117, 12, 117, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe4__1.get();
                valeursProratiseesListe4 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe5;
            CatalaOption<CatalaTuple> valeursProratiseesListe5__1 =
                CatalaOption.none();
            if (valeursProratiseesListe5__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 118, 12, 118, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe5__1.get();
                valeursProratiseesListe5 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe6;
            CatalaOption<CatalaTuple> valeursProratiseesListe6__1 =
                CatalaOption.none();
            if (valeursProratiseesListe6__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 119, 12, 119, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe6__1.get();
                valeursProratiseesListe6 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe7;
            CatalaOption<CatalaTuple> valeursProratiseesListe7__1 =
                CatalaOption.none();
            if (valeursProratiseesListe7__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 120, 12, 120, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe7__1.get();
                valeursProratiseesListe7 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe8;
            CatalaOption<CatalaTuple> valeursProratiseesListe8__1 =
                CatalaOption.none();
            if (valeursProratiseesListe8__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 121, 12, 121, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe8__1.get();
                valeursProratiseesListe8 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            final CatalaArray<CatalaMoney> valeursProratiseesListe9;
            CatalaOption<CatalaTuple> valeursProratiseesListe9__1 =
                CatalaOption.none();
            if (valeursProratiseesListe9__1.isNone()) {
                CatalaPosition pos =
                    new CatalaPosition
                     ("impot_revenu/oracles.catala_fr", 122, 12, 122, 39,
                      new String[]{"Calcul de pro-rata"});
                throw new CatalaError(CatalaError.Error.NoValue, pos);
            } else {
                CatalaTuple arg = valeursProratiseesListe9__1.get();
                valeursProratiseesListe9 = CatalaValue.<CatalaArray<CatalaMoney>>cast
                   (arg.get(0));
            }
            this.valeur_proratisee_1 = valeurProratisee1;
            this.valeur_proratisee_2 = valeurProratisee2;
            this.valeur_proratisee_3 = valeurProratisee3;
            this.valeur_proratisee_4 = valeurProratisee4;
            this.valeur_proratisee_5 = valeurProratisee5;
            this.valeur_proratisee_6 = valeurProratisee6;
            this.valeur_proratisee_7 = valeurProratisee7;
            this.valeur_proratisee_8 = valeurProratisee8;
            this.valeur_proratisee_9 = valeurProratisee9;
            this.valeurs_proratisees_liste_1 = valeursProratiseesListe1;
            this.valeurs_proratisees_liste_2 = valeursProratiseesListe2;
            this.valeurs_proratisees_liste_3 = valeursProratiseesListe3;
            this.valeurs_proratisees_liste_4 = valeursProratiseesListe4;
            this.valeurs_proratisees_liste_5 = valeursProratiseesListe5;
            this.valeurs_proratisees_liste_6 = valeursProratiseesListe6;
            this.valeurs_proratisees_liste_7 = valeursProratiseesListe7;
            this.valeurs_proratisees_liste_8 = valeursProratiseesListe8;
            this.valeurs_proratisees_liste_9 = valeursProratiseesListe9;
        }
        
        public static class ProRataArrondiEuroBranchementOut {
            public final CatalaMoney valeur_proratisee_1;
            public final CatalaMoney valeur_proratisee_2;
            public final CatalaMoney valeur_proratisee_3;
            public final CatalaMoney valeur_proratisee_4;
            public final CatalaMoney valeur_proratisee_5;
            public final CatalaMoney valeur_proratisee_6;
            public final CatalaMoney valeur_proratisee_7;
            public final CatalaMoney valeur_proratisee_8;
            public final CatalaMoney valeur_proratisee_9;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_1;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_2;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_3;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_4;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_5;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_6;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_7;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_8;
            public final CatalaArray<CatalaMoney> valeurs_proratisees_liste_9;
            public ProRataArrondiEuroBranchementOut (final CatalaMoney valeur_proratisee_1,
                                                     final CatalaMoney valeur_proratisee_2,
                                                     final CatalaMoney valeur_proratisee_3,
                                                     final CatalaMoney valeur_proratisee_4,
                                                     final CatalaMoney valeur_proratisee_5,
                                                     final CatalaMoney valeur_proratisee_6,
                                                     final CatalaMoney valeur_proratisee_7,
                                                     final CatalaMoney valeur_proratisee_8,
                                                     final CatalaMoney valeur_proratisee_9,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_1,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_2,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_3,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_4,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_5,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_6,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_7,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_8,
                                                     final CatalaArray<CatalaMoney> valeurs_proratisees_liste_9) {
                this.valeur_proratisee_1 = valeur_proratisee_1;
                this.valeur_proratisee_2 = valeur_proratisee_2;
                this.valeur_proratisee_3 = valeur_proratisee_3;
                this.valeur_proratisee_4 = valeur_proratisee_4;
                this.valeur_proratisee_5 = valeur_proratisee_5;
                this.valeur_proratisee_6 = valeur_proratisee_6;
                this.valeur_proratisee_7 = valeur_proratisee_7;
                this.valeur_proratisee_8 = valeur_proratisee_8;
                this.valeur_proratisee_9 = valeur_proratisee_9;
                this.valeurs_proratisees_liste_1 = valeurs_proratisees_liste_1;
                this.valeurs_proratisees_liste_2 = valeurs_proratisees_liste_2;
                this.valeurs_proratisees_liste_3 = valeurs_proratisees_liste_3;
                this.valeurs_proratisees_liste_4 = valeurs_proratisees_liste_4;
                this.valeurs_proratisees_liste_5 = valeurs_proratisees_liste_5;
                this.valeurs_proratisees_liste_6 = valeurs_proratisees_liste_6;
                this.valeurs_proratisees_liste_7 = valeurs_proratisees_liste_7;
                this.valeurs_proratisees_liste_8 = valeurs_proratisees_liste_8;
                this.valeurs_proratisees_liste_9 = valeurs_proratisees_liste_9;
            }
        }
        
        public ProRataArrondiEuroBranchement (ProRataArrondiEuroBranchementOut result) {
            this.valeur_proratisee_1 = result.valeur_proratisee_1;
            this.valeur_proratisee_2 = result.valeur_proratisee_2;
            this.valeur_proratisee_3 = result.valeur_proratisee_3;
            this.valeur_proratisee_4 = result.valeur_proratisee_4;
            this.valeur_proratisee_5 = result.valeur_proratisee_5;
            this.valeur_proratisee_6 = result.valeur_proratisee_6;
            this.valeur_proratisee_7 = result.valeur_proratisee_7;
            this.valeur_proratisee_8 = result.valeur_proratisee_8;
            this.valeur_proratisee_9 = result.valeur_proratisee_9;
            this.valeurs_proratisees_liste_1 = result.valeurs_proratisees_liste_1;
            this.valeurs_proratisees_liste_2 = result.valeurs_proratisees_liste_2;
            this.valeurs_proratisees_liste_3 = result.valeurs_proratisees_liste_3;
            this.valeurs_proratisees_liste_4 = result.valeurs_proratisees_liste_4;
            this.valeurs_proratisees_liste_5 = result.valeurs_proratisees_liste_5;
            this.valeurs_proratisees_liste_6 = result.valeurs_proratisees_liste_6;
            this.valeurs_proratisees_liste_7 = result.valeurs_proratisees_liste_7;
            this.valeurs_proratisees_liste_8 = result.valeurs_proratisees_liste_8;
            this.valeurs_proratisees_liste_9 = result.valeurs_proratisees_liste_9;
        }
        
        @Override
        public CatalaBool equalsTo(CatalaValue other) {
          if (other instanceof ProRataArrondiEuroBranchement v) {
              return this.valeur_proratisee_1.equalsTo(v.valeur_proratisee_1).and
                        (this.valeur_proratisee_2.equalsTo(v.valeur_proratisee_2).and
                        (this.valeur_proratisee_3.equalsTo(v.valeur_proratisee_3).and
                        (this.valeur_proratisee_4.equalsTo(v.valeur_proratisee_4).and
                        (this.valeur_proratisee_5.equalsTo(v.valeur_proratisee_5).and
                        (this.valeur_proratisee_6.equalsTo(v.valeur_proratisee_6).and
                        (this.valeur_proratisee_7.equalsTo(v.valeur_proratisee_7).and
                        (this.valeur_proratisee_8.equalsTo(v.valeur_proratisee_8).and
                        (this.valeur_proratisee_9.equalsTo(v.valeur_proratisee_9).and
                        (this.valeurs_proratisees_liste_1.equalsTo(v.valeurs_proratisees_liste_1).and
                        (this.valeurs_proratisees_liste_2.equalsTo(v.valeurs_proratisees_liste_2).and
                        (this.valeurs_proratisees_liste_3.equalsTo(v.valeurs_proratisees_liste_3).and
                        (this.valeurs_proratisees_liste_4.equalsTo(v.valeurs_proratisees_liste_4).and
                        (this.valeurs_proratisees_liste_5.equalsTo(v.valeurs_proratisees_liste_5).and
                        (this.valeurs_proratisees_liste_6.equalsTo(v.valeurs_proratisees_liste_6).and
                        (this.valeurs_proratisees_liste_7.equalsTo(v.valeurs_proratisees_liste_7).and
                        (this.valeurs_proratisees_liste_8.equalsTo(v.valeurs_proratisees_liste_8).and
                        (this.valeurs_proratisees_liste_9.equalsTo(v.valeurs_proratisees_liste_9))))))))))))))))));
          } else { return CatalaBool.FALSE; } 
        }
        
        @Override
        public String toString() {
            return "valeur_proratisee_1 = " + this.valeur_proratisee_1.toString() + ", "
            + "valeur_proratisee_2 = " + this.valeur_proratisee_2.toString() + ", "
            + "valeur_proratisee_3 = " + this.valeur_proratisee_3.toString() + ", "
            + "valeur_proratisee_4 = " + this.valeur_proratisee_4.toString() + ", "
            + "valeur_proratisee_5 = " + this.valeur_proratisee_5.toString() + ", "
            + "valeur_proratisee_6 = " + this.valeur_proratisee_6.toString() + ", "
            + "valeur_proratisee_7 = " + this.valeur_proratisee_7.toString() + ", "
            + "valeur_proratisee_8 = " + this.valeur_proratisee_8.toString() + ", "
            + "valeur_proratisee_9 = " + this.valeur_proratisee_9.toString() + ", "
            + "valeurs_proratisees_liste_1 = " + this.valeurs_proratisees_liste_1.toString() + ", "
            + "valeurs_proratisees_liste_2 = " + this.valeurs_proratisees_liste_2.toString() + ", "
            + "valeurs_proratisees_liste_3 = " + this.valeurs_proratisees_liste_3.toString() + ", "
            + "valeurs_proratisees_liste_4 = " + this.valeurs_proratisees_liste_4.toString() + ", "
            + "valeurs_proratisees_liste_5 = " + this.valeurs_proratisees_liste_5.toString() + ", "
            + "valeurs_proratisees_liste_6 = " + this.valeurs_proratisees_liste_6.toString() + ", "
            + "valeurs_proratisees_liste_7 = " + this.valeurs_proratisees_liste_7.toString() + ", "
            + "valeurs_proratisees_liste_8 = " + this.valeurs_proratisees_liste_8.toString() + ", "
            + "valeurs_proratisees_liste_9 = " + this.valeurs_proratisees_liste_9.toString();
        }
    }
    
}
