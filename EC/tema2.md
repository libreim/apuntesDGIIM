# Tema 2

## Estado visible al programador:

* Registros
* Contador del programa:PC.
* Registro de condición: cada bit tiene un significado de estad.

También un programador necesita ver:
* Si la memoria es direccionable por bytes
* Dónde está el inicio de la pila


### Ejemplo de trabajo

Código en c:

``` c++
int sum(int x,int y)
{
  int t = t+y
  return t;
}
```

Código en ensamblador IA32:

```
push1 %ebp
mov1 %esp,%ebp
mov1 12(%ebp)
addl 8(%ebp),%eax
pop1 %ebp
```
* %eax es el el regístro que conteiene la última operación hecha.
Almacena primero registros en la pila con el push, luego mueve los registros y los almacenos en otros registros y los manipula haciendo la operación y hago devuelvo los registros originales mediante el pop.


## Características del ensamblador:

### Datos
* Los datos __enteros__ son de 1, 2 ó 4 bytes. Son los que utilizaremos

* Existen los datos en punto flotante pero no los daremos
* No hay arrays ni Estructuras

### Operaciones

* De función aritmética
* De transferencia de datos entre memoria
* De control

### Ejemplo
