program creadorArchivos;

	
type

	venta=record
		cod:integer;
		nombre:string;
		anio:integer;
		mes:integer;
		dia:integer;
		monto:real;
	end;

	maestro=file of venta;


procedure leerVenta(var r:venta);
begin
	with r do begin
		write ('INGRESE CODIGO: '); readln (cod);
		if (cod <> -1) then begin
			write('INGRESE NOMBRE: '); readln(nombre);
			write('INGRESE ANIO: '); readln(anio);
			write('INGRESE MES: '); readln(mes); 
			write('INGRESE DIA: ');readln(dia); 
			write('INGRESE MONTO: ');readln(monto); 
		end;
		writeln ('-----------------------------');
	end;
end;


procedure imprimirVenta(r:venta);
begin
	with r do begin
		writeln ('CODGIO: ',cod);
		writeln ('NOMBRE: ',nombre);
		writeln ('ANIO: ',anio);
		writeln ('MES: ',mes);
		writeln ('DIA: ',dia);
		writeln ('MONTO: ',monto:0:2);
	end;
end;


procedure crearMaestro (var mae:maestro);
var
	d:venta;
begin
	rewrite (mae);
	leerVenta(d);
	while (d.cod <> -1) do begin
		write(mae,d);
		leerVenta(d);
	end;
	close(mae);
end;



VAR
	mae:maestro;
	regm:venta;

begin
	assign(mae,'maestro.dat');
	//crearMaestro(mae);
	//writeln ();
	writeln ('##########VENTAS##########');
	reset(mae);
	while(not eof(mae)) do
	begin
		read(mae,regm);
		imprimirVenta(regm);
	end;
	close(mae);
end.
