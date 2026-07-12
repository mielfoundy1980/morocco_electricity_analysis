# Titre du Projet : End-to-End Data Pipeline & Analyse de la Consommation Électrique au Maroc

## Rôle : Data Engineer / Data Analyst
## Technologies : MySQL, Python (Pandas, Seaborn), JupyterDash

## Contexte et Objectifs
L'objectif de ce projet est d'analyser la consommation électrique au Maroc, mesurée à des intervalles de 10 minutes à travers trois zones géographiques distinctes. L'analyse croise ces données avec des facteurs météorologiques clés pour identifier les modèles saisonniers et les principaux moteurs de la demande énergétique.

## À propos des données

* **Source :** UCI Machine Learning Repository
* **Licence :** CC BY 4.0 (Creative Commons Attribution 4.0 International)
* **Lien :** [Les données sur la plateforme : Maven Analytics](https://mavenanalytics.io/data-playground/morocco-electricity-consumption)

## Dictionnaire de Données

* **Datetime :** La date et l'heure de l'enregistrement.
* **Temperature :** La température en degrés Celsius.
* **Humidity :** La concentration de vapeur d'eau dans l'air.
* **WindSpeed :** La vitesse du vent en kilomètres par heure.
* **Power Consumption (Zones 1, 2, 3) :** La consommation électrique exprimée en Kilowatt-Heures pour chaque zone de puissance.

## Architecture des Données (Médaillon)

* **Couche Bronze :** Ingestion sécurisée des données brutes (VARCHAR) via LOAD DATA INFILE pour garantir la traçabilité sans perte de données.
* **Couche Silver :** Nettoyage, formatage (dates et décimales) et gestion des valeurs nulles pour obtenir un ensemble de données typé et fiable.
* **Couche Gold :** Création de vues SQL (Datamarts) pré-calculées pour alimenter directement les tableaux de bord interactifs (Profils horaires, saisonnalités, corrélations météo).

## Principaux Résultats (Key Insights)

* **Saisonnalité :** Identification d'un pic de consommation résidentielle majeur à 20h pour l'ensemble des zones, et d'un creux réseau autour de 6h du matin.
* **Corrélation Météorologique :** Démonstration mathématique (via Pandas) que la température est le facteur le plus fortement corrélé (0.73) à la hausse de la consommation, loin devant la vitesse du vent et l'humidité.
* **Profilage Géographique :** Mise en évidence de la Zone 1 comme étant le pôle le plus énergivore, suggérant une forte densité urbaine ou industrielle.

## Analyse de la Saisonnalité et Impact Météorologique (Visualisations)

![Graphiques combinés des corrélations météo et de la consommation électrique](dashboard_meteo_consommation.png)
