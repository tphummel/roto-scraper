FROM node:alpine

COPY ./ /var/app
WORKDIR /var/app
RUN ["npm", "install"]

ENTRYPOINT ["node", "./bin.js"]
