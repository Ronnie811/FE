let XMLWriter = require('xml-writer');

/*var XMLWriter = require('xml-writer');
    xw = new XMLWriter;
    xw.startDocument();
    xw.startElement('root');
    xw.writeAttribute('foo', 'value');
    xw.text('Some content');
    xw.endDocument();
 
    console.log(xw.toString());*/
require('http').createServer(function(req, res){

	let xml = new XMLWriter();
	/*xml.startDocument().startElement('facturas');
	xml.startElement('factura');
    xml.writeAttribute('ambiente','1');
	xml.startElement('id', 1001);
    xml.startElement('razonSocial','Ronnie Almeida');
    xml.endElement();
	xml.endElement();
    xml.endElement();
    xml.endElement();
    xml.endDocument();*/
    xml.startDocument().startElement('facturas');
	xml.startElement('ClaveAcceso');
    //xml.writeAttribute('ambiente', '1');
    xml.text('2101202201179001691900121391150002859320716013418');
    xml.endElement();
    xml.startElement('numeroComprobantes');
    xml.text('1');
    xml.endElement();
    xml.startDocument().startElement('Autorizaciones');
    xml.startDocument().startElement('Autorizacion');
    //xml.text('1');
    
    //xml.startDocument().startElement('Autorizaciones');
    xml.startElement('ESTADO');
    xml.text('AUTORIZADO');
    xml.endElement();
    xml.startElement('numeroAutorizacion');
    xml.text('0503201201176001321000110010030009900641234567814');
    xml.endElement();
    xml.startElement('fechaAutorizacion');
    xml.text('2020-03-05T16:57:34.997-05:00');
    xml.endElement();
    xml.startElement('ambiente');
    xml.text('PRUEBAS');
    xml.endElement();   
    xml.startElement('comprobante');
    xml.text('version="1.0" encoding="UTF-8"?><factura id="comprobante" version="1.1.0"><infoTributaria><ambiente>2</ambiente><tipoEmision>1</tipoEmision><razonSocial>CORPORACION FAVORITA');
    xml.endElement(); 
    xml.endDocument();
    xml.endDocument();
    
    xml.endDocument();
    xml.endDocument();
    /*
    xml.startDocument();
	xml.startElement('root');
	xml.writeAttribute('foo', 'value');
	xml.text('Some content');
	xml.endDocument();*/
	res.writeHead(200, {'Content-Type': 'application/xml', 'Access-Control-Allow-Origin': '*'});
	res.end(xml.toString(),'utf8');
}).listen(4900);

console.log('El servidor se está ejecutando en el puerto 4900');
    /*xml.startElement('nombreComercial','Ronnie Almeida');
    xml.startElement('ruc','1001647641');
    xml.startElement('claveAcceso','2101202201179001691900121391150002859320716013418');
    xml.startElement('codDoc','01');
    xml.startElement('estab','100');
    xml.startElement('ptoEmi','101');
    xml.startElement('secuencial','000000002');
    xml.startElement('dirMatriz','Granados y Queri');
    xml.startElement('fechaEmision','01/01/2022');
    xml.startElement('dirEstablecimiento','AV.interoceanica');
    xml.startElement('contribuyenteEspecial','01');
    xml.startElement('obligadoContabilidad','SI');
    xml.startElement('tipoIdentificacionComprador','cedula');
    xml.startElement('identificacionComprador','1002556148');
    xml.startElement('totalSinImpuestos','50.38');
    xml.startElement('totalDescuento','2.38');
    xml.startElement('totalConImpuestos','50.38');
    xml.startElement('totalSinImpuestos','50.38');
    xml.startElement('totalImpuesto');
    xml.startElement('codigo','02');
    xml.startElement('codigoPorcentaje','0.0');
    xml.startElement('valor','2.10');
    xml.startElement('valorDevolucionIva','0.00');
    xml.startElement('propina','0.00');
    xml.startElement('importeTotal','0.00');
    xml.startElement('pago','0.00');
    xml.startElement('total','0.00');
    xml.startElement('plazo','0.00');
    xml.startElement('unidadTiempo','0.00');*/
    
