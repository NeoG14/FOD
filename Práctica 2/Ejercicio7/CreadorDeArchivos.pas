program creadorArchivos;

CONST
	n = 2;
	
type

	producto=record
		cod:integer;
		nom:string;
		precio:real;
		stock_act:integer;
		stock_min:integer;
	end;
	
	venta=record
		cod:integer;
		ventas:integer;
	end;
	
	detalle=file of venta;
	maestro=file of producto;


procedure leerProducto(var r:producto);
begin
	with r do begin
		write ('INGRESE CODIGO: '); readln (cod);
		if (cod <> -1) then begin
			write('INGRESE NOMBRE: '); readln(nom);
			write('INGRESE PRECIO: '); readln(precio);
			write(' STOCK ACTUAL: '); readln(stock_act); 
			write(' STOCK MINIMO: ');readln(stock_min); 
		end;
		writeln ('-----------------------------');
	end;
end;

procedure leerDetalle(var r:venta);
begin
	with r do begin
		write ('INGRESE CODIGO: '); readln (cod);
		if (cod <> -1) then begin
			write('INGRESE CANTIDAD VENDIDA: '); readln(ventas);
		end;
		writeln ('-----------------------------');
	end;
end;

procedure imprimirProducto (r:producto);
begin
	writeln ('##########NACIMIENTOS##########');
	with r do begin
		writeln ('CODGIO: ',cod);
		writeln ('NOMBRE: ',nom);
		writeln ('PRECIO: ',precio);
		writeln ('STOCK ACTUAL: ',stock_act);
		writeln ('STOCK MINIMO: ',stock_min);
	end;
end;

procedure crearDetalle (var det:detalle);
var
	d:venta;
begin
	rewrite(det);
	leerDetalle(d);
	while (d.cod <> -1) do begin
		write(det,d);
		leerDetalle(d);
	end;
	close(det);
end;

procedure crearMaestro (var mae:maestro);
var
	d:producto;
begin
	rewrite (mae);
	leerProducto(d);
	while (d.cod <> -1) do begin
		write(mae,d);
		leerProducto(d);
	end;
	close(mae);
end;



VAR
	aString: string;
	i:integer;
	det:detalle;
	mae:maestro;

begin
	assign(mae,'maestro.dat');
	crearMaestro(mae);
	for i:= 1 to n do 
	begin
		Str (i,aString);
		assign (det,'detalle'+aString+'.dat');
		crearDetalle(det);
	end;
end.
