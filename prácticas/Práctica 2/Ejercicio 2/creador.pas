program creador;

type
	alumno=record
		codigo:integer;
		apellido:string;
		nombre:string;
		cursadas:integer;
		finales:integer;
	end;
	
	det_alumno=record
		codigo:integer;
		materia:string;
	end;
	
	maestro=file of alumno;
	detalle=file of det_alumno;
	
procedure crearMaestro();
var
	reg:alumno;
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
		readln(datos,reg.codigo,reg.cursadas,reg.finales);
		readln(datos,reg.nombre);
		readln(datos,reg.apellido); 
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;

procedure crearDetalle();
var
	reg:det_alumno;
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
		readln(datos,reg.codigo,reg.materia);
		write(arch,reg);
	end;
	close(arch);
	close(datos);
end;

BEGIN
	crearMaestro();
	crearDetalle();
END.
