# Proxy Nginx - Infraestrutura

## 📋 Estrutura do Projeto

```
/opt/proxy/
├── .git/                      # Histórico do Git
├── .gitignore                 # Regras de ignorção para Git
├── docker-compose.yml         # Arquivo principal de orquestração
├── README.md                  # Este arquivo
├── config/                    # Configurações dos containers
│   ├── html/                  # Arquivos HTML para o site de boas-vindas
│   │   ├── index.html
│   │   └── welcome.html
│   ├── proxy.conf            # Configuração do proxy principal (HTTPS)
│   └── welcome-site.conf     # Configuração do site de boas-vindas
├── certs/                     # Certificados SSL (Let's Encrypt)
│   ├── fullchain.pem
│   └── privkey.pem
└── logs/                      # Logs do Nginx
```

## 🚀 Inicialização

Para iniciar os containers:

```bash
cd /opt/proxy
docker compose up -d
```

Isso irá:

1.  **Container `proxy`** → Roda na porta **443** (HTTPS)
2.  **Container `welcome-site`** → Roda na porta **8080** (site de boas-vindas)

## 📝 Configurações

- **Proxy Principal:** HTTPS com certificado Let's Encrypt
- **Site de Boas-vindas:** Acesso direto na porta 8080 para desenvolvimento
- **Firewall:** Portas 80 (HTTP→redirect) e 443 (HTTPS) expostas

## 🌐 Acesso Remoto

**Endereço oficial do servidor:**
*   **HTTPS:** `https://openclaw.jpbx.com.br`
*   **HTTP (apenas para desenvolvimento):** `http://openclaw.jpbx.com.br`
*   **DNS:** `openclaw.jpbx.com.br`

## 🔐 SSL/HTTPS

Certificados SSL são gerenciados automaticamente via **Certbot/Let's Encrypt**:

*   **Certificados:** Armazenados em `/opt/proxy/certs/`
*   **Renovação automática:** Configurada via `cron`
*   **Forçar HTTPS:** Todo o tráfego HTTP é redirecionado para HTTPS

### Certificados Let's Encrypt

```bash
# Certificados atuais
ls -la /opt/proxy/certs/

# Certificado completo (certificado + chave)
cat /opt/proxy/certs/fullchain.pem

# Chave privada
cat /opt/proxy/certs/privkey.pem
```

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

# Renovar certificados SSL (via Certbot)
docker compose exec proxy certbot renew --webroot -w /opt/proxy/certs

# Gerenciar certificados
certbot certificates
```

## 🔄 Git

Este repositório é gerenciado via Git para versionamento de configuração.

**Status atual:**
*   ✅ Configuração inicial versionada
*   ✅ Repositório remoto configurado e sincronizado
*   ✅ HTTPS com certificado Let's Encrypt
*   ✅ DNS configurado: `openclaw.jpbx.com.br`

## 🔄 Deploy

Para deploy completo:

```bash
# Parar containers atuais
docker compose down

# Limpar volumes (se necessário)
docker compose down -v

# Reiniciar com nova configuração
docker compose up -d --build

# Renovar certificados
docker compose exec proxy certbot renew --webroot -w /opt/proxy/certs
```

## 🔧 Configuração de Proxy

O proxy está configurado para:

*   **HTTPS:** Portas 443
*   **Redirecionamento:** HTTP → HTTPS (porta 80)
*   **Certificado:** Let's Encrypt (automático)
*   **Segurança:** HSTS, HTTP Strict Transport Security

---

*Infraestrutura DevOpsAI - Pronta para suas aplicações com HTTPS seguro*
