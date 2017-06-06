
# Algorítmica

## Introducción. 

La ciencia de la computación es el estudio de los algoritmos,
incluyendo sus propiedades, hardware, aspectos lingüísticos y
aplicaciones.

Podemos definir un __Algoritmo__ como una secuencia ordenada y finita
de pasos no ambiguos tales que al llevarse a cabo, dará como resultado
que se realice la tarea para la que se ha diseñado en un tiempo finito
y con recursos limitados. 

De esta forma, no podemos por ejemplo obtener la sucesión de
__Fibonacci__ mediante un algoritmo pues esta es infinita. 

_Nota_ : Debemos tener claro que hay una diferencia entre un programa y un algoritmo. Un programa es una serie de instrucciones ordenadas codificadas en un lenguaje de programación que *expresa* un algoritmo.


### Los algoritmos. 

Un algoritmo es una secuencia finita y ordenada de pasos, exentos de
ambigüedad, tal que al llevarse a cabo dará el resultado esperado a la
tarea esperada. Se resuelve con recursos limitados y tiempo finito. 

* _Definición de Bazaara_ : algoritmo como proceso iterativo.

* _Definición de Knuth_ : 

  Un método computacional es una cuaterna $(Q,I,\Omega,f)$ en la que
  $Q$ es un conjunto que contiene a $I$ y a $\Omega$ como subconjuntos
  y $f$ es una función de $Q$ en $Q$ tal que:

$$f(q) = q \ \ \ \forall q \in \Omega$$ 

y donde $Q$ es el conjunto de estados del cálculo, I la entrada ,
$\Omega$ la salida y $f$ la regla de cálculo aplicada. Cada entrada
$x\in I$ define una sucesión computacionel $x_0,...,x_n$ tal que $x_0
= x$ y $x_{k+1}=f(x_k)$ si $k\geq 0$. 

  Se dice que la sucesión computacional termina en $k$ etapas si $k$ es el menor entero para el cual $x_k$ está en $\Omega$ y en esa caso, a partir de $x$ se obtiene como salida $x_k$.

#### Ejemplo: Algoritmo de Euclídes 

Dados dos enteros m y n, calcular su m.c.d: 

* _E1_ : Calculo del resto de m entre n. 
* _E2_ : Si el resto es 0, el algoritmo termina y la solución es n. 
* _E3_ : Tomo m=n y n=r, vuelvo a _E1_ y repito el proceso.


### Propiedades de los algoritmos 

Los algoritmos tienen un conjunto de propiedades comunes a todos
ellos: 

* _Finitud._ Se puede completar en un número finito de pasos. 
* _Especifidad._ Cada etapa del algoritmo está definida y descrita
  correctamente para dar respuesta a una parte determinada del
  problema. 
* _Input._ El algoritmo recibe una entrada de datos. 
* _Output._ El algoritmo devuelve un resultado en base a estos datos. 
* _Efectividad._ Se completa en un tiempo determinado, que viene dado
  por el número de operaciones que se requieren para afrontar el
  problema. 

Además los algoritmos dependen tanto de sus propiedades de forma y
matemáticas, como del hardware en el que sean ejecutadas. Según el uso
que se le quiera dar al algoritmo se implementará en un lenguaje de
programación o en otro.


### Etapas en la elaboración de un algoritmo 

1. _Construcción:_ Acto de crear un algoritmo. 

2. _Expresión de algoritmos:_ Cada paso debe de describirse de manera
   clara. 

3. _Validación:_ Que calcule los resultados esperados al problema
   dado. Es una frase previa a la escritura del programa. 

4. _Análisis:_ Comprobar el tiempo que tardaría, así como el tamaño
   que ocuparía. Permite realizar comparaciones teóricas entre
   algoritmos. 

5. _Test:_ Corrección de errores que se detecten y comparación de
   resultados. 
   
La elección final de un algoritmo dependerá, como ya hemos dicho
antes, tanto del número de operaciones que se requieran como de los
recursos de hardware disponibles. También son otros factores a
considerar la adaptación a cualquier tipo de computador, la
simplicidad y elegancia del algoritmo y del coste económico de su
realización, así como su eficiencia, rapidez y facilidades de
programación. 

Para probar un algoritmo y validarlo, interesa probar su comportamiento y funcionamiento en los casos extremos, que prevemos que podría causar errores en su funcionamiento.

#### Comportamiento: Algoritmos Selección y Ordenación 

Un mismo algoritmo puede dar diversos tiempos en función de los datos
del problema que desee resolver. 

__Caso inicial:__ U y V arrays de n elementos. U ordenado de forma
ascendente y V de forma descendente. 

* _Selección:_ Indiferentes U y V. Menos de 15% de diferencia en sus
  ejecuciones. 

* _Inserción:_ Para U y 5000 elementos tarda $\frac{1}{5}$ segundos.
Para V y 5000 elementos tarda 3 minutos y medio.

## Tema 1: La Eficiencia de los Algoritmos

### Cálculo de la eficiencia de un algoritmo 

Podemos destacar tres métodos para calcular la eficiencia e un algoritmo:
  
1. _Enfoque empírico o (a posteri):_ Programar los diferentes
   algoritmos candidatos y ejecutarlos sobre diferentes casos con
   ayuda de un ordenador. 

2. _Enfoque teórico o (a priori):_ Trata de determinar matemáticamente
   la cantidad de recursos necesarios para cada algoritmo como una
   función del tamaño de los casos considerados. 

3. _Enfoque Híbrido:_ Determina teóricamente la forma de la función
   que describe la eficiencia del algoritmo y cualquier parámetro
   numérico que se necesite se determina empíricamente con un
   ordenador.

El tiempo de ejecución de un programa depende de: 

1. _Input del programa._ 

2. _Calidad del código generado por computador._ 

3. _Naturaleza y velocidad de instrucciones máquina._ 

4. _Complejidad del algoritmo._ 

No siempre un algoritmo es mejor cuanto menor sea su tiempo de
ejecución por ejemplo: 

Sean dos algoritmos que consumen uno $n^3$ días y otro $n^2$ segundos,
el primero es mejor asintóticamente hablando y el segundo mejor que el
primero desde un punto de vista práctico, ya que la constante *oculta*
lo hace mejor. 

### Notaciones O y $\Omega$ 

Para poder comparar los algoritmos empleando los tiempos de ejecución,
se emplea una notación asintótica, según la cual un algoritmo de
ejecución T(n) se dice que es de orden O(f(n)), si existe una
constante positiva c y un número entero $n_0$ tales que: 
 

$$\forall \ n \geq n_0 \longrightarrow T(n) \leq cf(n)$$ 

Así queda claro que cuando T(n) es O(f(n)), lo que estamos dando es
una cota superior para el tiempo de ejecución, que siempre referiremos
al peor caso del problema en cuestión. 

De manera análoga, se introduce la notación $\Omega(n)$. 

Se dice que un algorítmo A es de orden $\Omega(f(n))$, donde $f(n)$
es una función matemática, cuando existe una implementación del mismo
cuyo tiempo de ejecución $T_A(n)$ es mayor o igual que $k\cdot f(n)$,
donde K es constante, para "tamaños de casos grandes". Formalmente: 

$$ A\ es\ \Omega(f(n)) \Leftrightarrow \exists K \in \Re ^+, \exists
n_0 \in N:T_a(n) \leq K\cdot f(n) \forall n \leq n_0$$ 

Es de destacar la simetría de ambas notaciones, mientras que una acota
superiormente, la otra lo hace inferiormente. Una de las razones por
lo que esto es útil, es porque hay veces en las que un algoritmo es
rápido, pero no lo es para los _inputs_ por lo que debemos de estar
dispuestos a saber lo menos que estamos dispuestos en consumir tiempo
para resolver cualquier caso de un problema. 

### Notación $\Theta$ 

Se dice que un algoritmo A es de orden $\Theta (f(n))$, donde $f(n)$
es una función matemática, cuando existe una implementación del mismo
con órdenes de eficiencia $O(f(n))\ y\ \Omega (f(n))$.

### Llamadas a funciones recursivas: Ecuaciones en recurrencias 

Para calcular el tiempo de ejecución T(n) de una función recursiva hay
que plantear el problema con ecuaciones recurrentes.

**Método general:** Para resolver la ecuación en recurrencia T(n) =
c + T(n-1) podemos expandir la ecuación hasta el caso
base. $(n-1)\cdot c + T(1) = (n-1)\cdot c + c$

$T(n) = c\cdot n \leq K\cdot n$. Luego el algoritmo sería de orden
O(n).

**La ecuación característica:** Estudiaremos los siguientes casos de
ecuaciones:

* Lineales homogéneas de coeficientes constantes
* Lineales no homogéneas de coeficientes constantes

Teniendo en cuenta cambios de variable y de recorrido.

Reescribiendo T(n) como $t_n$ son del tipo:
$$a_0t_n + a_1t_{n-1}+...+a_kt_{n-k} = 0$$

Pasos:

1. Se considera $t_n = x^n$:
$$a_0x^n + a_1x^{n-1}+...+a_kx^{n-k} = 0$$

2. Se saca factor común $x^{n-k}$:
$$(a_0x^k + a_1x^{k-1}+...+a_k)x^{n-k} = 0$$

Entonces como c no es cero, el otro término vale cero, obteniendo así
la ecuación característica:

$$a_0x^k + a_1x^{k-1}+...+a_k = 0$$

Esta ecuación se resuelve como:

$$t_n =  \sum \limits _{i=1}^r  \sum \limits _{j = 0} ^{M_j-1} k_{ij}R_i^nn^j$$


Siendo:

$R_i$ las raíces del polinomio

$k_{ij} coeficientes constantes

r el número de raíces distintas del polinomio característico

$M_i$ la multiplicidad de la raíz $R_i$ del polinomio

## Divide y Vencerás

Los algoritmos que aplican *divide y vencerás* obtienen un mejor
tiempo de respuesta a problemas grandes mediante la división del
problema en subproblemas de tamaño menor, más fáciles de resolver.

Para poder aplicar esta técnica los problemas deben poder dividirse en
uno o más casos equicalentes de tamaño menor, que sean independientes
entre sí y que puedan resolverse por separado. Este es el caso de
algoritmos como MergeSort, Quicksort o selección (ordenación).

Además es necesario que estas subsoluciones independientes se puedan
combinar entre sí para poder dar lugar a la solución del caso inicial.
Así como también debe de existir una *condición de parada* (caso base
resuelto) o un método básico que resuelva el problema para un tamaño
pequeño.

**El problema del umbral:** Si el tamaño del problema inicial es muy
grande puede ser tan costoso gestionar millones de llamadas recursivas
como resolver el problema original. Pero para poder saber cual es
el umbral debemos comparar tiempos de ejecución entre el algoritmo
original y el DyV.


## Algoritmos Greedy 

Es una forma de resolver algunos problemas mediante algoritmos que
construyen la solución paso a paso, siempre actuando con el mismo
criterio fijado y sin modificar nada en la resolución anterior. 

Estos tienen por ventajas que son eficientes, fáciles de diseñar y de
implementar, pero por el contrario puede que la solución alcanzada no
sea óptima, o no encontrar ninguna solución aunque el problema la
tenga. 

Ejemplos de algoritmos greedy los podemos encontrar en el problema del
cambio de la máquina expendedora o en diversos algoritmos de caminos
en grafos.

**Diseño de algoritmos greedy:** 

Todos los algoritmos greedy se pueden aplicar siempre que existan:

* **Lista de candidatos** para formar la solución.
* **Lista de candidatos usados**.
* **Función solución** para saber cuando un conjunto de candidatos es
  solución al problema.
* **Criterio de factibilidad** para saber si un candidato puede formar
  parte de la solución final.
* **Función de selección** del candidato más prometedor para forar
  parte de la solución
* **Función objetivo** de minimización/maximización

## Exploración en grafos

En ocasiones no existe un algoritmo conocido que pueda resolver un
determinado problema, o no de manera eficiente. En esta situación la
resolución para por la exploración directa de todas o una gran parte
de las posibilidades para llegar a una solución.

Dada la naturaleza de estos problemas se pueden representar como un
grafo. Por esto es necesario conocer cómo explorar este.

### Recorridos de profundidad y anchura

Los primeros, estudiados en la asignatura Estructura de Datos, se
basan en algoritmos recursivos para visitar cada nodo y sus hijos.

Los recorridos en anchura por su parte se basan en un procedimiento
parecido, pero se basan en el uso de una cola en la que para cada nodo
visitado se elimina este de la cola, se insertan  sus adyacentes, se
visitan y se inserta w al final de la cola.

Otros ejemplos de estos recorridos son los recorridos **preorden,
inorden y postorden.**

### Diseño de algoritmos Backtracking

Para representar el posible estado de un problema y los
movimientos/acciones para pasar de un estado a otro podemos utilizar
árboles y grafos.

De esta idea nace el **Backtracking**. Que consiste en hacer una
búsqueda exhaustiva sobre grafos(árboles) dirigidos y acíclicos,
mediante un recorrido en profundidad. Se realiza una poda de las ramas
poco prometedoras para acelerar su búsqueda.

La solución del problema se expresa dependiendo de la representación
del problema, como tuplas $T=(x_1,x_2,x_3, ... ,x_t$

**Criterio de parada:** Dependiendo del problema el objetivo puede ser
encontrar todas las soluciones al problema o alguna de ellas.

**Pasos para el diseño de Backtracking:**

* Buscar una **representación** del tipo $T=(x_1,x_2,x_3, ... ,x_t$

* Diseñar las **restricciones implícitas:** Son los valores que cada
  valor $x_i$ puede tener para construir la solución.
  
* Identificar las **restricciones explícitas:** Restricciones externas
  al proceso de encontrar una solución.
  
* Diseñar la estructura del **árbol/grafo implícito** que define los
  estados y transiciones entre estados de búsqueda de soluciones.
  
* Diseñar la **función objetivo:** Criterio de parada para encontrar
  la solución o soluciones requeridas.
  
* Adaptar la estructura general del **procedimiento Backtracking** al
  problema y resolverlo.
  
  
### Diseños de algoritmos Branch & Bound

**Terminología:**

* **Nodo vivo:** Nodo del espacio de soluciones del que no se han
  generado/visitado aún todos sus hijos.
  
* **Nodo en curso:** nodo del que se están generando hijos.

* **Nodo muerto:** nodo del que no se van a generar más hijos porque
  sea hoja, se pode o no produzca una solución mejor que la solución
  en curso.
  
Se diferencia de Backtracking en que se generan todos los hijos del
nodo en curso antes de que cualquier nodo vivo pase a ser el nodo en
curso, mientras que backtracking analizaba inmediatamente todo nodo
generado. Eso hace que requiera una estructura auxiliar para almacenar
los nodos vivos (Lista de nodos vivos).

Esto hace que backtracking sea más fácil de implementar y tenga un
menor requisito de memoria, mientras que branch & bound es más eficiente.

**Componentes:**

* **Representación** de la solución en una tupla $T=(x_1,x_2,x_3, ... ,x_t$

* **Función objetivo** que determina si la solución actual es óptima.

* **Restricciones implícitas:** Valores de cada $x_i$

* **Restricciones explícitas:** Las que no dependen de la
  representación del problema.
  
* **Función de elección** para seleccionar qué nodo es mejor y
  considerarlo “*en curso*”
  
* **Cálculo de cotas** para eliminar partes del árbol que no vayan a
  generar una solución o para elegir el camino más prometedor.
  
* **Árbol de búsqueda** para organizar el problema.

Al igual que en backtracking, la solución se construye paso a paso. El
proceso acaba cuando no quedan nodos en la lista de nodos vivos.
