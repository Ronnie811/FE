const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('emisor/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {nombreEmisor, ruc, nombreComercial, dirMatriz, dirEstablecimiento, codEstablecimiento,codPuntoEmision,contribuyenteEspecial,obligadoLlevarCont,contRegMicro,agenteRetencion,logo,tiempoEsperaAut,tipoAmbiente,token} = req.body;
    const newEmisor = {
        nombreEmisor,
        ruc,
        nombreComercial,
        dirMatriz,
        dirEstablecimiento,
        codEstablecimiento,
        codPuntoEmision,
        contribuyenteEspecial,
        obligadoLlevarCont,
        contRegMicro,
        agenteRetencion,
        logo,
        tiempoEsperaAut,
        tipoAmbiente,
        token,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO emisor set ?', [newEmisor]);
    req.flash('success', 'Emisor Saved Successfully');
    res.redirect('/emisor');
});

router.get('/', isLoggedIn,  async (req, res)=>{
    const emisor = await pool.query('SELECT * FROM emisor WHERE user_id = ?',[req.user.id]);
    res.render('emisor/list', {emisor});
});

router.get('/delete/:id', isLoggedIn,async (req, res) => {
    const { ruc } = req.params;
    await pool.query('DELETE FROM emisor WHERE ruc = ?', [ruc]);
    req.flash('success', 'Emisor Removed Successfully');
    res.redirect('/emisor');
});

router.get('/edit/:id', isLoggedIn, async (req, res) => {
    const { ruc } = req.params;
    const emisor = await pool.query('SELECT * FROM emisor WHERE ruc = ?', [ruc]);
    console.log(emisor);
    res.render('emisor/edit', {emisor: emisor[0]});
});

router.post('/edit/:ruc', isLoggedIn, async (req, res) => {
    const { ruc } = req.params;
    const {nombreEmisor, nombreComercial, dirMatriz, dirEstablecimiento, codEstablecimiento,codPuntoEmision,contribuyenteEspecial,obligadoLlevarCont,contRegMicro,agenteRetencion,logo,tiempoEsperaAut,tipoAmbiente,token} = req.body; 
    const newEmisor = {
        nombreEmisor,
        ruc,
        nombreComercial,
        dirMatriz,
        dirEstablecimiento,
        codEstablecimiento,
        codPuntoEmision,
        contribuyenteEspecial,
        obligadoLlevarCont,
        contRegMicro,
        agenteRetencion,
        logo,
        tiempoEsperaAut,
        tipoAmbiente,
        token,
        user_id: req.user.id
    };
    await pool.query('UPDATE emisor set ? WHERE ruc = ?', [newEmisor, ruc]);
    req.flash('success', 'emisor Updated Successfully');
    res.redirect('/emisor');
});
module.exports = router;