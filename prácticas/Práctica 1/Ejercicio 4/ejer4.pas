program ejer4;


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
	texto = text;
	
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

//ej4
procedure agregar_empleado(var arch:arch_emp);
var
	i:integer;
	cant:integer;
	emp,aux:empleado;
	ok:boolean;
begin
	write('Cuantos empleados quieres agregar? ');
	readln(cant);
	reset(arch);
	for i:=1 to cant do
	begin
		leer_empleado(emp);
		ok:=true;
		seek(arch,0);
		while(not eof(arch))do
		begin
			read(arch,aux);
			if(aux.numero=emp.numero)then
			begin
				ok:=false;
				break;
			end;
		end;
		if(ok)then
		begin
			seek(arch,filesize(arch));
			write(arch,emp);
		end
		else
			writeln('El numero de empleado ya existe');
	end;
	close(arch);
end;

procedure modificar_edad(var arch:arch_emp);
var
	emp:empleado;
	num:integer;
	ok:boolean;
begin
	write('Ingrese numero de empleado a modificar: ');
	readln(num);
	reset(arch);
	ok:=false;
	while(not eof(arch))do
	begin
		read(arch,emp);
		if(emp.numero=num)then
		begin
			ok:=true;
			break;
		end;
	end;
	if(ok)then
	begin
		write('Ingrese la nueva edad: ');
		readln(emp.edad);
		seek(arch,filepos(arch)-1);
		write(arch,emp);
		writeln('Edad modificada correctamente');
	end 
	else
		writeln('Numero empleado no encontrado');
	close(arch);
end;

procedure exportar_txt(var arch:arch_emp);
var
	emp:empleado;
	arch_text:texto;
begin
	assign(arch_text,'todos_empleados.txt');
	reset(arch);
	rewrite(arch_text);
	while(not eof(arch))do
	begin
		read(arch,emp);
		writeln(arch_text,'Numero: ',emp.numero);
		writeln(arch_text,'Nombre: ',emp.nombre);
		writeln(arch_text,'Apellido: ',emp.apellido);
		writeln(arch_text,'Edad: ',emp.edad);
		writeln(arch_text,'DNI: ',emp.dni);
		writeln(arch_text,'-----------');
	end;
	writeln('Datos exportados en todos_empleados.txt');
	close(arch_text);
	close(arch);
end;

procedure exportar_sin_dni_txt(var arch:arch_emp);
var
	emp:empleado;
	arch_text:texto;
begin
	assign(arch_text,'faltaDNIEmpleado.txt');
	reset(arch);
	rewrite(arch_text);
	while(not eof(arch))do
	begin
		read(arch,emp);
		if(emp.dni='00')then
		begin
			writeln(arch_text,'Numero: ',emp.numero);
			writeln(arch_text,'Nombre: ',emp.nombre);
			writeln(arch_text,'Apellido: ',emp.apellido);
			writeln(arch_text,'Edad: ',emp.edad);
			writeln(arch_text,'DNI: ',emp.dni);
			writeln(arch_text,'-----------');
		end;
	end;
	writeln('Empleados con DNI 00 exportados en faltaDNIEmpleado.txt');
	close(arch_text);
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
	writeln('5-Agregar empleados');
	writeln('6-Modificar edad');
	writeln('7-Exportar todo a txt');
	writeln('8-Exportar sin DNI a txt');
	writeln('0- Salir');
	readln(op);
	while(op<>0)do
	begin
		case op of
			1: crear_archivo(arch);
			2: listar_por_nombre(arch);
			3: mostrar_archivo(arch);
			4: listar_mayores(arch);
			5: agregar_empleado(arch);
			6: modificar_edad(arch);
			7: exportar_txt(arch);
			8: exportar_sin_dni_txt(arch);
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
		writeln('5-Agregar empleados');
		writeln('6-Modificar edad');
		writeln('7-Exportar todo a txt');
		writeln('8-Exportar sin DNI a txt');
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
