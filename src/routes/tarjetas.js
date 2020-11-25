const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('tarjetas/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {nombreTarjeta, valor, descripcion} = req.body;
    const newTarjeta = {
        nombreTarjeta,
        valor,
        descripcion,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO tarjetas set ?', [newTarjeta]);
    req.flash('success', 'Tarjeta Saved Successfully');
    res.redirect('/tarjetas');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    const tarjetas = await pool.query('SELECT * FROM tarjetas WHERE user_id = ?',[req.user.id]);
    res.render('tarjetas/list', {tarjetas});
});

router.get('/delete/:id', isLoggedIn,async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM tarjetas WHERE ID = ?', [id]);
    req.flash('success', 'Tarjeta Removed Successfully');
    res.redirect('/tarjetas');
});

router.get('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const tarjetas = await pool.query('SELECT * FROM tarjetas WHERE id = ?', [id]);
    console.log(tarjetas);
    res.render('tarjetas/edit', {tarjetas: tarjetas[0]});
});

router.post('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const { nombreTarjeta, valor, descripcion} = req.body; 
    const newTarjeta = {
        nombreTarjeta,
        valor,
        descripcion
    };
    await pool.query('UPDATE tarjetas set ? WHERE id = ?', [newTarjeta, id]);
    req.flash('success', 'Tarjeta Updated Successfully');
    res.redirect('/tarjetas');
});
module.exports = router;