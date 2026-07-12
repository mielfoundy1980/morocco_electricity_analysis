CREATE TABLE IF NOT EXISTS 1_bronze_layer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `Datetime` VARCHAR(50),
    Temperature VARCHAR(10),
    Humidity VARCHAR(10),
    WindSpeed VARCHAR(10),
    GeneralDiffuseFlows VARCHAR(10),
    DiffuseFlows VARCHAR(10),
    PowerConsumption_Zone1 VARCHAR(40),
    PowerConsumption_Zone2 VARCHAR(40),
    PowerConsumption_Zone3 VARCHAR(40),
    date_import TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ligne_originale TEXT  -- Pour conserver la ligne brute
);

-- Importer un fichier CSV dans bronze_layer
LOAD DATA LOCAL INFILE 'C:/Users/Pc/Desktop/DOSSIER PERSONNEL/ANALYSE DONNEES/SQL PROJECTS/SQL/SQL_Morocco_Power_Consumption/powerconsumption.csv'
INTO TABLE 1_bronze_layer
CHARACTER SET utf8
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(`Datetime`, Temperature, Humidity, WindSpeed, GeneralDiffuseFlows, 
 DiffuseFlows, PowerConsumption_Zone1, PowerConsumption_Zone2, PowerConsumption_Zone3);
