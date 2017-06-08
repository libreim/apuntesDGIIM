---
title:	Resumen de los seminarios Arquitectura de Computadores
author: Doble grado Ingeniería Informática y matemática		
header-includes:      	 	        	
toc: true                   	
numbersections: true
fontsize: 11pt
geometry: margin=1in
---

\newpage

# Seminario 0. Atcgrid y TORQUE

Para estas prácticas hacemos uso de un servidor *front-end*:**Atcgrid**.
Este tiene un conjunto de nodos de cómputo, a los cuales les envía las
tareas de cálculo para obtener respuesta a las peticiones de los
usuarios.

Esto es posible mediante **TORQUE**, un gestor de colas y recursos.

## Comandos para TORQUE
Usamos comandos en atc mediante **ssh** para poder realizar los trabajos
que queramos en él. Además, para subir nuestros archivos al front-end
necesitamos comunicarnos con el servidor mediante **sftp**. Siempre
debemos de estar conectados a la VPN de la ugr (usar eduroam o bien
conectarse a la VPN con openconnect).

* psbnodes: Información sobre los nodos.
* qsub: Enviar un trabajo a ejecutar, devuelve la salida en un
fichero output(\*.o) y otro error (\*.e).

**Ejemplos de uso:**

* "echo 'hello' | qsub -q ac" $\rightarrow$ Envía el trabajo(programa)
hello por la cola ac
* "qstat" $\rightarrow$ Muestra los trabajos ejecutándose y los que
están en las colas

* "echo 'hello/trabajoMiTrabajo' | qsub -q ac -N “NombreMiNombre” "

\newpage

# Seminario 1. Directivas OPENMP

**Openmp** es una API, capa de abstracción que permite al programador
trabajar a través de una interfaz para aplicar el paralelismo en sus
programas. Comprende un conjunto de directivas del compilador,
funciones de biblioteca y variables de entorno.

Una **directiva** es "una marca" en nuestro archivo fuente que es sustituida por
el preprocesador del compilador por otro código que permite realizar
una tarea determinada sin tener que definirla nosotros explícitamente.


## Sintaxsis de las directivas C/C++

```c
#pragma omp <nombre_directiva> [<cláusula(s)>] <\n(newline)>
```
Donde:

* \#pragma omp es necesario para indicar que estamos usando una directiva de openmp.

* <nombre_directiva> es el nombre de la acción que realiza la directiva.

* <cláusula> es opcional, modifica o aporta información para la
ejecución de la directiva, pueden combinarse.

* <\\n(newline)> es el salto de línea necesario.

**Compilación:** Compilamos usando gcc -fopenmp para poder usar estas
directivas.


## Directivas

### Parallel
Especifica qué cálculos se realizarán en paralelo. Un thread master
crea un conjunto de threads cuando llega a esta directiva. El código
contenido en esta región es ejecutado por cada thread. No reparte las
tareas entre threads, tiene una barrera implícita y se pueden usar de
forma anidada.

```c
#pragma omp parallel
{
	//Code
}
```

### Trabajo compartido. Worksharing

**Paralelismo de datos(for):** Para distribuir las iteraciones de un bucle
entre los diversos hilos usamos:
```c
#pragma omp for
{
	//Code
}
```

**Paralelismo de tareas(sections):** Para distribuir trozos de código que son
independientes entre sí.
```c
#pragma omp sections
{
	#pragma omp section
	{
		//Codeblock 1
	}

	#pragma omp section
	{
		//Codeblock 2
	}
}
```

**Ejecución única(single):** Para que sólo un hilo ejecute un trozo de código
(lo cual interesa por ejemplo para pedir/mostrar datos al usuario del programa
una única vez en una situación de paralelismo).
```c
#pragma omp single
{
	//Code
}
```
### Combinando parallel con worksharing

Es posible, además del uso de las directivas de worksharing tras el
uso de la directiva parallel, realizar una versión combinada
única. Esto difiere del original tanto en legibilidad como en
prestaciones.

```c
#pragma omp parallel for
{
	//For loop
}
```

```c
#pragma omp parallel sections
{
	#pragma omp section
	{
		//Codeblock 1
	}

	#pragma omp section
	{
		//Codeblock 2
	}
}
```
### Directivas básicas de comunicación y sincronización
En diversas ocasiones nos interesa que la *lectura/escritura* de una
variable se hiciese en exclusión mutua (secuencial) para evitar que se
modifique o use un valor de manera incorrecta. Para esto veremos las
directivas **critical y atomic** y la directiva de “control”
**barrier**.


**Barrier:** Es una barrera que se situa en el punto en el que
esperamos que todos los threads lleguen ahí. Lo usamos cuando
necesitamos todos los cálculos de los threads hasta ese punto para que
no se produzcan errores.

**Critical:** Evita que varios threads accedan a variables compartidas
a la vez (situaciones de carrera). Un thread protege una variable frente a
los accesos de otros threads a la misma variable.

**Atomic:** Da una respuesta más eficiente que “*Critical*”.

### Directiva master
Es similar a la directiva single, pero en este caso la hebra que
ejecutará el bloque de código será la *thread master* o "*hebra 0*".

\newpage

# Seminario 2. Cláusulas OpenMP

Las **cláusulas** son las encargadas de ajustar el comportamiento de
las directivas. No pueden ser usadas en directivas tales como: master,
critical, barrier, atomic, flush, ordered o threadprivate.

## Ámbito de los datos por defecto. Compartición de datos.

Es conveniente saber qué valores tomarán las variables dentro de una
zona donde queramos hacer uso del paralelismo. Dejando claro si
queremos que la memoria se comparta o en cada thread se mantengan unos
datos privados.

Por lo general las variables declaradas fuera de una región y las
dinámicas son compartidas por los threads de la región. Mientras que
las variables declaradas dentro son privadas.

A excepción de esto nos encontramos los índices de los bucles for y
las variables declaradas *static*, que son privados y “públicas”
respectivamente.

### Shared
```c
#pragma omp parallel for shared(a,b,...,N)
```

Las variables indicadas por la lista son compartidas por los
threads. Hay que tener cuidado cuando un thread lea lo que otro
escribe en una variable de la lista.

### Private
```c
#pragma omp parallel for private(a,b,...,N)
```

De modo análogo a shared, indica una lista de variables cuya memoria
no es compartida. Es importante saber que el valor de entrada y de
salida están indefinidos aunque la variable haya sido definida antes
de la región (por lo cual es necesario definirlas dentro de esta).

Los índices de los bucles tienen un ámbito predeterminado privado si
se usa la directiva for.

### Lastprivate
```c
#pragma omp parallel for lastprivate(a,b,...,N)
```

Combina la protección que otorga private pero al salir de la región
paralela le asigna a las variables de la lista el último valor en una
ejecución secuencial. (En un bucle la ultima iteración y en una
construcción sections el valor que tuviese tras la última sección).

### Firstprivate
```c
#pragma omp parallel for firstprivate(a,b,...,N)
```

Combina la protección que otorga private pero al entrar en la región,
en lugar de tener valores indefinidos, asigna los valores que tenía
antes de entrar a cada variable de la lista para cada thread.

Útil para no olvidar la inicialización dentro de la región paralela cuando usamos variables private.

### Default
Con `default(<none/shared>)` podemos alterar el comportamiento por
defecto de las variables (sólo se puede usar una única vez. En caso de
`none` habrá que especififcar el alcance de todas las variables usadas
en la construcción por parte del programador.

Podemos excluir del ámbito por defecto usando todas las cláusulas de
compartición que hemos visto hasta ahora.

### Reduction
```c
#pragma omp parallel for reduction(operator:list)
```

Esta cláusula indica que las variables de la lista serán tratadas
según el operador indicado. Así de este modo se sumarán, restarán,
multiplicarán... todas las variables del mismo nombre en distintos
threads al final de la región tomando unos valores iniciales por
defecto (el neutro para el correspondiente operador).

**Operadores reduction (v3.0)**

C/C++


+------+-------+
| tipo |Valor  |
|      |inicial|
+------+-------+
|  \+  |   0   |
+------+-------+
|  \-  |   0   |
+------+-------+
|  \*  |   1   |
+------+-------+
|  &   |  ~0   |
+------+-------+
|  |   |   0   |
+------+-------+
|  ^   |   0   |
+------+-------+
|  &&  |   1   |
+------+-------+
|  ||  |   0   |
+------+-------+


### Copyprivate
```c
#pragma omp parallel
{
// init list vars

	#pragma omp single copyprivate(list)
	{
		//Codeblock
	}
}
```

Esta cláusula sólo se puede usar con la directiva single, y dentro de
una región paralela copia el valor de la variable en el thread que
ejecuta el single a la misma variable privada en los otros
threads. Esto es usado comúnmente en lecturas o peticiones al usuario
únicas.

# Seminario 3. Variables de OpenMP

##Variables de control


1. *dyn-var* controla el ajuste dinámico del nº de threads.
2. *nthreads-var* controla el nº de threads en la siguiente ejecución paralela.
3. *thred-limit-var* controla el máximo numero de threads.
4. *nest-var* controla el paralelismo anidado.
5. *run-sched-var* controla la planificacion de bucles para *runtime*

##Variables de entorno

Se evitan con #ifdef_OPENMP ...(funciones)... #endif para asegurarnos
de que sólo se usarán cuando estemos usando -fopenmp

1. *dyn-var* OMP_DYNAMIC export OMP_DYNAMIC=FALSE/TRUE
2. *nthreads-var* OMP_NUM_THREADS export OMP_NUM_THREADS=8
3. *thread-limit-var* OMP_THREAD_LIMIT export OMP_THREAD_LIMIT=8
4. *nest-var* OMP_NESTED export OMP_NESTED=TRUE/FALSE
5. *run-sched-var* OMP_SCHEDULE export OMP_SCHEDULE="static,4“/"dynamic"

##Funciones del entorno de ejecución

1. *dyn-var* omp_get_dynamic() omp_set_dynamic()
2. *nthreads-var* omp_get_max_threads() omp_set_num_threads()
3. *thread-limit-var* omp_get_thread_limit()
4. *nest-var* omp_get_nested() omp_set_nested()
5. *run-sched-var* omp_get_schedule(&kind, &modifier) omp_set_schedule(kind, modifier)

- omp_get_thread_num() - Devuelve al thread su identificador dentro del grupo de thread.
- omp_get_num_threads() - Obtiene el nº de threads que se están usando en una región paralela.
- omp_get_num_procs() - Devuelve el nº de procesadores disponibles para el programa en el momento de la ejecución.
- omp_in_parallel() -  Devuelve true si se llama a la rutina dentro de una región
parallel activa.

##Clausulas para interactuar con el entorno

_Prioridad:_

1º Cláusula id
2º Cláusula num_threads
3º Función omp_set_num_threads()
4º OMP_NUM_THREADS
5º Prefijado en la implementación

###Cláusula if

*Sintaxsis:* if(condición)

No hay ejecución paralela si no se cumple la condición

###Cláusula schedule

*Sintaxsis:*  schedule (kind[,chunk])

kind: static dynamic guided auto runtime

chunk: granularidad de la distribución

Solo se usa en bucles. Define el modo en el que se granula el trabajo
