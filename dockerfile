# Usa a imagem oficial mais recente do n8n (base Debian moderna)
FROM n8nio/n8n:latest

# Troca para o usuário root para instalar dependências do sistema
USER root

# Atualiza pacotes e instala dependências úteis (Python + libs para automação web)
RUN apt-get update && apt-get install -y \
    python3 python3-pip curl wget unzip chromium-driver \
    && pip3 install --no-cache-dir selenium beautifulsoup4 requests pandas \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Retorna para o usuário padrão do n8n
USER node

# Define a porta padrão do n8n
EXPOSE 5678

# Comando padrão para iniciar o n8n
CMD ["n8n", "start"]
