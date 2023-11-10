#!/bin/bash
mongod &
mongosh <<EOF
use admin
db.createUser({
  user: "$MONGO_INITDB_ROOT_USERNAME",
    pwd: "$MONGO_INITDB_ROOT_PASSWORD",
      roles: [{ role: "readWrite", db: "$MONGO_INITDB_DATABASE" }]
});
use $MONGO_INITDB_DATABASE
db.startup.insertOne({ "startup": "true" })
EOF
tail -f /dev/null
