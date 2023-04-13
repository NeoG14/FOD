program creadorArchivos;

CONST
	n = 3;
	
type

	dire=record
		calle:string;
		nro:integer;
		piso:integer;
		depto:string;
		ciudad:string;
	end;

	nac=record
		nro:integer;
		nombre:string;
		apellido:string;
		direccion:dire;
		matri:string;
		nom_ma:string;
		ape_ma:string;
		dni_ma:string;
		nom_pa:string;
		ape_pa:string;
		dni_pa:string;
	end;
	
	def=record
		nro:integer;
		dni:string;
		nombre:string;
		apellido:string;
		matri:string;
		fecha:string;
		hora:string;
		lugar:string;
	end;


	detalle_nac = file of nac;
	detalle_def = file of def;
	ar_nac = array[1..n] of detalle_nac;
	ar_def = array[1..n] of detalle_def;

//NACIMIENTOS
procedure leerNac(var r:nac);
begin
	with r do begin
		write ('INGRESE NRO: '); readln (nro);
		if (nro <> -1) then begin
			write('INGRESE NOMBRE: '); readln(nombre);
			write('INGRESE APELLIDO: '); readln(apellido);
			write('INGRESE DIRECCION: Calle: '); read(direccion.calle); write(' NUMERO: ');read(direccion.nro); write(' PISO: '); read(direccion.piso); write(' DEPTO: '); read(direccion.depto); write(' CIUDAD: '); readln(direccion.ciudad);
			write('INGRESE MATRICULA: ');readln(matri);
			write('INGRESE NOMBRE MADRE: ');readln(nom_ma);
			write('INGRESE APELLIDO MADRE: ');readln(ape_ma);
			write('INGRESE DNI MADRE: ');readln(dni_ma);
			write('INGRESE NOMBRE PADRE: ');readln(nom_pa);
			write('INGRESE APELLIDO PADRE: ');readln(ape_pa);
			write('INGRESE DNI PADRE: ');readln(dni_pa);
		end;
		writeln ('-----------------------------');
	end;
end;

procedure imprimirNac (r:nac);
begin
	with r do begin
		writeln ('NUMERO: ',nro);
		writeln ('NOMBRE: ',nombre);
		writeln ('APELLIDO: ',apellido);
		writeln ('DIRECCION: ',direccion.calle,' NUMERO: ',direccion.nro,' PISO: ',direccion.piso,' DEPTO: ',direccion.depto,' CIUDAD: ',direccion.ciudad);
		writeln ('MATRICULA: ',matri);
		writeln ('NOMBRE MADRE: ',nom_ma);
		writeln ('APELLIDO MADRE: ',ape_ma);
		writeln ('DNI MADRE: ',dni_ma);
		writeln ('NOMBRE PADRE: ',nom_pa);
		writeln ('APELLIDO PADRE: ',ape_pa);
		writeln ('DNI PADRE: ',dni_pa);
	end;
end;

procedure crearDetalleNac (var arc_detalle:detalle_nac);
var
	d:nac;
begin
	rewrite (arc_detalle);
	leerNac (d);
	while (d.nro <> -1) do begin
		write (arc_detalle,d);
		leerNac(d);
	end;
	close (arc_detalle);
end;

procedure mostrarDetalleNac (var arc_detalle:detalle_nac);
var
	d:nac;
begin
	reset (arc_detalle);
	while not eof (arc_detalle) do begin
		read (arc_detalle,d);
		imprimirNac(d);
	end;
	close (arc_detalle);
end;

//DEFUNCIONES
procedure leerDef(var r:def);
begin
	with r do begin
		write ('INGRESE NRO: '); readln (nro);
		if (nro <> -1) then begin
			write('INGRESE DNI: '); readln(dni);
			write('INGRESE NOMBRE: '); readln(nombre);
			write('INGRESE APELLIDO: '); readln(apellido);
			write('INGRESE MATRICULA DEFUNCION: ');readln(matri);
			write('INGRESE FECHA: ');readln(fecha);
			write('INGRESE HORA: ');readln(hora);
			write('INGRESE LUGAR: ');readln(lugar);
		end;
		writeln ('-----------------------------');
	end;
end;

procedure imprimirDef (r:def);
begin
	with r do begin
		writeln ('NUMERO: ',nro);
		writeln ('DNI: ',dni);
		writeln ('NOMBRE: ',nombre);
		writeln ('APELLIDO: ',apellido);
		writeln ('MATRICULA DEFUNCION: ',matri);
		writeln ('FECHA: ',fecha);
		writeln ('HORA: ',hora);
		writeln ('LUGAR: ',lugar);

	end;
end;

procedure crearDetalleDef (var arc_detalle:detalle_def);
var
	d:def;
begin
	rewrite (arc_detalle);
	leerDef(d);
	while (d.nro <> -1) do begin
		write (arc_detalle,d);
		leerDef(d);
	end;
	close (arc_detalle);
end;

procedure mostrarDetalleDef (var arc_detalle:detalle_def);
var
	d:def;
begin
	reset (arc_detalle);
	while not eof (arc_detalle) do begin
		read (arc_detalle,d);
		imprimirDef(d);
	end;
	close (arc_detalle);
end;

VAR
	aString: string;
	i:integer;
	deta_nac:ar_nac;
	deta_def:ar_def;

begin
	for i:= 1 to n do begin
		Str (i,aString);
		Assign (deta_nac[i],'detalleNAC'+ aString);
		Assign (deta_def[i],'detalleDEF'+ aString);
		crearDetalleNac(deta_nac[i]);
		crearDetalleDef(deta_def[i]);
		mostrarDetalleNac (deta_nac[i]);
		mostrarDetalleDef (deta_def[i]);	
	end;
end.
