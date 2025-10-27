# Usa imagem base do n8n com Debian moderno
https://hub.docker.com/r/n8nio/n8n/tags
USER root

# Instala Python e dependências necessárias
RUN apt-get update && apt-get install -y \
    python3 python3-pip curl wget unzip chromium-driver \
    && pip3 install selenium beautifulsoup4 requests pandas

# Retorna ao usuário padrão do n8n
USER node

# Expõe a porta padrão
EXPOSE 5678

# Comando padrão
CMD ["n8n", "start"]
