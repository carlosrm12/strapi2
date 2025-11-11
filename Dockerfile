# Etapa 1: Construcción
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN NODE_OPTIONS="--max-old-space-size=2048" npm run build


# Etapa 2: Producción
FROM node:18-alpine

WORKDIR /app

COPY --from=build /app ./

ENV NODE_ENV=production
EXPOSE 1337

CMD ["npm", "run", "start"]
