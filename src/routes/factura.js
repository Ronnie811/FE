const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('factura/add');
});


router.get('/add/:nombre', isLoggedIn,async (req, res) => {
    
    const { nombre } = req.params;
    const cliente = await pool.query('SELECT * FROM cliente',nombre);
    console.log(cliente);
    res.render('add/factura', {nombre});
});




module.exports = router;