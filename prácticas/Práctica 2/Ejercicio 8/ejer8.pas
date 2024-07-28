program ejer8;
const
	valorAlto=9999;
type
	cliente=record
		codigo:integer;
		nombre:string;
		apellido:string;
	end;
	

	venta=record
		cli:cliente;
		anio:integer;
		dia:integer;
		mes:integer;
		monto:real;
	end;
	
	ventas = file of venta;
	
procedure leer(var arch:ventas; var reg:venta);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.cli.codigo:=valorAlto;
end;

procedure mostrar_maestro(var arch:ventas);
var
	reg:venta;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Codigo: ',cli.codigo,' |Nombre: ',cli.nombre,' |Apellido: ',cli.apellido,' |Fecha: ',dia,'/',mes,'/',anio,' |Monto: ',monto:0:2);
		end;
	end;
	close(arch);
end;
	
var
	archivo:ventas;
	reg:venta;
	total,totalMes,totalAnio:real;
	codigo,mes,anio:integer;
BEGIN
	assign(archivo,'maestro.dat');
	
	writeln('ARCHIVO MAESTRO');
	mostrar_maestro(archivo);
	
	reset(archivo);
	total:=0;
	leer(archivo,reg);
	while(reg.cli.codigo<>valorAlto)do
	begin
		codigo:=reg.cli.codigo;
		writeln('Cliente:',codigo,' |Nombre: ',reg.cli.nombre,' |Apellido: ',reg.cli.apellido);
		
		while(reg.cli.codigo = codigo)do
		begin
			anio:=reg.anio;
			writeln('Anio: ',anio);
			totalAnio:=0;
			
			while( (reg.cli.codigo = codigo) and (reg.anio = anio) )do
			begin
				totalMes:=0;
				mes:=reg.mes;
		
				while( (reg.cli.codigo = codigo) and (reg.anio = anio) and (mes=reg.mes) )do
				begin
					totalMes:= totalMes+reg.monto;
					leer(archivo,reg);
				end;
				if(totalMes>0)then
				begin
					writeln('Total Mes: ',mes,' |Monto: ',totalMes:0:2);
					totalAnio:=totalAnio+totalMes;
				end;
			end;
			writeln('Total Anio: ',anio,' |Monto: ',totalAnio:0:2);
			total:=total+totalAnio;
		end;
		
	end;
	Writeln('Total ventas obtenido por la empresa: ',total:0:2);
	close(archivo);
END.
