FROM node:21.2-alpine3.18

COPY ./ /var/app
WORKDIR /var/app
RUN ["npm", "install"]

ENTRYPOINT ["./bin.js"]
