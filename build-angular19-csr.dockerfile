# =============================
# Etapa 1: Build do Angular
# =============================

# Usa imagem Node.js leve para o build
FROM node:22-alpine AS build

# Configura o timezone (opcional)
ENV TZ=America/Sao_Paulo

# Define a pasta de trabalho para o build do Angular
WORKDIR /opt/app

# Copia TODO o projeto para dentro do container de build
COPY . .

# Instala as dependências e executa o build de produção
# 'npm ci' garante build limpo; 'npm run build' gera o dist padrão Angular (dist/<nome-do-projeto>)
RUN npm ci && npm run build

# =============================
# Etapa 2: Servindo estáticos com NGINX
# =============================

# Usa imagem leve do NGINX para servir arquivos estáticos
FROM nginx:1.27-alpine

# Remove configuração default do NGINX para evitar conflitos (opcional se for usar nginx.conf próprio)
RUN rm /etc/nginx/conf.d/default.conf

# Copia apenas o build final do Angular (dist/<nome-do-projeto>) para o root padrão do NGINX
# ATENÇÃO: ajuste 'meu-projeto' conforme o nome real do seu projeto Angular!
COPY --from=build /opt/app/dist/meu-projeto /usr/share/nginx/html

# Copia o nginx.conf customizado para sobrescrever a configuração padrão
COPY nginx.conf /etc/nginx/nginx.conf

# Expõe a porta 80 padrão para acesso HTTP
EXPOSE 80

# Comando padrão do NGINX (mantém o serviço rodando em foreground)
CMD ["nginx", "-g", "daemon off;"]
