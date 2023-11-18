# Base Image
FROM node:18.14.2-alpine3.17 

# Set the working directory
WORKDIR /usr/src/app

# Copy Source Code & Install Modules
RUN apk update && apk add bash
COPY . /usr/src/app
RUN npm ci

# Set an environment variable
ENV SERVER_PORT 5000
ENV MONGO_URI mongodb://mongo_user:mongo_pass@172.18.0.2:27017

# Set a label used to be able to add meta data to a iamge
LABEL version="1.0"
LABEL description="backend chess application"

# Expose a port
EXPOSE $SERVER_PORT

# Start The Backend App
CMD ["node", "server.js"]

