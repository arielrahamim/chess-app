# Base Image
#FROM node:18.14.2-alpine3.17
FROM node:18.18.2-alpine3.18

# Set the working directory
WORKDIR /usr/src/app

# Copy files/directory from the host to the container
COPY package*.json ./

RUN npm install --loglevel verbose                
RUN npm install -g serve --loglevel verbose 

COPY . /usr/src/app

# Set an environment variable
### old env variable, probably not needed?
ENV REACT_APP_HOST localhost
ENV SKIP_PREFLIGHT_CHECK true

# Set a label used to be able to add meta data to a iamge
LABEL version="1.0.0"
LABEL description="front-end chess application"

# Expose a port
EXPOSE 80


# Set the default command 
### CMD ["/bin/bash", "-c", "/entrypoint.sh"]




