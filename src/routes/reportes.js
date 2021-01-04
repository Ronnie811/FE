const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');



router.get('/', isLoggedIn,  async (req, res)=>{
    const reportes = await pool.query('SELECT * FROM tarjetas WHERE user_id = ? order by valor desc limit 1',[req.user.id]);
    res.render('reportes/list', {reportes});
});

module.exports = router;