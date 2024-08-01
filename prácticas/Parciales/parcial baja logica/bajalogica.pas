program ejer1;

type



procedure compactar(var arch:archivo);
var
	reg:prenda;
	i:integer;
begin
	reset(arch);
	leer(arch,reg);
	while(reg.codigo<>valorAlto)do
	begin
		if(reg.stock=-1)then
		begin
			i:=(filepos(arch)-1)
			seek(arch,filesize(arch)-1);
			read(arch,reg);
			seek(arch,i);
			write(arch,reg);
			seek(arch,filesize(arch)-1);
			truncate(arch);
			seek(arch,i);
		end;
	end;
end;

BEGIN
	
	
END.
