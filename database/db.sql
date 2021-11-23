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
    calidad_id INT(11),
    fecha timestamp NOT NULL DEFAULT current_timestamp,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES usuarios(id),
    CONSTRAINT fk_bus FOREIGN KEY(bus_id) REFERENCES bus(id),
    CONSTRAINT fk_calidad FOREIGN KEY(calidad_id) REFERENCES calidad(id),
);

ALTER TABLE tarjetas
  ADD PRIMARY KEY (id);

ALTER TABLE tarjetas
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

ALTER TABLE tarjetas
ADD bus_id INT(11);

ALTER TABLE tarjetas MODIFY valor INT(11);

ALTER TABLE tarjetas
ADD CONSTRAINT fk_bus
FOREIGN KEY (bus_id) REFERENCES bus(id);

ALTER TABLE tarjetas
ADD calidad_id INT(11);

ALTER TABLE tarjetas
ADD CONSTRAINT fk_calidad
FOREIGN KEY (calidad_id) REFERENCES calidad(id);


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

CREATE TABLE tarjeta_bus (
  id INT(11) NOT NULL,
  tarejeta_id INT(11),
  bus_id INT(11),
  CONSTRAINT fk_bus1 FOREIGN KEY(bus_id) REFERENCES bus(id),
  CONSTRAINT fk_tarjeta1 FOREIGN KEY(tarejeta_id) REFERENCES tarjetas(id)
);

ALTER TABLE tarjeta_bus
  ADD PRIMARY KEY (id);

ALTER TABLE tarjeta_bus
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

CREATE TABLE transaccion (
  id INT(11) NOT NULL,
  busTransaccion VARCHAR(16) NOT NULL,
  tarjetaTransaccion VARCHAR(16) NOT NULL,
  valor INT(11)
);

ALTER TABLE transaccion
  ADD PRIMARY KEY (id);

ALTER TABLE transaccion
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

ALTER TABLE transaccion
ADD tarjetaTransaccion VARCHAR(16) NOT NULL;

DESCRIBE tarjetas;

CREATE TABLE calidad (
  id INT(11) NOT NULL,
  descripcion VARCHAR(16) NOT NULL
);

ALTER TABLE calidad
  ADD PRIMARY KEY (id);

ALTER TABLE calidad
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

  CREATE TABLE cliente (
  id INT(11) NOT NULL,
  nombre VARCHAR(32) NOT NULL,
  apellido VARCHAR(60) NOT NULL,
  telefono VARCHAR(16) NOT NULL,
  cedula VARCHAR(50) NOT NULL,
  email VARCHAR(16) NOT NULL,
  direccion VARCHAR(64) NOT NULL
);

ALTER TABLE cliente
  ADD PRIMARY KEY (id);

ALTER TABLE cliente
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

  ALTER TABLE cliente
ADD user_id INT(11);

  ALTER TABLE cliente
ADD CONSTRAINT fk_user3
FOREIGN KEY (user_id) REFERENCES usuarios(id);

CREATE TABLE proveedor (
  id INT(11) NOT NULL,
  nombre VARCHAR(32) NOT NULL,
  apellido VARCHAR(60) NOT NULL,
  telefono VARCHAR(16) NOT NULL,
  cedula VARCHAR(50) NOT NULL,
  email VARCHAR(16) NOT NULL,
  direccion VARCHAR(64) NOT NULL
);

ALTER TABLE proveedor
  ADD PRIMARY KEY (id);

ALTER TABLE proveedor
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

  ALTER TABLE proveedor
ADD user_id INT(11);

  ALTER TABLE proveedor
ADD CONSTRAINT fk_user4
FOREIGN KEY (user_id) REFERENCES usuarios(id);

CREATE TABLE producto (
  idproducto INT(11) NOT NULL,
  nombre VARCHAR(32) NOT NULL,
  tipoproducto VARCHAR(10) NOT NULL,
  Iva VARCHAR(20) NOT NULL,
  precio FLOAT(6,2) NOT NULL,
  Stock INT(15) NOT NULL,
  Detalle VARCHAR(75) NULL
);

ALTER TABLE producto
  ADD PRIMARY KEY (idproducto);

ALTER TABLE producto
  MODIFY idproducto INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

  ALTER TABLE producto
ADD user_id INT(11);

  ALTER TABLE producto
ADD CONSTRAINT fk_user4
FOREIGN KEY (user_id) REFERENCES usuarios(id);

CREATE TABLE notacredito (
  idnotacredito int(11) NOT NULL,
  fecha date NOT NULL,
  numeroregistro varchar(25) NOT NULL,
  nombrecliente varchar(50) NOT NULL,
  cedula varchar(15) NOT NULL,
  telefono varchar(10) NOT NULL,
  correo varchar(30) NOT NULL,
  direccion varchar(50) NOT NULL,
  codigo int(11) NOT NULL,
  nombreproducto varchar(25) NOT NULL,
  descrpcion varchar(25) NOT NULL,
  precio float NOT NULL,
  cantidad int(11) NOT NULL,
  subtotal float NOT NULL,
  iva12 float NOT NULL,
  noobjetoiva int(11) NOT NULL,
  descuento float NOT NULL,
  ice float NOT NULL,
  total float NOT NULL
) 

ALTER TABLE notacredito
  ADD PRIMARY KEY (idnotacredito);

ALTER TABLE notacredito
  MODIFY idnotacredito int(11) NOT NULL AUTO_INCREMENT = 2;

  CREATE TABLE configuracion (
  idconf INT(11) NOT NULL,
  ruc VARCHAR(32) NOT NULL,
  razonsocial VARCHAR(50) NOT NULL,
  nombrecomercial VARCHAR(50)  NULL,
  direccion VARCHAR(75) NOT NULL,
  codigoestabl VARCHAR(15) NOT NULL,
  contabilidad VARCHAR(2)  NOT NULL,
  contribuyenteMicro VARCHAR(2) NOT NULL,
  numeroresolucion VARCHAR(20)  NOT NULL,
  tiempoespera int(11) NOT NULL,
  ambiente VARCHAR(10) NOT NULL,
  token VARCHAR(75) NOT NULL
);

ALTER TABLE configuracion
  ADD PRIMARY KEY (idconf);

ALTER TABLE configuracion
  MODIFY idconf INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

  ALTER TABLE configuracion
ADD user_id INT(11);

  ALTER TABLE configuracion
ADD CONSTRAINT fk_user4
FOREIGN KEY (user_id) REFERENCES usuarios(id);