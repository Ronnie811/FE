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
  direccionCliente VARCHAR(50) NOT NULL,
  telefonoConvencionalCliente VARCHAR(16) NOT NULL,
  extensionCliente VARCHAR(16) NOT NULL,
  telefonoCelularCliente VARCHAR(16) NOT NULL,
  emailCliente VARCHAR(64) NOT NULL
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
CREATE TABLE tarifa_iva (
  idTarifaIva INT(11) NOT NULL,
  codIva INT(32) NOT NULL,
  porcentajeIva VARCHAR(32) NOT NULL
);

ALTER TABLE tarifa_iva
  ADD PRIMARY KEY (idTarifaIva);

ALTER TABLE tarifa_iva
  MODIFY idTarifaIva INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

insert into tarifa_iva (codIva,porcentajeIva) values (0,'0%');
insert into tarifa_iva (codIva,porcentajeIva) values (2,'12%');
insert into tarifa_iva (codIva,porcentajeIva) values (3,'14%');
insert into tarifa_iva (codIva,porcentajeIva) values (6,'No objeto de Impuesto');
insert into tarifa_iva (codIva,porcentajeIva) values (7,'Excento de Iva');


CREATE TABLE tarifa_ice (
  idTarifaIce INT(11) NOT NULL,
  codIce INT(32) NOT NULL,
  descripcionIce VARCHAR(32) NOT NULL,
  tarifaAdValorem VARCHAR(32) NOT NULL,
  tarifaEspecificaED VARCHAR(32) NOT NULL,
  tarifaEspecificaMD2 VARCHAR(32) NOT NULL
);

ALTER TABLE tarifa_ice
  ADD PRIMARY KEY (idTarifaIce);

ALTER TABLE tarifa_ice
  MODIFY idTarifaIce INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;

insert into tarifa_ice (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3101,'ICE Bebidas Energizantes','10%','','');
insert into tarifa_ice (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3041,'ICE Cerveza Industrial Gran Escala','75%','13,2000','');
insert into tarifa_ice (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3073,'ICE Vehículos Motorizados cuyo PVP sea hasta de 20000 USD','5%','','');
insert into tarifa_ice (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3077,'ICE Vehículos Motorizados cuyo PVP superior USD 40.000
hasta 50.000','20%','','');
insert into tarifa_ice (codIce,descripcionIce,tarifaAdValorem,tarifaEspecificaED,tarifaEspecificaMD2) values (3073,'ICE Vehículos Motorizados cuyo PVP sea hasta de 20000 USD','5%','','');

CREATE TABLE producto (
  idproducto INT(11) NOT NULL,
  codPrincipal INT(32) NOT NULL,
  codAuxiliar INT(32) NOT NULL,
  tipoProducto VARCHAR(32) NOT NULL,
  nombreProducto VARCHAR(64) NOT NULL,
  valorUnitario FLOAT(6,2) NOT NULL,
  codIrbPnr INT(11) NULL,
  idTarifaIceFk INT(11) NOT NULL,
  idTarifaIvaFk INT(11) NOT NULL,
  CONSTRAINT idTarifaIceFk FOREIGN KEY(idTarifaIceFk) REFERENCES tarifa_ice(idTarifaIce),
  CONSTRAINT idTarifaIvaFk FOREIGN KEY(idTarifaIvaFk) REFERENCES tarifa_iva(idTarifaIva)
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
 
CREATE TABLE tipo_forma_pago (
  idTipoFormaPago INT(11) NOT NULL,
  codTipoFormaPago INT(3) NOT NULL,
  descripcionTipoFP VARCHAR(50) NOT NULL
);
  
ALTER TABLE tipo_forma_pago
  ADD PRIMARY KEY (idTipoFormaPago);

ALTER TABLE tipo_forma_pago
  MODIFY idTipoFormaPago INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;  

CREATE TABLE forma_pago (
  idFormaPago INT(11) NOT NULL,
  codigoFP INT(3) NOT NULL,
  descripcionFP VARCHAR(50) NOT NULL,
  totalFP FLOAT(10,2) NOT NULL,
  plazoFP VARCHAR(50) NOT NULL,
  unidadTiempoFP VARCHAR(45) NOT NULL,
  accionFP VARCHAR(45) NOT NULL,
  idTipoFormaPago int(11) NOT NULL,
  CONSTRAINT idTipoFormaPago FOREIGN KEY(idTipoFormaPago) REFERENCES tipo_forma_pago(idTipoFormaPago)
);

ALTER TABLE forma_pago
  ADD PRIMARY KEY (idFormaPago);

ALTER TABLE forma_pago
  MODIFY idFormaPago INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;  

CREATE TABLE factura_producto (
  idFacturaProducto INT(11) NOT NULL,
  cantidadProducto INT(10) NOT NULL,
  codigoPrincipalP INT(10) NOT NULL,
  codigoAuxiliarP INT(10) NOT NULL,
  descripcionP VARCHAR(64) NOT NULL,
  precioUnitarioSubsidio FLOAT(10,2) NOT NULL,
  precioSinSubsidioP FLOAT(10,2) NOT NULL,
  descuentoP FLOAT(10,2) NOT NULL,
  valorTotalP FLOAT(10,2) NOT NULL,
  valorIce VARCHAR(45) NOT NULL,
  biIrbPnrP VARCHAR(45) NOT NULL,
  irbPnrP VARCHAR(45) NOT NULL,
  AccionP VARCHAR(45) NOT NULL,
  idFacturaFK int(11) NOT NULL,
  idProductoFK int(11) NOT NULL,
  CONSTRAINT idFacturaFK FOREIGN KEY(idFacturaFK) REFERENCES producto(idproducto),
  CONSTRAINT idProductoFK FOREIGN KEY(idProductoFK) REFERENCES factura(idfactura)
);

ALTER TABLE factura_producto
  ADD PRIMARY KEY (idFacturaProducto);

ALTER TABLE factura_producto
  MODIFY idFacturaProducto INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;  

CREATE TABLE emisor (
  idEmisor int(11) NOT NULL,
  ruc int(13) NOT NULL,
  nombreEmisor varchar(300) NOT NULL,
  nombreComercial varchar(300) NOT NULL,
  dirMatriz varchar(300) NOT NULL,
  dirEstablecimiento varchar(300) NOT NULL,
  codEstablecimiento int(15) NOT NULL,
  codPuntoEmision int(15) NOT NULL,
  contribuyenteEspecial int(11) NOT NULL,
  obligadoLlevarCont int(1) NOT NULL,
  contRegMicro int(1) NOT NULL,
  agenteRetencion varchar(128) NOT NULL,
  logo varchar(64) NOT NULL,
  tiempoEsperaAut int(32) NOT NULL,
  tipoAmbiente varchar(32) NOT NULL,
  token varchar(64) NOT NULL
); 

ALTER TABLE emisor
  ADD PRIMARY KEY (idEmisor);

ALTER TABLE emisor
  MODIFY idEmisor INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;  

    ALTER TABLE emisor
ADD user_id INT(11);

  ALTER TABLE emisor
ADD CONSTRAINT fk_user8
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

CREATE TABLE calidad (
  id INT(11) NOT NULL,
  descripcion VARCHAR(16) NOT NULL
);

ALTER TABLE calidad
  ADD PRIMARY KEY (id);

ALTER TABLE calidad
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;












  CREATE TABLE factura (
  idFactura int(11) NOT NULL,
  claveAcceso VARCHAR(64) NOT NULL,
  guiaRemision VARCHAR(64) NOT NULL,
  direccionComprador VARCHAR(64) NOT NULL,
  cantidad VARCHAR(64) NOT NULL,
  codigoPrincipal VARCHAR(64) NOT NULL,
  codigoAuxiliar VARCHAR(64) NOT NULL,
  descripcionDetFact VARCHAR(64) NOT NULL,
  preciounitario VARCHAR(64) NOT NULL,
  subsidio VARCHAR(64) NOT NULL,
  precioSinSub VARCHAR(64) NOT NULL,
  descuento VARCHAR(64) NOT NULL,
  valorTotalDetFact VARCHAR(64) NOT NULL,
  valorIce VARCHAR(64) NOT NULL,
  biIrbpnr VARCHAR(64) NOT NULL,
  irbpnr VARCHAR(64) NOT NULL,
  accion VARCHAR(64) NOT NULL,
  codigoFormaPago VARCHAR(64) NOT NULL,
  descripcionFormaPago VARCHAR(64) NOT NULL,
  totalFormaPago VARCHAR(64) NOT NULL,
  plazo VARCHAR(64) NOT NULL,
  unidadTiempo VARCHAR(64) NOT NULL,
  accionFormaPago VARCHAR(64) NOT NULL,
  subTotalSinImp VARCHAR(64) NOT NULL,
  subtotalDoce VARCHAR(64) NOT NULL,
  subtotal VARCHAR(64) NOT NULL,
  subTotalNoObjIva VARCHAR(64) NOT NULL,
  subTotalExcentoIva VARCHAR(64) NOT NULL,
  totalDescuento VARCHAR(64) NOT NULL,
  totalValorIce VARCHAR(64) NOT NULL,
  valorIva VARCHAR(64) NOT NULL,
  valorTotalIrb VARCHAR(64) NOT NULL,
  propina VARCHAR(64) NOT NULL,
  valorTotal VARCHAR(64) NOT NULL
  ); 

ALTER TABLE factura
  ADD PRIMARY KEY (idFactura);

ALTER TABLE factura
  MODIFY idFactura INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 2;  