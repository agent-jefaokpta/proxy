# Certificados SSL - Let's Encrypt

## Estrutura de Arquivos

```
certs/
├── fullchain.pem      # Certificado público completo
└── privkey.pem        # Chave privada
└── README.md          # Este arquivo
```

## Configuração Inicial

Para configurar os certificados SSL pela primeira vez:

### Opção 1: Usar Certbot (Recomendado)

```bash
# Instalar Certbot (se ainda não instalado)
sudo apt install certbot python3-certbot-nginx

# Obter certificado para o domínio
sudo certbot certonly --standalone -d openclaw.jpbx.com.br --agree-tos

# Mover certificados para /opt/proxy/certs/
sudo cp /etc/letsencrypt/live/openclaw.jpbx.com.br/fullchain.pem /opt/proxy/certs/
sudo cp /etc/letsencrypt/live/openclaw.jpbx.com.br/privkey.pem /opt/proxy/certs/
```

### Opção 2: Usar o script fornecido

```bash
cd /opt/proxy
./get-letsencrypt-cert.sh
```

## Gerenciamento de Certificados

```bash
# Listar certificados
sudo certbot certificates

# Renovar certificados (interativo)
sudo certbot renew --dry-run

# Renovar via Docker
docker compose exec proxy certbot renew --webroot -w /opt/proxy/certs

# Verificar expiração
sudo certbot renew --dry-run
```

## Backup de Certificados

```bash
# Backup completo
tar -czf /backup/certs-$(date +%Y%m%d).tar.gz \
  -C /opt/proxy certs/

# Restaurar
tar -xzf /backup/certs-$(date +%Y%m%d).tar.gz \
  -C /opt/proxy certs/
```

## Segurança

*   **Permissões:** `644` para certificados, `600` para chaves privadas
*   **HTTPS:** Todo o tráfego deve usar HTTPS
*   **HSTS:** Ativa para evitar downgrade attacks
*   **Protocolos:** TLSv1.2 e TLSv1.3 apenas

## Monitoramento

```bash
# Verificar status do SSL
openssl s_client -connect openclaw.jpbx.com.br:443 -showcerts

# Verificar validade do certificado
openssl x509 -in /opt/proxy/certs/fullchain.pem -noout -dates
```

---

*Gerenciado por DevOpsAI - Infraestrutura Proxy SSL*
