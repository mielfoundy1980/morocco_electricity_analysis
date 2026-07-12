"""
Analyse de corrélation entre la météo et la consommation électrique.
"""
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px

# 1. Chargement des données exportées depuis la vue Gold
path = '/kaggle/input/datasets/mohamedissamelfoundy/ffdtdd/fichier_sources.csv'

df = pd.read_csv(
    path,
    sep=';',
    quotechar='"',
    encoding='utf-8',
    decimal=',',
    engine='python'
)

# 2. Nettoyage et conversion
df.columns = df.columns.str.replace('"', '').str.strip()
df['jour_'] = pd.to_datetime(df['jour_'])

# 3. Matrice de corrélation
corr_matrix = df.corr()

# 4. Visualisation (Heatmap)
plt.figure(figsize=(10, 8))
sns.heatmap(
    corr_matrix, 
    annot=True,           
    fmt=".2f",            
    cmap="coolwarm",      
    vmin=-1, vmax=1,      
    linewidths=0.5,       
    square=True           
)
plt.title("Matrice de Corrélation : Météo vs Consommation Électrique", fontsize=14, pad=20)
plt.show()

