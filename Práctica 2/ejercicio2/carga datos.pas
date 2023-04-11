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

procedure leerMateriaTrue(var mate:materia);
begin
	write('codgo alumno: ');
	readln(mate.cod_alum);
	if(mate.cod_alum<>-1)then
	begin
		write('materia: ');
		readln(mate.nombre_mat);
		write('cursada: ');
		mate.nota_cursada:=true;
		mate.nota_final:=false;
	end;
end;

procedure leerMateriaFalse(var mate:materia);
begin
	write('codgo alumno: ');
	readln(mate.cod_alum);
	if(mate.cod_alum<>-1)then
	begin
		write('materia: ');
		readln(mate.nombre_mat);
		write('cursada: ');
		mate.nota_cursada:=true;
		mate.nota_final:=true;
	end;
end;

procedure mostrarDetalle(var det:detalle);
begin
	assign(det, 'detalle.dat');
	reset(det);
	while (not eof(det))do
	begin
		read(det,regd);
		writeln('codigo: ',regd.cod_alum);
		writeln('materia: ',regd.nombre_mat);
		writeln('cursada: ',regd.nota_cursada);
		writeln('codigo: ',regd.nota_final);
	end;
	close(det);
end;

procedure mostrarMaestro(var mae:maestro);
begin
	assign(mae, 'maestro.dat');
	reset(mae);
	while (not eof(mae))do
	begin
		read(mae,regm);
		writeln('codigo: ',regm.cod_alum);
		writeln('nombre: ',regm.nombre);
		writeln('apellido: ',regm.apellido);
		writeln('cursada: ',regm.cant_cursadas);
		writeln('finales: ',regm.cant_finales);
	end;
	close(mae);
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
	close(mae);
	
	{
	assign(det, 'detalle.dat');
	rewrite(det);
	leerMateriaTrue(regd);
	while(regd.cod_alum<>-1)do
	begin
		write(det,regd);
		leerMateriaTrue(regd);
	end;
	leerMateriaFalse(regd);
	write(det,regd);
	close(det);
	* }
	//mostrarDetalle(det);
	mostrarMaestro(mae);
	
END.

