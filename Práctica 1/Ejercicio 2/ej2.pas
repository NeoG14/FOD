program ejer2;
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

procedure recorrer(var enteros:archivo_enteros);
var n:integer; total:real; cant:integer;
begin
	total:=0;
	cant:=0;
	reset(enteros);
	while not eof(enteros) do
	begin
		read(enteros,n);
		if(n<1500) then 
			cant:=cant+1;
		total+=n;
	end;
	writeln('La cantidad de numeros menores a 1500 es: ',cant);
	writeln('el promedio de numeros es: ',(total / filesize(enteros)):0:2);
	close(enteros);
end;

var
	archivo:archivo_enteros;
	nombre:string;

BEGIN
	write('Ingrese nombre del archivo a procesar: ');
	readln(nombre);
	assign(archivo,nombre);
	mostrarArchivo(archivo);
	recorrer(archivo);
END.

