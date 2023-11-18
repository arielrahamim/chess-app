# Base Image
FROM node:18.14.2-alpine3.17

# Set the working directory
WORKDIR /usr/src/app

# Copy files/directory from the host to the container 
COPY . /usr/src/app
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
RUN apk update 
RUN apk add bash

# installing package dependecies 
RUN npm install 
RUN npm install -g serve

# ENV VARI
# ENV REACT_APP_HOST localhost:5000/api
ENV SKIP_PREFLIGHT_CHECK true

# Expose a port
EXPOSE 80

# Set the default command 
CMD ["/bin/bash", "-c", "/entrypoint.sh"]



