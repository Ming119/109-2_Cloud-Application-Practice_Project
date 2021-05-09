// server.js

require('dotenv').config();
const express = require('express');
const http = require('http');

const app = express();
const server = http.createServer(app);
const port = process.env.PORT;

app.listen(port, () => {
	console.log(`Server running on port ${port}`);
});
