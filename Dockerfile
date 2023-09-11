FROM node:14.17.0-alpine AS base
WORKDIR /app
ADD package*.json ./
RUN npm install
#COPY . ./

FROM node:14.17.0-alpine
RUN addgroup aayush && adduser -D aayush -G aayush
WORKDIR /app
COPY --from=base /app/node_modules /app/node_modules
COPY app.js .
USER aayush
CMD ["node", "app.js"]

# --->>> Prod practice -> In 1st stage fire npm install , this will install all the dependencies defined in your 
# package.json and package-lock.json files . In the 2nd satge fire npm run build, it creates a build directory 
# with a production build of your app anCd within the same stage fire RUN npm remove whichh will remove all the
# node modules bcoz they are not required for the production code. So you can afforf to remove them.
# And finally in the last stage you can pass CMD . But remember you never use CMD in the PROD environment.
# Jab dependencies me express hoga to build remove nahi karoge Okay.
# And yes this concept is generic for Java and also Python.

# You can use this nodejs project --> git clone https://github.com/salma71/frontend.git

# prod ready dockerfile for nodejs

#FROM node:14 AS dependencies

#WORKDIR /app

#COPY package*.json /app/
#RUN npm install --production

#FROM dependencies AS build

#WORKDIR /app

#COPY . /app
#RUN npm install && npm run build && rm -rf node_modules

#FROM node:14-slim AS production

#RUN addgroup harshit && adduser -D harshit -G harshit


#WORKDIR /app

#COPY --from=build /app/package*.json /app/build/ .
#USER harshit

#CMD ["npm", "start"]
