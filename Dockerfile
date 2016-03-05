FROM node:slim

git clone https://github.com/ryba-io/ryba-www.git /www
WORKDIR /www
CMD [ "node", "bin/deploy" ]
