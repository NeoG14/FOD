program cargador;

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
	
VAR
	mae:maestro;
	det:detalle;
	regm:alumno;
	regd:materia;
	
procedure leerAlumno(var alum:alumno);
begin
	write('codgo alumno: ');
	readln(alum.cod_alum);
	if(alum.cod_alum<>-1)then
	begin
		write('nombre: ');
		readln(alum.nombre);
		write('apellido: ');
		readln(alum.apellido);
		write('cursadas: ');
		readln(alum.cant_cursadas);
		write('finales: ');
		readln(alum.cant_finales);
	end;
end;


BEGIN
	assign(mae, 'maestro.dat');
	rewrite(mae);
	leerAlumno(regm);
	while(regm.cod_alum<>-1)do
	begin
		write(mae,regm);
		leerAlumno(regm);
	end;
	
END.

