program parcial;
const
	valorAlto=9999;
type
	prestamo=record
		cod_sucursal:integer;
		dni:longint;
		num_prestamo:integer;
		fecha:integer;
		monto:real;
	end;
	
	archivo=file of prestamo;
	
procedure leer(var arch:archivo; var reg:prestamo);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.cod_sucursal:=valorAlto;
end;

procedure informar(var arch:archivo);
var
	reg:prestamo;
	informe:text;
	fecha_act,suc_act:integer;
	dni_act:longint;
	monto_empresa,monto_sucursal,monto_empleado,monto_anio:real;
	total_empresa,total_sucursal,total_empleado,total_anio:integer;
begin
	reset(arch);
	assign(informe,'informe.txt'); rewrite(informe);
	writeln(informe,'Informe de ventas de la empresa');
	leer(arch,reg);
	monto_empresa:=0;
	total_empresa:=0;
	while(reg.cod_sucursal<>valorAlto)do
	begin
		suc_act:=reg.cod_sucursal;
		monto_sucursal:=0;
		total_sucursal:=0;
		writeln(informe,'Sucursal ',suc_act);
		
		while(suc_act=reg.cod_sucursal)do
		begin
			dni_act:=reg.dni;
			monto_empleado:=0;
			total_empleado:=0;
			writeln(informe,'Empleado DNI:',dni_act);
			writeln(informe,'Año    Cantidad de ventas    Monto de ventas:');
			
			while( (suc_act=reg.cod_sucursal) and (dni_act=reg.dni) )do
			begin
				fecha_act:=reg.fecha;
				monto_anio:=0;
				total_anio:=0;
				
				while( (suc_act=reg.cod_sucursal) and (dni_act=reg.dni) and (fecha_act=reg.fecha) )do
				begin
					monto_anio+=reg.monto;
					total_anio+=1;
					leer(arch,reg);
				end;
				writeln(informe,fecha_act,'    ',total_anio,'    ',monto_anio:0:2);
				monto_empleado+=monto_anio;
				total_empleado+=total_anio;
			end;
			writeln(informe,'Totales: ',total_empleado,'    ',monto_empleado:0:2);
			monto_sucursal+=monto_empleado;
			total_sucursal+=total_empleado;
		end;
		writeln(informe,'Cantidad total de ventas sucursal: ',total_sucursal);
		writeln(informe,'Monto total vendido por sucursal: ',monto_sucursal:0:2);
		monto_empresa+=monto_sucursal;
		total_empresa+=total_sucursal;
	end;
	writeln(informe,'Cantidad total de la empresa: ',total_empresa);
	writeln(informe,'Monto total vendido por la empresa: ',monto_empresa:0:2);
	close(arch); close(informe);
end;

procedure mostrar_archivo(var arch:archivo);
var
	reg:prestamo;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		writeln('Codigo sucursal: ',reg.cod_sucursal,' |DNI empleado: ',reg.dni,' |Numero prestamo: ',reg.num_prestamo,' |Anio: ',reg.fecha,' |Monto: ',reg.monto:0:2);
	end;
	close(arch);
end;

var
	arch:archivo;

BEGIN
	assign(arch,'maestro.dat');
	mostrar_archivo(arch);
	informar(arch);
END.
