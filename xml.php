$xml->formatOutput=true;
$xml_fact = $xml->createElement('factura');
$cabecera = $xml->createElement('id');
$cabecera->value='comprobante';
$cabecerav=$xmlcreateAtribute('version');
$cabecerav->value='1.00';
$xml_inf = $xml->createElement('infoTributeria');
$xml_amb = $xml->createElement('ambiente','1');
$xml_tip = $xml->createElement('tipoEmision','1');
$xml_raz = $xml->createElement('razonSocial','Empresa ABC');
$xml_nom = $xml->createElement('nombreComercial','Empresa ABC');
$xml_ruc = $xml->createElement('ruc','1001647641');

$xml_cla = $xml->createElement('claveAcceso','1001647641');
$xml_doc = $xml->createElement('codDoc','01');
$xml_est = $xml->createElement('estab','001');
$xml_emi = $xml->createElement('ptoEmi','001');
$xml_sec = $xml->createElement('secuencial','0000000001');
$xml_dir = $xml->createElement('dirMatriz','Granados y queri');

$xml_def = $xml->createElement('infoFactura');
$xml_fec = $xml->createElement('fechaEmision','17/01/2022');
$xml_des = $xml->createElement('dirEstablecimiento','Granados y queri');
$xml_obl = $xml->createElement('obligadoContabilidad','SI');
$xml_ide = $xml->createElement('tipoIdentificacionComprador','05');
$xml_rco = $xml->createElement('razonSocialComprador','Ronnie Almeida');
$xml_idc = $xml->createElement('identificacionComprador','1050126661');
$xml_tsi = $xml->createElement('totalSinImpuestos','1.00');
$xml_tds = $xml->createElement('totalDescuento','0.00');

$xml_imp = $xml->createElement('totalConImpuestos');
$xml_tim = $xml->createElement('totalImpuesto');
$xml_tco = $xml->createElement('codigo','2');
$xml_cpr = $xml->createElement('codigoPorcentaje','0');
$xml_bas = $xml->createElement('baseImponible','1.00');
$xml_val = $xml->createElement('valor','0');

$xml_pro = $xml->createElement('propina','0.00');
$xml_imt = $xml->createElement('importeTotal','1.00');
$xml_mon = $xml->createElement('moneda','DOLAR');




