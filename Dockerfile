FROM node:14.17.0-alpine AS base
WORKDIR /app
ADD package*.json ./
RUN npm install
#COPY . ./

FROM node:14.17.0-alpine
RUN addgroup harshit && adduser -D harshit -G harshit
WORKDIR /app
COPY --from=base /app/node_modules /app/node_modules
COPY app.js .
USER harshit
CMD ["node", "app.js"]
