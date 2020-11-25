CREATE DATABASE db_pasajeros;

USE db_pasajeros;

SHOW TABLES;

CREATE TABLE usuarios (
  id INT(11) NOT NULL,
  nombreusuario VARCHAR(16) NOT NULL,
  password VARCHAR(60) NOT NULL,
  nombrecompleto VARCHAR(100) NOT NULL
);

ALTER TABLE usuarios
    ADD PRIMARY KEY(id);

ALTER TABLE usuarios
    MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

DESCRIBE usuarios;

--tarjetas table
CREATE TABLE tarjetas (
    id INT(11) NOT NULL,
    nombreTarjeta VARCHAR(150) NOT NULL,
    valor VARCHAR(150) NOT NULL,
    descripcion TEXT,
    user_id INT(11),
    fecha timestamp NOT NULL DEFAULT current_timestamp,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES usuarios(id)
);

ALTER TABLE tarjetas
  ADD PRIMARY KEY (id);

ALTER TABLE tarjetas
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

DESCRIBE tarjetas;