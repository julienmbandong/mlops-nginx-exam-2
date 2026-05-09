FROM python:3.12-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Installation des dépendances système si nécessaire (souvent utile pour sklearn/pandas)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copier le fichier requirements (remonte de deux crans par rapport au contexte de build)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le script de l'API et le modèle ML
# Note : Lors du build, nous nous assurerons que le fichier model.joblib est accessible
COPY main.py .
COPY model.joblib .

# Exposer le port interne
EXPOSE 8000

# Lancer l'application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]