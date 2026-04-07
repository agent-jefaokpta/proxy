# Proxy Nginx - Infraestrutura

## 📋 Estrutura do Projeto

```
/opt/proxy/
├── docker-compose.yml      # Arquivo principal de orquestração
├── README.md               # Este arquivo
├── config/                 # Configurações dos containers
│   ├── html/               # Arquivos HTML para o site de boas-vindas
│   │   └── welcome.html
│   ├── proxy.conf         # Configuração do proxy principal
│   └── welcome-site.conf  # Configuração do site de boas-vindas
└── certs/                  # Certificado SSL (futuro)
    └── logs/               # Logs do Nginx
```

## 🚀 Inicialização

Para iniciar os containers:

```bash
cd /opt/proxy
docker compose up -d
```

Isso irá:

1.  **Container `proxy`** → Roda na porta **80** (seu domínio/IP)
2.  **Container `welcome-site`** → Roda na porta **8080** (site de boas-vindas)

## 📝 Configurações

- **Proxy Principal:** Redireciona todas as requisições (pronto para suas aplicações)
- **Site de Boas-vindas:** Acesso direto na porta 8080 para desenvolvimento
- **Firewall:** Apenas a porta 80 está exposta (conforme solicitado)

## 🔐 SSL/Futuro

Certificados SSL podem ser adicionados em `/opt/proxy/certs/` quando necessário.

## 📊 Monitoramento

Verifique os logs com:

```bash
docker compose logs -f
```

## 🛠️ Comandos Úteis

```bash
# Listar containers
docker compose ps

# Parar containers
docker compose down

# Re-iniciar
docker compose restart
```

---

*Infraestrutura DevOpsAI - Pronta para suas aplicações*
