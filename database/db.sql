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

/*CREATE TABLE cliente (
  idCliente INT(11) NOT NULL,
  nombreCliente VARCHAR(32) NOT NULL,
  apellidoCliente VARCHAR(60) NOT NULL,
  telefonoCliente VARCHAR(16) NOT NULL,
  cedulaCliente VARCHAR(50) NOT NULL,
  emailCliente VARCHAR(16) NOT NULL,
  direccionCliente VARCHAR(64) NOT NULL
);*/

CREATE TABLE cliente (
  idCliente INT(11) NOT NULL,
  nombreCliente VARCHAR(32) NOT NULL,
  identificacionCliente VARCHAR(60) NOT NULL,
  tipoCliente VARCHAR(16) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(16) NOT NULL,
  email VARCHAR(64) NOT NULL
);

ALTER TABLE cliente
  ADD PRIMARY KEY (idCliente);

ALTER TABLE cliente
  MODIFY idCliente INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

  ALTER TABLE cliente
ADD user_id INT(11);

 
/*CREATE TABLE producto (
  idproducto INT(11) NOT NULL,
  nombreProducto VARCHAR(32) NOT NULL,
  tipoproducto VARCHAR(10) NOT NULL,
  IvaProducto VARCHAR(20) NOT NULL,
  precioProducto FLOAT(6,2) NOT NULL,
  StockProducto INT(15) NOT NULL,
  DetalleProducto VARCHAR(75) NULL
);*/
CREATE TABLE TARIFA_IVA (
  idTarifaIva INT(11) NOT NULL,
  codIva INT(32) NOT NULL,
  porcentajeIva VARCHAR(32) NOT NULL
);

ALTER TABLE TARIFA_IVA
  ADD PRIMARY KEY (idTarifaIva);

ALTER TABLE TARIFA_IVA
  MODIFY idTarifaIva INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

insert into TARIFA_IVA (codIva,porcentajeIva) values (0,'0%');
insert into TARIFA_IVA (codIva,porcentajeIva) values (2,'12%');
insert into TARIFA_IVA (codIva,porcentajeIva) values (3,'14%');
insert into TARIFA_IVA (codIva,porcentajeIva) values (6,'No objeto de Impuesto');
insert into TARIFA_IVA (codIva,porcentajeIva) values (7,'Excento de Iva');


CREATE TABLE TARIFA_ICE (
  idTarifaIce INT(11) NOT NULL,
  codIce INT(32) NOT NULL,
  descripcionIce VARCHAR(32) NOT NULL,
  tarifaAdValorem VARCHAR(32) NOT NULL,
  tarifaEspecificaED VARCHAR(32) NOT NULL,
  tarifaEspecificaMD2 VARCHAR(32) NOT NULL
);

ALTER TABLE TARIFA_ICE
  ADD PRIMARY KEY (idTarifaIce);

ALTER TABLE TARIFA_ICE
  MODIFY idTarifaIce INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

insert into TARIFA_ICE (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3101,'ICE Bebidas Energizantes','10%','','');
insert into TARIFA_ICE (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3041,'ICE Cerveza Industrial Gran Escala','75%','13,2000','');
insert into TARIFA_ICE (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3073,'ICE Vehículos Motorizados cuyo PVP sea hasta de 20000 USD','5%','','');
insert into TARIFA_ICE (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3077,'ICE Vehículos Motorizados cuyo PVP superior USD 40.000
hasta 50.000','20%','','');
insert into TARIFA_ICE (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3073,'ICE Vehículos Motorizados cuyo PVP sea hasta de 20000 USD','5%','','');

CREATE TABLE producto (
  idproducto INT(11) NOT NULL,
  codPrincipal INT(32) NOT NULL,
  codAuxiliar INT(32) NOT NULL,
  tipoProducto VARCHAR(32) NOT NULL,
  nombreProducto VARCHAR(64) NOT NULL,
  valorUnitario FLOAT(6,2) NOT NULL,
  tarifaIva INT(11) NULL,
  tarifaIce INT(11) NULL,
  codIrbPnr INT(11) NULL
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
  subtotal float NOT NULL,
  iva12 float NOT NULL,
  noobjetoiva int(11) NOT NULL,
  descuento float NOT NULL,
  ice float NOT NULL,
  total float NOT NULL,
  fkIdCliente int(11) NOT NULL,
  fkIdProducto int(11) NOT NULL,
  CONSTRAINT fk_IdProducto FOREIGN KEY(fkIdProducto) REFERENCES producto(idproducto)
);

ALTER TABLE notacredito
  ADD PRIMARY KEY (idnotacredito);

ALTER TABLE notacredito
  MODIFY idnotacredito int(11) NOT NULL, AUTO_INCREMENT = 2;

  ALTER TABLE notacredito
ADD fkIdProducto INT(11);

ALTER TABLE notacredito
ADD CONSTRAINT fkIdProducto
FOREIGN KEY (fkIdProducto) REFERENCES producto(idproducto);

ALTER TABLE notacredito
ADD CONSTRAINT fkIdCliente
FOREIGN KEY (fkIdCliente) REFERENCES cliente(idCliente);
  
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
  nombrecliente varchar(50) NOT NULL,
  codigoproducto int(11) NOT NULL,
  nombreproducto varchar(25) NOT NULL,
  total float NOT NULL,
  user_id int(11) NOT NULL,
  cliente_id int(11) NOT NULL,
  producto_id int(11) NOT NULL
); 

ALTER TABLE factura
    ADD PRIMARY KEY(idfactura);

ALTER TABLE factura
    MODIFY idfactura INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;
	
ALTER TABLE factura
ADD CONSTRAINT fk_user7
FOREIGN KEY (user_id) REFERENCES usuarios(id);

ALTER TABLE factura
ADD CONSTRAINT fk_user8
FOREIGN KEY (producto_id) REFERENCES producto(idproducto);

ALTER TABLE factura
ADD CONSTRAINT fk_user9
FOREIGN KEY (cliente_id) REFERENCES cliente(idCliente);

ALTER TABLE factura
  ADD PRIMARY KEY (idfactura);

ALTER TABLE factura
  MODIFY idfactura int(11) NOT NULL, AUTO_INCREMENT = 2;

  ALTER TABLE factura
ADD CONSTRAINT fk_user7
FOREIGN KEY (user_id) REFERENCES usuarios(id);
