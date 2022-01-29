const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('cliente/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {nombreCliente, identificacionCliente, tipoCliente, direccion, telefono, email} = req.body;
    const newCliente = {
        nombreCliente,
        identificacionCliente,
        tipoCliente,
        direccion,
        telefono,
        email,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO cliente set ?', [newCliente]);
    req.flash('success', 'Cliente Saved Successfully');
    res.redirect('/cliente');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    const cliente = await pool.query('SELECT * FROM cliente WHERE user_id = ?',[req.user.id]);
    res.render('cliente/list', {cliente});
});

router.get('/delete/:idCliente', isLoggedIn,async (req, res) => {
    const { idCliente } = req.params;
    await pool.query('DELETE FROM cliente WHERE idCliente = ?', [idCliente]);
    req.flash('success', 'cliente Removed Successfully');
    res.redirect('/cliente');
});

router.get('/edit/:idCliente', isLoggedIn, async (req, res) => {
    const { idCliente } = req.params;
    const cliente = await pool.query('SELECT * FROM cliente WHERE idCliente = ?', [idCliente]);
    console.log(cliente);
    res.render('cliente/edit', {cliente: cliente[0]});
});

router.post('/edit/:idCliente', isLoggedIn, async (req, res) => {
    const { idCliente } = req.params;
    const {nombreCliente, apellidoCliente, telefonoCliente, cedulaCliente, emailCliente, direccionCliente} = req.body; 
    const newCliente = {
        nombreCliente,
        apellidoCliente,
        telefonoCliente,
        cedulaCliente,
        emailCliente,
        direccionCliente
    };
    await pool.query('UPDATE cliente set ? WHERE idCliente = ?', [newCliente, idCliente]);
    req.flash('success', 'cliente Updated Successfully');
    res.redirect('/cliente');
});

// Search for clientes
router.get('/search', async (req, res) => {
    let { term } = req.query;
    console.log(term);
    // Make lowercase
    term = term.toLowerCase();
    const cliente = await pool.query('SELECT * FROM cliente WHERE nombreCliente = ?',[term]);
    res.render('cliente/list', {cliente});
    
  });
module.exports = router;