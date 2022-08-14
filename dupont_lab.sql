### \d -> PARA MOSTRAR LAS TABLAS:
### cargos - departamentos - empleados - job_grades - job_history - paises - regiones - ubicaciones

### Tablas y sus respectivos campos:

### cargos
### departamento_id | departamento_nombre  | gerente_id | ubicacion_id

### departamentos
### departamento_id | departamento_nombre  | gerente_id | ubicacion_id

### empleados
### empleado_id |   nombres   |  apellidos  |  email   |      telefono      | fecha_contrato |  cargo_id  |  sueldo  | porc_comision | gerente_id | departamento_id

### job_grades
### grade_level | lowest_sal | highest_sal

### job_history
### employee_id | start_date |  end_date  |   job_id   | department_id

### paises
### pais_id |       pais_nombre        | region_id

### regiones
### region_id |     region_nombre

### ubicaciones
### ubicacion_id |                direccion                 | codigo_postal |       ciudad        | provincia_estatal | pais_id


### 4. Presentar un reporte de todos los departamentos, la ciudad donde están establecidos,
### además del código de su ubicación,

SELECT * FROM departamentos;
SELECT * FROM ubicaciones;

### Answer:
SELECT departamento_id, departamento_nombre, ubicaciones.ciudad, ubicaciones.codigo_postal FROM departamentos 
INNER JOIN ubicaciones
ON departamentos.ubicacion_id = ubicaciones.ubicacion_id;

### 7. Presente un listado que exhiba para cada región los países que la conforman así
### como las ciudades que pertenecen a dichos países.

SELECT * FROM paises;
SELECT * FROM regiones;
SELECT * FROM ubicaciones;

### Answer:
SELECT region_nombre, paises.pais_nombre, ubicaciones.ciudad FROM regiones 
INNER JOIN paises
ON regiones.region_id = paises.region_id
INNER JOIN ubicaciones
ON paises.pais_id = ubicaciones.pais_id;


### 8. Elabore una consulta que presente un listado del código de ubicación del
### departamento, ciudad y el nombre del departamento para todas aquellas ciudades
### cuyo nombre no inicie en S.

SELECT * FROM departamentos;
SELECT * FROM ubicaciones;

### Answer:
SELECT departamento_id, ubicaciones.ciudad, ubicaciones.codigo_postal, departamento_nombre FROM departamentos 
INNER JOIN ubicaciones
USING (ubicacion_id)
WHERE ubicaciones.ciudad NOT LIKE 'S%';

### 9. Fresente un listado que mediante JOIN USING exhiba el nombre de región y las
### ciudades que pertenecen a EEUU.

### Answer:
SELECT region_nombre, paises.pais_nombre, ubicaciones.ciudad FROM regiones 
INNER JOIN paises
USING (region_id)
INNER JOIN ubicaciones
USING (pais_id)
WHERE paises.pais_nombre = 'United States of America';

### 11. Obtenga el total de tuplas de la tabla regiones y de Ia tabla países.

### Answer:
SELECT * FROM paises;
SELECT * FROM regiones;
SELECT * FROM regiones CROSS JOIN paises;

### 14. Diseña una consulta que presente todos los países cuyo nombre se inicie en A y las
### ciudades que le pertenecen (si hubiera)

### Answer:
SELECT * FROM paises 
RIGHT OUTER JOIN ubicaciones
USING (pais_id)
WHERE pais_nombre LIKE 'A%';

### 16. Diseñe una consulta que presente a los empleados que no tienen asignado un
### departamento.

SELECT * FROM empleados;

### Answer:
SELECT * FROM empleados
WHERE departamento_id IS NULL;

### 17. Diseñe una consulta que presente a todos los departamentos que no tienen asignados
### Empleados.

### Answer:
SELECT departamentos.departamento_id, departamentos.departamento_nombre FROM empleados
RIGHT OUTER JOIN departamentos
USING (departamento_id)
WHERE nombres IS NULL;


### 18. Elabore una consulta que presente en un único listado el código y nombre de todos los
### departamentos (inclusive los que no tienen empleados) acompañados del código y
### apellido de todos los empleados que laboran en la empresa (inclusive los que no
### tienen asignado un departamento).

### Answer:
SELECT departamento_id, departamento_nombre, empleados.empleado_id, empleados.apellidos FROM departamentos
FULL OUTER JOIN empleados
USING (departamento_id);

### 19. Elabore un listado donde figuren todos los empleados y sus empleadores bajo los
### títulos empleado y jefe rerpectivamente.


### Extra: El nombre de los jefes de los departamentos
SELECT empleados.departamento_id, departamento_nombre, departamentos.gerente_id, empleados.apellidos, empleados.email FROM departamentos
INNER JOIN empleados
ON departamentos.gerente_id = empleados.empleado_id;


### Answer:
SELECT empleados.empleado_id AS empleado_id,
empleados.nombres AS empleado_nombres,
empleados.apellidos AS empleado_apellidos,
empleados.email AS empleado_email, 
jefe.empleado_id AS jefe_id, 
jefe.nombres AS jefe_nombres, 
jefe.apellidos AS jefe_apellidos, 
jefe.email AS jefe_email FROM empleados
INNER JOIN (SELECT * FROM empleados) AS jefe
ON empleados.gerente_id = jefe.empleado_id;
