const obtenerUsuarios = async(req, res) => {

    const usuarios = await pool.query('SELECT nombreusuario FROM usuarios');
  
    res.json({
      ok: true,
      usuarios
    });
  
  };

  module.exports = {
    obtenerUsuarios
  }