FROM node:15.2.1-alpine3.10

LABEL maintainer = "Ángel Valera Motos" 
LABEL com.lyricshunter.version="0.0.1" 
LABEL com.lyricshunter.release-date="2020-11-22" 
    
RUN mkdir -p /home/node/app/node_modules && \
    mkdir -p /home/node/app/test && \
    chown -R node:node /home/node/app && \
    npm install -g grunt-cli 

WORKDIR /home/node/app

USER node 

COPY --chown=node:node package*.json ./ 
COPY --chown=node:node Gruntfile.js ./ 
COPY --chown=node:node .jshintrc ./

RUN npm ci grunt-cli && grunt install

CMD [ "grunt" ]