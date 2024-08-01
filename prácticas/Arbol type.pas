program ejer1;

const 
	M=5;
type
	cliente=record
		numero:integer;
		nombre:string;
		apellido:string;
	end;
	
	nodo=record
		claves=array [1..M-1] of integer;
		hijos=array [1..M] of integer;
		N_claves=integer;
		enlaces=array [1..M-1] of integer; //NRR
	end;
	
	archivo_clientes=file of cliente;
	arbolB=file of nodo;
	
var
	Btree:arbolB;
	clientes:archivo_clientes;
	
BEGIN
	
	
END.
