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
ENV CLIENT_URL localhost:3000
ENV MONGO_URI mongodb://mongo_user:mongo_pass@localhost:27017/mongo
ENV DB_HOST mongo_user
ENV DB_PASS mongo_pass
ENV MONGODB_DATABASE mongo

# Set a label used to be able to add meta data to a iamge
LABEL version="1.0"
LABEL description="backend chess application"

# Expose a port
EXPOSE $SERVER_PORT

# Start The Backend App
CMD ["node", "server.js"]

