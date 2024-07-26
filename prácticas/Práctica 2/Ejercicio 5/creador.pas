program creador;

uses SysUtils;

const 
	valorAlto=9999;
	N=5;

type
	producto=record
		codigo:integer;
		nombre:string;
		desc:string;
		stock_act:integer;
		stock_min:integer;
		precio:real;
	end;
	
	info_prod=record
		codigo:integer;
		cv:integer;
	end;
	
	maestro=file of producto;
	detalle=file of info_prod;
	
	vec_datos=array [1..N] of text;
	vec_det=array [1..N] of detalle;
	
procedure crearMaestro();
var
	reg:producto;
	arch:maestro;
	datos:text;
begin
	assign(datos,'datosM.txt');
	//cambiar nombre dependiendo del problema
	assign(arch,'maestro.dat');
	reset(datos);
	rewrite(arch);
	while(not eof(datos))do
	begin
		//cambiar segun el archivo
		readln(datos,reg.nombre);
		readln(datos,reg.desc);
		readln(datos,reg.codigo,reg.stock_act,reg.stock_min,reg.precio);
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;

procedure crearDetalles();
var
	reg:info_prod;
	i:integer;
	datos:vec_datos;
	v_det:vec_det;
begin
	for i:=1 to N do
	begin	
		assign(datos[i],'datosD'+ IntToStr(i) +'.txt');
		//cambiar nombre dependiendo del problema
		assign(v_det[i],'detalle'+ IntToStr(i) +'.dat');
		reset(datos[i]);
		rewrite(v_det[i]);
		while(not eof(datos[i]))do
		begin
			//cambiar segun el archivo
			readln(datos[i],reg.codigo,reg.cv);
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
	crearMaestro();
	crearDetalles();
END.
