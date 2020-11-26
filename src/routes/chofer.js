const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('chofer/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {nombre, apellido, telefono, cedula, email} = req.body;
    const newChofer = {
        nombre,
        apellido,
        telefono,
        cedula,
        email,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO chofer set ?', [newChofer]);
    req.flash('success', 'Chofer Saved Successfully');
    res.redirect('/chofer');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    const chofer = await pool.query('SELECT * FROM chofer WHERE user_id = ?',[req.user.id]);
    res.render('chofer/list', {chofer});
});

router.get('/delete/:id', isLoggedIn,async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM chofer WHERE ID = ?', [id]);
    req.flash('success', 'Chofer Removed Successfully');
    res.redirect('/chofer');
});

router.get('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const chofer = await pool.query('SELECT * FROM chofer WHERE id = ?', [id]);
    console.log(chofer);
    res.render('chofer/edit', {chofer: chofer[0]});
});

router.post('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const {nombre, apellido, telefono, cedula, email} = req.body; 
    const newChofer = {
        nombre,
        apellido,
        telefono,
        cedula,
        email
    };
    await pool.query('UPDATE chofer set ? WHERE id = ?', [newChofer, id]);
    req.flash('success', 'Chofer Updated Successfully');
    res.redirect('/chofer');
});
module.exports = router;