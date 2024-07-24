{1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
archivo debe ser proporcionado por el usuario desde teclado.}
program ejer1;
type
	enteros = file of integer;
	arch_enteros = enteros;
	
procedure mostrarArchivo(var arch:arch_enteros);
var
	num:integer;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,num);
		writeln('Numero: ',num);
	end;
	close(arch);
end;
	
var
	nombre:string;
	num:integer;
	arch:arch_enteros;
begin
	write('ingrese nombre del archivo: ');
	readln(nombre);
	assign(arch,nombre);
	rewrite(arch);
	write('Ingrese un numero: ');
	readln(num);
	while(num<>30000) do
	begin
		write(arch,num);
		write('Ingrese un numero: ');
		readln(num);
	end;
	close(arch);
	mostrarArchivo(arch);
end.
