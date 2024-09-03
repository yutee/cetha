const express = require('express');

const app = express();
const port = 3000;

// handlinng request...

app.get('/', (req, res) => {
  const currentTime = new Date().toString();
  console.log('request received and processed at: ', currentTime);
  res.json({ 
    message: 'hello from cetha, the current time is...',
    currentTime 
    });
});

app.listen(port, () => {
  console.log(`api is listening at http://localhost:${port}`);
});