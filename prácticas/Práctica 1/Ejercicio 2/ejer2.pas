program ejer2;

type
	arch_enteros = file of integer;
	
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
	
procedure informar(var arch:arch_enteros; nombre_logico:string);
var
	num,suma,cant,cant_menores:integer;
begin
	suma:=0;
	cant:=0;
	cant_menores:=0;
	reset(arch);
	while(not eof(arch)) do
	begin
		read(arch,num);
		if(num<1500) then
			cant_menores+=1;
		suma+=num;
		cant+=1;
	end;
	writeln('La cantidad de numeros menores a 1500 es: ',cant_menores);
	writeln('El promedio es: ',(suma/cant):0:2);
	close(arch);
end;

var
	arch:arch_enteros;
	nombre_logico:string;
begin
	write('Ingrese nombre del archivo: ');
	readln(nombre_logico);
	assign(arch,nombre_logico);
	//mostrarArchivo(arch);
	informar(arch,nombre_logico);
end.
