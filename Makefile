# Variables pour simplifier la maintenance
PROJECT_NAME=mlops-nginx-exam-2
NGINX_CERT=./deployments/nginx/certs/nginx.crt
URL_PREDICT=https://localhost/predict

.PHONY: run-project stop-project test-api test-ab-debug test-metrics

# --- GESTION DU PROJET ---

run-project:
	@echo "Démarrage du projet $(PROJECT_NAME)..."
	docker compose -p $(PROJECT_NAME) up --build -d
	@echo "Services démarrés."
	@echo "Grafana UI  : http://localhost:3000 (admin / admin)"
	@echo "Prometheus  : http://localhost:9090"
	@echo "API Predict : $(URL_PREDICT)"

stop-project:
	@echo "Arrêt du projet..."
	docker compose -p $(PROJECT_NAME) down
	@echo "Projet arrêté."

# --- TESTS DE L'API (Objectifs Examen) ---

test-api:
	@echo "Test de l'API V1 (Authentifié)..."
	curl -X POST "$(URL_PREDICT)" \
		-H "Content-Type: application/json" \
		-d '{"sentence": "Oh yeah, that was soooo cool!"}' \
		--user admin:admin \
		--cacert $(NGINX_CERT)

test-ab-debug:
	@echo "Test de l'A/B Testing (Routage vers V2)..."
	curl -X POST "$(URL_PREDICT)" \
		-H "Content-Type: application/json" \
		-H "X-Experiment-Group: debug" \
		-d '{"sentence": "Checking the debug version."}' \
		--user admin:admin \
		--cacert $(NGINX_CERT)

test-metrics:
	@echo "Vérification des métriques Nginx..."
	curl -k --user admin:admin https://localhost/metrics