FROM node:boron
MAINTAINER Froyo Yao <froyo@xenme.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/XenMe/ns-radius.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# install app dependencies
RUN wget https://raw.githubusercontent.com/XenMe/ns-radius/master/package.json
RUN npm install

# fetch radius-svr.js
RUN wget https://raw.githubusercontent.com/XenMe/ns-radius/master/radius-svr.js

EXPOSE 1812/udp

CMD [ "npm", "start"]
