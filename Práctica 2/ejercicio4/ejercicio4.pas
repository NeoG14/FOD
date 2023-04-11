program ejer4;
const 
	valorAlto='9999';
	fechaAlta='99-99-9999';
type
	str4=string[4];
	
	info_terminal = record
		cod_usuario:string;
		fecha:string;
		tiempo_sesion:real; //Expresado en segundos
	end;
	
	info_usuarios = record
		cod_usuario:string;
		fecha:string;
		tiempo_total:real; //Expresado en segundos
	end;
	
	detalle = file of info_terminal;
	maestro = file of info_usuarios;

VAR
	min,regd1,regd2,regd3,regd4,regd5:info_terminal;
	det1,det2,det3,det4,det5:detalle;
	regm:info_usuarios;
	mae:maestro;
	aux_min:info_terminal; aux_mae:info_usuarios;
	total:real;
	
procedure leer(var archivo:detalle; var dato:info_terminal);
begin
	if(not eof(Archivo) )then
		read(archivo,dato)
	else
		dato.cod_usuario:=valorAlto;
end;

procedure minimo(var r1,r2,r3,r4,r5:info_terminal; var min:info_terminal);
begin
	if (r1.cod_usuario<r2.cod_usuario) and (r1.cod_usuario<r3.cod_usuario) and (r1.cod_usuario<r4.cod_usuario) and (r1.cod_usuario<r5.cod_usuario) then 
	begin
		min := r1;
		leer(det1,r1);
	end
	else if (r2.cod_usuario<r3.cod_usuario) and (r2.cod_usuario<r4.cod_usuario) and (r2.cod_usuario<r5.cod_usuario) then
	begin
		min := r2;
		leer(det2,r2);
	end
	else if (r3.cod_usuario<r4.cod_usuario) and (r3.cod_usuario<r5.cod_usuario) then
	begin
		min := r3;
		leer(det3,r3);
	end
	else if (r4.cod_usuario<r5.cod_usuario) then
	begin
		min := r4;
		leer(det4,r4);
	end
	else
	begin
		min := r5;
		leer(det5,r5);
	end;
end;
	

BEGIN
	assign(mae,'maestro.dat');
	assign(det1,'detalle1.dat');
	assign(det2,'detalle2.dat');
	assign(det3,'detalle3.dat');
	assign(det4,'detalle4.dat');
	assign(det5,'detalle5.dat');
	reset(mae); reset(det1); reset(det2); reset(det3); reset(det4); reset(det5);
	leer(det1, regd1); leer(det2, regd2); leer(det3, regd3); leer(det4, regd4); leer(det5, regd5);
	minimo(regd1,regd2,regd3,regd4,regd5,min);
	// Se procesan los archivos detalle
	while (min.cod_usuario <> valoralto) do 
	begin
		//aux:= min;
		regm.cod_usuario:=min.cod_usuario;
		regm.fecha:=min.fecha;
		while (min.cod_usuario = regm.cod_usuario) do 
			total:=0;
			regm.fecha:=min.fecha;
		begin	
			while(min.fecha = regm.fecha) do
			begin
				total := total + min.tiempo_sesion;
				minimo (regd1,regd2,regd3,regd4,regd5,min);
			end;
			regm.tiempo_total := total;
			write (mae, regm);
		end;	
	end;
	
END.

