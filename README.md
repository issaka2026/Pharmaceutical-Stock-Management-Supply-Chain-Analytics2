# Analyse nationale de la chaîne d'approvisionnement pharmaceutique
**National Pharmaceutical Supply Chain – Executive Analytics Portfolio**

> **Avertissement essentiel :** le classeur source déclare explicitement que toutes les données sont fictives. Le projet est une démonstration de compétences et ne présente pas de résultats officiels du Niger.

## Objectif du projet
Démontrer la capacité à transformer des données de stock, consommation, commandes, lots et établissements en indicateurs de pilotage, alertes de risques et recommandations destinées à une Direction générale.

## Dashboard
- Ouvrir `index.html` dans un navigateur.
- Pour publication GitHub Pages : déposer le contenu du dépôt à la racine de la branche `main`, puis aller dans **Settings → Pages → Deploy from a branch → main → /(root)**.
- Le graphique Plotly utilise le CDN Plotly : une connexion Internet est nécessaire pour charger la bibliothèque.

## Périmètre source
- 60 produits; 44 établissements.
- 2,580 lignes de stock établissement-produit au 31/10/2026.
- 720 observations mensuelles de consommation, de novembre 2025 à octobre 2026.
- 240 commandes d'approvisionnement.
- 900 lots suivis.
- 1 800 transactions de stock.
- Devise : XOF.

## Principaux KPI calculés
| KPI | Valeur |
|---|---:|
| Valeur du stock disponible | 125,023,111 XOF |
| Disponibilité | 96.59% |
| Lignes en rupture | 88 |
| Stocks faibles | 129 |
| Surstocks | 171 |
| MOS moyen hors zéros | 2.49 mois |
| Lots FEFO High/Medium | 230 |
| Lots marqués expirés | 34 |
| Taux de service commande | 6.65% |
| Livraisons à temps | 50.79% |
| Commandes ouvertes en retard | 102 |
| Reliquat ouvert en retard | 390,008 unités |
| Rapports consommation Late/Missing | 83 |

## Questions de gestion
1. Où se concentrent les ruptures et stocks faibles ?
2. Quels niveaux de dépôts/établissements ont une disponibilité plus faible ?
3. Quel est le niveau de stock immobilisé et comment se répartit-il ?
4. Quel est le niveau d'exécution des commandes fournisseurs ?
5. Quels lots doivent être examinés selon les priorités FEFO ?
6. La qualité et la ponctualité du reporting permettent-elles une planification fiable ?

## Règles de calcul
- Disponibilité : `COUNT(Available_Qty > 0) / COUNT(*)`.
- Rupture : `Available_Qty = 0`.
- Stock faible : `0 < Available_Qty < Minimum_Stock_Qty`.
- Surstock : `Available_Qty > Maximum_Stock_Qty`.
- Valeur du stock : somme `Available_Qty * Unit_Price_XOF`.
- MOS moyen : moyenne de `Months_of_Stock` en excluant les valeurs égales à zéro.
- Risque FEFO : lots dont `FEFO_Priority` est `High` ou `Medium`.
- Taux de service : somme `Delivered_Qty` / somme `Ordered_Qty`.
- Ponctualité : commandes `Delivered` avec date réelle ≤ date prévue / toutes les commandes `Delivered`.
- Commande ouverte en retard : statut différent de `Delivered` et `Cancelled`, date prévue antérieure au 31/10/2026.

Les définitions des KPI suivent l'onglet `KPI_CALCULATIONS` du classeur source. Les indicateurs additionnels de retard et de qualité sont des analyses dérivées explicitement documentées.

## Points de vigilance data quality
- 117 commandes au statut `Delivered` gardent un reliquat positif.
- 11 commandes `Cancelled` gardent un reliquat positif.
- 71 commandes n'ont pas de date réelle de livraison.
- 83 rapports de consommation sont `Late` ou `Missing`.
- Les clés de stock testées (produit, établissement, couple produit-établissement), la formule de stock disponible et la valeur de stock ne présentent pas d'écart dans les contrôles réalisés.

## Structure
```text
.
├── README.md
├── index.html
├── data/
│   ├── source_workbook.xlsx
│   ├── products.csv
│   ├── facilities.csv
│   ├── stock_data.csv
│   ├── consumption.csv
│   ├── supply_orders.csv
│   ├── expiry_tracking.csv
│   ├── transactions.csv
│   └── fichiers KPI et audit qualité
├── reports/
│   └── note_decisionnelle_direction_generale.md
├── sql/
│   └── kpi_queries.sql
└── src/
    └── analysis.py
```

## Stack technique
Excel · Python · pandas · NumPy · Plotly · SQL · GitHub Pages

## Compétences démontrées
Data cleaning · Data quality · KPI design · Inventory analytics · Procurement analytics · FEFO/expiry risk · Executive reporting · Decision support.

## Description courte GitHub
Interactive executive analytics project for a fictional national pharmaceutical supply chain: inventory availability, stock-out risk, procurement performance, expiry monitoring, data quality and management recommendations.
