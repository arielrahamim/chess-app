//require('./JWT_Gen');
//require('./MSG_Gen');
require('dotenv').config();
const SERVER_PORT = process.env.BACKEND_SERVICE_PORT;
const CLIENT_URL = `http://${process.env.CLIENT_URL}`;
const MONGO_URI= process.env.MONGO_URI;
const GMAIL_USER= process.env.GMAIL_USER;
const GMAIL_PASS= process.env.GMAIL_PASS;
const JWT_SECRET= process.env.JWT_SECRET;
const MESSAGE_KEY= process.env.MESSAGE_KEY;
module.exports = {
  SERVER_PORT,
  CLIENT_URL,
  MONGO_URI,
  JWT_SECRET,
  MESSAGE_KEY,
  GMAIL_USER,
  GMAIL_PASS
};
