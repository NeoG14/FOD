program ejer6;
uses SysUtils;
const
	N=5;
	VALORALTO=9999;
type
	date=record
		dia:integer;
		mes:integer;
		anio:integer;
	end;
	
	logs=record
		codigo:integer;
		fecha:date;
		tiempo:real;
	end;
	
	usuario=record
		codigo:integer;
		fecha:date;
		tiempo_total:real;
	end;
	
	detalle = file of logs;
	maestro = file of usuario;
	
var
	detalles: array[1..N] of detalle;
	registros: array[1..N] of logs;
	
	
procedure leer(var arch:detalle; var reg:logs);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.codigo:=VALORALTO;
end;

procedure asignar_archivos();
var
	i:integer;
begin
	for i:=1 to N do
	begin
		assign(detalles[i],'detalle'+IntToStr(i)+'.dat');
	end;
end;



procedure minimo(var min:logs);
var
	i,i_min:integer;
begin
	min.codigo:=VALORALTO;
	for i:=1 to N do
	begin
		if(registros[i].codigo < min.codigo) or ((registros[i].codigo = min.codigo) and (registros[i].fecha.dia < min.fecha.dia) and (registros[i].fecha.mes <  min.fecha.mes) and (registros[i].fecha.anio <  min.fecha.anio))then
		begin
			min:=registros[i];
			i_min:=i;
		end;
	end;
	if(min.codigo<>VALORALTO)then
		leer(detalles[i_min],registros[i_min]);
end;

function fechas_iguales(fecha1, fecha2:date): boolean;
begin
	fechas_iguales:= (fecha1.dia=fecha2.dia) and (fecha1.mes=fecha2.mes) and (fecha1.anio=fecha2.anio);
end;


procedure crearMaestro(var mae:maestro);
var
	i:integer;
	min:logs;
	regm:usuario;
	fecha_act:date;
	cod_act:integer;
begin
	for i:=1 to N do
	begin
		reset(detalles[i]);
		leer(detalles[i],registros[i]);
	end;
	minimo(min);
	rewrite(mae);
	while(min.codigo<>VALORALTO)do
	begin
		cod_act:=min.codigo;
		fecha_act:=min.fecha;
		regm.codigo:=min.codigo;
		regm.fecha:=min.fecha;
		regm.tiempo_total:=0;
		while( (cod_act=min.codigo) and ( fechas_iguales(fecha_act,min.fecha) ) )do
		begin
			regm.tiempo_total+=min.tiempo;
			minimo(min);
		end;
		write(mae,regm);
	end;
	close(mae);
	for i:=1 to N do
		close(detalles[i]);
end;

procedure mostrar_maestro(var arch:maestro);
var
	reg:usuario;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Codigo: ',codigo,' |Fecha: ',fecha.dia,'/',fecha.mes,'/',fecha.anio,' |Tiempo Total: ',tiempo_total:0:2);
		end;
	end;
	close(arch);
end;

var
	mae:maestro;

BEGIN
	assign(mae,'maestro.dat');
	asignar_archivos();
	crearMaestro(mae);
	mostrar_maestro(mae);
	
END.
