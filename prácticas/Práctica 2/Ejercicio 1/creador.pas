program creador;

type
	comision=record
		codigo:integer;
		nombre:string;
		monto:real;
	end;
	
	comisiones=file of comision;
	
procedure crearArchivo();
var
	reg:comision;
	arch:comisiones;
	datos:text;
begin
	assign(datos,'datos.txt');
	//cambiar nombre dependiendo del problema
	assign(arch,'comisiones.dat');
	reset(datos);
	rewrite(arch);
	while(not eof(datos))do
	begin
		readln(datos,reg.codigo,reg.monto,reg.nombre); //cambiar segun el archivo
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;

BEGIN
	crearArchivo();
	
END.
