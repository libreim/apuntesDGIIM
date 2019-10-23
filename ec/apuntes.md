# Estructura de computadores. Tema Introducción.

## Estructuras de bus
Existen:

* Bus único: Barato, sencillo pero muy ineficiente
* Bus múltiple: es un bus de sistema que comunica CPU-Memoria

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

# Instrucciones en Ensamblador


__push:__ Decrementa el puntero de pila (ESP) el número de posiciones de memoria que ocupe el dato a insertar, posteriormente procede a escribir el dato en esas posiciones reservadas, a partir de donde apunta ESP ahora

    push %edx

__pop:__ Lee el tope de la pila, guardando el valor de esa dirección donde indique el argumento, posteriormente incrementa el puntero de pila (ESP)

    pop %edx

__call:__ Guarda la dirección de retorno en la pila antes de saltar a la subrutina indicada como argumento

    call suma     (llama a la subrutina etiquetada como "suma")

__ret:__ Recupera de la pila la dirección de retorno

    ret

__mov:__ Mueve el src al dest

    mov $0,%eax

__add:__ Suma al registro de destino el src

    add (%ebx,%ebx,4),%eax

    (Con el formato (%ebx,%edx,4) %ebx es el registro base, al cual se le suma el contenido de %edx, multiplicado por 4 y se añade en %eax)

__inc:__ Incrementa en una unidad el registro indicando

    add %edx

__cmp:__ Compara el contenido de dos registros


__jne:__ Salta a la subrutina indicada por la etiquetada si

