# SISTEMAS CONCURRENTES Y DISTRIBUIDOS

## Tema 1. Introducción

### 1. Conceptos básicos y motivación

#### 1.1 Modelos básicos relacionados con la concurrencia

- Programa secuencial: Declaraciones de datos y conjunto de instrucciones sobre dichos datos que se deben ejecutar en secuencia.

- Programa concurrente: conjunto de programas secuenciales ordinarios que se pueden ejecutar *lógicamente* en paralelo.

- Proceso: Ejecución de un programa secuencial.

- Concurrencia: Describe el potencial para ejecución paralela, es decir, el solapamiento real o virtual de varias actividades en el tiempo.

- Programación concurrente: Conjunto de notaciones y técnicas de programación usadas para expresar paralelismo potencial y resolver problemas de sincreonización y comunicación. La programación concurrente es independiente de la implementación del paralelismo. Es una abstracción.

- Programación paralela: Su principal objetivo es acelerar la resolución d eproblemas concretos mediante el aprovechamiento de la capacidad de procesamiento en paralelo del hardware disponible.

- Programación distribuida: Su principal objetivo es hacer que varios componentes software localizados en diferentes ordenadores trabajen juntos.

- Programación de tiempo real: Se centra en al programación de sistemas que están funcionando continuamente, recibiendo entradas y enviando salidas a/desde componentes hardware en los que se trabaja con restricciones muy estrictas en cuanto a la respuesta temporal.



### 2. Modelo abstracto y consideraciones sobre el hardware

#### 2.1 Consideraciones sobre el hardware
#### 2.2 Modelo abstracto de concurrencia

##### Sentencia atómica
Una sentencia o instrucción de un proceso en un programa concurrente es atómica (indivisble) si siempre se ejecuta de principio a fin sin verse afectada por otras sentencias en ejecución de otros procesos del programa. No se verá afectada cuando el funcionamiento de dicha instrucción no dependa nunca de como se estén ejecutando otras instrucciones. El funcionamiento de una instrucción se define por su efecto en el estado de ejecución del programa justo cuando acaba. El estado de ejecución está formado por los valores de las variables y los registros de todos los procesos.

Algunos ejemplos de intrucciones atómicas son:

- Leer una celda de memoria y cargar su valor en ese momento en un registro del procesador.
- Incrementar el valor de un regristro (u otras operaciones aritméticas entre registros).
- Escribir el valor de un regristro en una celda de memoria.

La mayoría de sentencias en lenguajes de alto nivel son típicamente no atómicas. Por ejemplo, la sentencia

*x = x+1*

consta en realidad de una secuencia de 3 sentencias:

1. Leer el valor de x y cargarlo en un registro *r* del procesador.
2. Incrementar en una unidad el valor almacenado en el regristro *r*.
3. Escribir el valor del registro r en la variable *x*.

El resultado depende de que haya o no otras sentencias ejecutándose a la vez y escribiendo simultáneamente sobre la variable *x*. Hay indeterminación (no se puede predecir el estado final a partir del inicial).

Si tenemos un programa *C* compuesto por dos procesos *P_A* y *P_B* que se ejecutan a la vez, las ejecución sentencias atómicas de cada uno de estos procesos pueden darse en múltiples órdenes (interfoliaciones). Las sentencias atómicas se ordenan en función del instante en que acaban. El modelo basado en el estudio de las posibles secuencias de ejecución entrelazadas de los procesos constituye una abstracción:
- Se consideran exclusivamente caracterísitcas relevantes que determinan el resultado del cálculo.
- Esto permite simplificar el análisis y diseño de los programas concurrentes.

Se ignoran los detalles no relevantes para el resultado, como or ejemplo:

- Las áreas de memoria asignadas a los procesos.
- Los registros particulares que están usando.
- El costo de los cambios de contexto entre procesos.
- La política del SO relativa a la asignación de CPU.
- Las diferencias entre entornos multiprocesador o monoprocesador.

##### El entrelazamiento preserva la consistencia

El resultado de una instrucción individual sobre un dato no depende de las circunstancias de la ejecución. Supongamos que un programa *P* se compone de dos instrucciones atómicas, *I_0* e *I_1* que se ejecutan concurrentemente. Entonces:
- Si *I_0* e *I_1* nmo acceden a la misma celda de memoria o registro, el orden de ejecución no afecta al resultado final.
- Si *I_0* carga en la posición *M* de memoria un dato 1, e *I_1* carga un dato 2, entonces al final de la ejecución se dará *M = 1* o *M = 2*, pero nunca *M = 3*.

##### Progreso finito

No se puede hacer una suposición acerca de las velocidades absolutas o relativas de ejecución de los procesos, salvo que son mayores que 0. Un programa concurrente se entiende en basesa a sus componentes (procesos) y sus interacciones, sin tener en cuenta el entorno de ejecución.

Si se cumple la hipótesis, la velocidad de ejecución de cada proceso será no nula, lo cual tiene dos consecuencias. Desde el puntod e vista global, durante la ejecución del programa concurrente, en cualquier momento existirá al menos 1 proceso preparado. Desde el punto de vista local, cuando un proceso concreto de un programa concurrente comienza la ejecución de una sentencia, completará la ejecución de la sentencia en un intervalo de tiempo finito.

##### Estado e historia de ejecución de un programa concurrente

El estado de un programa concurrente son los valores de las variables del programa en un momento dado. Incluyen variables declaradas explícitamente y variables con información de estado oculta.
Un programa concurrente comienza su ejecución en un estado inicial y los procesos van modificando el estado conforme se van ejecutando sus sentencias atómicas.

La hostoria o traza de un rpograma concurrente son secuencias de estados producidas por una secuencia concreta de interfoliación.

##### Grafo de sincronización

El *grafo de sincronizació* es un grafo dirigido acíclico donde cada nodo representa una secuencia de sentencias del programa.

Dadas dos actividaddes *A* y *B*, una arista desde *A* hacia *B* significa que *B* no puede comenzar su ejecución hasta que *A* haya finalizado.

El grafo de sincronización muestra las restricciones de precedencia que determinan cuándo una actividad puede empezar en un programa.

##### Definición estática de procesos

El número de procesos (arbitrario) y el código que ejecutan no cambian entre ejecuciones. Cada proceso se asocia con su identificador y su código mediante la palabra clave process.

El programa acaba cuando acaban todos los procesos. Las variables compartidas se inicializan antes de comenzar ningún proceso.

Sew pueden usar definiciones estáticas de grupos de procesos similares que solo se diferencian en el valor de una constante (vectores de procesos).

##### Creación de procesos no estructurada con fork-join

**fork**: sentencia que especifica que la rutina nombrada puede comenzar su ejecución al mismo tiempo que comienza la sentencia siguiente (bifurcación).

**join**: sentencia que espera la terminación de la rutina nombrada, antes de comenzar la sentencia siguiente (unión).

##### Creación de procesos no estructurada con cobegin-coend

Las sentencias en un bloque delimitado por cobegin-coend comienzan su ejecución todas ellas a la vez.

En el coend es espera a que se terminen todas las sentencias. Hace explícuto qué rutinas van a ejecutarse concurrentemente.

### Exclusión mutua y sincronización

#### Concepto de exclusión mutua

Se´gun el modelo abstracto, los procesoso concurrentes ejecutan sus instrucciones atómicas de forma que, en principio, el entremezclado en el tiempo es arbitrario. Sin embargo, en un conjunto de porcesos que no son independientes entre sí (cooperativos) algunas de las posibles formas de combinar las secuencias no son válidas.

En general, se dice que hay una condición de sincronización cuando esto ocurre, es decir, que hay alguna restricción sobre el orden en el que se pueden mezclar las instrucciones de distontos procesos.

Un caso particular es la exclusión mutua, secuencias finitas de intrucciones que deben ejecutarse de principio a fin por un único proceso, sin que a la vez otro proceso las esté ejecutando también.

La restricción se refiere a una o varias secuencias de instrucciones consecutivas que aparecen en el texto de uno o varios procesos. Al conjunto de dicas secuencias de instrucciones se le denomina sección crítica (SC). Ocurre exclusión mutua (EM) cuando los procesos solo funcionan correctamente si, en cada instante de tiempo, hay como mucho uno de ellos ejecutando cualquier instrucciuón de la serie crítica.

El solapamiento de las instrucciones debe ser tal que cada secuencia de instrucciones de la SC se ejecuta como mucho por un proceso de principio a fin, sin que durante ese tiempo otros procesos ejecuten ninguna de estas instrucciones ni otras de la misma SC.

Un ejemplo típico de EM ocurre en procesos con memoria compartida que acceden para leer y modificar variables o estructuras de datos comunes usando operaciones no atómicas.
