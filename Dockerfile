FROM node:boron

MAINTAINER Froyo Yao <froyo@xenme.com>

ENV PORT 1812

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# install app dependencies
wget https://raw.githubusercontent.com/XenMe/ns-radius/master/package.json
RUN npm install

# fetch radius-svr.js
RUN wget https://raw.githubusercontent.com/XenMe/ns-radius/master/radius-svr.js

EXPOSE $PORT
CMD [ "npm", "start"]
