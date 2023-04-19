program Ejercicio3;

type
	empleado = record
		num:string;
		apellido:string;
		nombre:string;
		edad:integer;
		dni:string
	end;
	
	archivo = file of empleado;
	txt = text;
	
procedure leer(var emp:empleado);
begin
	write('ingrese apellido del empleado: ');
	readln(emp.apellido);
	if(emp.apellido <> 'fin')then
	begin
		write('ingrese nombre del empleado: ');
		readln(emp.nombre);
		write('ingrese numero del empleado: ');
		readln(emp.num);
		write('ingrese edad del empleado: ');
		readln(emp.edad);
		write('ingrese dni del empleado: ');
		readln(emp.dni);
	end;
end;

procedure leerArchivo(var arc:archivo; var emp:empleado);
begin
	if(not eof(arc)) then
		read(arc,emp)
	else
		emp.num:= '-1';
end;

procedure listar(emp:empleado);
begin
	writeln('nombre: ',emp.nombre);
	writeln('apellido: ',emp.apellido);
	writeln('numero de empleado: ',emp.num);
	writeln('dni: ',emp.dni);
	writeln('edad: ',emp.edad);
	writeln('--------------------------------');
end;

// Inciso a
procedure crearArchivo(var empleados:archivo);
var
	emp:empleado;
begin
	rewrite(empleados);
	leer(emp);
	while(emp.apellido <> 'fin') do
	begin
		write(empleados,emp);
		leer(emp);
	end;
	close(empleados);
end;

//Inciso b1
procedure listarPorNombre(var empleados:archivo);
var
	nombre,apellido:string;
	emp:empleado;
begin
	write('Ingrese nombre del empleado: ');
	readln(nombre);
	write('Ingrese apellido del empleado: ');
	readln(apellido);
	reset(empleados);
	writeln('Empleados con nombre: ',nombre,' o apellido: ',apellido);
	while not eof(empleados) do
	begin
		read(empleados,emp);
		if ( (emp.nombre = nombre) or (emp.apellido = apellido) ) then
			listar(emp);
	end;
	close(empleados);
end;

//Inciso b2
procedure listarEmpleados(var empleados:archivo);
var
	emp:empleado;
begin
	reset(empleados);
	writeln('Listado completo de empleados: ');
	while not eof(empleados) do
	begin
		read(empleados,emp);
		listar(emp);
	end;
	close(empleados);
end;

//inciso b3
procedure listaEmpleadosMayores(var empleados:archivo);
var 
	emp:empleado;
begin
	reset(empleados);
	writeln('Empleados proximos a jubilarse: ');
	while not eof(empleados) do
	begin
		read(empleados,emp);
		if(emp.edad>70)then
			listar(emp);
	end;
	close(empleados);
end;

//comprobar unicidad
procedure unicidad(var empleados:archivo; cod_emp:string; var b:boolean);
var
	emp:empleado;
begin
	//pocisionamiento al principio para comenzar la busqueda
	b:=true;
	seek(empleados,0);
	while not eof(empleados) do
	begin
		read(empleados,emp);
		if(emp.num=cod_emp)then
			b:=false;
	end;
end;

// punto 4a
procedure cargarEmpleados(var empleados:archivo);
var
	emp:empleado;
	b:boolean;
begin
	reset(empleados);
	leer(emp);
	while(emp.apellido <> 'fin') do
	begin
		unicidad(empleados,emp.num,b);
		if(b)then
			write(empleados,emp)//aca no compruebo porque el puntero se encuentra en eof
		else
			writeln('el numero de empleado ya existe: ');
		leer(emp);
	end;
	close(empleados);
end;
//punto 4b
procedure modificarEdad(var empleados:archivo);
var
	num:string;
	emp:empleado;
begin
	reset(empleados);
	write('Ingrese numero de empleado a modificar: '); readln(num);
	leerArchivo(empleados,emp);
	while(num<> '-1') do
	begin
		while( (emp.num<>'-1') and (num<>emp.num) ) do
			leerArchivo(empleados,emp);
		if(num=emp.num)then
		begin
			writeln('Ingrese la nueva edad'); readln(emp.edad);
			seek(empleados,filepos(empleados)-1);
			write(empleados,emp);
		end
		else
			writeln('No se encontro el numero ingresado');
		write('Ingrese numero de empleado a modificar: '); readln(num);
	end;
	close(empleados);
end;

// punto 4c
procedure exportarATxt(var empleados:archivo);
var
	emp:empleado;
	emp_txt:txt;
begin
	assign(emp_txt,'todos_empleados.txt');
	rewrite(emp_txt);
	reset(empleados);
	while not eof(empleados) do 
	begin
		read(empleados,emp);
		writeln(emp_txt,'nombre: ',emp.nombre);
		writeln(emp_txt,'apellido: ',emp.apellido);
		writeln(emp_txt,'numero de empleado: ',emp.num);
		writeln(emp_txt,'dni: ',emp.dni);
		writeln(emp_txt,'edad: ',emp.edad);
		writeln(emp_txt,'--------------------------------');
	end;
	close(emp_txt);
	close(empleados);
end;
		
// punto 4d
procedure exportarSinDni(var empleados:archivo);
var
	emp:empleado;
	emp_txt:txt;
begin
	assign(emp_txt,'faltaDNIEmpleado.txt');
	rewrite(emp_txt);
	reset(empleados);
	while not eof(empleados) do 
	begin
		read(empleados,emp);
		if(emp.dni='00')then
		begin
			writeln(emp_txt,'nombre: ',emp.nombre);
			writeln(emp_txt,'apellido: ',emp.apellido);
			writeln(emp_txt,'numero de empleado: ',emp.num);
			writeln(emp_txt,'dni: ',emp.dni);
			writeln(emp_txt,'edad: ',emp.edad);
			writeln(emp_txt,'--------------------------------');
		end;
	end;
	close(emp_txt);
	close(empleados);
end;

procedure mostrarMenu();
begin
	writeln('------------------------------------------------');
	writeln('1- Crear archivo de empleados');
	writeln('2- Listar empleados por nombre o apellido');
	writeln('3- Listar Todos los empleados');
	writeln('4- Listar todos los empleados mayores a 70 anios');
	writeln('5- Agregar empleados al archivo');
	writeln('6- Modificar edad de empleados');
	writeln('7- Exportar datos a texto');
	writeln('8- Exportar empleados sin dni a texto');
	writeln('0- SALIR');
	writeln('------------------------------------------------');
end;

procedure ejercutarPrograma(var arc:archivo);
var
	nombre:string;
	opc:integer;
begin
	write('ingrese nombre del archivo para trabajar: '); readln(nombre);
	assign(arc,nombre);
	mostrarMenu();
	readln(opc);
	while(opc<>0) do
	begin
		case opc of
			1:crearArchivo(arc);
			2:listarPorNombre(arc);
			3:listarEmpleados(arc);
			4:listaEmpleadosMayores(arc);
			5:cargarEmpleados(arc);
			6:modificarEdad(arc);
			7:exportarATxt(arc);
			8:exportarSinDni(arc);
			else 
				writeln('Opcion Incorrecta');
			mostrarMenu();
			readln(opc);
		end;
	end;
end;

VAR
 	arc:archivo;

BEGIN
	ejercutarPrograma(arc);
END.
