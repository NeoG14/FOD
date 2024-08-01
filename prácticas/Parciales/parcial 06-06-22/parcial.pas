program parcial;

uses SysUtils;

const
	N=3; valorAlto='ZZZZ';
type
	carrera=record
		dni:string;
		apellido:string;
		nombre:string;
		kms:real;
		gano:integer;
	end;
	
	archivo=file of carrera;
	archivos = array[1..N] of archivo;
	registros = array[1..N] of carrera;
	
procedure leer(var arch:archivo; var reg:carrera);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.dni:=valorAlto;
end;

procedure minimo(var  archs:archivos; var regs:registros; var min:carrera);
var
	i,i_min:integer;
begin
	min.dni:=valorAlto;
	for i:=1 to N do begin
		if(regs[i].dni<min.dni)then begin
			min:=regs[i];
			i_min:=i;
		end;
	end;
	if(min.dni<>valorAlto)then
		leer(archs[i_min],regs[i_min]);
end;

procedure merge(var detalles:archivos);
var
	regs:registros;
	mae:archivo;
	min,regm:carrera;
	i:integer;
begin
	for i:=1 to N do begin
		reset(detalles[i]);
		leer(detalles[i],regs[i]);
	end;
	assign(mae,'maestro.dat');
	rewrite(mae);
	minimo(detalles,regs,min);
	while(min.dni<>valorAlto)do
	begin
		regm:=min;
		regm.kms:=0;
		regm.gano:=0;
		while(regm.dni=min.dni)do
		begin
			regm.kms+=min.kms;
			regm.gano+=min.gano;
			minimo(detalles,regs,min);
		end;
		write(mae,regm);
	end;
	for i:=1 to N do
		close(detalles[i]);
	close(mae);
end;


var
	detalles:archivos;
	i:integer;

BEGIN
	for i:=1 to N do
		assign(detalles[i],'det'+IntToStr(i)+'.dat');
	merge(detalles);
	
END.
