program creador;

type
	provincia=record
		nombre:string;
		cant_alf:integer;
		cant_enc:integer;
	end;
	
	info_prov=record
		nombre:string;
		codigo:integer;
		cant_alf:integer;
		cant_enc:integer;
	end;
	
	maestro=file of provincia;
	detalle=file of info_prov;
	
procedure crearMaestro();
var
	reg:provincia;
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
		readln(datos,reg.cant_alf,reg.cant_enc);
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;

procedure crearDetalle1();
var
	reg:info_prov;
	arch:detalle;
	datos:text;
begin
	assign(datos,'datosD1.txt');
	//cambiar nombre dependiendo del problema
	assign(arch,'detalle1.dat');
	reset(datos);
	rewrite(arch);
	while(not eof(datos))do
	begin
		//cambiar segun el archivo
		readln(datos,reg.nombre);
		readln(datos,reg.codigo,reg.cant_alf,reg.cant_enc);
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;

procedure crearDetalle2();
var
	reg:info_prov;
	arch:detalle;
	datos:text;
begin
	assign(datos,'datosD2.txt');
	//cambiar nombre dependiendo del problema
	assign(arch,'detalle2.dat');
	reset(datos);
	rewrite(arch);
	while(not eof(datos))do
	begin
		//cambiar segun el archivo
		readln(datos,reg.nombre);
		readln(datos,reg.codigo,reg.cant_alf,reg.cant_enc);
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;


BEGIN
	crearMaestro();
	crearDetalle1();
	crearDetalle2();
END.
