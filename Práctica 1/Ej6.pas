program ejer6;
type
	celular = record
		cod:integer;
		nombre:string;
		descripcion:string;
		marca:string;
		precio:real;
		stock_min:integer;
		stock_disp:integer;
	end;
	
	arch_celular = file of celular;
	text_celular = text;

//proceso leer para no salta el ultimo
procedure leer (var archivo:arch_celular; var dato:celular);
begin
	if (not eof(archivo))then 
		read (archivo,dato)
	else 
		dato.nombre := 'zzzz';
end;
	
//leer celular
procedure leerCelular(var cel:celular);
begin
	write('codigo: ');
	readln(cel.cod);
	if(cel.cod<>-1)then
	begin
		write('nombre: ');
		readln(cel.nombre);
		write('descripcion: ');
		readln(cel.descripcion);
		write('marca: ');
		readln(cel.marca);
		write('precio: ');
		readln(cel.precio);
		write('stock minimo: ');
		readln(cel.stock_min);
		write('stock disponible: ');
		readln(cel.stock_disp);
	end;
end;
	
//proceso para ver el archivo bin
procedure mostrarDatos(var celulares:arch_celular);
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
		writeln('descripcion: ',cel.descripcion);
		writeln('marca: ',cel.marca);
		writeln('precio: ',cel.precio:0:2);
		writeln('stock_min: ',cel.stock_min);
		writeln('stock_disp: ',cel.stock_disp);
		writeln(' ');
	end;
	close(celulares);
end;
	
//incisoa a
procedure crearArchivoCelulares(var celulares:arch_celular; var celular_text:text_celular);
var
	nombre_fisico,nombre,descripcion,marca:string;
	cod,stock_min,stock_disp:integer;
	precio:real;
	c:celular;
begin
	write('ingrese nombre del archivo: ');
	readln(nombre_fisico);
	assign(celulares,nombre_fisico);
	rewrite(celulares);
	assign(celular_text,'export.txt');
	reset(celular_text);
	while not eof(celular_text) do
	begin
		readln(celular_text,cod,precio,marca);
		readln(celular_text,stock_disp,stock_min,descripcion);
		readln(celular_text,nombre);
		c.cod:=cod;
		c.precio:=precio;
		c.marca:=marca;
		c.stock_disp:=stock_disp;
		c.stock_min:=stock_min;
		c.descripcion:=descripcion;
		c.nombre:=nombre;
		write(celulares,c);
	end;
	close(celulares);
	close(celular_text);
end;
	
//inciso b
procedure listarMenorAStock(var celulares:arch_celular);
var
	cel:celular;
begin
	assign(celulares,'celulares.dat');
	reset(celulares);
	while not eof(celulares) do
	begin
		read(celulares,cel);
		if(cel.stock_disp<cel.stock_min)then
		begin
			writeln('codigo: ',cel.cod);
			writeln('nombre: ',cel.nombre);
			writeln('descripcion: ',cel.descripcion);
			writeln('marca: ',cel.marca);
			writeln('precio: ',cel.precio:0:2);
			writeln('stock minimo: ',cel.stock_min);
			writeln('stock disponible: ',cel.stock_disp);
			writeln('-------------------------');
		end;
	end;
	close(celulares);
end;

//inciso c
procedure listarContaisDesc(var celulares:arch_celular);
var
	cel:celular;
	desc:string;
	aux:integer;
begin
	write('ingrese parte de una descrpcion: ');
	readln(desc);
	assign(celulares,'celulares.dat');
	reset(celulares);
	while not eof(celulares) do
	begin
		read(celulares,cel);
		aux:=pos(desc,cel.descripcion);
		if(aux>0)then
		begin
			writeln('codigo: ',cel.cod);
			writeln('nombre: ',cel.nombre);
			writeln('descripcion: ',cel.descripcion);
			writeln('marca: ',cel.marca);
			writeln('precio: ',cel.precio:0:2);
			writeln('stock minimo: ',cel.stock_min);
			writeln('stock disponible: ',cel.stock_disp);
			writeln('-------------------------');
		end;
	end;
	close(celulares);
end;

//inciso d
procedure exportarCelulares(var celulares:arch_celular);
var
	celu_text:text_celular;
	cel:celular;
begin
	assign(celulares,'celulares.dat');
	reset(celulares);
	assign(celu_text,'export.txt');
	rewrite(celu_text);
	while not eof(celulares)do
	begin
		read(celulares,cel);
		writeln(celu_text,cel.cod,' ',cel.precio:0:2,' ',cel.marca);
		writeln(celu_text,cel.stock_disp,' ',cel.stock_min,' ',cel.descripcion);
		writeln(celu_text,cel.nombre);
	end;
	close(celulares);
	close(celu_text);
end;
//inciso 6a
procedure agregarCelular(var celulares:arch_celular);
var
	cel:celular;
begin
	assign(celulares,'celulares.dat');
	reset(celulares);
	leerCelular(cel);
	while(cel.cod<>-1)do
	begin
		seek(celulares,filesize(celulares));
		write(celulares,cel);
		leerCelular(cel);
	end;
	close(celulares);
end;

//inciso 6b
procedure modificarStock(var celulares:arch_celular);
var
	nombre:string;
	cel:celular;
begin
	write('ingrese nombre del celular a modificar: ');
	readln(nombre);
	assign(celulares,'celulares.dat');
	reset(celulares);
	leer(celulares,cel);
	while (cel.nombre<>'zzzz') and (cel.nombre <> nombre)do
	begin
		leer(celulares,cel);
	end;
	if(cel.nombre=nombre)then
	begin
		write('ingrese stock disponible: ');
		readln(cel.stock_disp);
		seek(celulares,filepos(celulares)-1);
		write(celulares,cel);
	end
	else
		write('no se encontro el ceular con el nombre: ',nombre);
	close(celulares);
end;

//inciso 6c
procedure exportarSinStock(var celulares:arch_celular);
var
	celu_text:text_celular;
	cel:celular;
begin
	assign(celulares,'celulares.dat');
	reset(celulares);
	assign(celu_text,'SinStock.txt');
	rewrite(celu_text);
	while not eof(celulares)do
	begin
		read(celulares,cel);
		if(cel.stock_disp=0)then
		begin
			writeln(celu_text,'Codigo: ',cel.cod);
			writeln(celu_text,'Precio: ',cel.precio:0:2);
			writeln(celu_text,'Marca: ',cel.marca);
			writeln(celu_text,'Stock disponible: ',cel.stock_disp);
			writeln(celu_text,'Stock minimo: ',cel.stock_min);
			writeln(celu_text,'Descripciion: ',cel.descripcion);
			writeln(celu_text,'Nombre: ',cel.nombre);
		end
	end;
	close(celulares);
	close(celu_text);
end;

var
	celulares:arch_celular;
	texto_celulares:text_celular;
BEGIN
	//crearArchivoCelulares(celulares,texto_celulares);
	//mostrarDatos(celulares);
	//listarMenorAStock(celulares);
	//listarContaisDesc(celulares);
	//exportarCelulares(celulares);
	//agregarCelular(celulares);
	//modificarStock(celulares);
	//exportarSinStock(celulares);
END.
