---
title:	Algoritmos & Problemas				# Título
author: Jesús Sánchez de Lechina Tejada		# Nombre del autor
header-includes:      	 	        	# Incluir paquetes en LaTeX
toc: true                   			# Índice
numbersections: false       			# Numeración de secciones
fontsize: 11pt              			# Tamaño de fuente
geometry: margin=1in        			# Tamaño de los márgenes
---

\newpage 

# Algoritmos & Problemas

## Divide y Vencerás

### Mergesort

1. Hay un vector de tamaño n.

2. Lo dividimos en dos subvectores de tamaño n/2, estos serán
   ordenados independientemente. 

3. Se combinan los subvectores para generar el vector ordenado del
   tamaño original n.
   
4. La condición de parada para dejar de dividir es obtener un vector
   de tamaño $n\leq 1$
   
```c
void mergesort(int* v, int ini, int fin){
	if(ini < fin){
		int med = (ini + fin) / 2;
		mergesort(v,ini,med);
		mergesort(v,med+1,fin);
		Combina(v,ini,med,fin);
	}
}
		
```
Combina() es una función O(n) que se encarga de recorrer los dos
subvectores ordenados introduciendo en un nuevo vector el mínimo de
ambos para generar el vector de tamaño inicial ordenado.

### Quicksort

Es el mejor algoritmo de ordenación en el caso promedio, está basado
en la ordenación de un vector de tamaño n del siguiente modo:

1. Determinamos un *pivote*, para dividir el vector en dos partes con
   elementos menores que el pivote y otra con los elementos mayores o
   iguales
   
2. Se ordenan los dos subvectores generados

3. Combinar las dos soluciones para obtener v ordenado

```c
void QuickSort(int* v, int ini, int fin){
	int pospivote;
	if(in < fin){
		pospivote = Pivotar((v, ini, fin);
		QuickSort(v, ini, pospivote - 1);
		QuickSort(v, pospivote + 1, fin);
	}
}
```

Pivotar es una función que toma como pivote el primer elemento del
vector y pasa a la parte izquierda los elementos menores o iguales y
a la derecha los elementos mayores que el pivote. Finalmente devuelve
la posición central donde se dividen ambas partes.

```c
// Función para dividir el array y hacer los intercambios
int Pivotar(int* v, int start, int end) {
    int left, right, pivot, temp;
 
    pivot = array[start];
    left = start;
    right = end;
 
    // Mientras no se cruzen los índices
    while (left < right) {
        while (array[right] > pivot) {
            right--;
        }
 
        while ((left < right) && (array[left] <= pivot)) {
            left++;
        }
 
        // Si todavía no se cruzan los indices seguimos intercambiando
        if (left < right) {
            temp = array[left];
            array[left] = array[right];
            array[right] = temp;
        }
    }
 
    // Los índices ya se han cruzado, ponemos el pivot en el lugar que le corresponde
    temp = array[right];
    array[right] = array[start];
    array[start] = temp;
 
    // La nueva posición del pivot
    return right;
}
```

\newpage

## Greedy

### Problema del Cambio de monedas

Una máquina expendedora tiene que devolver el cambio con un número
mínimo de monedas, para esto la máquina tiene el siguiente
procedimiento:

1. Mientras quede importe a devolver se coge la mayor moneda
   disponible y comprueba si es menor que el importe a devolver. Si
   esta es mayor coge la siguiente moneda más pequeña y se vuelve a
   empezar. Si es menor, se procede al siguiente paso. Si el importe
   no es cero y se acaban las monedas o tipo de monedas se devuelve el
   error "sin solución".
   
2. Se añade la moneda al la estructura de datos que almacene la
   solución. Se resta al importe restante el valor de la moneda y se
   vuelve al primer paso.
   
3. En el caso de que el importe restante sea 0 se devuelve la solución
   calculada.
   
\newpage
### El problema del arbol generador minimal (AGM)

Sea G=(V,A) un grafo no dirigido conexo, ponderado con pesos no
negativos, siendo V el conjunto de vértices del grafo y A el conjunto
de aristas. El problema consiste en obtener un grafo parcial, conexo y
acíclico tal que la suma de sus aristas sea mínima

#### Kruskal

Empezamos con un conjunto de aristas vacío. En cada paso iremos
construyendo la solución final seleccionando la arista de menor coste
entre los candidatos. Si dicha arista no forma ciclos, será añadida a
la solución, en caso contrario es descartada.

Pseudocódigo:
```
Kruskal(grafo G=(V,A)){
	Ordenar A por orden creciente de pesos
	N = Número de vértices en V
	T= vacío (solución a construir)
	Repetir:
		a = Arista de A más de menos peso no considerada
		A = A\{a}
		Si (T U {a} no forma ciclos)
			T= T U {a}
	Hasta que número de aristas en T sea igual a N-1
	Devolver S
}
```

Kruskal devuelve una solución óptima al problema del AGM (demostrable
por inducción).

\newpage
#### Prim

En este caso la solución original será un conjunto de aristas
vacío. Pero en cada paso iremos construyendo la solución final
seleccionando la arista de menor coste entre las aristas que unen un
nodo de la lista de candidatos utilizados con otro de los aún no
usados. Así hasta que la lista de candidatos tenga el mismo tamaño que
el número de vértices del grafo.

Pseudocódigo:
```
Prim(grafo G=(V,A)){
	B={elemento cualquiera de V} // Candidatos usados
	T= vacío // Solución a crear

	Mientras(|B| != |V|) hacer:
		Seleccionar arista a=(b,v) de peso mínimo que una un nodo b en
		B y otro nodo v en V\B
		T = T U {a}
		B = B U {v}
	Fin-Mientras
	
	Devolver T
}
```

\newpage
### El problema de caminos mínimos
Sea G=(V,A) un grafo dirigido, ponderado con pesos no
negativos, siendo V el conjunto de vértices del grafo y A el conjunto
de aristas. El problema consiste en obtener un conjunto de secuencias
de nodos/aristas que definan un camino mínimo entre un nodo origen y
todos los demás nodos del grafo.

#### Algoritmo de Dijkstra:

Suponemos que los nodos están numerados entre 0 y n-1. Y la solución
serán dos vectores P y D.

P[i] contiene el elemento anterior por el que hay que pasar en el
camino mínimo entre el nodo inicial S dado y el nodo i.

D[i] contiene la distancia existente para el camino mínimo entre el
nodo inicial S dado y el nodo i.

Existe una matriz L , donde cada componente L[i][j] indica el coste de
viajar desde el nodo i al nodo j directamente (matriz de adyacencia).

**Metodología a seguir en el algoritmo:**

En un primer lugar supondremos que el camino mínimo entre dos nodos S
e i es mínimo si L[S][i]>0 (es decir, están conectados
directamente). En otro caso suponemos que la distancia es infinita e
inicializamos P y D con estos datos.

En cada caso el algoritmo greedy selecciona el nodo v de menor
distancia D[v], y comprobamos si para el resto de los nodos w es más
corta la distancia D[w] (ir de S a w) o D[v] + L[v][w] (ir de S a w
pasando por v). En tal caso se actualiza P y D.

Pseudocódigo:
```
Dijkstra(G=(V,A),L,S){
	C=V\{S} // Candidatos no utilizados
	Para i = 1 hasta n, hacer: 
		D[i] = L[S][i];
		P[i] = S;
	Fin-Para
	
	Repetir n-1 veces:
		v=elemento de C tal que D[v] es mínimo // seleccionar el
			                                   // arista de menor peso
		C = C\{v}
		
		// Actualizamos si el camino más corto a los demás nodos es el 
		// directo o el que pasa por el nodo que acabamos de calcular
		Para cada w en C, hacer:
			Si D[w]>D[v]+L[c][w], entonces:
				D[w] = D[v]+ L[v][w];
				P[w] <-- v
			Fin-Si
		Fin-Para
	Fin-Repetir
	Devolver D,P
}
```

\newpage
### El problema del viajante de comercio

Un comerciante quiere distribuir su mercancía entre diferentes
ciudades. Su problema consiste en encontrar la ruta más corta tal que:

* Pase por todas las ciudades
* Al finalizar el recorrido, se encuentre en la ciudad de origen
* No debe de pasar por la misma ciudad dos veces

Dicho **formalmente**: 

Dado un grafo G=(V,A) no dirigido, completo, con V vértices
y A aristas, donde las aristas están ponderadas con pesos no
negativos. Encontrar el circuito hamiltoniano minimal del grafo G.

Pseudocódigo:
```
TravelingSalesmanProblem(G=(V,A)){
	C = A // Candidatos no utilizados
	T = vacío
	Repetir hasta que |T| = |V|-1:
		a = (u,v) arista de C con peso mínimo
		C = C\{a}
		Si T U {a} no forma ciclos ni v está en 2 aristas de T ni y u
		está en 2 aristas de T entonces:
			T = T U {a}
		Fin-Si
	Fin-Repetir
	
	A = Arista restante que queda para cerrar el circuito
	T = T U {a} 
	
	Devolver T
```

Intuitivamente buscamos el circuito minimal (seleccionamos las aristas
de menor peso), que sólo tengan "una entrada y una salida" (el arista
escogido no puede tener vértices que ya estén en dos aristas) y
hamiltoniano (cuando sólo nos quede un arista por escoger, escogemos
el que cierre el circuito al nodo donde empezamos).

\newpage
### El problema de la mochila

Tenemos una mochila y un conjunto de objetos a transportar. Y se desea
saber qué objetos y en qué cantidad hay que transportarlos para
rentabilizar el esfuerzo sabiendo que:

* La mochila tiene un máximo de peso M
* Hay n objetos diferentes a transportar
* Cada objeto i tiene un peso asociado $w_i$
* Llevar el objeto nos reporta un beneficio $b_i$
* Incluiremos en la mochila una cantidad $x_i$ del objeto i

De nuevo, **formalmente**:

Maximizar $\sum \limits _{i=1} ^n b_ix_i$ sujeto a la restricción
$\sum \limits _{i=1} ^n w_ix_i \leq M $


**Variantes del problema:**

* **Caso continuo:** Todos los objetos son fraccionables
* **Caso discreto:** Ningun objeto es fraccionable 
* **Caso del problema 0/1:** Caso particular del discreto, sólo
  podemos llevar un único ejemplar de cada tipo de objeto.
  
\newpage
#### Problema de la mochila continuo

Supondremos que las cantidades que podemos llevar de cada objeto es un
número real normalizado al intervalo [0,1] (No llevarnos
nada/llevarnos todo el objeto/llevarnos un porcentaje del total del
objeto).

Pseudocódigo:
```
MochilaContinuo(M, B[0..n-1], W[0..n-1]){
	C= Conjunto de objetos posibles
	T= Vector de n cantidades a llevar a 0 // Solución a crear
	Mientras (suma(peso de llevar las cantidades T)<M) y
	queden candidatos en C, hacer:
		Seleccionar i= mejor objeto restante en C
		C= C\{i}
		
		Si suma(peso de llevar las cantidades T)+ w_i <= M
		entonces 
			T_i = 1
		En otro caso
			T_i = (M-suma(peso de llevar las cantidades de T))/w_i
			
	Fin-Mientras
	Devolver T
}
```

\newpage
### El problema de la planificación de tareas

Supongamos que hay n tareas pendientes. Se plantea el problema de la
minimización del tiempo que cada tarea espera hasta haberse
finalizado.

Sean n tareas pendientes por ejecutar. Se desea encontrar el orden de
ejecución de dichas tareas para minimizar el tiempo T que todas las
tareas esperan antes de finalizar su ejecución:

$$T = \sum \limits _{i=1} ^n\ (Tiempo\ transcurrido\ antes\ de\ que\
i\ finalice)$$

En este problema, cuando se ejecutan las tareas en orden ascendente de
tiempo de ejecución obtenemos la mejor planificación. Este diseño
sería óptimo.

\newpage
## Exploración en grafos
