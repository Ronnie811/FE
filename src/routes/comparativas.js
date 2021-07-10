const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');



router.get('/', isLoggedIn,  async (req, res)=>{
    const usuarios = await pool.query('SELECT * FROM usuarios');
    res.render('comparativas/list', {usuarios});
});

router.post('/busqueda/', isLoggedIn, async (req, res) => {
    const { fechafin, fechainicio, nombreusuario } = req.body;
    
    const fechafinSumanda = fechafin.split('-');
    const dia = fechafinSumanda[0]+'-'+fechafinSumanda[1]+'-'+(Number(fechafinSumanda[2])+1);
    const tarjetas = await pool.query(`select u.nombreusuario, t.nombretarjeta, t.fecha from usuarios as u inner join tarjetas as t on u.id = t.user_id where u.nombreusuario = ? and t.fecha between ? and ? `, [nombreusuario,fechainicio,dia]);
    console.log(tarjetas);
    console.log(dia);
    
    res.render('comparativas/usuariostarjetas', {tarjetas});
});

module.exports = router;