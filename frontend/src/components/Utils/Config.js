const SERVER_HOST = process.env.REACT_APP_HOST;
const SERVER_URL = `http://${SERVER_HOST}`;
const POD = process.env.REACT_APP_POD;
module.exports = { SERVER_URL ,POD};
