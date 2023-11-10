const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  // Handle the /test route logic here
  res.send('Test route');
});

module.exports = router;
