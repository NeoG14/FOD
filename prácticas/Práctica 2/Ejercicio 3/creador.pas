program creador;

type
	producto=record
		codigo:integer;
		nombre:string;
		precio:real;
		stock_act:integer;
		stock_min:integer;
	end;
	
	venta=record
		codigo:integer;
		cv:integer;
	end;
	
	maestro=file of producto;
	detalle=file of venta;
	
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
		readln(datos,reg.codigo,reg.stock_act,reg.stock_min,reg.precio);
		readln(datos,reg.nombre);
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;

procedure crearDetalle();
var
	reg:venta;
	arch:detalle;
	datos:text;
begin
	assign(datos,'datosD.txt');
	//cambiar nombre dependiendo del problema
	assign(arch,'detalle.dat');
	reset(datos);
	rewrite(arch);
	while(not eof(datos))do
	begin
		//cambiar segun el archivo
		readln(datos,reg.codigo,reg.cv);
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;


BEGIN
	crearMaestro();
	crearDetalle();
END.
