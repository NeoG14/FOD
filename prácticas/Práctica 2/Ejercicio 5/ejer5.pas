program ejer5;

uses SysUtils;

const 
	valorAlto=9999;
	N=5;

type
	producto=record
		codigo:integer;
		nombre:string;
		desc:string;
		stock_act:integer;
		stock_min:integer;
		precio:real;
	end;
	
	info_prod=record
		codigo:integer;
		cv:integer;
	end;
	
	maestro=file of producto;
	detalle=file of info_prod;
	
	vec_det=array [1..N] of detalle;
	vec_reg=array [1..N] of info_prod;
	
procedure leer(var arch:detalle; var reg:info_prod);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.codigo:=valorAlto;
end;	

procedure asignar_archivos(var vector:vec_det);
var
	i:integer;
begin
	for i:=1 to N do
	begin
		assign(vector[i],'detalle'+IntToStr(i)+'.dat');
	end;
end;

procedure minimo(var v_det:vec_det; var v_reg:vec_reg; var min:info_prod);
var
	i,i_min:integer;
begin
	min.codigo:=valorAlto;
	for i:=1 to N do
	begin
		if(v_reg[i].codigo<min.codigo)then
		begin
			min:=v_reg[i];
			i_min:=i;
		end;
	end;
	if min.codigo <> valorAlto then
		leer(v_det[i_min],v_reg[i_min]);
end;

procedure actualizar(var mae:maestro; var v_det:vec_det);
var
	v_reg:vec_reg;
	min:info_prod;
	i:integer;
	regm:producto;
begin
	for i:=1 to N do
	begin
		reset(v_det[i]); //Abrir detalles
		leer(v_det[i],v_reg[i]); //Leer detalles
	end;
	reset(mae);
	minimo(v_det,v_reg,min); //Calcular minimo
	while(min.codigo <> valorAlto)do
	begin
		read(mae,regm);
		while(regm.codigo<>min.codigo)do //Encontrar el maestro que coincide
			read(mae,regm);
		while(regm.codigo=min.codigo)do //Mientras de igual
		begin
			regm.stock_act:= regm.stock_act - min.cv;  //Procesar la informacion
			minimo(v_det,v_reg,min);  //Avanzar en los detalles
		end;
		seek(mae,filepos(mae)-1); //Posiciono el puntero
		write(mae,regm); //Escribo en el registro maestro los cambios
	end;
	writeln('aca');
	for i:=1 to N do
		close(v_det[i]);
	close(mae);
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
		writeln('Nombre: ',nombre,' |Codigo: ',codigo,' |Stock Actual: ',stock_act,' |Stock Minimo: ',stock_min);
		end;
	end;
	close(arch);
end;

procedure mostrar_detalle(var det:detalle);
var
	reg:info_prod;
begin
	reset(det);
	while(not eof(det))do
	begin
		read(det,reg);
		with reg do
		begin
		writeln('Codigo: ',codigo,' |Cantidad vendida: ',cv);
		end;
	end;
	close(det);
end;
	
	
var
	v_det:vec_det;
	mae:maestro;
BEGIN
	assign(mae,'maestro.dat');
	asignar_archivos(v_det);
	mostrar_maestro(mae);
	//mostrar_detalle(v_det[5]);
	writeln('###Actualizando###');
	actualizar(mae,v_det);
	writeln('Maestro Actualizado');
	mostrar_maestro(mae);
END.
