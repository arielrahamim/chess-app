# Base Image
FROM node:18.18.2-alpine3.18

# Set the working directory
WORKDIR /usr/src/app

# Copy files/directory from the host to the container 
COPY . /usr/src/app
RUN chmod +x /usr/src/app/entrypoint.sh
RUN apk update 
RUN apk add bash

# installing package dependecies 
RUN npm install 
RUN npm install -g serve

# ENV VARI
ENV REACT_APP_HOST 172.18.0.3:5000

# Expose a port
EXPOSE 80

# Set the default command 
CMD ["/bin/bash", "-c", "/usr/src/app/entrypoint.sh"]



