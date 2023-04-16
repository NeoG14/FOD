program ejercicio8;
const
	valorAlto=9999;
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
	ventas_cli=array[1..12] of real;
	
	
procedure leer(var archivo:maestro; var reg:venta);
begin
	if(not eof(archivo)) then
		read(archivo,reg)
	else
		reg.cod:=valorAlto;
end;

procedure setearArreglo(var arreglo:ventas_cli);
var
	i:integer;
begin
	for i:=1 to 12 do
		arreglo[i]:=0;
end;

procedure mostrarCliente(cod:integer;nombre:string;arreglo:ventas_cli;totAnual:real);
var
	i:integer;
begin
	writeln('CODIGO CLIENTE: ',cod);
	writeln('NOMBRE CLIENTE: ',nombre);
	for i:=1 to 12 do
	begin
		if(arreglo[i] <> 0) then
			writeln('MES: ',i,' COMPRO: $',arreglo[i]:0:2)
		else
			writeln('MES: ',i,' NO REALIZO COMPRAS');
	end;
	writeln('TOTAL ANUAL: $',totAnual:0:2);
end;

procedure informar(var mae:maestro);
var
	arr_ventas:ventas_cli;
	total_mes:real; total_anio:real;
	total_gral:real;
	regm:venta;
	codAct:integer; anioAct:integer; mesAct:integer;
	nombreAct:string;
begin
	reset(mae);
	leer(mae,regm);
	total_gral:=0;
	while(regm.cod<>valorAlto)do
	begin
		setearArreglo(arr_ventas);
		codAct:=regm.cod;
		anioAct:=regm.anio;
		mesAct:=regm.mes;
		nombreAct:=regm.nombre;
		total_anio:=0;
		//while(codAct = regm.cod) do
		//begin
			while( (codAct = regm.cod) and (anioAct = regm.anio) )do
			begin
				total_mes:=0;
				while( (mesAct = regm.mes) and (anioAct = regm.anio) and (codAct = regm.cod) )do
				begin
					total_mes+=regm.monto;
					leer(mae,regm);
				end;//mes
				arr_ventas[mesAct]:=total_mes;
				total_anio+=total_mes;
				mesAct:=regm.mes;
			end;//año
			mostrarCliente(codAct,nombreAct,arr_ventas,total_anio);
			total_gral+=total_anio;
		//end;//cod
		//total_gral+=total_anio;
	end;
	close(mae);
	writeln('------------------');
	writeln('TOTAL DE VENTAS DE LA EMPRESA: $',total_gral:0:2);
end;

var
	mae:maestro;
	

BEGIN
	assign(mae,'maestro.dat');
	informar(mae);
END.

