const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('notacredito/add');
});

    
router.get('/ search/:cedula', isLoggedIn,  async (req, res)=>{
    const { cedula } = req.params;
    const cliente = await pool.query('SELECT * FROM cliente where cedula like ?',[cedula]);
    res.redirect('/notacredito', {cliente});
    
});

router.get('/buscar/:nombreTarjeta', isLoggedIn,async (req, res) => {
    
    const { nombreTarjeta } = req.params;
    const notacredito = await pool.query('SELECT * FROM cliente');
    const tarjetas = await pool.query('SELECT * FROM tarjetas');
    const tarjetasBusqueda = await pool.query('SELECT * FROM tarjetas where nombreTarjeta = ?',nombreTarjeta);
    console.log(tarjetas);
    console.log(tarjetasBusqueda);
    res.render('transaccion/buscar', {transaccion,tarjetas,tarjetasBusqueda});
});

module.exports = router;