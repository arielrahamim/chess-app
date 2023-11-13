const fs = require('fs');
const { randomBytes } = require('crypto');

const envFilePath = '.env';
const jwtSecretEnvVar = 'JWT_SECRET';

// Read the .env file
let envFile = '';
if (fs.existsSync(envFilePath)) {
  envFile = fs.readFileSync(envFilePath, 'utf-8');
}

// Check if JWT_SECRET already exists in the .env file or process.env
const jwtSecretExists = jwtSecretEnvVar in process.env || /JWT_SECRET=/.test(envFile);

// Generate random JWT secret if it doesn't exist
const jwtSecret = jwtSecretExists ? null : randomBytes(32).toString('hex');

// Append the JWT_SECRET value to the .env file if it doesn't exist
if (!jwtSecretExists) {
  if (fs.existsSync(envFilePath)) {
    fs.appendFileSync(envFilePath, `\n${jwtSecretEnvVar}=${jwtSecret}`);
  } else {
    process.env[jwtSecretEnvVar] = jwtSecret;
  }
}

// Use the JWT_SECRET value in your code

