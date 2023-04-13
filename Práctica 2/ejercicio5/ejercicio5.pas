program ejercicio5;
const
	valorAlto=9999;
	N=3;

type
	dire=record
		calle:string;
		nro:integer;
		piso:integer;
		depto:string;
		ciudad:string;
	end;
	
	nac=record
		nro:integer;
		nombre:string;
		apellido:string;
		direccion:dire;
		matri:string;
		nom_ma:string;
		ape_ma:string;
		dni_ma:string;
		nom_pa:string;
		ape_pa:string;
		dni_pa:string;
	end;
	
	def=record
		nro:integer;
		dni:string;
		nombre:string;
		apellido:string;
		matri:string;
		fecha:string;
		hora:string;
		lugar:string;
	end;
	
	master=record
		nro:integer;
		nombre:string;
		apellido:string;
		direccion:dire;
		matri:string;
		nom_ma:string;
		ape_ma:string;
		dni_ma:string;
		nom_pa:string;
		ape_pa:string;
		dni_pa:string;
		matri_def:string;
		fecha:string;
		hora:string;
		lugar:string;
	end;
	
	detalle_nac = file of nac;
	detalle_def = file of def;
	
	ar_nac = array[1..N] of detalle_nac;
	reg_nac = array[1..N] of nac;
	ar_def = array[1..N] of detalle_def;
	reg_def = array[1..N] of def;
	
	maestro = file of master;
	
procedure leerNac(var archivo:detalle_nac; var dato:nac);
begin
	if(not eof(archivo)) then
		read(archivo,dato)
	else
		dato.nro:=valorAlto;
end;

procedure leerDef(var archivo:detalle_def; var dato:def);
begin
	if(not eof(archivo)) then
		read(archivo,dato)
	else
		dato.nro:=valorAlto;
end;

procedure minimoNac(var nacimientos:ar_nac; var ar_reg:reg_nac; var min:nac);
var
	i,indiceMin:integer;
begin
	indiceMin:=0;
	min.nro:=valorAlto;
	for i:=1 to N do
		if(ar_reg[i].nro <> valorAlto) then
			if(ar_reg[i].nro < min.nro) then
			if(ar_reg[i].nro < min.nro) then
			begin
				min:=ar_reg[i];
				indiceMin:=i;
			end;
	if(indiceMin <> 0) then
		leerNac(nacimientos[indiceMin],ar_reg[indiceMin]);
end;

procedure minimoDef(var defunciones:ar_def; var ar_reg:reg_def; var min:def);
var
	i,indiceMin:integer;
begin
	indiceMin:=0;
	min.nro:=valorAlto;
	for i:=1 to N do
		if(ar_reg[i].nro <> valorAlto) then
			if(ar_reg[i].nro < min.nro) then
			begin
				min := ar_reg[i];
				indiceMin:=i;
			end;
	if(indiceMin <> 0) then
		leerDef(defunciones[indiceMin],ar_reg[indiceMin]);
end;


procedure crearMaestro(var mae:maestro; var det_nac:ar_nac; var det_def:ar_def; var registros_nac:reg_nac; var registros_def:reg_def);
var
	
	min_nac:nac; min_def:def;
	regm:master;
	i:integer;
begin
	rewrite(mae);
	for i:=1 to N do
	begin
		reset(det_nac[i]); reset(det_def[i]);
		leerNac(det_nac[i],registros_nac[i]);
		leerDef(det_def[i],registros_def[i]);
	end;
	minimoNac(det_nac,registros_nac,min_nac);
	minimoDef(det_def,registros_def,min_def);
	while(min_nac.nro <> valorAlto) do
	begin
		regm.nro:=min_nac.nro;
		regm.nombre:=min_nac.nombre;
		regm.apellido:=min_nac.apellido;
		regm.direccion:=min_nac.direccion;
		regm.matri:=min_nac.matri;
		regm.nom_ma:=min_nac.nom_ma;
		regm.ape_ma:=min_nac.ape_ma;
		regm.dni_ma:=min_nac.dni_ma;
		regm.nom_pa:=min_nac.nom_pa;
		regm.ape_pa:=min_nac.ape_pa;
		regm.dni_pa:=min_nac.dni_pa;
		if(min_def.nro <> valorAlto) and (min_nac.nro = min_def.nro)then
		begin
				regm.matri_def:=min_def.matri;
				regm.fecha:=min_def.fecha;
				regm.hora:=min_def.hora;
				regm.lugar:=min_def.lugar;
				minimoDef(det_def,registros_def,min_def);
		end
		else
		begin
			regm.matri_def:='No ha fenecido';
			regm.fecha:='No ha fenecido';
			regm.hora:='No ha fenecido';
			regm.lugar:='No ha fenecido';
		end;
		minimoNac(det_nac,registros_nac,min_nac);
		write(mae,regm);
	end;
	for i:=1 to N do
	begin
		close(det_nac[i]);
		close(det_def[i]);
	end;
	close(mae);
end;

procedure imprimirMaestro (m:master);
begin
	with m do begin
		writeln ('NUMERO: ',nro);
		writeln ('NOMBRE: ',nombre);
		writeln ('APELLIDO: ',apellido);
		writeln ('DIRECCION: ',direccion.calle,' NUMERO: ',direccion.nro,' PISO: ',direccion.piso,' DEPTO: ',direccion.depto,' CIUDAD: ',direccion.ciudad);
		writeln ('MATRICULA: ',matri);
		writeln ('NOMBRE MADRE: ',nom_ma);
		writeln ('APELLIDO MADRE: ',ape_ma);
		writeln ('DNI MADRE: ',dni_ma);
		writeln ('NOMBRE PADRE: ',nom_pa);
		writeln ('APELLIDO PADRE: ',ape_pa);
		writeln ('DNI PADRE: ',dni_pa);
		writeln ('MEDICO DEFUNCION: ',matri_def);
		writeln ('FECHA: ',fecha);
		writeln ('HORA: ',hora);
		writeln ('LUGAR: ',lugar);
		
	end;
end;

procedure mostrarMaestro (var arc_maestro:maestro);
var
	m:master;
begin
	writeln('###########MAESTRO###########');
	reset (arc_maestro);
	while not eof (arc_maestro) do begin
		read (arc_maestro,m);
		imprimirMaestro(m);
	end;
	close (arc_maestro);
end;

procedure listarMaestro(var info:text; var mae:maestro);
var
	r:master;
begin
	reset(mae); rewrite(info);
	while(not eof(mae))do
	begin
		read(mae,r);
		with r do
		begin
			writeln (info,'NUMERO: ',nro);
			writeln (info,'NOMBRE: ',nombre);
			writeln (info,'APELLIDO: ',apellido);
			writeln (info,'DIRECCION: ',direccion.calle,' NUMERO: ',direccion.nro,' PISO: ',direccion.piso,' DEPTO: ',direccion.depto,' CIUDAD: ',direccion.ciudad);
			writeln (info,'MATRICULA: ',matri);
			writeln (info,'NOMBRE MADRE: ',nom_ma);
			writeln (info,'APELLIDO MADRE: ',r.ape_ma);
			writeln (info,'DNI MADRE: ',dni_ma);
			writeln (info,'NOMBRE PADRE: ',nom_pa);
			writeln (info,'APELLIDO PADRE: ',ape_pa);
			writeln (info,'DNI PADRE: ',dni_pa);
			writeln (info,'MEDICO DEFUNCION: ',matri_def);
			writeln (info,'FECHA: ',fecha);
			writeln (info,'HORA: ',hora);
			writeln (info,'LUGAR: ',lugar);
			writeln (info,'##############################');
		end;
	end;
	close(mae); close(info);
end;


var
	mae:maestro;
	detalle_nacimientos:ar_nac;
	detalle_defunciones:ar_def;
	i:integer;
	numero:string;
	registros_nac:reg_nac;
	registros_def:reg_def;
	info:text;
	

BEGIN
	assign(info,'informacion.txt');
	assign(mae,'maestro');
	for i:=1 to N do
	begin
		Str(i,numero);
		assign(detalle_nacimientos[i],'detalleNAC'+numero);
		assign(detalle_defunciones[i],'detalleDEF'+numero);
	end;
	crearMaestro(mae,detalle_nacimientos,detalle_defunciones,registros_nac,registros_def);
	mostrarMaestro(mae);
	listarMaestro(info,mae);
	
END.
