program ejercicio7;
type
	novela=record
		cod:integer;
		nombre:string;
		genero:string;
		precio:real;
	end;
	
	novelas_dat = file of novela;
	
procedure leer(var archivo:novelas_dat; var dato:novela);
begin
	if(not eof(archivo))then
		read(archivo,dato)
	else
		dato.cod:=9999;
end;

procedure leerNovela(var nov:novela);
begin
	write('ingrese codigo de novela: ');
	readln(nov.cod);
	if(nov.cod<>-1)then
	begin
		write('ingrese nombre de novela: ');
		readln(nov.nombre);
		write('ingrese genero de novela: ');
		readln(nov.genero);
		write('ingrese precio de novela: ');
		readln(nov.precio);
	end;
end;
	
procedure crearArchivo(var novelas:text);
var
	nov:novela;
	novelas_dat:file of novela;
begin
	assign(novelas_dat,'novelas.dat');
	rewrite(novelas_dat);
	while not eof(novelas)do
	begin
		readln(novelas,nov.cod,nov.precio,nov.genero);
		readln(novelas,nov.nombre);
		write(novelas_dat,nov);
	end;
	close(novelas_dat);
end;

procedure mostrarDatos(var novelas:novelas_dat);
var
	nov:novela;
begin
	assign(novelas,'novelas.dat');
	reset(novelas);
	while not eof(novelas)do
	begin
		read(novelas,nov);
		writeln('codigo: ',nov.cod);
		writeln('preico: ',nov.precio:0:2);	
		writeln('genero: ',nov.genero);
		writeln('nombre: ',nov.nombre);
		writeln(' ');
	end;
	close(novelas);
end;

procedure modificarNovela(var novelas:novelas_dat;var nov:novela);
var
	codigo:integer;
begin
	write('ingrese codigo de novela: ');
	readln(codigo);
	leer(novelas,nov);
	while((nov.cod<>9999) and (nov.cod <> codigo))do
		leer(novelas,nov);
	if(nov.cod=codigo)then
	begin
		leerNovela(nov);
		seek(novelas,filepos(novelas)-1);
		write(novelas,nov);
	end
	else
		writeln('El codigo no existe');
end;

procedure agregarNovela(var novelas:novelas_dat; var nov:novela);
begin
	leerNovela(nov);
	seek(novelas,filesize(novelas));
	write(novelas,nov);
end;

//incisob
procedure modificarArchivo(var novelas:novelas_dat);
var
	nov:novela;
	op:integer;
begin
	assign(novelas,'novelas.dat');
	reset(novelas);
	writeln('Seleccione una opcion:');
	writeln('1. Modifica novela existente');
	writeln('2. Agregar novela');
	writeln('3. Salir');
	readln(op);
	case op of
		1:modificarNovela(novelas,nov);
		2:agregarNovela(novelas,nov);
		3:writeln('Saliendo...');
		else writeln('Opcion incorrecta');
	end;
	close(novelas);
end;

VAR
	novelas:text;
	datos_novelas:novelas_dat;
BEGIN
	//assign(novelas,'novelas.txt');
	//reset(novelas);
	//crearArchivo(novelas);
	//close(novelas);
	mostrarDatos(datos_novelas);
	//modificarArchivo(datos_novelas);
END.

