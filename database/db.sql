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
  
CREATE TABLE inventario (
  id INT(11) NOT NULL,
  fecha DATE NOT NULL,
  detalle VARCHAR(64) NOT NULL,
  valor_unitario FLOAT(18,2) NOT NULL,
  cantidad INT(16) NOT NULL,
  total FLOAT(18,2) NOT NULL,
  tipo_transaccion VARCHAR(24) NOT NULL,
  codigo_producto INT(11) NOT NULL,
  CONSTRAINT codigo_producto FOREIGN KEY(codigo_producto) REFERENCES producto(idproducto)
);

ALTER TABLE inventario
  ADD PRIMARY KEY (id);

ALTER TABLE inventario
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

  ALTER TABLE inventario
ADD user_id INT(11);


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
ADD CONSTRAINT fk_user5
FOREIGN KEY (user_id) REFERENCES usuarios(id);

CREATE TABLE factura_proveedor (
  id INT(11) NOT NULL,
  proveedor_id INT(11) NOT NULL,
  CONSTRAINT fk_proveedor FOREIGN KEY(proveedor_id) REFERENCES proveedor(id)
);

ALTER TABLE factura_proveedor
  ADD PRIMARY KEY (id);

ALTER TABLE factura_proveedor
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;
  
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
) ;

ALTER TABLE notacredito
  ADD PRIMARY KEY (idnotacredito);

ALTER TABLE notacredito
  MODIFY idnotacredito int(11) NOT NULL, AUTO_INCREMENT = 2;
  
CREATE TABLE factura_nota_credito (
  id INT(11) NOT NULL,
  numero_factura_id INT(11) NOT NULL,
  CONSTRAINT fk_numero_factura FOREIGN KEY(numero_factura_id) REFERENCES notacredito(idnotacredito)
);

ALTER TABLE factura_nota_credito
  ADD PRIMARY KEY (id);

ALTER TABLE factura_nota_credito
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;
  
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
ADD CONSTRAINT fk_user6
FOREIGN KEY (user_id) REFERENCES usuarios(id);
 

  
  

CREATE TABLE factura (
  idfactura int(11) NOT NULL,
  fecha date NOT NULL,
  secuencial varchar(25) NOT NULL,
  nombrecliente varchar(50) NOT NULL,
  cedula varchar(15) NOT NULL,
  telefono varchar(10) NOT NULL,
  correo varchar(30) NOT NULL,
  direccion varchar(50) NOT NULL,
  codigoproducto int(11) NOT NULL,
  nombreproducto varchar(25) NOT NULL,
  descrpcion varchar(25) NOT NULL,
  precio float NOT NULL,
  cantidad int(11) NOT NULL,
  subtotal float NOT NULL,
  iva12 float NOT NULL,
  noobjetoiva int(11) NOT NULL,
  descuento float NOT NULL,
  ice float NOT NULL,
  total float NOT NULL,
  user_id int(11) NOT NULL,
  cliente_id int(11) NOT NULL,
  CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES usuarios(id),
  CONSTRAINT fk_cliente FOREIGN KEY(cliente_id) REFERENCES cliente(id)
); 

ALTER TABLE factura
  ADD PRIMARY KEY (idfactura);

ALTER TABLE factura
  MODIFY idfactura int(11) NOT NULL, AUTO_INCREMENT = 2;

  ALTER TABLE factura
ADD CONSTRAINT fk_user7
FOREIGN KEY (user_id) REFERENCES usuarios(id);
