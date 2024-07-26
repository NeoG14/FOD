program ejer3;

const valorAlto=9999;

type
	producto=record
		codigo:integer;
		nombre:string;
		precio:real;
		stock_act:integer;
		stock_min:integer;
	end;
	
	venta=record
		codigo:integer;
		cv:integer;
	end;
	
	maestro=file of producto;
	detalle=file of venta;
	
procedure leer(var arch:detalle; var reg:venta);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.codigo:=valorAlto;
end;

procedure actualizar(var mae:maestro; var det:detalle);
var
	regd:venta;
	regm:producto;
begin
	reset(mae); reset(det);
	leer(det,regd);
	while(regd.codigo <> valorAlto)do
	begin
		read(mae,regm);
		while(regm.codigo<>regd.codigo)do
			read(mae,regm);
		while(regd.codigo = regm.codigo)do
		begin
			regm.stock_act:= regm.stock_act - regd.cv;
			leer(det,regd);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
	end;
	close(det); close(mae);
end;

procedure exportar_minimos(var arch:maestro);
var
	arch_txt:text;
	reg:producto;
begin
	reset(arch);
	assign(arch_txt,'stock_minimo.txt');
	rewrite(arch_txt);
	while(not eof(arch))do
	begin
		read(arch,reg);
		if(reg.stock_min>reg.stock_act)then
			writeln(arch_txt,'Codigo: ',reg.codigo,' |Nombre: ',reg.nombre,' |Precio: ',reg.precio:0:2,' |Stock Actuak: ',reg.stock_act,' |stock Minimo: ',reg.stock_min);
	end;
	close(arch_txt); close(arch);
end;

procedure mostrar_maestro(var arch:maestro);
var
	reg:producto;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Codigo: ',codigo,' |Nombre: ',nombre,' |Precio: ',precio:0:2,' |Stock actual: ',stock_act,' |Stock minimo: ',stock_min);
		end;
	end;
	close(arch);
end;

procedure mostrar_detalle(var arch:detalle);
var
	reg:venta;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Codigo: ',codigo,' |Cantidad vendida: ',cv);
		end;
	end;
	close(arch);
end;

var
	mae:maestro;
	det:detalle;
	
BEGIN
	assign(mae,'maestro.dat');
	assign(det,'detalle.dat');
	writeln('Maestro');
	mostrar_maestro(mae);
	writeln('Detalle');
	mostrar_detalle(det);
	writeln('Actualizando maestro');
	actualizar(mae,det);
	mostrar_maestro(mae);
	exportar_minimos(mae);
END.
