const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');



router.get('/add', isLoggedIn,async (req, res) => {
    const bus = await pool.query('SELECT * FROM bus');
    const tarjetas = await pool.query('SELECT * FROM tarjetas');
    console.log(bus);
    
    res.render('transaccion/add', {tarjetas,bus});
    
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {busTransaccion,tarjetaTransaccion, valor} = req.body;
    const newTransaccion = {
        busTransaccion,
        tarjetaTransaccion,
        valor
    };
    await pool.query('UPDATE tarjetas SET valor = valor - ? where nombreTarjeta = ?', [valor,tarjetaTransaccion]);
    await pool.query('INSERT INTO transaccion set ?', [newTransaccion]);
    req.flash('success', 'Transaccion Saved Successfully');
    res.redirect('/transaccion');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    const transaccion = await pool.query('SELECT * FROM transaccion');
    const tarjetas = await pool.query('SELECT * FROM tarjetas');
    console.log(tarjetas);
    res.render('transaccion/list', {transaccion,tarjetas});
});

router.get('/usuarios', isLoggedIn,  async (req, res)=>{
    const usuarios = await pool.query('SELECT * FROM usuarios');
    console.log(usuarios);
});

router.get('/delete/:id', isLoggedIn,async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM transaccion WHERE ID = ?', [id]);
    req.flash('success', 'Transaccion Removed Successfully');
    res.redirect('/transaccion');
});

router.get('/search/:nombreTarjeta', isLoggedIn,  async (req, res)=>{
    const { nombreTarjeta } = req.params;
    const tarjetas = await pool.query('SELECT * FROM tarjetas where nombreTarjeta like ?',[nombreTarjeta]);
    res.redirect('/transaccion', {tarjetas});
    
});

router.get('/buscar/:nombreTarjeta', isLoggedIn,async (req, res) => {
    
    const { nombreTarjeta } = req.params;
    const transaccion = await pool.query('SELECT * FROM transaccion');
    const tarjetas = await pool.query('SELECT * FROM tarjetas');
    const tarjetasBusqueda = await pool.query('SELECT * FROM tarjetas where nombreTarjeta = ?',nombreTarjeta);
    console.log(tarjetas);
    console.log(tarjetasBusqueda);
    res.render('transaccion/buscar', {transaccion,tarjetas,tarjetasBusqueda});
});

router.get('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const transaccion = await pool.query('SELECT * FROM transaccion WHERE id = ?', [id]);
    console.log(transaccion);
    res.render('transaccion/edit', {transaccion: transaccion[0]});
});

router.post('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const { busTransaccion, valor} = req.body; 
    const newTransaccion = {
        busTransaccion,
        valor
    };
    await pool.query('UPDATE transaccion set ? WHERE id = ?', [newTransaccion, id]);
    req.flash('success', 'Transaccion Updated Successfully');
    res.redirect('/transaccion');
});
module.exports = router;