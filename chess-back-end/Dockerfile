# Base Image
# FROM node:18.14.2-alpine3.17 
FROM node:18.18.2-alpine3.18
# Set the working directory
WORKDIR /usr/src/app

# Copy files/directory from the host to the container
# COPY package-lock.json package-lock.json 
# COPY package.json package.json
# RUN npm install --loglevel verbose
COPY package*.json ./
COPY . /usr/src/app
RUN npm install --loglevel verbose

# Set an environment variable
ENV SERVER_PORT 5000
ENV CLIENT_URL localhost:3000
ENV MONGO_URI mongodb://mongo1:27017/mongo
ENV DB_HOST mongo_user
ENV DB_PASS mongo_pass
ENV MONGODB_DATABASE mongo

# Set a label used to be able to add meta data to a iamge
LABEL version="1.0"
LABEL description="back-end chess application"

# Expose a port
EXPOSE $SERVER_PORT


# Set the default command 

CMD [ "node", "server.js" ]

