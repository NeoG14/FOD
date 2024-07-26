program creador;

uses SysUtils;

const 
	valorAlto=9999;
	N=5;

type
	date=record
		dia:integer;
		mes:integer;
		anio:integer;
	end;
	
	logs=record
		codigo:integer;
		fecha:date;
		tiempo:real;
	end;
	
	detalle=file of logs;
	
	vec_datos=array [1..N] of text;
	vec_det=array [1..N] of detalle;

procedure crearDetalles();
var
	reg:logs;
	i:integer;
	datos:vec_datos;
	v_det:vec_det;
begin
	for i:=1 to N do
	begin	
		assign(datos[i],'det'+ IntToStr(i) +'.txt');
		//cambiar nombre dependiendo del problema
		assign(v_det[i],'detalle'+ IntToStr(i) +'.dat');
		reset(datos[i]);
		rewrite(v_det[i]);
		while(not eof(datos[i]))do
		begin
			//cambiar segun el archivo
			readln(datos[i],reg.codigo,reg.tiempo);
			readln(datos[i],reg.fecha.dia,reg.fecha.mes,reg.fecha.anio);
			write(v_det[i],reg);
		end;
	end;
	for i:=1 to N do
	begin
	close(datos[i]);
	close(v_det[i]);
	end;
end;


BEGIN
	crearDetalles();
END.
