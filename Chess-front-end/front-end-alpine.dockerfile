# Base Image
FROM node:18.14.2-alpine3.17 

# Set the working directory
WORKDIR /usr/src/app

# Copy files/directory from the host to the container
COPY . /usr/src/app
COPY entrypoint.sh /entrypoint.sh


# Run a command during build time
RUN chmod +x /entrypoint.sh
RUN apk update 
RUN apk add bash
RUN apk add curl
RUN npm install 
RUN npm install -g serve

# Set an environment variable
ENV REACT_APP_HOST localhost
ENV SKIP_PREFLIGHT_CHECK true



# Set a label used to be able to add meta data to a iamge
LABEL version="1.0"
LABEL description="front-end chess application"

# Expose a port
EXPOSE 80


# Set the default command 
CMD ["/bin/bash", "-c", "/entrypoint.sh"]




