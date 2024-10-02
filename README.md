# Markus Bike Shop

Aplicación Web base para realizar pedidos de una bicicleta, los requisitos se han acotado a un tiempo prudente y a la especificación de requisitos de la prueba.

La aplicación ha sido construida con Ruby 3.2.5 + RoR 7.2.1 y se utiliza principalmente Bootstrap para estilos.
A continuación se emiten las asunciones y especificaciones.

## Asunciones

* Por cada pedido solo se puede pedir una sola bicicleta
* Solo tenemos un rol de usuario el cual puede crear un pedido, editar su order, borrar y mostrarlo.
* Las restricciones entre productos (productos llamados Components en el proyecto) van de 0..*, es decir una restricción engloba idealmente a 2 o más productos, abriendo así el abanico para tuplas más grandes de restricciones.

## Especificaciones

* Las restricciones entre productos (productos llamados Components en el proyecto) van de 0..*, es decir una restricción engloba idealmente a 2 o más productos, abriendo así el abanico para tuplas más grandes de restricciones, pudiendo hacer más escalable la solución que solo contempla tuplas de 2 componentes restringidos. (Clase ComponentConstraint)
* Al igual pasa con los conjuntos de componentes, en las especificaciones es explícito que al juntar dos productos uno de ellos puede alterar su precio, se ha generalizado que, teniendo un componente `source` al que se le aplicará el precio, la unión de 1..* componentes marcará el precio de este.
* La comprobación de restricciones entre productos se hacen de forma asíncronas con la vista. En la vista New Order, se irán inhabilitando los productos "que no están disponibles (que están restringidos).
* Al igual que pasa con las restricciones, los precios se irán mostrando de manera dinámica en la vista.

## Installation

Se ha preparado un entorno docker (con un docker-compose) para una aislada ejecución del proyecto y facilitaros la tarea de comprobación. Para ejecutarlo, simplemente ejecutar en raíz del proyecto:

```
docker-compose up
```

Esto construirá el proyecto y ejecutará los contenedores, el contenedor web crea la BD, lanza las migraciones y popula la base de datos en su inicio. La aplicación queda lista para atacarla desde localhost:3000
El peso de la imagen del proyecto está en torno a 1.2GB

## Aspectos a mejorar

* En un inicio se planteó un scope mayor y se plantearon vistas y controladores que han quedado como restos del proyecto pero que no tienen validez, por lo que hay ficheros extra en el proyecto que no se utilizan.
* La interfaz es básica y no está pulida
* Los principales métodos de como la validación de restricciones o el calculo de precios de conjuntos de componentes los plantearía de nuevo con una recursión típica con su caso base y caso recursivo.
* El TDD ha sido nulo en este proyecto, me veía limitado por el tiempo, crear un coverage completo de la funcionalidad es vital.

### Mejoras y cierre de leftovers
  * Crear la test suite
  * Implementar la gestión de roles para usuarios y atribuir la autorización a los distintos recursos de la aplicación.
  * Gestionar los CRUD de ComponentSet, Component y ComponentConstraints a un rol administrador de la aplicación.
  * Crear superadmin que pueda ver y editar todo
  * Pulir estilos y vistas

# Dificultades en el desarrollo (a modo de retrospectiva)
Los principales handicaps que me he encontrado:
* Plantear la aplicación Web como una API y atacarla con un framework front sería ideal pero al no dominar ninguno me llevaba demasiado tiempo aprenderlo para realizar la prueba
* Tampoco he utilizado Bootstrap a nivel profesional y la maquetación ha sido una tarea demandante.

   
