program ejer4;
const 
	valorAlto=9999;
	n = 3;
type
	
	info = record
		cod_usuario:integer;
		fecha:string;
		tiempo_sesion:real; //Expresado en segundos
	end;
	
	detalle = file of info;
	maestro = file of info;
	ar_detalle = array[1..n] of detalle;
	ar_reg = array[1..n] of info;

	
procedure leer(var archivo:detalle; var dato:info);
begin
	if(not eof(archivo) )then
		read(archivo,dato)
	else
		dato.cod_usuario:=valorAlto;
end;

procedure minimo(var detalles:ar_detalle; var registros:ar_reg; var min:info);
var
	i,indiceMin:integer;
begin
	indiceMin:=0;
	min.cod_usuario:=valorAlto;
	for i:=1 to n do
		if(registros[i].cod_usuario <> valorAlto) then
			if ( registros[i].cod_usuario < min.cod_usuario) or ( (registros[i].cod_usuario = min.cod_usuario) and (registros[i].fecha < min.fecha) ) then
			begin
				min:=registros[i];
				indiceMin:=i;
			end;
	if(indiceMin <> 0) then
		leer(detalles[indiceMin],registros[indiceMin]);
end;

procedure crearMaestro(var mae:maestro; var det:ar_detalle);
var
	i:integer;
	min,actual:info;
	registro:ar_reg;
begin
	rewrite(mae);
	for i:=1 to n do begin
		reset(det[i]);
		leer(det[i],registro[i]);
	end;
	
	minimo(det,registro,min);
	while(min.cod_usuario <> valorAlto) do
	begin
		actual.cod_usuario := min.cod_usuario;
		while(min.cod_usuario = actual.cod_usuario) do
		begin
			actual.fecha := min.fecha;
			actual.tiempo_sesion:=0;
			while(min.cod_usuario = actual.cod_usuario) and (min.fecha = actual.fecha) do
			begin
				actual.tiempo_sesion += min.tiempo_sesion;
				minimo(det,registro,min);
			end;
			write(mae,actual);
		end;
	end;
	for i:=1 to n do
		close(det[i]);
	close(mae);
end;

procedure imprimirMaestro (m:info);
begin
	with m do begin
		writeln ('CODIGO: ',cod_usuario);
		writeln ('FECHA: ',fecha);
		writeln ('TIEMPO TOTAL DE SESIONES ABIERTAS: ',tiempo_sesion:0:2);
	end;
end;

procedure mostrarMaestro (var arc_maestro:maestro);
var
	m:info;
begin
	reset (arc_maestro);
	while not eof (arc_maestro) do begin
		read (arc_maestro,m);
		imprimirMaestro(m);
	end;
	close (arc_maestro);
end;

VAR
	mae:maestro;
	det:ar_detalle;
	i:integer;
	numero:string;

BEGIN
	assign(mae,'maestro');
	for i:=1 to n do begin
		Str(i,numero);
		assign(det[i],'detalle'+numero);
	end;
	crearMaestro(mae,det);
	mostrarMaestro(mae);
END.

