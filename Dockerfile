# Imagen base del contenedor
FROM node:15.2.1-alpine3.10
# Definimos etiquetas informativas al contenedor
LABEL maintainer = "Ángel Valera Motos" \
    com.lyricshunter.version="0.0.2" \
    com.lyricshunter.release-date="2020-11-22" \
    org.opencontainers.image.source https://github.com/angelvalera/lyricshunter

# Definimos una carpeta para los modules de node
# Definimos otra carpeta para los test 
# Hacemos todos los ficheros y carpetas del directorio 
# /app propiedad del usuario node
# Instalamos de manera global el task runner Grunt
RUN mkdir -p /app/node_modules && \
    mkdir -p /app/test && \
    chown -R node:node /app && \
    npm install -g grunt-cli 
# Indicamos el workdir por defecto
WORKDIR /app/test
# Indicamos que utilice el usuario node sin permisos de usuario
USER node 
# Copiamos los ficheros necesarios para instalar las dependencias
# Los copiamos y hacemos propiedad del usuario node
COPY --chown=node:node ["package*.json", "Gruntfile.js",".jshintrc", "./"]
# Grunt necesita estar localmente instalado
# Ejecutamos la tarea de Grunt para instalar el resto de 
# dependencias
RUN npm ci grunt-cli && grunt install
# Ejecutamos la tarea por defecto definida en Gruntfile que
# consiste en ejecutar los test
CMD [ "grunt", "test" ]