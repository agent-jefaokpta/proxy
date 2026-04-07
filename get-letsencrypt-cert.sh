#!/bin/bash
# Script para obter certificados SSL via Let's Encrypt (Certbot)
# Uso: ./get-letsencrypt-cert.sh --force-renewal [opcional]

set -e

DOMAIN="openclaw.jpbx.com.br"
CERT_PATH="/opt/proxy/certs"
PROJECT_PATH="/opt/proxy"

# Verificar se o Certbot está instalado
if ! command -v certbot &> /dev/null; then
    echo "❌ Certbot não está instalado."
    echo "   Instale com: sudo apt install certbot python3-certbot-nginx"
    exit 1
fi

# Verificar se o domínio está resolvendo
if ! getent hosts "$DOMAIN" > /dev/null; then
    echo "❌ O domínio $DOMAIN não está resolvendo."
    exit 1
fi

echo "🌐 Domínio: $DOMAIN"
echo "📁 Caminho dos certificados: $CERT_PATH"

# Gerar key e certificados manualmente (sem interatividade do Certbot)
mkdir -p "$CERT_PATH/live"

echo "📝 Gerando certificados SSL (Let's Encrypt)..."

# Obter certificado via Certbot
if ! certbot certonly --standalone -d "$DOMAIN" --non-interactive --agree-tos --email "admin@openclaw.jpbx.com.br" --cert-name "$DOMAIN"; then
    echo "❌ Falha ao obter certificado."
    exit 1
fi

# Mover os certificados para o caminho correto
echo "🔄 Movendo certificados para /opt/proxy/certs/..."
mv /etc/letsencrypt/live/openclaw.jpbx.com.br/fullchain.pem "$CERT_PATH/"
mv /etc/letsencrypt/live/openclaw.jpbx.com.br/privkey.pem "$CERT_PATH/"

# Garantir permissões corretas
chmod 644 "$CERT_PATH/fullchain.pem"
chmod 600 "$CERT_PATH/privkey.pem"

echo "✅ Certificados SSL configurados com sucesso!"
echo ""
echo "📝 Localização dos certificados:"
echo "   fullchain.pem: $CERT_PATH/fullchain.pem"
echo "   privkey.pem:   $CERT_PATH/privkey.pem"
echo ""
echo "📝 Para renovar os certificados:"
echo "   certbot renew --webroot -w /opt/proxy/certs"
echo ""
