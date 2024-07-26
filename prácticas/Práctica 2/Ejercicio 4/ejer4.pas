program ejer4;

const ValorAlto='ZZZZZZ';

type
	
	provincia=record
		nombre:string;
		cant_alf:integer;
		cant_enc:integer;
	end;
	
	info_prov=record
		nombre:string;
		codigo:integer;
		cant_alf:integer;
		cant_enc:integer;
	end;
	
	maestro=file of provincia;
	detalle=file of info_prov;

procedure leer(var arch:detalle;var reg:info_prov);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.nombre:=valorAlto;
end;



procedure minimo(var det1:detalle;var det2:detalle; var reg1:info_prov;
				 var reg2:info_prov; var min:info_prov);
begin
	if(reg1.nombre<reg2.nombre)then
	begin
		min:=reg1;
		leer(det1,reg1);
	end 
	else
	begin
		min:=reg2;
		leer(det2,reg2);
	end;
end;


procedure actualizar(var mae:maestro; var det1:detalle; var det2:detalle);
var
	regm:provincia;
	regD1,regD2,min:info_prov;
begin
	reset(mae); reset(det1); reset(det2);
	leer(det1,regD1); leer(det2,regD2);
	minimo(det1,det2,regD1,regD2,min);
	while( (not eof(mae)) and (min.nombre<>valorAlto))do
	begin
		read(mae,regm);
		while(regm.nombre<>min.nombre)do
			read(mae,regm);
		while(min.nombre = regm.nombre)do
		begin
			regm.cant_alf:= regm.cant_alf + min.cant_alf;
			regm.cant_enc:= regm.cant_enc + min.cant_enc;
			minimo(det1,det2,regD1,regD2,min);
		end;
			seek(mae,filepos(mae)-1);
			write(mae,regm);
	end;
	close(det2); close(det1); close(mae);
end;

procedure mostrar_maestro(var arch:maestro);
var
	reg:provincia;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Nombre: ',nombre,' |Alfabetizados: ',cant_alf,' |Encuestados: ',cant_enc);
		end;
	end;
	close(arch);
end;

procedure mostrar_detalle(var arch:detalle);
var
	reg:info_prov;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Nombre: ',nombre,' |Alfabetizados: ',cant_alf,' |Encuestados: ',cant_enc);
		end;
	end;
	close(arch);
end;

var
	mae:maestro;
	det1:detalle;
	det2:detalle;

BEGIN
	assign(mae,'maestro.dat');
	assign(det1,'detalle1.dat');
	assign(det2,'detalle2.dat');
	writeln('Maestro');
	mostrar_maestro(mae);
	writeln('Detalle 1');
	mostrar_detalle(det1);
	writeln('Detalle 2');
	mostrar_detalle(det2);
	writeln('###Actualizando maestro###');
	actualizar(mae,det1,det2);
	writeln('Maestro Actualizado');
	mostrar_maestro(mae);
END.
