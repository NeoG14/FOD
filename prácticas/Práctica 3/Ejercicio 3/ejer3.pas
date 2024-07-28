program ejer3;

const valorAlto=9999;

type
	novela=record
		//cabecera:integer;
		codigo:integer;
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
		write('duración: ');
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
		write('duración: ');
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
		cabecera.codigo:= (filepos(arch)-1)*-1;//guardo en el reg cabecera la posicion del ultimo borrado
		seek(arch,0);//me posiciono en la cabecera
		write(arch,cabecera);//actualizo la cabecera
	end
	else
		write('Codigo de novela no encontrado: ');
	close(arch);
end;

var
	arch:archivo;
	
BEGIN
	
	
END.
