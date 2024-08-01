program creador;

uses SysUtils;

const 
	valorAlto='ZZZZ';
	N=3;

type
	carrera=record
		dni:string;
		apellido:string;
		nombre:string;
		kms:real;
		gano:integer;
	end;
	
	archivo=file of carrera;
	archivos = array[1..N] of text;
	registros = array[1..N] of archivo;

procedure crearDetalles();
var
	reg:carrera;
	i:integer;
	datos:archivos;
	v_det:registros;
begin
	for i:=1 to N do
	begin	
		assign(datos[i],'det'+ IntToStr(i) +'.txt');
		//cambiar nombre dependiendo del problema
		assign(v_det[i],'det'+ IntToStr(i) +'.dat');
		reset(datos[i]);
		rewrite(v_det[i]);
		while(not eof(datos[i]))do
		begin
			//cambiar segun el archivo
			readln(datos[i],reg.dni);
			readln(datos[i],reg.nombre);
			readln(datos[i],reg.apellido);
			readln(datos[i],reg.kms,reg.gano);
			write(v_det[i],reg);
		end;
	end;
	for i:=1 to N do
	begin
	close(datos[i]);
	close(v_det[i]);
	end;
end;

procedure mostrar_Archivo(var arch:archivo);
var
	reg:carrera;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		writeln('DNI: ',reg.dni,' |Nombre: ',reg.nombre,' |Apellido: ',reg.apellido,' |Kms: ',reg.kms:0:2,' |Gano: ',reg.gano);
	end;
	close(arch);
end;

var
	det1,det2,det3,mae:archivo;
BEGIN
	//crearDetalles();
	assign(det1,'det1.dat');
	assign(det2,'det2.dat');
	assign(det3,'det3.dat');
	assign(mae,'maestro.dat');
	writeln('Detalle 1');
	mostrar_Archivo(det1);
	writeln('Detalle 2');
	mostrar_Archivo(det2);
	writeln('Detalle 3');
	mostrar_Archivo(det3);
	writeln('MAESTRO');
	mostrar_Archivo(mae);
END.

