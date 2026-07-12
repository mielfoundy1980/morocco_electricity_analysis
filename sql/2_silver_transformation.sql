/*
=============================================================================
COUCHE SILVER : NETTOYAGE ET TYPAGE DES DONNÉES
Objectif : Gérer les valeurs nulles, typer les décimales et les dates.
=============================================================================
*/

DROP TABLE IF EXISTS 2_Silver_layer;

CREATE TABLE IF NOT EXISTS 2_Silver_layer (
    id INT,
    Datetime_ DATETIME,
    Temperature_ DECIMAL(10, 3),
    Humidity_ DECIMAL(10, 3),
    WindSpeed_ DECIMAL(10, 3),
    GenDiffFlows_ DECIMAL(10, 3),
    DiffFlows_ DECIMAL(10, 3),
    PowerCons_Zone1_ DECIMAL(20, 6),
    PowerCons_Zone2_ DECIMAL(20, 6),
    PowerCons_Zone3_ DECIMAL(20, 6),
    date_import TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO 2_Silver_layer (
    id, Datetime_, Temperature_, 
    Humidity_, WindSpeed_, 
    GenDiffFlows_, DiffFlows_,
    PowerCons_Zone1_, PowerCons_Zone2_, PowerCons_Zone3_
)
SELECT
    id,
    STR_TO_DATE(`Datetime`, '%Y-%m-%d %H:%i:%s') AS Datetime_,
    CAST(NULLIF(TRIM(Temperature), '') AS DECIMAL(10, 3)) AS Temperature_,
    CAST(NULLIF(TRIM(Humidity), '') AS DECIMAL(10, 3)) AS Humidity_,
    CAST(NULLIF(TRIM(WindSpeed), '') AS DECIMAL(10, 3)) AS WindSpeed_,
    CAST(NULLIF(TRIM(GeneralDiffuseFlows), '') AS DECIMAL(10, 3)) AS GenDiffFlows_,
    CAST(NULLIF(TRIM(DiffuseFlows), '') AS DECIMAL(10, 3)) AS DiffFlows_,
    CAST(NULLIF(TRIM(PowerConsumption_Zone1), '') AS DECIMAL(20, 6)) AS PowerCons_Zone1_,
    CAST(NULLIF(TRIM(PowerConsumption_Zone2), '') AS DECIMAL(20, 6)) AS PowerCons_Zone2_,
    CAST(NULLIF(TRIM(PowerConsumption_Zone3), '') AS DECIMAL(20, 6)) AS PowerCons_Zone3_
FROM 1_bronze_layer;
