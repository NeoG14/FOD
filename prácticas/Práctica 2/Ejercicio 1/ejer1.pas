program ejer1;

const valorAlto=9999;

type
	comision=record
		codigo:integer;
		nombre:string;
		monto:real;
	end;
	
	comisiones=file of comision;
	
procedure leer(var arch:comisiones; var reg:comision);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.codigo:=valorAlto;
end;

procedure mostrar_archivo(var arch:comisiones);
var
	reg:comision;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		writeln('Codigo: ',reg.codigo,' |Nombre: ',reg.nombre,' |Monto: ',reg.monto:0:2);
	end;
	close(arch);
end;
	
procedure compactar(var arch:comisiones);
var
	reg,reg_actual:comision;
	arch_new:comisiones;
begin
	reset(arch);
	assign(arch_new,'comisiones compactado.dat');
	rewrite(arch_new);
	leer(arch,reg);
	while(reg.codigo <> valorAlto)do
	begin
		reg_actual:=reg;
		reg_actual.monto:=0;
		while(reg_actual.codigo = reg.codigo)do
		begin
			reg_actual.monto+=reg.monto;
			leer(arch,reg);
		end;
		write(arch_new,reg_actual);
	end;
	close(arch_new);
	close(arch);
end;

var
	arch:comisiones;
	arch_compact:comisiones;
BEGIN
	assign(arch,'comisiones.dat');
	mostrar_archivo(arch);
	compactar(arch);
	writeln('Archivo Compactado');
	assign(arch_compact,'comisiones compactado.dat');
	mostrar_archivo(arch_compact);
END.
