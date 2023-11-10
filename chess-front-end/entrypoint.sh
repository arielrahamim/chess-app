#!/bin/bash

export REACT_APP_POD=$HOSTNAME
export REACT_APP_HOST="$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-ipv4):30050"

npm run build && serve -s build