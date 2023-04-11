program Ejercicio2;
const valorAlto=9999;
type
	alumno=record
		cod_alum:integer;
		nombre:string;
		apellido:string;
		cant_cursadas:integer;
		cant_finales:integer;
	end;
	
	materia=record
		cod_alum:integer;
		nombre_mat:string;
		nota_cursada:boolean;
		nota_final:boolean;
	end;
	
	maestro=file of alumno;
	detalle=file of materia;
	listado=text;
	
VAR
	mae:maestro;
	det:detalle;
	regm:alumno;
	regd:materia;
	
procedure leer(var archivo:detalle; var dato:materia);
begin
	if(not eof(archivo)) then
		read(archivo,dato)
	else
		dato.cod_alum:=valorAlto;
end;
	
//inciso a
procedure actualizarMaestro(var mae:maestro; var det:detalle);
begin
	reset(mae); reset(det);
	read(mae,regm);
	leer(det,regd);
	while(regd.cod_alum<>valorAlto)do
	begin
		while(regd.cod_alum<>regm.cod_alum)do
			read(mae,regm);
		while(regd.cod_alum=regm.cod_alum)do
		begin
			if(regd.nota_cursada)then
				regm.cant_cursadas:=regm.cant_cursadas+1;
			if(regd.nota_final)then
				regm.cant_finales:=regm.cant_finales+1;
			leer(det,regd);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
	end;
	close(det); close(mae);
end;

//inciso b
procedure crearListadoAlumnos(var mae:maestro);
var
	lista:listado;
begin
	assign(lista,'Listado Alumnos.txt');
	rewrite(lista);
	reset(mae);
	while(not eof(mae))do
	begin
		read(mae,regm);
		if( (regm.cant_cursadas-4) > regm.cant_finales)then
		begin
			writeln(lista,'codigo alumno: ',regm.cod_alum);
			writeln(lista,'nombre: ',regm.nombre,' ',regm.apellido);
			writeln(lista,'cantidad cursadas: ',regm.cant_cursadas);
			writeln(lista,'cantidad finales: ',regm.cant_finales);
		end;
	end;
	close(mae); close(lista);
end;

BEGIN
	assign(mae, 'maestro.dat');
	assign(det, 'detalle.dat');
	actualizarMaestro(mae,det);
	crearListadoAlumnos(mae);
END.

