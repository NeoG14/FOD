program ejer6;
uses SysUtils;
const valorAlto=9999;

type
	celular=record
		codigo:integer;
		nombre:string;
		desc:string;
		marca:string;
		precio:real;
		stock_min:integer;
		stock_disp:integer;
	end;
	arch_cel=file of celular;
	texto_cel=text;
	
procedure leer(var archivo:arch_cel; var reg:celular);
begin
	if(not eof(archivo))then
		read(archivo,reg)
	else
		reg.codigo:=valorAlto;
end;

	
procedure leer_registro(var reg:celular);
begin
	with reg do
	begin
		write('Codigo: ');
		readln(codigo);
		write('Nombre: ');
		readln(nombre);
		write('Descripcion: ');
		readln(desc);
		write('Marca: ');
		readln(marca);
		write('precio: ');
		readln(precio);
		write('stock Minimo: ');
		readln(stock_min);
		write('stock Disponible: ');
		readln(stock_disp);
	end
end;
	
procedure crear_archivo(var celulares:texto_cel; var arch:arch_cel);
var
	reg:celular;
	nombre:string;
begin
	write('Ingrese nombre para el archivo: ');
	readln(nombre);
	assign(arch,nombre);
	rewrite(arch);
	reset(celulares);
	while(not eof(celulares))do
	begin
		readln(celulares,reg.codigo,reg.precio,reg.marca);
		readln(celulares,reg.stock_disp,reg.stock_min,reg.desc);
		readln(celulares,reg.nombre);
		write(arch,reg);
	end;
	close(celulares);
	close(arch);
end;

procedure listar_sin_stock(var arch:arch_cel);
var
	reg:celular;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		if(reg.stock_disp<reg.stock_min)then
		begin
			writeln('Codigo: ',reg.codigo,'| Nombre: '+reg.nombre+'| Descripcion: '+reg.desc+'| Marca: '+reg.marca);
			writeln('Stock Minimo: ',reg.stock_min,'| Stock Disponible: ',reg.stock_disp,'| Precio: ',reg.precio:0:2);
		end;	
	end;
	close(arch);
end;

procedure listar_descripcion(var arch:arch_cel);
var
	reg:celular;
	cadena:string;
begin
	write('Ingrese cadena a buscar: ');
	readln(cadena);
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		if( Pos(cadena,reg.desc)>0)then
		begin
			writeln('Codigo: ',reg.codigo,'| Nombre: '+reg.nombre+'| Descripcion: '+reg.desc+'| Marca: '+reg.marca);
			writeln('Stock Minimo: ',reg.stock_min,'| Stock Disponible: ',reg.stock_disp,'| Precio: ',reg.precio:0:2);
		end;	
	end;
	close(arch);
end;

procedure mostrar_archivo(var arch:arch_cel);
var 
	reg:celular;
begin
	reset(arch);
	while(not eof(arch)) do
	begin
		read(arch,reg);
		writeln('Codigo: ',reg.codigo,'| Nombre: '+reg.nombre+'| Descripcion: '+reg.desc+'| Marca: '+reg.marca);
		writeln('Stock Minimo: ',reg.stock_min,'| Stock Disponible: ',reg.stock_disp,'| Precio: ',reg.precio:0:2);
	end;
	close(arch);
end;

procedure exportar_txt(var arch:arch_cel);
var
	reg:celular;
	cel_txt:texto_cel;
begin
	reset(arch);
	assign(cel_txt,'celulares2.txt');
	rewrite(cel_txt);
	while(not eof(arch))do
	begin
		read(arch,reg);
		writeln(cel_txt,reg.codigo,' ',reg.precio:0:2,' ',reg.marca);
		writeln(cel_txt,reg.stock_disp,' ',reg.stock_min,' ',reg.desc);
		writeln(cel_txt,reg.nombre);
	end;
	close(cel_txt);
	close(arch);
end;

procedure agregar_celular(var arch:arch_cel);
var
	reg:celular;
	i:integer;
	n:integer;
begin
	writeln('Cuantos celulares deseas agregar: ');
	readln(n);
	reset(arch);
	for i:=1 to n do
	begin
		leer_registro(reg);
		seek(arch,filesize(arch));
		write(arch,reg);
	end;
	close(arch);
end;

procedure modificar_stock(var arch:arch_cel);
var
	reg:celular;
	nombre:string;
begin
	write('Ingrese el nombre del celular a modificar: ');
	readln(nombre);
	reset(arch);
	leer(arch,reg);
	while( (reg.codigo<>valorAlto) and (reg.nombre<>nombre) )do
	begin
		leer(arch,reg);
	end;
	
	if(reg.codigo<>valorAlto)then
	begin
		write('Ingrese nuevo stock disponible: ');
		readln(reg.stock_disp);
		write('Ingrese nuevo stock minimo: ');
		readln(reg.stock_min);
		seek(arch,filepos(arch)-1);
		write(arch,reg);
	end;
	close(arch);
end;

procedure exportar_sin_stock(var arch:arch_cel);
var
	reg:celular;
	celus:texto_cel;
begin
	reset(arch);
	assign(celus,'SinStock.txt');
	rewrite(celus);
	leer(arch,reg);
	while(reg.codigo<>valorAlto)do
	begin
		if(reg.stock_disp=0)then
		begin
			writeln(celus,reg.codigo,' ',reg.precio:0:2,' ',reg.marca);
			writeln(celus,reg.stock_disp,' ',reg.stock_min,' ',reg.desc);
			writeln(celus,reg.nombre);
		end;
		leer(arch,reg);
	end;
	close(celus);
	close(arch);
end;

procedure menu(var celulares:texto_cel;var arch:arch_cel);
var
	op:integer;
begin
	writeln('Seleccione una opcion:');
	writeln('1-Crear Archivo');
	writeln('2-Mostrar archivo');
	writeln('3-lista elementos con stock menor al minimo');
	writeln('4-Listar cuya descripcion contenga una cadena');
	writeln('5-Exportar datos a txt');
	writeln('6-Agregar celulares');
	writeln('7-Modificar Stock');
	writeln('8-Exportar a txt celulares sin Stock');
	writeln('0- Salir');
	readln(op);
	while(op<>0)do
	begin
		case op of
			1: crear_archivo(celulares,arch);
			2: mostrar_archivo(arch);
			3: listar_sin_stock(arch);
			4: listar_descripcion(arch);
			5: exportar_txt(arch);
			6: agregar_celular(arch);
			7: modificar_stock(arch);
			8: exportar_sin_stock(arch);
			0: break;
		else
			writeln('Opcion Incorrecta');
		end;
		writeln();
		writeln('Seleccione una opcion:');
		writeln('1-Crear Archivo');
		writeln('2-Mostrar archivo');
		writeln('3-lista elementos con stock menor al minimo');
		writeln('4-Listar cuya descripcion contenga una cadena');
		writeln('5-Exportar datos a txt');
		writeln('6-Agregar celulares');
		writeln('7-Modificar Stock');
		writeln('8-Exportar a txt celulares sin Stock');
		writeln('0- Salir');
		readln(op);
	end;
end;

var
	arch:arch_cel;
	celulares:texto_cel;
begin
	assign(celulares,'celulares2.txt');
	menu(celulares,arch);
end.

