FROM node:4-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN npm install -g nodemon
COPY package.json /usr/src/app/
RUN npm install
COPY . /usr/src/app

CMD [ "npm", "start" ]
