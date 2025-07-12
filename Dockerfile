#Getting base image to build npm realted packages
FROM node:18 AS builder

#making a working dir for container putting code and files
WORKDIR /app

#copy code from sorce (host) to dest (container)>> copy that which which is required to install libraries
COPY package*.json ./

#Install packages
RUN npm install

#copy code
COPY . .

#base image to run app only: distorless image
FROM node:18-alpine

#working dir for container
WORKDIR /app

#copy code from 1st stage

COPY --from=builder /app . 
# if i didn't copy data from /app and directly did . . then again current folders complete data will be stored here.

#Expose ports
EXPOSE 5173

#Now to run application >>> by this command once a container runs, then we give arguments to a running container
CMD ["npm", "run", "dev"]
