//Para almacenar rutas principales de la aplicacion
const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
    res.render('index');
});

module.exports = router;