# mpruna
# add a now commit
FROM node:16
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD [ "node", "index.js" ]
