FROM node:16.8.0-alpine3.13

COPY ./ /var/app
WORKDIR /var/app
RUN ["npm", "install"]

ENTRYPOINT ["./bin.js"]
