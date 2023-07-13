program Ejer1;
type
	archivo_enteros = file of integer;

procedure mostrarArchivo(var arc:archivo_enteros);
var
	num:integer;
begin
	reset(arc);
	while(not eof(arc))do
	begin
		read(arc,num);
		writeln(num);
	end;
	close(arc);
end;

var
	enteros: archivo_enteros;
	nombre_fisico: string[20];
    n:integer;
begin
	write('Ingrese nombre del archivo: ');
	readln(nombre_fisico);
	assign(enteros, nombre_fisico);
	rewrite(enteros);
	write('ingrese un entero o 30000 para finalizar: ');
	readln(n);
	while(n<>30000) do begin
		write(enteros,n);
		write('ingrese un entero o 30000 para finalizar: ');
		readln(n);
	end;
	close(enteros);
	//recorrer(enteros);
    //readln(n);
    mostrarArchivo(enteros);
end.
