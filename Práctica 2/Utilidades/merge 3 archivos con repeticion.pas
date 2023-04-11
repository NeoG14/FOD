program union_de_archivos_II;
const valoralto = '9999';
type 
	str4 = string[4];
	str10 = string[10];
	
	vendedor = record
		cod: str4;
		producto: str10;
		montoVenta: real;
	end;
	
	ventas = record
		cod: str4;
		total: real;
	end;
	
	detalle = file of vendedor;
	maestro = file of ventas;
	
var 
	min, regd1, regd2, regd3:vendedor;
	det1, det2, det3:detalle;
	mae1:maestro;
	regm:ventas;
	aux:str4;
	
procedure leer(var archivo:detalle; var dato:vendedor);
begin
	if (not eof( archivo ))then 
		read (archivo, dato)
	else 
		dato.cod := valoralto;
end;
	
procedure minimo(var r1,r2,r3:vendedor; var min:vendedor);
begin
	if (r1.cod<r2.cod) and (r1.cod<r3.cod) then 
	begin
		min := r1;
		leer(det1,r1)
	end
	else if(r2.cod<r3.cod)then
	begin
		min := r2;
		leer(det2,r2)
	end
	else begin
		min := r3;
		leer(det3,r3)
	end;
end;
	
	
begin
	assign(det1, 'det1'); assign(det2, 'det2'); assign(det3, 'det3'); assign(mae1, 'maestro');
	reset(det1); reset(det2); reset(det3);
	rewrite(mae1);
	leer(det1, regd1); leer(det2, regd2); leer(det3, regd3);
	minimo(regd1,regd2,regd3,min);
	{ se procesan los archivos de detalles }
	while (min.cod <> valoralto)do 
	begin
		{se asignan valores para registro del archivo maestro}
		regm.cod := min.cod;
		regm.total := 0;
		{se procesan todos los registros de un mismo vendedor}
		while (regm.cod = min.cod )do 
		begin
			regm.total := regm.total+ min.montoVenta;
			minimo (regd1, regd2, regd3, min);
		end;
		{ se guarda en el archivo maestro}
		write(mae1, regm);
	end;
	close(mae1);close(det1);close(det2);close(det3);
End.
