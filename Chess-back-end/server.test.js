const mongoose = require('mongoose');
const request = require('supertest');
const { app ,server} = require('./server');
const { MONGO_URI } = require('./config/config.js');

describe('Server', () => {
  let testServer;

  beforeAll(async () => {
    // Start the server and assign it to the testServer variable
    testServer = app.listen(5001); // Use the appropriate port

    // Connect to the MongoDB database
    await mongoose.connect(MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
    });
  });

  afterAll(async () => {
    // Close the server and return a promise
    await new Promise((resolve) => testServer.close(resolve));
    await new Promise((resolve) => server.close(resolve));
    // Close the MongoDB connection
    await mongoose.connection.close();
  });

  test('should establish a connection to the MongoDB database', () => {
    expect(mongoose.connection.readyState).toBe(1); // 1 represents the 'connected' state
  });

  test('GET /test should respond with status code 200', async () => {
    const response = await request(app).get('/test');
    expect(response.status).toBe(200);
  });

  // Add more tests for other routes, functionality, etc.
});
