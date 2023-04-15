program ejercicio7;
const 
	valorAlto=9999;
	
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
	
procedure leer(var archivo:detalle; var reg:venta);
begin
	if(not eof(archivo))then
		read(archivo,reg)
	else
		reg.cod:=valorAlto;
end;

procedure actualizarMaestro(var mae:maestro; var det:detalle);
var
	regm:producto;
	regd:venta;
	codActual:integer;
begin
	reset(mae); reset(det);
	leer(det,regd);
	read(mae,regm);
	while(regd.cod <> valorAlto) do
	begin
		codActual:=regd.cod;
		while(regm.cod<>codActual) do 
			read(mae,regm);
		while(regd.cod = codActual) do
		begin
			regm.stock_act -= regd.ventas;
			leer(det,regd);
		end;
		seek(mae,(filepos(mae)-1));
		write(mae,regm);
	end;
	close(mae); close(det);
end;

procedure listar(var mae:maestro);
var
	info:text;
	regm:producto;
begin
	assign(info,'stock_minimo.txt');
	rewrite(info); reset(mae);
	while(not eof(mae)) do
	begin
		read(mae,regm);
		if(regm.stock_act<regm.stock_min) then
		begin
			writeln(info,'CODIGO PRODUCTO: ',regm.cod);
			writeln(info,'NOMBRE PRODUCTO: ',regm.nom);
			writeln(info,'PRECIO PRODCUTO: $',regm.precio:0:2);
			writeln(info,'STOCK ACTUAL: ',regm.stock_act);
			writeln(info,'STOCK MIN: ',regm.stock_min);
			writeln(info,'-----------------------');
		end;
	end;
	close(info); close(mae);
end;

procedure mostrarMaestro(var mae:maestro);
var
	regm:producto;
begin
	reset(mae);
	while(not eof(mae))do
	begin
		read(mae,regm);
		writeln('CODIGO PRODUCTO: ',regm.cod);
		writeln('NOMBRE PRODUCTO: ',regm.nom);
		writeln('PRECIO PRODCUTO: $',regm.precio:0:2);
		writeln('STOCK ACTUAL: ',regm.stock_act);
		writeln('STOCK MIN: ',regm.stock_min);
		writeln('-----------------------');
	end;
	close(mae);
end;

procedure mostrarMenu(var mae:maestro; var det:detalle);
var
	opc:integer;
begin
	writeln('SELECCIONES UNA OPCION');
	writeln('1- ACTUALIZAR MAESTRO');
	writeln('2- LISTAR INFORMACION DE ARCHIVOS SIN STOCK MINIMO');
	writeln('3- MOSTRAR MAESTRO');
	writeln('9- SALIR');
	readln(opc);
	while(opc<>9) do
	begin
		case opc of
			1:begin
				actualizarMaestro(mae,det);
				writeln();
				writeln('SELECCIONES UNA OPCION');
				writeln('1- ACTUALIZAR MAESTRO');
				writeln('2- LISTAR INFORMACION DE ARCHIVOS SIN STOCK MINIMO');
				writeln('3- MOSTRAR MAESTRO');
				writeln('9- SALIR');
			end;
			2:begin
				listar(mae);
				writeln();
				writeln('SELECCIONES UNA OPCION');
				writeln('1- ACTUALIZAR MAESTRO');
				writeln('2- LISTAR INFORMACION DE ARCHIVOS SIN STOCK MINIMO');
				writeln('3- MOSTRAR MAESTRO');
				writeln('9- SALIR');
			end;
			3:begin
				mostrarMaestro(mae);
				writeln();
				writeln('SELECCIONES UNA OPCION');
				writeln('1- ACTUALIZAR MAESTRO');
				writeln('2- LISTAR INFORMACION DE ARCHIVOS SIN STOCK MINIMO');
				writeln('3- MOSTRAR MAESTRO');
				writeln('9- SALIR');
			end;
			else 
			begin
				writeln('OPCION NO VALIDA');
				writeln('SELECCIONES UNA OPCION');
				writeln('1- ACTUALIZAR MAESTRO');
				writeln('2- LISTAR INFORMACION DE ARCHIVOS SIN STOCK MINIMO');
				writeln('3- MOSTRAR MAESTRO');
				writeln('9- SALIR');
			end;
		end;
		readln(opc);
	end;
	writeln('SALIENDO...');
end;

var
	mae:maestro;
	det:detalle;

BEGIN
	assign(mae,'maestro.dat');
	assign(det,'detalle2.dat');
	mostrarMenu(mae,det);
END.

