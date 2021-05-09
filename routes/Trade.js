// Trade.js

const express = require('express');
const router  = express.Router();


// CREATE
router.post('/', (req, res) => {
    console.log('trade CREATE');
});

// READ
router.get('/', (req, res) => {
    console.log('trade READ');
});

// UPDATE
router.put('/', (req, res) => {
    console.log('trade UPDATE');
});

// DELETE
router.delete('/', (req, res) => {
    console.log('trade DELETE');
});

module.exports = router;
