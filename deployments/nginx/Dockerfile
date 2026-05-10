# Utilisation de l'image officielle Nginx
FROM nginx:latest

# Suppression de la configuration par défaut pour éviter les conflits
RUN rm /etc/nginx/conf.d/default.conf

# Installation des outils SSL (Objectif 3) et htpasswd (Objectif 4)
RUN apt-get update && apt-get install -y openssl apache2-utils && rm -rf /var/lib/apt/lists/*

# Création du répertoire pour les certificats SSL
RUN mkdir -p /etc/nginx/certs

# Génération du certificat auto-signé pour le HTTPS (Objectif 3)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/nginx.key \
    -out /etc/nginx/certs/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=MLOps/CN=localhost"

# Création des accès admin/admin pour l'authentification basique (Objectif 4)
RUN htpasswd -bc /etc/nginx/.htpasswd admin admin

# Copie du fichier de configuration que nous avons rédigé ensemble
COPY nginx.conf /etc/nginx/nginx.conf

# Exposition des ports 80 (HTTP) et 443 (HTTPS)
EXPOSE 80 443

# INSTRUCTION DE LANCEMENT (Explicite) :
# "nginx" : lance le binaire
# "-g 'daemon off;'" : force Nginx à rester au premier plan pour que le conteneur ne s'arrête pas
CMD ["nginx", "-g", "daemon off;"]