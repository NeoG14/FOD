program ejercicio6;
const
	valorAlto=9999;
	N = 3;
type
	det=record
		cod_loc:integer;
		cod_cepa:integer;
		activos:integer;
		nuevos:integer;
		recuperados:integer;
		fallecidos:integer;
	end;
	
	master=record
		nom_loc:string;
		nom_cepa:string;
		datos:det;
	end;
	
	detalle = file of det;
	maestro = file of master;
	ar_detalle = array [1..N] of detalle;
	ar_regd = array [1..N] of det;
	
procedure leer(var archivo:detalle; var reg:det);
begin
	if(not eof(archivo))then
		read(archivo,reg)
	else
	begin
		reg.cod_loc:=valorAlto;
	end;
end;

procedure leerMaestro(var archivo:maestro; var regm:master);
begin
	if(not eof(archivo))then
		read(archivo,regm)
	else
	begin
		regm.datos.cod_loc:=valorAlto;
	end;
end;
	
procedure minimo(var detalles:ar_detalle; var registros:ar_regd; var min:det);
var
	i,indiceMin:integer;
begin
	min.cod_loc:=valorAlto;
	indiceMin:= 0;
	for i:=1 to N do
	begin
		if (registros[i].cod_loc <> valorAlto) then 
		begin
			if(registros[i].cod_loc < min.cod_loc) or ( (registros[i].cod_loc = min.cod_loc) and (registros[i].cod_cepa < min.cod_cepa) )then
			begin
				min:=registros[i];
				indiceMin:=i;
			end;
		end;
	end;
	if (indiceMin <> 0) then 
		leer(detalles[indiceMin],registros[indiceMin]);
end;

procedure actualizar(var mae:maestro; var detalles:ar_detalle);
var
	regm:master;
	registros:ar_regd;
	min:det;
	i:integer;
	cant:integer;
begin
	cant:=0;
	reset(mae);
	for i:=1 to N do
	begin
		reset(detalles[i]);
		leer(detalles[i],registros[i]);
	end;
	minimo(detalles,registros,min);
	while(min.cod_loc <> valorAlto) do
	begin
		read(mae,regm);
		if(regm.datos.activos>50) then
			cant := cant+1;
		if(min.cod_loc=regm.datos.cod_loc) and (min.cod_cepa=regm.datos.cod_cepa) then
		begin
			regm.datos.fallecidos += min.fallecidos;
			regm.datos.recuperados += min.recuperados;
			regm.datos.activos := min.activos;
			regm.datos.nuevos := min.nuevos;
			seek(mae,filepos(mae)-1);
			write(mae,regm);
		end;
		for i:=1 to N do
			leer(detalles[i],registros[i]);
		minimo(detalles,registros,min);
	end;
	for i:=1 to N do
		close(detalles[i]);
	close(mae);
end;

var
	mae:maestro;
	detalles:ar_det;
	i:integer;
	numero:string;
BEGIN
	assign(mae,'maestro');
	for i:=1 to N do
	begin
		Str(i,numero);
		assign(detalles[i],'detalle'+numero);
	end;
	actualizar(mae,detalles);
	
END.

