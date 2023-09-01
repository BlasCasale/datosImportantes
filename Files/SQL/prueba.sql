/* paso a paso para crear una tabla*/

/*
id serial => te autoincrementa los id solo cuando se crea uno nuevo
PRIMARY KEY => mezcla de NOT NULL & UNIQUE, es identificatorio!
UNIQUE => es unico para cada tabla
NOT NULL => no puede faltar
*/

CREATE TABLE personajes 
(
    id serial PRIMARY KEY,
    name varchar(30) NOT NULL,
    status varchar(10) NOT NULL,
    location integer REFERENCES locations(id)
);

CREATE TABLE locations 
(
    id serial PRIMARY KEY,
    name varchar(30) NOT NULL UNIQUE
);

/* para empezar a insertar datos el primer paso es crear la location */
/* porque para crear los personajes nos va a pedir location */
/* para ingresar datos hay que usar comillas simples ' ' "Strings" */

INSERT INTO locations(name)
VALUES('Earth');
INSERT INTO locations(name)
VALUES('Mars');
INSERT INTO personajes(name,status,location)
VALUES('Rick Sanchez', 'Alive', 1);
INSERT INTO personajes(name,status,location)
VALUES('Morty Smith', 'Alive', 1);
INSERT INTO personajes(name,status,location)
VALUES('Juan Verstraten', 'Alive', 2);
INSERT INTO personajes(name,status,location)
VALUES('Miguel Fernandez', 'Dead', 2);
INSERT INTO personajes(name,status,location)
VALUES('Nelson Macias', 'Dead', 3);
INSERT INTO personajes(name,status)
VALUES('Blas Casale', 'Alive');

/* para consultar */

/* 
esto va entre el SELECT y el FROM
"*" => todos los campos
(param) => un parámetro en particular entre () para a cierta tabla  
*/

SELECT * FROM locations;
SELECT * FROM personajes;


/* para eliminar un registro de una tabla */

/* DELETE FROM locations; => asi se borra toda una tabla */

/* asi se escribe bien, NO EXISTE DELETE SIN WHERE */
DELETE FROM locations
WHERE id=5;


/* SELECT FROM con una condicion para filtrar usando WHERE */
/* se puede filtrar asi para que no lleguen, anidación de condiciones */
/* 
el AND & OR son los mismos operadores logicos que en JS y se puede 
filtrar la busqueda como en JS para devolver datos al back 
*/

SELECT * FROM personajes
WHERE status='Alive' OR location=3;
-- WHERE status='Alive' AND location=3;
-- WHERE status='Alive';
/* WHERE location=1; (los que estan en 'Earth') */


/* ORDER BY */
/* con esto podemos filtrar y ordenar de la manera que queramos */

SELECT * FROM personajes
WHERE status='Alive' OR location=3
ORDER BY name; -- se puede poner ASC(ascendente(default)) o DES(inversa)
-- despues del ORDER BY se pone el campo o criterio a utilizar

/* GROUP BY */
-- para agrupar hay que coincidir el SELECT y el GROUP BY

-- con esto se puede hacer conteo del "status" que esta en SELECT
-- como parametro al COUNT se le pasa el "id" de los "personajes"
SELECT status, COUNT(id) FROM personajes 
GROUP BY status;


/* SUB QUERY */
/* es una consulta dentro de otra consulta en SQL, se utiliza 
para obtener datos mas específicos y precisos, filtrando los 
resultados de la consulta principal
*/

-- en el SELECT van las tablas con los datos que voy a elegir
-- en el FROM junto con el JOIN elijo las tablas que voy a unir
-- esto conecta ambas tablas con los datos que le ingresamos anteriormente
-- con el as p o l abrevio el nombrar personajes y locations arriba en el SELECT
-- arriba cuando me devuelve la nueva tabla de consulta puede cambiarle el nombre que me va a devolver en esa tabla como en l.name as planeta
SELECT p.name, p.status, l.name as planeta
FROM personajes as p JOIN locations as l ON p.location = l.id;



-- otro ejemplo
CREATE TABLE customers (
    customer_id serial PRIMARY KEY,
    customer_name varchar(20) NOT NULL,
    city varchar(25) NOT NULL
);

CREATE TABLE orders (
    order_id serial PRIMARY KEY,
    customer_id integer references customers(customer_id),
    order_date date,
    total_amount numeric(10,2)
);

INSERT INTO orders (customer_id, order_date, total_amount)
VALUES(2,'2023-04-20', 600.00);

-- en el SELECT cuando cree la tabla de la QUERY lo que va a hacer es asignarle el valor de lo seleccionado a cada columna y despues voy comparando los datos para que coincida
SELECT cust.customer_name, ord.order_date, ord.total_amount
FROM orders as ord
JOIN customers as cust ON ord.customer_id = cust.customer_id
ORDER BY ord.total_amount DESC;


SELECT * 
FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    WHERE city = 'Brasilia'
);