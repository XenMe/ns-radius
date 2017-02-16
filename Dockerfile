FROM node:boron
MAINTAINER Froyo Yao <froyo@xenme.com>

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="ns-radius version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV PORT 1812

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# install app dependencies
RUN wget https://raw.githubusercontent.com/XenMe/ns-radius/master/package.json
RUN npm install

# fetch radius-svr.js
RUN wget https://raw.githubusercontent.com/XenMe/ns-radius/master/radius-svr.js

EXPOSE $PORT
CMD [ "npm", "start"]
