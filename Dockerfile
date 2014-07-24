FROM node
MAINTAINER Caner Candan <caner@candan.fr>

ADD . /usr/src/app
WORKDIR /usr/src/app

RUN npm install -g roots

EXPOSE 1111

CMD [ "roots", "watch" ]
