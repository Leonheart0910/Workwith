const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');  // Import the 'cors' module
const app = express();
const path = require('path');

// For testing
// app.use(express.static('public'));  // 'public' directory is now a root for static files

// app.get('/', function(req, res) {
//     res.sendFile(path.join(__dirname, 'public', 'index.html'));  // or just '/' if your index.html is directly in 'public' directory
// });

// app.listen(8080, function() {
//     console.log('Server started on port 8080');
// });

// Web Socket
const WebSocket = require('ws');

const socket = new WebSocket.Server({
    port: 8081
});

socket.on('connection', (ws, req)=>{
    ws.on('message', (msg)=>{
        console.log('유저가 보낸 메세지 : ' + msg);
        ws.send('GTFO');
    })
});

// HTTP
app.use(bodyParser.json()); // Parse JSON request bodies
app.use(cors());  // Use cors middleware

app.post('/', function(req, res) {
    const id = req.body.id;
    const password = req.body.password;

    // You can add authentication logic here
    console.log(`Recieve Data :`);
    console.log(`ID: ${id}, Password: ${password}`);

    res.json({ token: 'your_token_here' }); // Send back a response with a token
});

app.listen(8090, function() {
    console.log('Server started on port 8090');
});