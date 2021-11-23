const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('producto/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {nombre, tipoproducto, Iva, precio, Stock, Detalle} = req.body;
    const newProducto = {
        nombre,
        tipoproducto,
        Iva,
        precio,
        Stock,
        Detalle,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO producto set ?', [newProducto]);
    req.flash('success', 'El producto se a registrado Satisfactoriamente');
    res.redirect('/producto');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    const producto = await pool.query('SELECT * FROM producto WHERE user_id = ?',[req.user.id]);
    res.render('producto/list', {producto});
});

router.get('/delete/:idproducto', isLoggedIn,async (req, res) => {
    const { idproducto } = req.params;
    await pool.query('DELETE FROM producto WHERE idproducto = ?', [idproducto]);
    req.flash('success', 'Producto Eliminado');
    res.redirect('/producto');
});

router.get('/edit/:idproducto', isLoggedIn, async (req, res) => {
    const { idproducto } = req.params;
    const producto = await pool.query('SELECT * FROM producto WHERE idproducto = ?', [idproducto]);
    console.log(producto);
    res.render('producto/edit', {producto: producto[0]});
});

router.post('/edit/:idproducto', isLoggedIn, async (req, res) => {
    const { idproducto } = req.params;
    const {nombre, tipoproducto, Iva, precio, Stock, Detalle} = req.body; 
    const newProducto = {
        nombre,
        tipoproducto,
        Iva,
        precio,
        Stock,
        Detalle
    };
    await pool.query('UPDATE producto set ? WHERE idproducto = ?', [newProducto, idproducto]);
    req.flash('success', 'El registro se actualizó');
    res.redirect('/producto');
});
module.exports = router;


