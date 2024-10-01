# Etapa 1: Build da aplicação com Node.js
FROM node:18 AS build
WORKDIR /app

# Copiar arquivos de dependências e instalar dependências
COPY package*.json ./
RUN npm install

# Copiar o restante dos arquivos e rodar o build
COPY . .
RUN npm run build

# Etapa 2: Imagem de produção
FROM node:18 AS production
WORKDIR /app

# Copiar apenas os arquivos essenciais da etapa de build
COPY --from=build /app /app
EXPOSE 3000

CMD ["npm", "run", "start"]