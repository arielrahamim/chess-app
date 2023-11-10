FROM mongo

COPY mongo-init.sh /docker-entrypoint-initdb.d/mongo-init.sh
ENV MONGO_INITDB_ROOT_USERNAME mongo    
ENV MONGO_INITDB_ROOT_PASSWORD mongo
ENV MONGO_INITDB_DATABASE mongo
EXPOSE 27017

CMD ["/bin/bash", "-c", "/docker-entrypoint-initdb.d/mongo-init.sh"]