#!/bin/bash
echo "region = ${AWS_REGION}">>/root/.aws/config
#echo "output = json">>/root/.aws/config
#echo "aws_access_key_id = ${AWS_ACCESS_KEY_ID}">>/root/.aws/credentials
#echo "aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}">>/root/.aws/credentials
# Define an array of parameter names
parameter_names=("JWT_SECRET" "MESSAGE_KEY")

# Loop through the parameter names
for parameter_name in "${parameter_names[@]}"; do
  # Retrieve the parameter value using AWS CLI
  value=$(aws ssm get-parameter --name "$parameter_name" --query "Parameter.Value" --output text)

  # Wait until a non-empty value is obtained
  while [[ -z "$value" ]]; do
    sleep 1
    value=$(aws ssm get-parameter --name "$parameter_name" --query "Parameter.Value" --output text)
  done
  # external ip 
  export CLIENT_URL="$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-ipv4):30080"
                                                                                                                 
  # Assign the parameter value to a variable
  export "$parameter_name=$value"
  echo "$parameter_name: ${!parameter_name}"
done

npm install && node server.js
71327e84f8c0