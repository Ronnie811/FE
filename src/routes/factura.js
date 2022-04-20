const express = require('express');
const router = express.Router();
const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

/*router.get('/', isLoggedIn, async (req, res) => {
    
  const cliente = await pool.query('SELECT * FROM cliente WHERE user_id = ?',[req.user.id]);
  const producto = await pool.query('SELECT * FROM producto');
  
  res.render('factura',{cliente,producto});
});*/

router.get('/', isLoggedIn,  async (req, res)=>{
  const factura = await pool.query('SELECT * FROM factura');
  res.render('factura/list', {factura});
});

router.post('/add', isLoggedIn, async (req, res)=>{
  const {claveAcceso ,guiaRemision, direccionComprador ,cantidad ,codigoPrincipal, codigoAuxiliar, descripcionDetFact, preciounitario ,subsidio ,precioSinSub ,descuento, valorTotalDetFact,  valorIce, biIrbpnr, irbpnr, accion , codigoFormaPago, descripcionFormaPago, totalFormaPago, plazo, unidadTiempo, accionFormaPago, subTotalSinImp , subtotalDoce, subtotal, subTotalNoObjIva, subTotalExcentoIva, totalDescuento, totalValorIce ,valorIva, valorTotalIrb, propina ,valorTotal} = req.body;
  const newFactura = {
    claveAcceso,
    guiaRemision,
    direccionComprador,
    cantidad,
    codigoPrincipal,
    codigoAuxiliar,
    descripcionDetFact,
    preciounitario,
    subsidio, 
    precioSinSub,
    descuento,
    valorTotalDetFact,
    valorIce,
    biIrbpnr,
    irbpnr,
    accion,
    codigoFormaPago,
    descripcionFormaPago,
    totalFormaPago,
    plazo,
    unidadTiempo,
    accionFormaPago,
    subTotalSinImp,
    subtotalDoce,
    subtotal,
    subTotalNoObjIva,
    subTotalExcentoIva,
    totalDescuento,
    totalValorIce,
    valorIva,
    valorTotalIrb,
    propina,
    valorTotal
  };
  await pool.query('INSERT INTO factura set ?', [newFactura]);
  req.flash('success', 'Factura Saved Successfully');
  res.redirect('/factura');
});

router.get('/add', isLoggedIn, async (req, res) => {
    
    const cliente = await pool.query('SELECT * FROM cliente WHERE user_id = ?',[req.user.id]);
    const producto = await pool.query('SELECT * FROM producto');
    
    res.render('factura/add',{cliente,producto});
});
 
router.post('/add/Guardar', isLoggedIn, async (req, res)=>{
  const {nombreProducto, nombreEmisor,} = req.body;
  console.log(nombreProducto);
  console.log(nombreEmisor);
  const newFactura = {
      nombreProducto,
      nombreEmisor
  };
  console.log(newFactura);
  await pool.query('INSERT INTO factura set ?', [newFactura]);
  req.flash('success', 'La factura se a registrado Satisfactoriamente');
  res.redirect('/add');
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

  router.get('/delete/:id', isLoggedIn,async (req, res) => {
    const { ruc } = req.params;
    await pool.query('DELETE FROM factura WHERE ruc = ?', [ruc]);
    req.flash('success', 'Emisor Removed Successfully');
    res.redirect('/emisor');
});

module.exports = router;