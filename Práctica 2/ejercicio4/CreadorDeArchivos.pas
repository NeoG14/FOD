program creadorArchivos;

CONST
	n = 3;
	
type
	{
	date =record
		dia:integer;
		mes:integer;
		anio:integer;
	end;
	* }
	
	info = record
		cod_usuario:integer;
		fecha:string;
		tiempo_sesion:real; //Expresado en segundos
	end;
	{
	rec = record
		cod:integer;
		fecha:date;
		tiempo:real;
	end;
	* }

	maestro = file of info;
	detalle = file of info;
	ar_detalle = array[1..n] of detalle;

procedure imprimir (r:info);
begin
	with r do begin
		writeln ('CODIGO: ',cod_usuario);
		writeln ('FECHA: ',fecha);
		writeln ('TIEMPO TOTAL DE SESIONES ABIERTAS: ',tiempo_sesion:0:2);
	end;
end;

procedure leer (var r:info);
begin
	with r do begin
		write ('INGRESE COD: '); readln (cod_usuario);
		if (cod_usuario <> -1) then begin
			write ('INGRESE Fecha DD-MM-AAAA: '); readln(fecha);
			write ('INGRESE TIEMPO DE SESION: '); readln (tiempo_sesion);
		end;
		writeln ('');
	end;
end;


procedure crearDetalle (var arc_detalle:detalle);
var
	d:info;
begin
	rewrite (arc_detalle);
	leer (d);
	while (d.cod_usuario <> -1) do begin
		write (arc_detalle,d);
		leer(d);
	end;
	close (arc_detalle);
end;

procedure mostrarDetalle (var arc_detalle:detalle);
var
	d:info;
begin
	reset (arc_detalle);
	while not eof (arc_detalle) do begin
		read (arc_detalle,d);
		imprimir(d);
	end;
	close (arc_detalle);
end;

VAR
	//mae: maestro;
	aString: string;
	i:integer;
	deta:ar_detalle;

begin
	//Assign (mae,'maestro');
	for i:= 1 to n do begin
		Str (i,aString);
		Assign (deta[i],'detalle'+ aString);
		crearDetalle (deta[i]);
		mostrarDetalle (deta[i]);
	end;
end.
