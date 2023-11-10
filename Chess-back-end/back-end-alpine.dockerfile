# Base Image
FROM node:18.14.2-alpine3.17 

# Set the working directory
WORKDIR /usr/src/app

# Copy files/directory from the host to the container
COPY . /usr/src/app
COPY entrypoint.sh /entrypoint.sh
COPY aws /root/.aws

# Run a command during build time
RUN apk update && apk add --no-cache \
    bash \
    curl \
    jq \
    nodejs \
    npm 
RUN chmod +x /entrypoint.sh
RUN apk add aws-cli
RUN bash

# Set an environment variable

ENV SERVER_PORT 5000
ENV CLIENT_URL localhost:3000
ENV MONGO_URI mongodb://192.168.1.231:27017/
ENV AWS_REGION eu-central-1


# Set a label used to be able to add meta data to a iamge
LABEL version="1.0"
LABEL description="back-end chess application"

# Expose a port
EXPOSE $SERVER_PORT


# Set the default command 
CMD ["/bin/bash", "-c", "/entrypoint.sh"]




