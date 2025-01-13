# Utilizar la imagen oficial de Node.js
FROM node:18

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY package*.json ./

# Instalar todas las dependencias (incluyendo devDependencies)
RUN npm ci

# Copiar el resto del código fuente al contenedor
COPY . .

# Compilar TypeScript a JavaScript
RUN npm run build

# Exponer el puerto en el que se ejecutará la aplicación (si aplica)
EXPOSE 3000

# Comando por defecto al iniciar el contenedor
CMD ["node", "dist/index.js"]