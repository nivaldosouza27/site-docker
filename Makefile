# HELP
help:
	@echo ""
	@echo "🛠️  Comandos disponíveis por ambiente:"
	@echo ""
	@echo "  make up-dev         ➜ Sobe tudo em dev"
	@echo "  make up-homol       ➜ Sobe tudo em homologação"
	@echo "  make up-prod        ➜ Sobe tudo em produção"
	@echo ""
	@echo "  make up-db-dev      ➜ Sobe só bancos em dev"
	@echo "  make up-api-prod    ➜ Sobe só APIs em produção"
	@echo "  make up-front-homol ➜ Sobe só frontends em homologação"
	@echo "  make up-pma-dev     ➜ Sobe só phpMyAdmin em dev"
	@echo ""
	@echo "  make down-dev       ➜ Derruba tudo em dev"
	@echo "  make restart-prod   ➜ Reinicia tudo em produção"
	@echo ""
	@echo "  make logs-dev       ➜ Logs do ambiente dev"
	@echo "  make bash-db-dev    ➜ Entra no banco dash dev"
	@echo "  make bash-api-prod  ➜ Entra na API dash produção"
	@echo ""
	@echo "  make clean-dev      ➜ Remove containers, volumes, imagens e redes do dev"
	@echo ""

# ========= FUNÇÕES BASE ========== #

define compose_up
	@echo "✅ Subindo todos os containers: $(1)"
	@docker compose -f docker-compose.$(1).yml --env-file .env.$(1) up -d --build
endef

define compose_down
	@echo "✅ Removendo todos os containers: $(1)"
	@docker compose -f docker-compose.$(1).yml --env-file .env.$(1) down
endef

define compose_logs
	@echo "📜 Logs do ambiente: $(1)"
	@docker compose -f docker-compose.$(1).yml --env-file .env.$(1) logs -f
endef

define compose_clean
	@echo "🧨 Limpando tudo no ambiente: $(1)"
	@docker compose -f docker-compose.$(1).yml --env-file .env.$(1) down -v --remove-orphans
	@docker image prune -a -f
	@docker volume prune -f
	@docker network prune -f
endef

define compose_up_group
	@echo "✅ Subindo os containers do grupo: $(2) no ambiente $(1)"
	@docker compose -f docker-compose.$(1).yml --env-file .env.$(1) up -d --build $(2)
endef


# ========= COMANDOS POR AMBIENTE ========== #

# ========= UP ========= #
up-dev:
	$(call compose_up,dev)

up-homol:
	$(call compose_up,homol)

up-prod:
	$(call compose_up,prod)


# ========= DOWN ========= #
down-dev:
	$(call compose_down,dev)

down-homol:
	$(call compose_down,homol)

down-prod:
	$(call compose_down,prod)


# ========= RESTART ========= #
restart-dev:
	$(MAKE) down-dev && $(MAKE) up-dev

restart-homol:
	$(MAKE) down-homol && $(MAKE) up-homol

restart-prod:
	$(MAKE) down-prod && $(MAKE) up-prod


# ========= POR GRUPO DE SERVIÇOS ========= #

up-db-dev:
	$(call compose_up_group,dev,db-dash db-manager db-site)

up-db-homol:
	$(call compose_up_group,homol,db-dash db-manager db-site)

up-db-prod:
	$(call compose_up_group,prod,db-dash db-manager db-site)


up-api-dev:
	$(call compose_up_group,dev,api-dash api-manager api-site)

up-api-homol:
	$(call compose_up_group,homol,api-dash api-manager api-site)

up-api-prod:
	$(call compose_up_group,prod,api-dash api-manager api-site)


up-front-dev:
	$(call compose_up_group,dev,front-dash front-site)

up-front-homol:
	$(call compose_up_group,homol,front-dash front-site)

up-front-prod:
	$(call compose_up_group,prod,front-dash front-site)


up-pma-dev:
	$(call compose_up_group,dev,phpmyadmin)

up-pma-homol:
	$(call compose_up_group,homol,phpmyadmin)

up-pma-prod:
	$(call compose_up_group,prod,phpmyadmin)

# ========= LOGS & BASH ========= #

logs-dev:
	$(call compose_logs,dev)

logs-homol:
	$(call compose_logs,homol)

logs-prod:
	$(call compose_logs,prod)

bash-db-dev:
	docker exec -it db-main-dev bash

bash-db-homol:
	docker exec -it db-main-homol bash

bash-db-prod:
	docker exec -it db-main-prod bash

# ========= CLEAN (TOTAL WIPE) ========= #

clean-dev:
	$(call compose_clean,dev)

clean-homol:
	$(call compose_clean,homol)

clean-prod:
	$(call compose_clean,prod)
