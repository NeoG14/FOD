program ejercicio4;
const valorAlto=9999;
type
	reg_flor = record
		nombre: String[45];
		codigo:integer;
	end;
	
	tArchFlores = file of reg_flor;
	
procedure leerFlor(var reg:reg_flor);
begin
	read(reg.codigo);
	if(reg.codigo<>-1)then
		read(reg.nombre);
end;

procedure leerArc(var arc:tArchFlores; var reg:reg_flor);
begin
	if(not eof(arc))then
		read(arc,reg)
	else
		reg.codigo:=valorAlto;
end;

procedure crearArchivo(var arc:tArchFlores);
var
	reg:reg_flor;
begin
	rewrite(arc);
	reg.codigo:=0;
	write(arc,reg);
	close(arc);
end;

procedure agregarFlor(var arc:tArchFlores; nombre:string; codigo:integer);
var
	reg:reg_flor;
	reg_indice:reg_flor;
	pos:integer;
begin
	reg.nombre:=nombre;
	reg.codigo:=codigo;
	reset(arc);
	read(arc,reg_indice);
	if(reg_indice.codigo<0)then // Si hay espacio libre
	begin
		pos:=reg_indice.codigo*-1;//guardo la posicion
		seek(arc,pos); //salto a la posicion
		read(arc,reg_indice); //leo el indice de la posicion
		seek(arc,pos); //me posiciono nuevamente
		write(arc,reg); //escribo el registro en la posicion libre
		seek(arc,0); //me posiciono en la cabecera
		write(arc,reg_indice); //reescribo el nuevo indice en la cabecera
	end
	else //Sino
	begin
		seek(arc,filesize(arc)); //me posiciono al final
		write(arc,reg); //escribo el registro
	end;
	close(arc);
end;

procedure eliminarFlor(var arc:tArchFlores; codigo:integer);
var
	reg:reg_flor;
	reg_indice:reg_flor;
	pos:integer;
	encontre:boolean;
begin
	encontre:=false;
	reset(arc);
	read(arc,reg_indice);
	leerArc(arc,reg);
	while((reg.codigo<>codigo) and (reg.codigo<>valorAlto))do
	begin
		leerArc(arc,reg);
	end;
	
	if(reg.codigo=codigo)then // Si encontre el codigo
	begin
		encontre:=true;
		pos:=(filepos(arc)-1);//guardo la posicion a eliminar
		seek(arc,pos);//salto a la posicion
		write(arc,reg_indice); //escribo el indice de la posicion
		reg_indice.codigo:=pos*-1;//actualizo el registro de cabecera con el indice del ultimo eliminado
		seek(arc,0); //me posiciono en la cabecera
		write(arc,reg_indice); //reescribo el nuevo indice en la cabecera
	end;
	if(encontre)then
		writeln('Registro Eliminado Correctamente')
	else
		writeln('Registro no Encontrado');
	close(arc);
end;

procedure mostrarArchivo(var arc:tArchFlores);
var
	reg:reg_flor;
begin
	reset(arc);
	leerArc(arc,reg);
	while(reg.codigo<>valorAlto)do
	begin
		if(reg.codigo>0)then
			writeln('Nombre: ',reg.nombre,' Codigo: ',reg.codigo)
		else if(reg.codigo<0)then
			writeln('Espacio ',reg.codigo,' Libre');
		leerArc(arc,reg);
	end;
end;

VAR
	arc:tArchFlores;
	nom:string; cod:integer;
BEGIN
	assign(arc,'flores.dat');
	//crearArchivo(arc);
{
	write('ingrese codigo: '); readln(cod);
	if(cod<>-1)then
		write('ingrese nombre: '); readln(nom);
	while(cod<>-1)do
	begin
		agregarFlor(arc,nom,cod);
		write('ingrese codigo: '); readln(cod);
		if(cod<>-1)then
		begin
			write('ingrese nombre: '); 
			readln(nom);
		end;
	end;
}
	//eliminarFlor(arc,6);
	agregarFlor(arc,'Jorge',12);
	mostrarArchivo(arc);
	
END.

