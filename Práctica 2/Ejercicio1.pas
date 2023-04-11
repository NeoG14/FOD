program Ejercicio1;
const valorAlto=9999;
type
	ingreso=record
		emp_cod:integer;
		nombre:string[20];
		monto:real;
	end;
	
	ingresos = file of ingreso;
	
procedure leer(var archivo:ingresos; var dato:ingreso);
begin
	if(not eof(archivo)) then
		read(archivo,dato)
	else
		dato.emp_cod:=valorAlto;
end;

VAR
	archivo:ingresos;
	archivo_tot:ingresos;
	dato,aux:ingreso;

BEGIN
	assign(archivo, 'comisiones.dat');
	assign(archivo_tot, 'comisiones_unificadas.dat');
	reset(archivo); rewrite(archivo_tot);
	leer(archivo,dato);
	while(dato.emp_cod <> valorAlto)do
	begin
		aux:=dato;
		while(dato.emp_cod = aux.emp_cod)do
		begin
			aux.monto:= aux.monto + dato.monto;
			leer(archivo,dato);
		end;
		write(archivo_tot,aux);
	end;
	close(archivo); close(archivo_tot);
END.

