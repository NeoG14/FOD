program creador;

uses SysUtils;

const 
	valorAlto=9999;
	N=5;

type
	persona=record
		numero:integer;
		nombre:string;
		apellido:string;
		email:string;
		tel:string;
		dni:string;
	end;
	
	maestro= file of persona;


procedure crearMaestro();
var
	reg:persona;
	mae:maestro;
	datos:text;
begin
	assign(datos,'maestro.txt');
	//cambiar nombre dependiendo del problema
	assign(mae,'maestro.dat');
	reset(datos);
	rewrite(mae);
	while(not eof(datos))do
	begin
		//cambiar segun el archivo
		readln(datos,reg.numero);
		readln(datos,reg.nombre);
		readln(datos,reg.apellido);
		readln(datos,reg.email);
		readln(datos,reg.tel);
		readln(datos,reg.dni);
		write(mae,reg);
	end;
	close(mae);
end;



BEGIN
	crearMaestro();
END.
