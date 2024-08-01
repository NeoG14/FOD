program bajaFisica1archivp;

const 
	valorAlto='ZZZZ';
type
	
	archivo=file of string;
	
procedure mostrar_archivo(var arch:archivo);
var
	nom:string;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,nom);
		writeln('Nombre: ',nom);
	end;
	close(arch);
end;

procedure leer(var arch:archivo; var nombre:string);
begin
	if(not eof(arch))then
		read(arch,nombre)
	else
		nombre:=valorAlto;
end;

procedure baja(var arch:archivo);
var
	nombre:string;
	nom:string;
begin
	reset(arch);
	write('Ingrese nombre a eliminar: ');
	readln(nom);
	leer(arch,nombre);
	while (nombre<>nom)do
	begin
		leer(arch,nombre);
	end;
	leer(arch,nombre);
	{se copian los registros restantes}
	While (nombre<>valoralto) do
	begin
		Seek(arch,filepos(arch)-2 );
		write(arch,nombre);
		Seek( arch, filepos(arch)+1 );
		leer(arch,nombre);
	end;
	Seek( arch, filepos(arch)-1);
	truncate(arch);
end;

var
	arch:archivo;
	//nom:string;
BEGIN
	assign(arch,'prueba.dat');
	mostrar_archivo(arch);
	baja(arch);
	mostrar_archivo(arch);
{
	rewrite(arch);
	write('Ingrese nombre: ');
	readln(nom);
	while(nom<>'zzz')do
	begin
		write(arch,nom);
		write('Ingrese nombre: ');
		readln(nom);
	end;
}
	
END.
