const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, async (req, res) => {
    const tarifaIva = await pool.query('SELECT * FROM tarifa_iva');
    const tarifaIce = await pool.query('SELECT * FROM tarifa_ice');
    res.render('producto/add',{tarifaIva,tarifaIce});
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {codPrincipal, codAuxiliar, tipoProducto, nombreProducto, valorUnitario, idTarifaIceFk,idTarifaIvaFk,codIrbPnr} = req.body;
    //const productoTarifaIva = await pool.query('SELECT * FROM TARIFA_IVA WHERE porcentajeIva = ?',[porcentajeIva]);
    //const idTarifaIvaFK = productoTarifaIva.idTarifaIva ;
    //console.log(idTarifaIvaFK);  
    //const idTarifaIceFK = codIce;
    //const productoTarifaIce = await pool.query('SELECT * FROM TARIFA_ICE WHERE codIce = ?',[codIce]);
    //const idTarifaIceFK =productoTarifaIce.idTarifaIce;
    //console.log(idTarifaIceFK);  
    //const idTarifaIvaFK = porcentajeIva;
    const newProducto = {
        codPrincipal,
        codAuxiliar,
        tipoProducto,
        nombreProducto,
        valorUnitario,
        idTarifaIvaFk,
        idTarifaIceFk,
        codIrbPnr
    };
    console.log(newProducto);
    await pool.query('INSERT INTO producto set ?', [newProducto]);
    req.flash('success', 'El producto se a registrado Satisfactoriamente');
    res.redirect('/producto');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    //const producto = await pool.query('SELECT * FROM producto WHERE user_id = ?',[req.user.id]);
    const producto = await pool.query('SELECT * FROM producto');
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
    const {nombreProducto, tipoproducto, IvaProducto, precioProducto, StockProducto, DetalleProducto} = req.body; 
    const newProducto = {
        nombreProducto,
        tipoproducto,
        IvaProducto,
        precioProducto,
        StockProducto,
        DetalleProducto,
    };
    await pool.query('UPDATE producto set ? WHERE idproducto = ?', [newProducto, idproducto]);
    req.flash('success', 'El registro se actualizó');
    res.redirect('/producto');
});
module.exports = router;


