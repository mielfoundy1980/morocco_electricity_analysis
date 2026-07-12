/*
=============================================================================
COUCHE GOLD : DATAMARTS MÉTIERS (VUES)
Objectif : Exposer les indicateurs clés et les agrégations pour l'analyse.
=============================================================================
*/

-- 1. Datamart : Profil Horaire
CREATE OR REPLACE VIEW 3_gold_layer_hourly_profile AS
SELECT
	HOUR(Datetime_) AS heure_,
	ROUND(AVG(PowerCons_Zone1_), 2) AS Avg_PC_Z1_KWH,
	ROUND(AVG(PowerCons_Zone2_), 2) AS Avg_PC_Z2_KWH,
	ROUND(AVG(PowerCons_Zone3_), 2) AS Avg_PC_Z3_KWH
FROM 2_silver_layer
WHERE Datetime_ IS NOT NULL
GROUP BY HOUR(Datetime_)
ORDER BY 1 ASC;

-- 2. Datamart : Saisonnalité Hebdomadaire
CREATE OR REPLACE VIEW 3_1_gold_layer_weekly_seasonality AS
SELECT
	DAYOFWEEK(Datetime_) AS jour_semaine,
	DAYNAME(Datetime_) AS jour_semaine_nom,
	ROUND(AVG(PowerCons_Zone1_), 2) AS Avg_PC_Z1_KWH,
	ROUND(AVG(PowerCons_Zone2_), 2) AS Avg_PC_Z2_KWH,
	ROUND(AVG(PowerCons_Zone3_), 2) AS Avg_PC_Z3_KWH
FROM 2_silver_layer
WHERE Datetime_ IS NOT NULL
GROUP BY DAYOFWEEK(Datetime_), DAYNAME(Datetime_)
ORDER BY 1 ASC;

-- 3. Datamart : Saisonnalité Annuelle (Mensuelle)
CREATE OR REPLACE VIEW 3_2_gold_layer_monthly_seasonality AS
SELECT
	MONTH(Datetime_) AS mois_annee,
	MONTHNAME(Datetime_) AS mois_annee_nom,
	ROUND(AVG(PowerCons_Zone1_), 2) AS Avg_PC_Z1_KWH,
	ROUND(AVG(PowerCons_Zone2_), 2) AS Avg_PC_Z2_KWH,
	ROUND(AVG(PowerCons_Zone3_), 2) AS Avg_PC_Z3_KWH
FROM 2_silver_layer
WHERE Datetime_ IS NOT NULL
GROUP BY MONTH(Datetime_), MONTHNAME(Datetime_)
ORDER BY 1 ASC;

-- 4. Datamart : Données de Corrélation Météo
CREATE OR REPLACE VIEW 3_3_gold_layer_weather_correlation AS
SELECT
	DATE(Datetime_) AS jour_,
	ROUND(AVG(Temperature_), 2) AS Avg_Temperature,
	ROUND(AVG(Humidity_), 2) AS Avg_Humidity,
	ROUND(AVG(WindSpeed_), 2) AS Avg_WindSpeed,
	ROUND(AVG(PowerCons_Zone1_ + PowerCons_Zone2_ + PowerCons_Zone3_), 2) AS Avg_PC_KWH
FROM 2_silver_layer
WHERE Datetime_ IS NOT NULL
GROUP BY DATE(Datetime_)
ORDER BY 1 ASC;
