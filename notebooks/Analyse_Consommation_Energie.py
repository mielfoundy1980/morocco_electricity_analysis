"""
Analyse de corrélation de la météo et la consommation électrique.
"""
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Configuration du style visuel (pour un rendu professionnel)
sns.set_theme(style="whitegrid")

# 1. Chargement des données exportées depuis la vue Gold
daily_weather_metrics = '/kaggle/input/datasets/mohamedissamelfoundy/ffdtdd/fichier_sources.csv'
hourly_weather_metrics = '/kaggle/input/datasets/mohamedissamelfoundy/ftdddt/fichier_sources_bis.csv'

df_daily = pd.read_csv(
    daily_weather_metrics,
    sep=';',
    quotechar='"',
    encoding='utf-8',
    decimal=',',
    engine='python'
)

df_hourly = pd.read_csv(
    hourly_weather_metrics,
    sep=';',
    quotechar='"',
    encoding='utf-8',
    decimal=',',
    engine='python'
)

# 2. Nettoyage et conversion
df_daily.columns = df_daily.columns.str.replace('"', '').str.strip()
df_daily['jour_'] = pd.to_datetime(df_daily['jour_'])

# 3. Matrice de corrélation (en excluant la colonne date pour éviter les erreurs Pandas)
corr_matrix = df_daily.corr(numeric_only=True)

# ==========================================
# 4. CRÉATION DE LA FIGURE COMBINÉE
# ==========================================

# Création d'une figure de grande taille contenant 1 ligne et 2 colonnes (axes)
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(20, 8))

# --- GRAPHIQUE 1 (Gauche : axes[0]) : Heatmap de Corrélation ---
sns.heatmap(
    corr_matrix, 
    annot=True,           
    fmt=".2f",            
    cmap="coolwarm",      
    vmin=-1, vmax=1,      
    linewidths=0.5,       
    square=True,
    ax=axes[0]  # On cible explicitement le panneau de gauche
)
axes[0].set_title("Matrice de Corrélation : Météo vs Consommation", fontsize=14, pad=15)

# --- GRAPHIQUE 2 (Droite : axes[1]) : Courbe de Consommation ---
axes[1].plot(df_hourly['heure_'], df_hourly['Avg_PC_Z1_KWH'], marker='o', linewidth=2, label='Zone 1', color='#1f77b4')
axes[1].plot(df_hourly['heure_'], df_hourly['Avg_PC_Z2_KWH'], marker='s', linewidth=2, label='Zone 2', color='#ff7f0e')
axes[1].plot(df_hourly['heure_'], df_hourly['Avg_PC_Z3_KWH'], marker='^', linewidth=2, label='Zone 3', color='#2ca02c')

# Personnalisation du graphique de droite (on utilise set_title, set_xlabel au lieu de plt.title)
axes[1].set_title("Profil de Consommation Électrique : Journée Type", fontsize=14, pad=15)
axes[1].set_xlabel("Heure de la journée (0 - 23h)", fontsize=12)
axes[1].set_ylabel("Consommation Moyenne (KWh)", fontsize=12)
axes[1].set_xticks(range(0, 24))
axes[1].legend(title="Zones de consommation", fontsize=11)

# ==========================================
# 5. AFFICHAGE FINAL
# ==========================================
# tight_layout() ajuste automatiquement les marges pour que les titres ne se chevauchent pas
plt.tight_layout()
plt.show()
