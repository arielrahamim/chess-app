# Base Image
FROM node:18.14.2-alpine3.17 

# Set the working directory
WORKDIR /usr/src/app

COPY . /usr/src/app

# Set an environment variable
ENV SERVER_PORT 5000
ENV CLIENT_URL localhost:3000
ENV MONGO_URI mongodb://mongo1:27017/mongo
ENV DB_HOST mongo_user
ENV DB_PASS mongo_pass
ENV MONGODB_DATABASE mongo

# Set a label used to be able to add meta data to a iamge
LABEL version="1.0"
LABEL description="backend chess application"

# Expose a port
EXPOSE $SERVER_PORT


CMD ["/bin/bash", "-c", "/entrypoint.sh"]

