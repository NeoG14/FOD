program Corte_de_Control;
const valoralto='zzzz';
type 
	str10 = string[10];
	prov = record
		provincia, partido, ciudad: str10;
		cant_varones, cant_mujeres, cant_desocupados : integer;
	end;
	instituto = file of prov;
	
procedure leer (var archivo:instituto; var dato:prov);
begin
	if (not eof( archivo ))then 
		read (archivo,dato)
	else 
		dato.provincia := valoralto;
end;

var 
	regm: prov;
	inst: instituto;
	t_varones, t_mujeres, t_desocupados: integer;
	t_prov_var, t_prov_muj, t_prov_des: integer;
	ant_prov, ant_partido: str10;

begin
	assign(inst, 'censo' ); 
	reset(inst); 
	leer(inst, regm);
	writeln ('Provincia: ', regm.provincia); 
	writeln('Partido: ', regm.partido); 
	writeln('Ciudad','Varones','Mujeres','Desocupados');
	//se inicilizan los contadores para el total del partido para varones, mujeres y desocupados
	t_varones:=0; t_mujeres:=0; t_desocupados:=0;
	//se iniciliazan los contadores para el total de cada provincia
	t_prov_var:=0; t_prov_muj:=0; t_prov_des:=0;
	while(regm.provincia<>valoralto)do //si no llegue al final del archivo
	begin
		ant_prov:=regm.provincia; //guardar provincia actual
		ant_partido:=regm.partido; //guardar partido actual
		while ( (ant_prov=regm.provincia) and (ant_partido=regm.partido) )do //mientras no cambie la provincia y no cambie el partido
		begin
			write(regm.ciudad,regm.cant_varones,regm.cant_mujeres,regm.cant_desocupados);
			//sumo cantidad de varones, mujeres, desocupados
			t_varones:=t_varones + regm.cant_varones; 
			t_mujeres:=t_mujeres + regm.cant_mujeres;
			t_desocupados:=t_desocupados + regm.cant_desocupados;
			leer (inst, regm); //leo otro registro del maestro
		end;
		writeln('Total Partido: ', t_varones,t_mujeres,t_desocupados);
		//se suman los totales del partido a los totales de la provincia
		t_prov_var:=t_prov_var + t_varones;
		t_prov_muj:=t_prov_muj + t_mujeres;
		t_prov_des:=t_prov_des + t_desocupados;
		//se ponen en 0 para otro partido o provincia
		t_varones:=0; t_mujeres:=0; t_desocupados:=0;
		ant_partido:=regm.partido;//actualizo el partido
		if(ant_prov <> regm.provincia)then //entro solo si cambie de provincia
		begin
			writeln('Total Provincia ',t_prov_var,t_prov_muj,t_prov_des);
			t_prov_var:=0; t_prov_muj:=0; t_prov_des:=0;
			writeln('Provincia: ', regm.provincia);
		end;
		writeln ('Partido: ', regm.partido);
	end;
end. 

