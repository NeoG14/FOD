program ejer17;

const
	valorAlto=9999;
	
type
	casos=record
		cod_loc:integer;
		nombre_loc:string;
		cod_muni:integer;
		nombre_muni:string;
		cod_hosp:integer;
		nombre_hosp:string;
		fecha:string;
		cantidad:integer;
	end;
		
	maestro=file of casos;
	
procedure leer(var arch:maestro; var reg:casos);
begin
	if(not eof(arch))then
		read(arch,reg)
	else
		reg.cod_loc:=valorAlto;
end;


procedure informar(var arch:maestro);
var
	reg:casos;
	loc,muni,hosp:integer;
	total_loc,total_muni,total_hosp,total_general:integer;
begin
	reset(arch);
	leer(arch,reg);
	total_general:=0;
	while(reg.cod_loc <> valorAlto)do
	begin
		loc:=reg.cod_loc;
		total_loc:=0;
		writeln('Localidad: ',reg.nombre_loc);
		
		while(reg.cod_loc = loc)do
		begin
			muni:=reg.cod_muni;
			total_muni:=0;
			writeln('Municipio: ',reg.nombre_muni);
			
			while( (reg.cod_loc = loc) and (reg.cod_muni = muni) )do
			begin
				hosp:=reg.cod_hosp;
				total_hosp:=0;
				write('Hospital: ',reg.nombre_hosp);
				
				while( (reg.cod_loc = loc) and (reg.cod_muni = muni) and (reg.cod_hosp = hosp))do
				begin
					total_hosp:= total_hosp + reg.cantidad;
					leer(arch,reg);
				end;
				
				writeln('Cantidad casos: ',total_hosp);
				total_muni:= total_muni + total_hosp;
			end;
			
			writeln('Cantidad casos Municipio: ',total_muni);
			total_loc:= total_loc + total_muni;
		end;
		
		writeln('Cantidad casos Localidad: ',total_loc);
		total_general:= total_general + total_loc;
	end;
	
	writeln(' Cantidad de casos totales: ',total_general);	
end;

procedure mostrar_maestro(var arch:maestro);
var
	reg:casos;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		with reg do
		begin
		writeln('Localidad: ',nombre_loc,' Codigo:',cod_loc,' |Municipio: ',nombre_muni,' Codigo:',cod_muni,' |Hospital: ',nombre_hosp,' Codigo:',cod_hosp,' |Casos: ',cantidad);
		end;
	end;
	close(arch);
end;

var
	mae:maestro;
	
BEGIN
	assign(mae,'maestro.dat');
	mostrar_maestro(mae);
	writeln('##################');
	reset(mae);
	informar(mae);
	
END.
