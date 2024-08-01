program ejer3;

const valorAlto=9999;

type
	novela=record
		codigo:integer;//Se usa como  cabecera
		genero:string;
		nombre:string;
		duracion:integer;
		director:string;
		precio:real;
	end;
	
	archivo=file of novela;
	
procedure leer(var arch:archivo;var reg:novela);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.codigo:=valorAlto
end;
	
procedure leer_registro(var reg:novela);
begin
	write('codigo: ');
	readln(reg.codigo);
	if(reg.codigo<>-1)then
	begin
		write('genero: ');
		readln(reg.genero);
		write('nombre: ');
		readln(reg.nombre);
		write('duracion: ');
		readln(reg.duracion);
		write('director: ');
		readln(reg.director);
		write('precio: ');
		readln(reg.precio);
	end;
end;

procedure crear_archivo(var arch:archivo);
var
	reg:novela;
	nombre:string;
	
begin
	write('Ingrese nombre para el archivo: ');
	readln(nombre);
	assign(arch,nombre);
	rewrite(arch);
	reg.codigo:=0;//cabecera
	write(arch,reg);
	leer_registro(reg);
	while(reg.codigo<>-1)do//leo hasta que llega el registro con codigo -1
	begin
		write(arch,reg);
		leer_registro(reg);
	end;
	close(arch);
end;

procedure alta_novela(var arch:archivo);
var
	reg:novela;
	cabecera:novela;
begin
	reset(arch);
	leer_registro(reg);
	read(arch,cabecera);
	if(cabecera.codigo<0)then //hay espacio libre disponible
	begin
		seek(arch,(cabecera.codigo*-1));//Me posiciono en el espacio libre
		read(arch,cabecera);//Lo guardo en la cabecera lo cual avanza el puntero
		seek(arch,filepos(arch)-1);//Vuelvo a la posicion libre
		write(arch,reg);//Escribo el registro en la posicion libre
		seek(arch,0);//vuelvo a la posicion de cabecera
		write(arch,cabecera)//y actualizo la cabecera
	end
	else//no hay espacio libre (agregar al final)
	begin
		seek(arch,filesize(arch));//me posiciono al final
		write(arch,reg);//escribo el registro al final
	end;
	close(arch);
end;

procedure modificar_novela(var arch:archivo);
var
	reg:novela;
	codigo:integer;
begin
	reset(arch);
	write('Ingrese codigo de novela a modificar: ');
	readln(codigo);
	leer(arch,reg);
	while( (codigo<>valorAlto) and (codigo<>reg.codigo) )do
		leer(arch,reg);

	if(reg.codigo<>valorAlto)then
	begin
		write('genero: ');
		readln(reg.genero);
		write('nombre: ');
		readln(reg.nombre);
		write('duracion: ');
		readln(reg.duracion);
		write('director: ');
		readln(reg.director);
		write('precio: ');
		readln(reg.precio);
		seek(arch,filepos(arch)-1);
		write(arch,reg);
	end
	else
		write('Codigo de novela no encontrado');
	close(arch);
end;

procedure baja_novela(var arch:archivo);
var
	reg:novela;
	codigo:integer;
	cabecera:novela;
begin
	reset(arch);
	read(arch,cabecera);
	write('Ingrese codigo de la novela a eliminar: ');
	readln(codigo);
	leer(arch,reg);
	while( (codigo<>valorAlto) and (codigo<>reg.codigo) )do
		read(arch,reg);
	if(reg.codigo<>valorAlto)then
	begin
		seek(arch,filepos(arch)-1);//me posiciono en el registro a borrar
		write(arch,cabecera);//escribo la cabecera
		cabecera.codigo:= (filepos(arch)-1)*-1;//guardo en el reg cabecera
											  //la posicion del ultimo borrado
		seek(arch,0);//me posiciono en la cabecera
		write(arch,cabecera);//actualizo la cabecera
	end
	else
		write('Codigo de novela no encontrado: ');
	close(arch);
end;

procedure listar(var arch:archivo);
var
	lista:text;
	reg:novela;
begin
	reset(arch);
	assign(lista,'listado.txt');
	rewrite(lista);
	while(not eof(arch))do
	begin
		read(arch,reg);
		if(reg.codigo>0)then
			writeln(lista,'Codigo: ',reg.codigo,' |Genero: ',reg.genero,' |Nombre: ',reg.nombre,' |Director: ',reg.director,' |Duracion: ',reg.duracion,' |Precio: ',reg.precio:0:2);
	end;
	close(lista); close(arch);
end;

procedure mostrar_archivo(var arch:archivo);
var
	reg:novela;
begin
	reset(arch);
	leer(arch,reg);
	leer(arch,reg);
	while(reg.codigo<>valorAlto)do
	begin
		writeln('Codigo: ',reg.codigo,' |Genero: ',reg.genero,' |Nombre: ',reg.nombre,' |Director: ',reg.director,' |Duracion: ',reg.duracion,' |Precio: ',reg.precio:0:2);
		leer(arch,reg);
	end;
	close(arch);
end;

procedure menu(var arch:archivo);
var
	nombre:string;
	op:integer;
begin
	write('Ingrese nombre del archivo a trabajar: ');
	readln(nombre);
	assign(arch,nombre);
	writeln('1- Agregar novela');
	writeln('2- Modificar novela');
	writeln('3- Eliminar novela');
	writeln('4- Mostrar archivo');
	writeln('5- Exportar listado');
	writeln('0- Salir');
	readln(op);
	while(op<>0)do
	begin
		case op of
			1:alta_novela(arch);
			2:modificar_novela(arch);
			3:baja_novela(arch);
			4:mostrar_archivo(arch);
			5:listar(arch);
			0:break;
		else
			writeln('Opcion Incorrectado');
		end;
		writeln('1- Agregar novela');
		writeln('2- Modificar novela');
		writeln('3- Eliminar novela');
		writeln('4- Mostrar archivo');
		writeln('5- Exportar listado');
		writeln('0- Salir');
		readln(op);
	end;
end;

var
	arch:archivo;
	
BEGIN
	//crear_archivo(arch);
	menu(arch);
END.
