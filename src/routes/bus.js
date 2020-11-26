const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('bus/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {nombreCoperativa, marca, placa, color, capacidad} = req.body;
    const newBus = {
        nombreCoperativa,
        marca,
        placa,
        color,
        capacidad,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO bus set ?', [newBus]);
    req.flash('success', 'Bus Saved Successfully');
    res.redirect('/bus');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    const bus = await pool.query('SELECT * FROM bus WHERE user_id = ?',[req.user.id]);
    res.render('bus/list', {bus});
});

router.get('/delete/:id', isLoggedIn,async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM bus WHERE ID = ?', [id]);
    req.flash('success', 'Bus Removed Successfully');
    res.redirect('/bus');
});

router.get('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const bus = await pool.query('SELECT * FROM bus WHERE id = ?', [id]);
    console.log(bus);
    res.render('bus/edit', {bus: bus[0]});
});

router.post('/edit/:id', isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const {nombreCoperativa, marca, placa, color, capacidad} = req.body; 
    const newBus = {
        nombreCoperativa,
        marca,
        placa,
        color,
        capacidad
    };
    await pool.query('UPDATE bus set ? WHERE id = ?', [newBus, id]);
    req.flash('success', 'Bus Updated Successfully');
    res.redirect('/bus');
});
module.exports = router;