const express = require('express');
const router = express.Router();
const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, async (req, res) => {
    
    const cliente = await pool.query('SELECT * FROM cliente WHERE user_id = ?',[req.user.id]);
    const producto = await pool.query('SELECT * FROM producto');

    res.render('factura/add',{cliente,producto});
});
 
// Search for clientes
router.get('/add/search', async (req, res) => {
    let { term } = req.query;
    console.log(term);
    // Make lowercase
    term = term.toLowerCase();
    const cliente = await pool.query('SELECT * FROM cliente WHERE identificacionCliente = ?',[term]);
    res.render('factura/add', {cliente});
    
  });


  // Search for producto
router.get('/add/searchProducto', async (req, res) => {
    console.log(req.query);
    let { term, idCliente } = req.query;
    console.log(term);
    // Make lowercase
    term = term.toLowerCase();
    
    const producto = await pool.query('SELECT * FROM producto WHERE codPrincipal = ?',[term]);
    const cliente = await pool.query('SELECT * FROM cliente WHERE idCliente = ?',[idCliente]);
    res.render('factura/add', {producto, cliente});
    
  });

module.exports = router;