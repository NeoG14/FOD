program ejercicio3;
const
	valorAlto=9999;
type

	novela=record
		cod:integer;
		gen:string;
		nom:string;
		dur:integer;
		dir:string;
		precio:real;
	end;
	
	archivo=file of novela;
	
procedure leerNovela(var reg:novela);
begin
	write('INGRESE CODIGO DE NOVELA: '); readln(reg.cod);
	if(reg.cod<>-1) then
	begin
		write('INGRESE GENERO DE NOVELA: ');readln(reg.gen);
		write('INGRESE NOMBRE DE NOVELA: ');readln(reg.nom);
		write('INGRESE DURACION DE NOVELA: ');readln(reg.dur);
		write('INGRESE DIRECTOR DE NOVELA: ');readln(reg.dir);
		write('INGRESE PRECIO DE NOVELA: ');readln(reg.precio);
	end;
end;

procedure asignarArchivo(var arc:archivo);
var
	nombre:string;
begin
	write('INGRESE NOMBRE DEL ARCHIVO: '); readln(nombre);
	assign(arc,nombre);
end;

procedure leerArc(var arc:archivo; var reg:novela);
begin
	if(not eof(arc)) then
		read(arc,reg)
	else
		reg.cod:=valorAlto;
end;

procedure mostrarArchivo(var arc:archivo);
var
	reg:novela;
begin
	reset(arc);
	leerArc(arc,reg);
	while(reg.cod<>valorAlto)do
	begin
		if(reg.cod>0)then
		begin
			with reg do
			begin
			writeln('CODIGO: ',cod);
			writeln('GENERO: ',gen);
			writeln('NOMBRE: ',nom);
			writeln('DURACION: ',dur,'MIN');
			writeln('DIRECTOR: ',dir);
			writeln('PRECIO: ',precio:0:2);
			writeln('---------------------');
			end;
		end;
		leerArc(arc,reg);
	end;
end;

// inciso a
procedure crearArchivo(var arc:archivo);
var
	reg:novela;
begin
	asignarArchivo(arc);
	rewrite(arc);
	reg.cod:=0;
	write(arc,reg);
	leerNovela(reg);
	while(reg.cod <> -1) do
	begin
		write(arc,reg);
		leerNovela(reg);
	end;
	close(arc);
end;

//inciso b1
procedure alta(var arc:archivo);
var
	reg,indice:novela;
begin
	reset(arc);
	read(arc,indice);//leemos la cabercera del registro
	leerNovela(reg);//leemos la novela a insertar
	if(indice.cod < 0) then //si hay algun espacio libre
	begin
		seek(arc,(indice.cod*-1));//me posiciono en el espacio libre
		read(arc,indice);//leo la informacion del espacio libre (para guardar su cod)
		seek(arc,filepos(arc)-1);//me posicione en el espacio libre nuevamente
		write(arc,reg);//escribo los datos en el espacio libre;
		seek(arc,0);//me pocisiono en la cabezera
		write(arc,indice);//guardo el indice del ultimo espacio libre (lista inversa)
	end
	else //si no hay espacio libre agrego al final
	begin
		seek(arc,filesize(arc));//me posiciono al final
		write(arc,reg);//escribo los datos
	end;
	close(arc);
end;

procedure modificarOpciones(var opc:integer);
begin
	writeln('SELECCIONE UNA OPCION');
	writeln('1-MODIFICAR GENERO');
	writeln('2-MODIFICAR NOMBRE');
	writeln('3-MODIFICAR DURACION');
	writeln('4-MODIFICAR DIRECTOR');
	writeln('5-MODIFICAR PRECIO');
	writeln('0-CANCELAR');
	readln(opc);
end;

procedure modificar(var reg:novela; opc:integer);
begin
	case opc of
		1:begin
			write('INGRESE NUEVO GENERO: '); readln(reg.gen);
		end;
		2:begin
			write('INGRESE NUEVO NOMBRE: '); readln(reg.nom);
		end;
		3:begin
			write('INGRESE NUEVA DURACION: '); readln(reg.dur);
		end;
		4:begin
			write('INGRESE NUEVO DIRECTOR: '); readln(reg.dir);
		end;
		5:begin
			write('INGRESE NUEVO PRECIO: '); readln(reg.precio);
		end;
		else
			writeln('OPCION NO VALIDA');
	end;
end;

//inciso b2
procedure modificacion(var arc:archivo);
var
	reg:novela;
	cod:integer;
	pude:boolean;
	opc:integer;
begin
	pude:=false;
	reset(arc);
	write('INGRESE CODIGO DE NOVELA A MODIFICAR: '); readln(cod);
	leerArc(arc,reg);
	while( (reg.cod<>valorAlto) and (reg.cod<>cod) )do
		leerArc(arc,reg);
	if(reg.cod=cod) then
	begin
		pude:=true;
		modificarOpciones(opc);
		while(opc<>0)do
		begin
			modificar(reg,opc);
			modificarOpciones(opc);
		end;
		seek(arc,filepos(arc)-1);
		write(arc,reg);
	end;
	if(pude)then
		writeln('NOVELA MODIFICADA EXITOSAMENTE')
	else
		writeln('NOVELA NO ENCONTRADA');
	writeln();
	close(arc);	
end;

//inciso b3
procedure baja(var arc:archivo);
var
	indice,reg:novela;
	cod:integer;
	pude:boolean;
begin
	reset(arc);
	pude:=false;
	write('INGRESE CODIGO DE NOVELA: '); readln(cod);
	leerArc(arc,indice);
	leerArc(arc,reg);
	while( (reg.cod<>valorAlto) and (reg.cod<>cod) ) do
		leerArc(arc,reg);
	if(reg.cod=cod) then
	begin
		pude:=true;
		seek(arc,filepos(arc)-1);//me posiciono en el registro
		write(arc,indice);//escribo el indice en el lugar a borrar
		indice.cod:=(filepos(arc)-1)*-1; // guardo la posicion borrada en el indice
		seek(arc,0);//me posiciono en el registro cabecera
		write(arc,indice);//escribo el indice del ultimo registro borrado en la cabecera
	end;
	if(pude)then
		writeln('NOVELA ELIMINADA EXITOSAMENTE')
	else
		writeln('NOVELA NO ENCONTRADA');
	writeln();
	close(arc);
end;

procedure listar(var arc:archivo);
var
	reg:novela;
	txt:text;
begin
	reset(arc);
	assign(txt,'novelas.txt');
	rewrite(txt);
	leerArc(arc,reg);
	while(reg.cod <> valorAlto)do
	begin
		if(reg.cod>1) then
			writeln(txt,'INFO NOVELA: CODIGO ',reg.cod,' GENERO ',reg.gen,' NOMBRE ',reg.nom,' DURACION ',reg.dur,'MIN',' PRECIO ',reg.precio:0:2)
		else
			if(reg.cod<0)then
				writeln(txt,'ESPACIO ', reg.cod, ' LIBRE');
		leerArc(arc,reg);
	end;
	close(arc); close(txt);
end;

procedure menuGeneral();
begin
	writeln('SELECCIONE UNA OPCION');
	writeln('1- CREAR ARCHIVO');
	writeln('2- TRABAJAR CON ARCHIVO');
	writeln('3- LISTAR NOVELAS');
	writeln('0- SALIR');
end;

procedure menuTrabajo();
begin
	writeln('SELECCIONE UNA OPCION');
	writeln('1- ALTA NOVELA');
	writeln('2- MODIFICAR DATOS NOVELA');
	writeln('3- ELIMINAR NOVELA');
	writeln('4- MOSTRAR ARCHIVO');
	writeln('5- VOLVER AL MENU GENERAL');
end;

procedure ejercutarPrograma(var arc:archivo);
var
	opc:integer;
begin
	menuGeneral();
	readln(opc);
	while(opc<>0) do
	begin
		case opc of
			1:crearArchivo(arc);
			2:
				begin
					asignarArchivo(arc);
					menuTrabajo();
					readln(opc);
					while(opc <> 5)do
					begin
						case opc of
							1:alta(arc);
							2:modificacion(arc);
							3:baja(arc);
							4:mostrarArchivo(arc);
							else
								writeln('OPCION NO VALIDA');
							
						end;
						menuTrabajo();
						readln(opc);
					end;
				end;
			3:listar(arc);
			else 
				writeln('OPCION NO VALIDA');
		end;
		menuGeneral();
		readln(opc);
	end;
end;

VAR
	arc:archivo;

BEGIN
	ejercutarPrograma(arc);
END.

