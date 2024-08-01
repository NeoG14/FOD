program creador;

type
	prestamo=record
		cod_sucursal:integer;
		dni:longint;
		num_prestamo:integer;
		fecha:integer;
		monto:real;
	end;
	
	maestro=file of prestamo;

	
procedure crearMaestro();
var
	reg:prestamo;
	arch:maestro;
	datos:text;
begin
	assign(datos,'datos.txt');
	//cambiar nombre dependiendo del problema
	assign(arch,'maestro.dat');
	reset(datos);
	rewrite(arch);
	while(not eof(datos))do
	begin
		//cambiar segun el archivo
		readln(datos,reg.cod_sucursal,reg.dni,reg.num_prestamo,reg.fecha,reg.monto);
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;

BEGIN
	crearMaestro();
END.
