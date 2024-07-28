program creador;

uses SysUtils;

const 
	valorAlto=9999;
	N=5;

type
	cliente=record
		codigo:integer;
		nombre:string;
		apellido:string;
	end;
	

	venta=record
		cli:cliente;
		anio:integer;
		dia:integer;
		mes:integer;
		monto:real;
	end;
	
	ventas = file of venta;


procedure crearMaestro();
var
	reg:venta;
	mae:ventas;
	datos:text;
begin
	assign(datos,'datos.txt');
	//cambiar nombre dependiendo del problema
	assign(mae,'maestro.dat');
	reset(datos);
	rewrite(mae);
	while(not eof(datos))do
	begin
		//cambiar segun el archivo
		readln(datos,reg.cli.codigo);
		readln(datos,reg.cli.nombre);
		readln(datos,reg.cli.apellido);
		readln(datos,reg.anio,reg.mes,reg.dia,reg.monto);
		write(mae,reg);
	end;
	close(mae);
end;



BEGIN
	crearMaestro();
END.
