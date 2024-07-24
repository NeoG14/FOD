program ejer2;

const valorAlto=9999;

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
	
procedure leer(var arch:detalle; var reg:det_alumno);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.codigo:=valorAlto;
end;

procedure mostrarMaestro(var arch:maestro);
var
	reg:alumno;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Codigo: ',codigo,' |Apellido: ',apellido,' |Nombre: ',nombre,' |Cursadas: ',cursadas,' |Finales: ',finales);
		end;
	end;
	close(arch);
end;

procedure mostrarDetalle(var arch:detalle);
var
	reg:det_alumno;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Codigo: ',codigo,' |Materia: ',materia);
		end;
	end;
	close(arch);
end;
	
procedure actualizarMaestro(var mae:maestro;var det:detalle);
var
	regd:det_alumno;
	regm:alumno;
begin
	reset(mae); reset(det);
	leer(det,regd);
	while( (not eof(mae)) and (regd.codigo<>valorAlto) )do
	begin
		read(mae,regm);
		while(regm.codigo<>regd.codigo)do
			read(mae,regm);
		while(regm.codigo=regd.codigo)do
		begin
			if(regd.materia=' final')then
			begin
				regm.finales+=1;
				regm.cursadas-=1;
			end
			else //Asumo que si no aprobo el final entonces aprobo la cursada
				regm.cursadas+=1;
			leer(det,regd);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
	end;
	close(det); close(mae);
end;

var
	mae:maestro;
	det:detalle;
	
BEGIN
	assign(mae,'maestro.dat');
	assign(det,'detalle.dat');
	writeln('Maestro');
	mostrarMaestro(mae);
	writeln('Detalle');
	mostrarDetalle(det);
	writeln('#####Actualizacion#####');
	actualizarMaestro(mae,det);
	writeln('Maestro Actualizado');
	mostrarMaestro(mae);
	
END.
