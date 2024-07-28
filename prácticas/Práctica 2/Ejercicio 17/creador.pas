program creador;

uses SysUtils;

const 
	valorAlto=9999;
	N=5;

type
	casos=record
		cod_loc:integer;
		nombre_loc:string;
		cod_muni:integer;
		nombre_muni:string;
		cod_hosp:integer;
		nombre_hosp:string;
		fecha:string;
		cantidad:integer;
	end;
		
	maestro=file of casos;


procedure crearMaestro();
var
	reg:casos;
	mae:maestro;
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
		readln(datos,reg.nombre_loc);
		readln(datos,reg.cod_loc);
		readln(datos,reg.nombre_muni);
		readln(datos,reg.cod_muni);
		readln(datos,reg.nombre_hosp);
		readln(datos,reg.cod_hosp);
		readln(datos,reg.cantidad);
		write(mae,reg);
	end;
	close(mae);
end;



BEGIN
	crearMaestro();
END.

