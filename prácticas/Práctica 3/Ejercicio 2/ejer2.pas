program ejer2;

type
	persona=record
		numero:integer;
		nombre:string;
		apellido:string;
		email:string;
		tel:string;
		dni:string;
	end;
	
	archivo= file of persona;
	
procedure leer_registro(var reg:persona);
begin
	with reg do
	begin
		write('Numero de persona: ');
		readln(numero);
		if(numero<>0) then
		begin
			write('Nombre: ');
			readln(nombre);
			write('Apellido: ');
			readln(apellido);
			write('email: ');
			readln(email);
			write('telefono: ');
			readln(tel);
			write('DNI: ');
			readln(dni);
		end;
	end;
end;

procedure crear_archivo(var arch:archivo);
var
	reg:persona;
begin
	leer_registro(reg);
	rewrite(arch);
	while(reg.numero<>0)do
	begin
		write(arch,reg);
		leer_registro(reg);
	end;
	close(arch);
end;

procedure mostrarEliminados(var arch:archivo);
var
	reg:persona;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
			writeln('Numero: ',numero,' |Nombre: ',nombre,' |Apellido: ',apellido,' |Email: ',email,' |Telefono: ',tel,' |DNI: ',dni);
		end;
	end;
	close(arch);
end;

procedure mostrar(var arch:archivo);
var
	reg:persona;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		if(reg.nombre[1]<>'@')then
			with reg do
			begin
				writeln('Numero: ',numero,' |Nombre: ',nombre,' |Apellido: ',apellido,' |Email: ',email,' |Telefono: ',tel,' |DNI: ',dni);
			end;
	end;
	close(arch);
end;

procedure eliminar_logico(var arch:archivo);
varh
	reg:persona;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		if(reg.numero<1000)then //Si cumple la condicion
		begin
			reg.nombre:= '@'+reg.nombre;//Al inicio agrego @
			seek(arch,filepos(arch)-1);//Me posiciono
			write(arch,reg);//Reescribo el registro en el archivo
		end;
	end;
	close(arch);
end;


var
	arch:archivo;
BEGIN
	assign(arch,'maestro.dat');
	//crear_archivo(arch);
	writeln('Todos los archivos');
	mostrarEliminados(arch);
	writeln('Solo los archivos sin borrado Logico');
	eliminar_logico(arch);
	mostrar(arch);
	
END.
