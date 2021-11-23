const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add', isLoggedIn, (req, res) => {
    res.render('configuracion/add');
});

router.post('/add', isLoggedIn, async (req, res)=>{
    const {ruc, razonsocial, nombrecomercial, direccion, codigoestabl, contabilidad,contribuyenteMicro,numeroresolucion,tiempoespera,ambiente,token} = req.body;
    const newConfig= {
        ruc,
        razonsocial,
        nombrecomercial,
        direccion, 
        codigoestabl, 
        contabilidad,
        contribuyenteMicro,
        numeroresolucion,
        tiempoespera,
        ambiente,
        token,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO configuracion set ?', [newConfig]);
    req.flash('success', 'La información se guardo Satisfactoriamente');
    res.redirect('/profile');
});


module.exports = router;