program pruebatexto;
type
	celular=record
		cod:integer;
		nombre:string;
		marca:string;
		descripcion:string;
		stock:integer;
	end;
	
	arch_bin = file of celular;
	arch_txt = text;
	
procedure leerCelular(var cel:celular);
begin
	write('codigo: ');
	readln(cel.cod);
	if(cel.cod<>-1)then
	begin
		write('nombre: ');
		readln(cel.nombre);
		write('marca: ');
		readln(cel.marca);
		write('descripcion: ');
		readln(cel.descripcion);
		write('stock: ');
		readln(cel.stock);
	end;
end;

procedure crearArchivo(var celulares:arch_bin);
var
	cel:celular; nombre:string;
begin
	write('ingrese nombre del archivo: ');
	readln(nombre);
	assign(celulares,nombre);
	rewrite(celulares);
	leerCelular(cel);
	while(cel.cod<>-1)do
	begin
		write(celulares,cel);
		leerCelular(cel);
	end;
	close(celulares);
end;

procedure mostrarDatos(var celulares:arch_bin);
var
	cel:celular;
begin
	assign(celulares,'celulares.dat');
	reset(celulares);
	while not eof(celulares)do
	begin
		read(celulares,cel);
		writeln('codigo: ',cel.cod);
		writeln('nombre: ',cel.nombre);
		writeln('marca: ',cel.marca);
		writeln('descripcion: ',cel.descripcion);
		writeln('stock: ',cel.stock);
		writeln(' ');
	end;
	close(celulares);
end;

VAR
	celulares:arch_bin;
	texto_celulares:arch_txt;
	cel:celular;
	
BEGIN
	//crearArchivo(celulares);
	mostrarDatos(celulares);
	assign(celulares,'celulares.dat');
	reset(celulares);
	assign(texto_celulares,'celulares.txt');
	rewrite(texto_celulares);
	while not eof(celulares)do
	begin
		read(celulares,cel);
		writeln(texto_celulares,cel.cod,' ',cel.marca);
		writeln(texto_celulares,cel.stock);
		writeln(texto_celulares,cel.descripcion);
	end;
	close(celulares);
	close(texto_celulares);
END.

