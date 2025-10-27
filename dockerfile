# Base: imagem oficial do n8n
FROM n8nio/n8n:latest

# Instala dependências extras
USER root
RUN apt-get update && apt-get install -y \
    python3 python3-pip curl wget unzip chromium-driver \
    && pip3 install selenium beautifulsoup4 requests pandas

# Variáveis de ambiente padrão
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=admin
ENV GENERIC_TIMEZONE=America/Sao_Paulo
ENV EXECUTIONS_PROCESS=main
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE=/home/node/.n8n/database.sqlite
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false

# Diretório de trabalho
WORKDIR /data

# Porta do n8n
EXPOSE 5678

# Comando para iniciar
CMD ["n8n", "start"]
