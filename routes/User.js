// User.js

const express = require('express');
const router  = express.Router();


// CREATE
router.post('/', (req, res) => {
    console.log('user CREATE');
});

// READ
router.get('/', (req, res) => {
    console.log('user READ');
});

// UPDATE
router.put('/', (req, res) => {
    console.log('user UPDATE');
});

// DELETE
router.delete('/', (req, res) => {
    console.log('user DELETE');
});

module.exports = router;
