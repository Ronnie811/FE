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
    bus_id INT(11),
    fecha timestamp NOT NULL DEFAULT current_timestamp,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES usuarios(id)
    CONSTRAINT fk_bus FOREIGN KEY(bus_id) REFERENCES bus(id)
);

ALTER TABLE tarjetas
  ADD PRIMARY KEY (id);

ALTER TABLE tarjetas
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

ALTER TABLE tarjetas
ADD bus_id INT(11);

ALTER TABLE tarjetas
ADD CONSTRAINT fk_bus
FOREIGN KEY (bus_id) REFERENCES bus(id);


  CREATE TABLE bus (
  id INT(11) NOT NULL,
  nombreCoperativa VARCHAR(16) NOT NULL,
  marca VARCHAR(60) NOT NULL,
  placa VARCHAR(16) NOT NULL,
  color VARCHAR(50) NOT NULL,
  capacidad VARCHAR(16) NOT NULL
);

ALTER TABLE bus
  ADD PRIMARY KEY (id);

ALTER TABLE bus
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

ALTER TABLE bus
ADD user_id INT(11);

  ALTER TABLE bus
ADD CONSTRAINT fk_user1
FOREIGN KEY (user_id) REFERENCES usuarios(id);

CREATE TABLE chofer (
  id INT(11) NOT NULL,
  nombre VARCHAR(16) NOT NULL,
  apellido VARCHAR(60) NOT NULL,
  telefono VARCHAR(16) NOT NULL,
  cedula VARCHAR(50) NOT NULL,
  email VARCHAR(16) NOT NULL
);

ALTER TABLE chofer
  ADD PRIMARY KEY (id);

ALTER TABLE chofer
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

ALTER TABLE chofer
ADD user_id INT(11);

  ALTER TABLE chofer
ADD CONSTRAINT fk_user2
FOREIGN KEY (user_id) REFERENCES usuarios(id);

DESCRIBE tarjetas;