const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('cliente/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {nombre, apellido, telefono, cedula, email, direccion} = req.body;
    const newCliente = {
        nombre,
        apellido,
        telefono,
        cedula,
        email,
        direccion,
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

router.get('/delete/:id', isLoggedIn,async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM cliente WHERE ID = ?', [id]);
    req.flash('success', 'cliente Removed Successfully');
    res.redirect('/cliente');
});

router.get('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const cliente = await pool.query('SELECT * FROM cliente WHERE id = ?', [id]);
    console.log(cliente);
    res.render('cliente/edit', {cliente: cliente[0]});
});

router.post('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const {nombre, apellido, telefono, cedula, email, direccion} = req.body; 
    const newCliente = {
        nombre,
        apellido,
        telefono,
        cedula,
        email,
        direccion
    };
    await pool.query('UPDATE cliente set ? WHERE id = ?', [newCliente, id]);
    req.flash('success', 'cliente Updated Successfully');
    res.redirect('/cliente');
});
module.exports = router;