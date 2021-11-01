const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('proveedor/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {nombre, apellido, telefono, cedula, email, direccion} = req.body;
    const newProveedor = {
        nombre,
        apellido,
        telefono,
        cedula,
        email,
        direccion,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO proveedor set ?', [newProveedor]);
    req.flash('success', 'Proveedor Saved Successfully');
    res.redirect('/proveedor');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    const proveedor = await pool.query('SELECT * FROM proveedor WHERE user_id = ?',[req.user.id]);
    res.render('proveedor/list', {proveedor});
});

router.get('/delete/:id', isLoggedIn,async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM proveedor WHERE ID = ?', [id]);
    req.flash('success', 'proveedor Removed Successfully');
    res.redirect('/proveedor');
});

router.get('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const proveedor = await pool.query('SELECT * FROM proveedor WHERE id = ?', [id]);
    console.log(proveedor);
    res.render('proveedor/edit', {proveedor: proveedor[0]});
});

router.post('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const {nombre, apellido, telefono, cedula, email, direccion} = req.body; 
    const newProveedor = {
        nombre,
        apellido,
        telefono,
        cedula,
        email,
        direccion
    };
    await pool.query('UPDATE proveedor set ? WHERE id = ?', [newProveedor, id]);
    req.flash('success', 'proveedor Updated Successfully');
    res.redirect('/proveedor');
});
module.exports = router;