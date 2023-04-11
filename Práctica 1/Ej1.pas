program Ejer1;
type
	archivo_enteros = file of integer;
	
procedure recorrer(var enteros:archivo_enteros);
var n:integer; prom:real; cant_prom:integer; cant:integer;
begin
	prom:=0;
	cant_prom:=0;
	cant:=0;
	reset(enteros);
	while not eof(enteros) do
	begin
		read(enteros,n);
		writeln(n);
		if(n<1500) then 
			cant:=cant+1;
		prom:=prom+n;
		cant_prom:=cant_prom+1;
	end;
	writeln('La cantidad de numeros menores a 1500 es: ',cant);
	writeln('el promedio de numeros es: ',(prom / cant_prom):0:2);
	close(enteros);
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
	write('ingrese un entero o 3000 para finalizar: ');
	readln(n);
	while(n<>3000) do begin
		write(enteros,n);
		write('ingrese un entero o 3000 para finalizar: ');
		readln(n);
	end;
	close(enteros);
	recorrer(enteros);
    readln(n);
end.
