program ejercicio2;

type
	asistente=record
		num:integer;
		apellido:string;
		nombre:string;
		email:string;
		tel:string;
		dni:string;
	end;
	
	archivo = file of asistente;
	
procedure leer(var reg:asistente);
begin
	write('ingrese numero de asistente'); readln(reg.num);
	if(reg.num<>-1)then
	begin
		write('ingrese apellido: '); readln(reg.apellido);
		write('ingrese nombre: '); readln(reg.nombre);
		write('ingrese email: '); readln(reg.email);
		write('ingrese tel: '); readln(reg.tel);
		write('ingrese dni: '); readln(reg.dni);
	end;
end;

procedure mostrarArchivo(var arc:archivo);
var
	reg:asistente;
begin
	reset(arc);
	while(not eof(arc)) do
	begin
		read(arc,reg);
		with reg do begin
			writeln('NUMERO ASISTENTE: ',num);
			writeln('APELLIDO: ',apellido);
			writeln('NOMBRE: ',nombre);
			writeln('EMAIL: ',email);
			writeln('TELEFONO: ',tel);
			writeln('DNI: ',dni);
			writeln('---------------------');
		end;
	end;
	close(arc);
end;

procedure mostrarArchivo2(var arc:archivo);
var
	reg:asistente;
begin
	reset(arc);
	while(not eof(arc)) do
	begin
		read(arc,reg);
		if(reg.apellido[1]<>'@')then
		begin
			with reg do begin
				writeln('NUMERO ASISTENTE: ',num);
				writeln('APELLIDO: ',apellido);
				writeln('NOMBRE: ',nombre);
				writeln('EMAIL: ',email);
				writeln('TELEFONO: ',tel);
				writeln('DNI: ',dni);
				writeln('---------------------');
			end;
		end;
	end;
	close(arc);
end;

procedure crearArchivo(var arc:archivo);
var
	reg:asistente;
begin
	rewrite(arc);
	leer(reg);
	while(reg.num<>-1) do
	begin
		write(arc,reg);
		leer(reg);
	end;
	close(arc);
end;

procedure eliminarMenoresAMil(var arc:archivo);
var
	reg:asistente;
begin
	reset(arc);
	while(not eof(arc)) do
	begin
		read(arc,reg);
		if(reg.num<1000) then
		begin
			reg.apellido:= '@'+reg.apellido;
			seek(arc,filepos(arc)-1);
			write(arc,reg);
		end;
	end;
	close(arc);
end;

procedure desEliminarMenoresAMil(var arc:archivo);
var
	reg:asistente;
begin
	reset(arc);
	while(not eof(arc)) do
	begin
		read(arc,reg);
		if(reg.apellido[1]='@')then
		begin
			reg.apellido:= copy(reg.apellido,2,99);
			seek(arc,filepos(arc)-1);
			write(arc,reg);
		end;
	end;
	close(arc);
end;

var 
	arc:archivo;


BEGIN
	assign(arc,'asistentes.dat');
	//crearArchivo(arc);
	//mostrarArchivo(arc);
	writeln('#############SINELIMINADOS#############');
	mostrarArchivo2(arc);

	
	
END.

