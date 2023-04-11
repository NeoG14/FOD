program Ejercicio3;
type
	empleado = record
		num:integer;
		apellido:string;
		nombre:string;
		edad:integer;
		dni:string
	end;
	
	archivo_empleados = file of empleado;
	
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

procedure listar(emp:empleado);
begin
	writeln('nombre: ',emp.nombre);
	writeln('apellido: ',emp.apellido);
	writeln('numero de empleado: ',emp.num);
	writeln('dni: ',emp.dni);
	writeln('edad: ',emp.edad);
end;


procedure crearArchivo(var empleados:archivo_empleados);
begin
	rewrite(empleados);
	close(empleados);
end;

procedure cargarArchivo(var empleados:archivo_empleados);
var
	emp:empleado;
begin
	reset(empleados);
	leer(emp);
	while(emp.apellido <> 'fin') do
	begin
		write(empleados,emp);
		leer(emp);
	end;
	close(empleados);
end;
//Inciso b1
procedure buscar(var empleados:archivo_empleados);
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
procedure listarEmpleados(var empleados:archivo_empleados);
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
procedure listaEmpleadosMayores(var empleados:archivo_empleados);
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
procedure unicidad(var empleados:archivo_empleados; cod_emp:integer;var b:boolean);
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
procedure cargarEmpleados(var empleados:archivo_empleados);
var
	emp:empleado;b:boolean;
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

// punto 4c
procedure exportar(var empleados:archivo_empleados; var todos_emp:archivo_empleados);
var
	emp:empleado;
begin
	rewrite(todos_emp);
	reset(empleados);
	while not eof(empleados) do 
	begin
		read(empleados,emp);
		write(todos_emp,emp)
	end;
	close(todos_emp);
	close(empleados);
end;
		
// punto 4d
procedure exportarSinDni(var empleados:archivo_empleados; var no_dni_emp:archivo_empleados);
var
	emp:empleado;
begin
	rewrite(no_dni_emp);
	reset(empleados);
	while not eof(empleados) do 
	begin
		read(empleados,emp);
		if(emp.dni='00')then
			write(no_dni_emp,emp);
	end;
	close(no_dni_emp);
	close(empleados);
end;
	
VAR
	empleados : archivo_empleados;
	todos_emp : archivo_empleados;
	no_dni_emp : archivo_empleados;
	opcion:integer;
	nombre_fisico:string[20];
BEGIN
	assign(todos_emp,'todos_empleados.txt');
	assign(no_dni_emp,'“faltaDNIEmpleado.txt');
	write('ingrese nombre del archivo a crear o utilizar: ');
	readln(nombre_fisico);
	assign(empleados,nombre_fisico);
	writeln('Seleccione una opcion:');
	writeln('0. Salir: ');
	writeln('1. Crear archivo y cargar datos'); 
	writeln('2. Listar Empleados');
	writeln('3. Añadir Empleados');
	writeln('4. Exportar todos los Empleados');
	writeln('5. Exportar los Empleados sin Dni');
	readln(opcion);
	while (opcion <> 0) do
	begin
		case opcion of
			1:
			begin
				crearArchivo(empleados);	
				cargarArchivo(empleados);
			end;
			2: 
			begin
				writeln('Seleccione una opcion:');
				writeln(' 1. listar por nombre o apellido');
				writeln(' 2. listar todos los empleados');
				writeln(' 3. listar los empleados mayores de 70 anios');
				readln(opcion);
				case opcion of
					1: buscar(empleados);
					2: listarEmpleados(empleados);
					3: listaEmpleadosMayores(empleados);
				else
					writeln('opcion incorrecta');
				end;
			end;
			3: cargarEmpleados(empleados);
			4: exportar(empleados,todos_emp);
			5: exportarSinDni(empleados,no_dni_emp);
			else
				writeln('opcion incorrecta');
				writeln('Seleccione una opcion:');
				writeln('0. Salir: ');
				writeln('1. Crear archivo y cargar datos'); 
				writeln('2. Listar Empleados');
				writeln('3. Añadir Empleados');
				writeln('4. Exportar todos los Empleados');
				writeln('5. Exportar los Empleados sin Dni');
				readln(opcion);
		end;
	end;	
END.

