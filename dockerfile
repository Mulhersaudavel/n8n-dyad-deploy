FROM debian:bookworm-slim AS builder
RUN apt-get update && apt-get install -y python3 python3-pip git curl chromium-driver && rm -rf /var/lib/apt/lists/*
# copie os binários/arquivos necessários para /tmp/artifacts
RUN mkdir -p /artifacts && cp /usr/bin/chromedriver /artifacts/ && cp -r /usr/lib/python3 /artifacts/

FROM docker.n8n.io/n8nio/n8n:latest
USER root
COPY --from=builder /artifacts/chromedriver /usr/bin/chromedriver
COPY --from=builder /artifacts/python3 /usr/local/python3
ENV PATH="/usr/local/python3/bin:${PATH}"
# continue com sua configuração do n8n



USER root
RUN apt-get update && apt-get install -y \
    python3 python3-pip git curl chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Instala pacotes úteis para automação e raspagem
RUN pip3 install \
    selenium \
    beautifulsoup4 \
    requests \
    pandas \
    google-api-python-client \
    openai \
    playwright

# Instala Dyad globalmente
RUN npm install -g dyad

# Instala cliente (placeholder) da Evolution API se houver npm package
# (substitua por pacote correto ou deixe para instalar via workflow se necessário)
# RUN npm install -g @evolutionapi/evolution-api

# Variáveis de ambiente do n8n (não coloque segredos aqui em produção)
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=ChangeMe123
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Variáveis placeholders para Evolution / Dyad
ENV EVOLUTION_API_KEY=changeme
ENV EVOLUTION_API_URL=https://your-evolution-instance

EXPOSE 5678

# Inicializa Dyad (se necessário) e n8n
CMD dyad start & n8n start

