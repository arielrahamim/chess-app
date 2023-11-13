const fs = require('fs');
const { randomBytes } = require('crypto');

const envFilePath = '.env';
const MESSAGE_KEYEnvVar = 'MESSAGE_KEY';

// Read the .env file
let envFile = '';
if (fs.existsSync(envFilePath)) {
  envFile = fs.readFileSync(envFilePath, 'utf-8');
}

// Check if MESSAGE_KEY already exists in the .env file or process.env
const MESSAGE_KEYExists = MESSAGE_KEYEnvVar in process.env || /MESSAGE_KEY=/.test(envFile);

// Generate random JWT secret if it doesn't exist
const MESSAGE_KEY = MESSAGE_KEYExists ? null : randomBytes(32).toString('hex');

// Append the MESSAGE_KEY value to the .env file if it doesn't exist
if (!MESSAGE_KEYExists) {
  if (fs.existsSync(envFilePath)) {
    fs.appendFileSync(envFilePath, `\n${MESSAGE_KEYEnvVar}=${MESSAGE_KEY}`);
  } else {
    process.env[MESSAGE_KEYEnvVar] = MESSAGE_KEY;
  }
}

// Use the MESSAGE_KEY value in your code

