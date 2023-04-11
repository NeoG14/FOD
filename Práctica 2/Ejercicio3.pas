program ejerciocio3;
const valorAlto=9999;
type 
	producto=record
		cod:integer;
		nombre:string;
		desc:string;
		stock_disp:integer;
		stock_min:integer;
		precio:real;
	end;
	
	ventas=record
		cod:integer;
		cv:integer;
	end;
	
	maestro = file of producto;
	detalle = file of ventas;
	informacion = text;
	detalles = array[1..30] of detalle;
	
var
	mae:maestro;
	det:detalle; //archivo de ventas
	deta:detalles;//Arreglo de archivos de ventas
	regm:producto;
	regd:ventas;
	info:informacion;

procedure leer (var archivo:detalle; var dato:ventas);
begin
	if (not eof( archivo ))then 
		read (archivo, dato)
	else 
		dato.cod := valorAlto;
end;

procedure actualizarMaestro(var mae:maestro; var det:detalle);
begin
	reset(mae); reset(det);
	read(mae,regm);
	leer(det,regd);
	while(regd.cod<>valorAlto)do
	begin
		while(regd.cod<>regm.cod)do
			read(mae,regm);
		while(regd.cod=regm.cod)do
		begin
			regm.stock_disp:=regm.stock_disp - regd.cv;
			leer(det,regd);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
	end;
	close(det); close(mae);
end;

procedure actualizarMaestroPadre(var mae:maestro; var deta:detalles);
var
	i:integer;
begin
	for i:=1 to 30 do
	begin
		assign(deta[i],'det'+i); //??
		actualizarMaestro(mae,deta[i]);
	end;
end;

procedure generarTexto(var mae:maestro; var info:informacion);
begin
	reset(mae);
	rewrite(info);
	while(not eof(mae))do
	begin
		read(mae,regm);
		if(regm.stock_disp<regm.stock_min)then
		begin
			writeln(info,'nombre: ',regm.nombre);
			writeln(info,'descripcion: ',regm.desc);
			writeln(info,'stock disponible: ',regm.stock_disp);
			writeln(info,'preico unidad: ',regm.precio);
		end;
	end;
	close(mae); close(info);
end;
	

begin
	assign(mae,'maestro.dat');
	assign(info,'Info Stock.txt');
	actualizarMaestroPadre(mae,deta);
	generarTexto(mae,info);
end.
	
	
	
	






