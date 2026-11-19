# NOTE DE SYNTHÈSE À L'ATTENTION DE LA DIRECTION GÉNÉRALE
## Analyse nationale de la chaîne d'approvisionnement pharmaceutique
**Date de référence : 31 octobre 2026**  
**Nature des données : jeu de données entièrement synthétique**

### 1. Objet
Présenter une lecture décisionnelle des stocks, de la disponibilité des produits, des commandes fournisseurs, des risques de péremption et de la qualité des données, afin d'illustrer un dispositif de pilotage national.

### 2. Tableau de bord des indicateurs

| Indicateur | Résultat calculé | Interprétation |
|---|---:|---|
| Produits référencés | 60 | Taille du catalogue |
| Établissements | 44 | Périmètre du jeu de données |
| Enregistrements de stock | 2,580 | Couples établissement-produit |
| Valeur du stock disponible | 125,023,111 XOF | Somme de Available_Qty × Unit_Price_XOF |
| Disponibilité | 96.59% | Part des lignes avec stock disponible positif |
| Lignes en rupture | 88 | Couples établissement-produit à quantité disponible nulle |
| Stocks faibles | 129 | Quantité disponible positive sous le minimum |
| Surstocks | 171 | Quantité disponible au-dessus du maximum |
| Couverture moyenne | 2.49 mois | Moyenne simple de MOS, hors zéros |
| Lots FEFO High/Medium | 230 | Priorité FEFO source High ou Medium |
| Lots marqués expirés | 34 | Statut source Expired |
| Taux de service calculé | 6.65% | Quantités livrées / quantités commandées |
| Livraisons à temps | 50.79% | Parmi les commandes au statut Delivered |
| Commandes ouvertes en retard | 102 | Non livrées/non annulées, date prévue dépassée |
| Reliquat ouvert en retard | 390,008 unités | Somme des reliquats de ces commandes |
| Rapports conso tardifs/manquants | 83 | Reporting_Status Late ou Missing |

### 3. Principaux risques à porter à l'attention de la Direction

**Risque 1 – Continuité de disponibilité.**  
Les 88 lignes en rupture constituent un signal d'alerte à analyser par produit, établissement et caractère essentiel. Les 129 lignes sous le seuil minimum doivent faire l'objet d'une revue de réapprovisionnement. Une décision d'allocation doit toutefois tenir compte des stocks mobilisables, des besoins, des délais et des contraintes de transport.

**Risque 2 – Exécution des commandes.**  
Le calcul du taux de service donne 6.65%. 102 commandes ouvertes apparaissent en retard à la date de référence, représentant 390,008 unités de reliquat. Les fournisseurs doivent être examinés sur les quantités, les dates attendues, les dates réelles et les preuves de réception.

**Risque 3 – Péremption et pertes.**  
230 lots sont signalés High ou Medium dans le champ FEFO_Priority; 34 lots portent le statut Expired. Il convient de confirmer les quantités restantes, isoler les lots expirés selon les procédures applicables, puis organiser la sortie FEFO et les transferts lorsque cela est autorisé.

**Risque 4 – Qualité du reporting.**  
83 rapports de consommation sont tardifs ou manquants. Une donnée de consommation incomplète fragilise la prévision, le calcul des besoins et les décisions de redistribution.

### 4. Alertes de cohérence à traiter avant toute utilisation opérationnelle

- 117 commandes sont marquées « Delivered » tout en conservant un reliquat positif.
- 11 commandes sont marquées « Cancelled » avec un reliquat positif.
- 71 commandes n'ont pas de date réelle de livraison.
- Les reliquats totaux (1,073,373) incluent des commandes annulées; le carnet opérationnel hors annulations est de 978,085 unités.
- Le taux de service calculé est une mesure agrégée; il ne remplace pas une analyse par commande, fournisseur, produit et période.

Ces constats sont des anomalies ou points de rapprochement à vérifier dans le jeu de données. Ils ne doivent pas être interprétés comme des défaillances réelles d'un système national.

### 5. Décisions proposées

| Horizon | Décision proposée | Responsable à désigner | Preuve de suivi |
|---|---|---|---|
| 0–7 jours | Valider la liste des ruptures et stocks faibles, en priorisant les produits essentiels | Direction logistique / dépôts | Liste validée avec action par ligne |
| 0–7 jours | Réunir les responsables approvisionnement et fournisseurs sur les commandes ouvertes en retard | Approvisionnement | Plan de livraison daté |
| 0–15 jours | Faire confirmer les lots FEFO High/Medium et les lots expirés | Pharmacie / qualité / dépôts | État des lots et mesures prises |
| 0–30 jours | Réconcilier statuts, quantités et dates des commandes | Approvisionnement / SI | Rapport d'écarts corrigés |
| Mensuel | Instaurer un calendrier national de remontée des consommations et un suivi des retards | Directions régionales / districts | Taux de complétude et ponctualité |
| Mensuel | Tenir une revue de performance par région, produit essentiel et niveau de dépôt | Direction générale / logistique | Tableau de bord signé et décisions |

### 6. Limites et conditions d'interprétation
1. Le classeur précise que toutes les données sont fictives et conçues pour un portfolio.
2. La disponibilité mesure les lignes établissement-produit avec Available_Qty supérieur à zéro; elle ne mesure pas la disponibilité pondérée par la criticité ou la population.
3. Le MOS est une moyenne simple et non pondérée, selon la définition du classeur.
4. Le taux de service est calculé à partir des quantités agrégées. Les incohérences de statuts et de reliquats doivent être résolues.
5. Les seuils de décision doivent être validés avec les procédures nationales, les délais réels, la saisonnalité et les règles de gestion des produits.

### 7. Conclusion
Le tableau de bord permet de passer d'un suivi descriptif des stocks à un pilotage par les risques : disponibilité, exécution des commandes, péremption et fiabilité des données. Dans un contexte réel, la Direction générale pourrait s'appuyer sur une revue périodique assortie de responsables, d'échéances et de preuves de clôture des actions.
