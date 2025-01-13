# Etapa 1: Construcción de la aplicación
FROM node:18 AS build

WORKDIR /app
COPY package*.json ./
RUN npm ci

# Copiar el código fuente
COPY . .

# Compilar TypeScript a JavaScript
RUN npm run build

# Etapa 2: Imagen final de producción
FROM node:18-alpine

WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/package*.json ./

# Instalar solo dependencias de producción
RUN npm ci --only=production

# Exponer el puerto (ajustar si es necesario)
EXPOSE 3000

# Comando de inicio de la aplicación
CMD ["node", "dist/index.js"]