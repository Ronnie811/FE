const express = require('express');
const router = express.Router();
const app = express()
const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, async (req, res) => {
    
    const cliente = await pool.query('SELECT * FROM cliente WHERE user_id = ?',[req.user.id]);
    const producto = await pool.query('SELECT * FROM producto');

    res.render('notacredito/add',{cliente,producto});
});

router.get('/addCliente', isLoggedIn, async (req, res) => {
    const cliente = await pool.query('SELECT * FROM cliente WHERE user_id = ?',[req.user.id]);
    res.render('notacredito/addCliente',{cliente});
});

router.get('/addProducto', isLoggedIn, async (req, res) => {
    const producto = await pool.query('SELECT * FROM producto');
    res.render('notacredito/addProducto',{producto});
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

router.get('/add/buscar/:idproducto', isLoggedIn,async (req, res) => {
    console.log('hola1..');
    const { idproducto } = req.params;
    console.log('.');
    const productosBusqueda = await pool.query('SELECT * FROM producto where idproducto = ?',idproducto);
    console.log(productosBusqueda);
    console.log('hola..');
    res.render('notacredito/add', {productosBusqueda});
});

// Search for clientes
router.get('/add/search', async (req, res) => {
    let { term } = req.query;
    console.log(term);
    // Make lowercase
    term = term.toLowerCase();
    const cliente = await pool.query('SELECT * FROM cliente WHERE cedulaCliente = ?',[term]);
    res.render('notacredito/add', {cliente});
    
  });


  // Search for producto
router.get('/add/searchProducto', async (req, res) => {
    console.log(req.query);
    let { term, idCliente } = req.query;
    console.log(term);
    // Make lowercase
    term = term.toLowerCase();
    
    const producto = await pool.query('SELECT * FROM producto WHERE nombreProducto = ?',[term]);
    const cliente = await pool.query('SELECT * FROM cliente WHERE idCliente = ?',[idCliente]);
    res.render('notacredito/add', {producto, cliente});
    
  });

 /* router.post('/addNotaCredito', isLoggedIn, async (req, res)=>{
    console.log(req.query);
    let { term, idCliente } = req.query;
    console.log(idCliente);
    console.log(term);
    const {nombreCliente, apellidoCliente, telefonoCliente, cedulaCliente, emailCliente, direccionCliente} = req.body;
    const newCliente = {
        nombreCliente,
        apellidoCliente,
        telefonoCliente,
        cedulaCliente,
        emailCliente,
        direccionCliente,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO cliente set ?', [newCliente]);
    req.flash('success', 'Cliente Saved Successfully');
    res.redirect('notacredito/add');
});*/

module.exports = router;