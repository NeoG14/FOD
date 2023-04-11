program Ej2;
var
	e:integer;
	enteros: text;
begin
	assign(enteros,'numeros.txt');
	reset(enteros);
	read(enteros,e);
	writeln(e);
	close(enteros);
end.
	
