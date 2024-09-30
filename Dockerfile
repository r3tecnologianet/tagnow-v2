# Etapa 1: Build da aplicação com Node.js
FROM node:18 AS build

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar os arquivos de dependências para o container
COPY package*.json ./

# Instalar as dependências
RUN npm install

# Copiar o restante dos arquivos da aplicação
COPY . .

# Rodar o build da aplicação (ajuste o comando conforme necessário)
RUN npm run build

# Etapa 2: Servir a aplicação com Nginx
FROM nginx:alpine

# Copiar os arquivos estáticos gerados na etapa de build para o diretório padrão do Nginx
COPY --from=build /app/out /usr/share/nginx/html

# Expor a porta 80 para o Nginx
EXPOSE 80

# Comando padrão para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]