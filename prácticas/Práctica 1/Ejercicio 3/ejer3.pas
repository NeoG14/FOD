program ejer3;
type
	dni=string[8];
	str=string[30];
	
	empleado=record
		numero:integer;
		apellido:str;
		nombre:str;
		edad:integer;
		dni:dni;
	end;
	
	arch_emp=file of empleado;
	
procedure leer_empleado(var reg:empleado);
begin
	write('apellido: ');
	readln(reg.apellido);
	if(reg.apellido<>'fin') then
	begin
		write('nombre: ');
		readln(reg.nombre);
		write('numero empleado: ');
		readln(reg.numero);
		write('edad: ');
		readln(reg.edad);
		write('DNI: ');
		readln(reg.dni);
	end;
end;

procedure crear_archivo(var arch:arch_emp);
var
	emp:empleado;
begin
	rewrite(arch);
	leer_empleado(emp);
	while(emp.apellido<>'fin') do
	begin
		write(arch,emp);
		leer_empleado(emp);
	end;
	close(arch);
end;

//inciso b
procedure listar_por_nombre(var arch:arch_emp);
var
	nombre:str;
	apellido:str;
	emp:empleado;
begin
	reset(arch);
	write('Ingrese nombre a buscar: ');
	readln(nombre);
	write('Ingrese apellido a buscar: ');
	readln(apellido);
	while(not eof(arch)) do
	begin
		read(arch,emp);
		if((emp.nombre=nombre) or (emp.apellido=apellido))then
			writeln('Numero: ',emp.numero,' Nombre: ',emp.nombre,' Apellido: ',emp.apellido,' Edad: ',emp.edad,' DNI: ',emp.dni);
	end;
end;

procedure mostrar_archivo(var arch:arch_emp);
var
	reg:empleado;
begin
	reset(arch);
	while(not eof(arch))do
	begin
		read(arch,reg);
		writeln('Numero: ',reg.numero,' Nombre: ',reg.nombre,' Apellido: ',reg.apellido,' Edad: ',reg.edad,' DNI: ',reg.dni);
	end;
	close(arch);
end;

procedure listar_mayores(var arch:arch_emp);
var
	emp:empleado;
begin
	reset(arch);
	while(not eof(arch)) do
	begin
		read(arch,emp);
		if(emp.edad>30)then
			writeln('Numero: ',emp.numero,' Nombre: ',emp.nombre,' Apellido: ',emp.apellido,' Edad: ',emp.edad,' DNI: ',emp.dni);
	end;
	close(arch);
end;

procedure menu(var arch:arch_emp);
var
	op:integer;
begin
	writeln('Seleccione una opcion:');
	writeln('1-Crear Archivo');
	writeln('2-lista por nombre o apellido');
	writeln('3-Listar todos los empleados');
	writeln('4-Listar mayores de 30');
	writeln('0- Salir');
	readln(op);
	while(op<>0)do
	begin
		case op of
			1: crear_archivo(arch);
			2: listar_por_nombre(arch);
			3: mostrar_archivo(arch);
			4: listar_mayores(arch);
			0: break;
		else
			writeln('Opcion Incorrecta');
		end;
		writeln();
		writeln('Seleccione una opcion:');
		writeln('1-Crear Archivo');
		writeln('2-lista por nombre o apellido');
		writeln('3-Listar todos los empleados');
		writeln('4-Listar mayores de 30');
		writeln('0- Salir');
		readln(op);
	end;
end;

var
	nom_logico:string;
	arch:arch_emp;
begin
	write('Ingrese nombre del archivo con el  cual trabajar: ');
	readln(nom_logico);
	assign(arch,nom_logico);
	menu(arch);
end.
