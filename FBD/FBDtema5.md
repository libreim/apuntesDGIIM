# Tema 5

## Introducción

Sabemos que una BD almacena grandes cantitdades de datos y se pretende gestionarlos de forma eficiente, tanto ellos como su almacenamiento. Esto afecta a su organización lógica y física.

El __nivel interno_ expresa las operaciones sobre los datos en términos de actuación sobre unidades mínimas de almacenamiento, las páginas o bloques de base de datos. Está implementado en el SGBD y provee al administrador mecanismos para optimizar el acceso y almacenamiento de datos.

El _nivel físico_ está implementado en el SO y da al SGBD abstracción sobre el hardware. Este nivel accede al almacenamiento mediante llamadas a los servicios del sistema de archivos proporcionado por el SO.

## Dispositivos de almacenamiento

Existen diferentes dispositivos de almacenamiento con diferentes características. En orden creciente de coste, capacidad y tiempo de acceso los más importantes son: Registros, Caché, Memoria Principal, Discos Magnéticos, Discos ópticos.

* Memoria principal: Hace trabajos de caché de la porción de la BD que ha sido usada más recientemente. Ubica de forma temporal los datos afectados por las operaciones. El nivel interno debe optimizar su uso y garantizar que haya respaldo de la información si cae el sistema.

* Disco duro: El más usado en BD. Son conjuntos de discos magnéticos de dos caras donde cada cara tiene un conjunto de pistas concéntricas que se dividen en sectores con la misma capacidad de almacenamiento.

Cada dispositivo tiene un tiempo medio de acceso(ta), tiempo medio de búsqueda(tb) y tiempo de latencia rotacional(tl).También tiene un tiempo medio entre fallos(MTBF). Así, se cumple que:
\[
ta = tb+tl
\]

## Método de acceso a la BD almacenada

Si tenemos un bloque de la BD en disco, para obtenerlo se siguen una serie de pasos:
1. El SGBD solicita la página al gestor de archivos
2. El Gestor de archivos solicita los bloques de SO al gestor de Disco.
3. El gestor de disco hace una operación de E/S a disco.
4. El disco devuelve de la base de datos almacenada los sectores solicitados.
5. El Gestor de disco devuelve al gestor de archivos los bloques solicitados
6. El gestor de archivos manda al SGBD la página almacenada solicitada.


En este proceso, para que el gestor de almacenamiento pueda localizar la página de BD, se utiliza el Record Identifier. Cada registro tiene una cabecera y los datos. Los bloques de la BD tendrán un tamaño múltiplo de las páginas del SO y para recuperar un registro almacenado hay que ver en qué página de la BD está. Así, la estructura de almacenamiento debe estar organizada y deben minimizarse las operaciones de E/S a disco.

### El gestor de disco del SO.
Normalmente, el SGBD interactúa con la BD almacenada mediante el _gestor de disco del SO_. Este, organiza lso datos en conjuntos de bloques o archivos de SO y gestiona el espacio libre en disco. Una BD puede obtenerse de uno o varios de estos archivos. Sus funciones fundamentales son: crear y eliminar archivos de SO, añadir y eliminar nuevos bloques o reemplazar estos bloques.

### El gestor de archivos del SGBD.
Es un componente encargado de:
- Transformar entre campos, registros y archivos almacenados a bloques y conjuntos de blosuqe para que el gestor de disco lo entienda
- Organizar los datos para minimizar el tiempo de recuperación y las E/S a disco.

Puede crear archivos almacenados, eliminarlos, recuperar registros de archivos almacenados(buscando en qué página está) o añadir registros a archivos almacenados(buscando en qué pagina es más adecuado, y si no se puede se solicita una nueva página).También puede eliminar registros de archivos(marcando el espacio como disponible) y actualizar registros en archivos almacenados.

## Representación de la BD en el Nivel Interno
La BD se representa de formas distintas en los distintos niveles de arquitectura del SGBD. Esta representación no tiene por qué coincidir con la representación en el nivel conceptual, y un conjunto de registros del mismo tipo no tiene por qué ser un fichero. El nivel interno debe traducir las estructuras del nivel conceptual a otras intermedias cercanas al almacenamiento real de los datos.

Si la BD en el nivel interno tiene al conjunto de páginas en las que se ubican los registros, tenemos:
- Agrupamiento Intra-Archivo: Se ubican en la misma página registros del mismo tipo. Es el más frecuente.
- Agrupamiento Inter-Archivo. Se ubican en la misma página registros de distinto tipo. Debe existir relación entre ellos(entidades fuerte-debil)


En la vida real, cada SGBD comercial utiliza su organización concreta. No existe una relación directa fichero-almacenado/fichero-físico, pues los conjuntos de páginas están almacenados en uno o varios ficheros.

## Organización y métodos de acceso.

Cuando queremos acceder a los datos de una BD, pretendemos minimizar el número de acceso a disco. Por ello, necesitamos minimizar la cantidad da páginas de una BD involucradas en una de estas operaciones. Existen varias organizaciones usadas para las BD. La calidad de estas se mide en el tiempo de acceso y el porcentaje de memoria ocupada por los datos.

## Organización secuencial
 Existe un fichero de acceso secuencial donde los registros están almacenados consecutivamente y ordenados por una clave y para acceder a un registro  debemos pasar por los registros que le preceden. 

* Insertar un registro implica: buscar el bloque que le corresponde, colocarlo si hay sitio y si no o se crea uno nuevo o se crea uno se crea un bloque de desbordamiento. (Recomendable dejar espacio entre bloques para evitar problemas de reorganización)

* Borrado de un registro implica: Buscar el registro. Además, puede implicar una reorganización local de los registros de un bloque.

Ambas suponen escribrir en el bloque de registro, crear o liberar bloques de datos en el fichero secuencia, crear o liberar bloques de desbordamiento y reorganizar registros entre bloques contiguos.

Es por ello que esta forma tiene grandes inconvenientes que son subsanables mediante el uso de estructuras adicionales que nos permitan localizar los datos de manera más rápida y disminuir el número de bloques de disco trasnferidos. Las técnicas más populares son los índices y el acceso directo.

### Indexación

Pretende disminuir el tiempo de acceso a los datos por una clave de búsqueda.

## Fichero secuencial indexado

Partiendo de un fichero secuencia, añadimos una estructura llamada fichero índice, cuyos ficheros tienen una clave de búsqueda y un campo de referencia con los RID de los registros. Son registros más pequeños que los del fichero de datos aunque hay el mismo número de registros en ambos.

* Índice primario: la clave de búsqueda es el mismo campo clave por el que se ordena el fichero secuencial de datos

* Índices secundarios: se construyen sobre otros campos que no sean la clave física del fichero de datos.

Para _consultar_ un valor, podemos consultar:
- Por valor de la clave: sobre el índice localizamos la clave, obtenemos el RID del registro y vamos a disco para recuperar el bloque donde está el registro señalado por el RID.

- Por rango de valores: se busca en el índice por valor de la clave de la cota inferior y se recorren las entradas que están en el intervalo recuperando los registros correspondientes gracias a su RID.

Para _insertar_ un registro se hace lo mismo que en el fichero secuencial, y hay que actualizar el índice.

Para _borrar_ un registro se borra en el fichero de datos y se borra una entrada en el índice.

Como conclusión, estos índices aceleran el acceso pero hay que mantener estos índices por lo que se ralentizan otras operaciones.

## Índices no densos

Los índices suelen ser muy grandes pues contienen todos los registros del fichero que indexan. Por tanto, aparecen los índices no densos que se componen por la clave de búsqueda y la dirección de comienzo del bloque donde está el registro deseado. El número de registros se reduce al número de bloques del fichero de datos.

La búsqueda ahora es diferente, pues una vez se encuentra el bloque donde podría estar el registro hay que cargarlo en memoria y hacer búsqueda secuencial en ese bloque. Además, no se garantiza encontrar el registro hasta consultar el bloque completo.

Los índices no densos sólo se pueden definir sobre la clave física. Su mantenimiento es menos costoso: la inserción y borrado son menos frecuentes pues solo ocurren cuando la operación afecta al valor que representa al bloque completo.

## Índices jerárquicos

Estos índices quieren disminuir el tiempo necesario para encontrar un registro. Para ello, crearán índices multinivel, formados por índices construidos sucesivamente unos sobre otros. El tamaño de bloque se establece para optimizar las operaciones de acceso al disco. ASí se reduce el acceso a disco para encontrar un registro pero es más difícil mantener los índices.

* Árboles B+

Son una generalización de los árboles binarios balanceados en la que los nodos pueden tener más de 2 hijos. Los valores de la clave se encuentran almacenados en los nodos hoja. Un árbol B+ de orden M (máximo número de hijos que puede tener cada nodo) tiene en cada nodo como máximo M hijos y como mínimo (M+1)/2 hijos; todos los nodos hoja están al mismo nivel y las claves contenidas en cada nodo nos llevan al nodo del niver inferior.

Se pone como restricción que los valores de clave $C_i$ están ordenados dentro del nodo y que los valores $x$ del subárbol apuntado por $P_i$ cumplen:
\[
C_{i-1} \leq x < C_i
\]
Excepto para $i = 1$ ( $x < C_1$ ) e $i = n $ ( $x \geq C_n$)

Los nodos hoja tienen punteros al siguiente nodo hoja. La lista concatenada de nodos hoja es útil para hacer consulstas por intervalos. Las claves aparecerán ordenadas en cada nodo y todas deben ser menores que las del siguiente nodo. Los nodos deberán estar rellenos como mínimo hasta la mitad.

 * Consulta: Para localizar un registro, se bajan niveles desde la raíz, buscando el registro en el nodo hoja y recuperando el registro del fichero de datos por el RID. Para consultar en un rango se localoza el nodo hoja con el valor inferior y se recorren los demás nodos hoja hasta encontrar el superior.

 * Inseción y borrado: Los algoritmos utilizados deben garantizar que el árbol siga siendo equilibrado.

Los árboles B+ en BD son variaciones del árbol B+ de orden elevado en la que se procura que cada nodo tenga casi el mismo almacenamiento que un bloque de datos, reduciendo los acceso a disco. En los nodos _intermedios_ solo están los rangos de valores de la clave y los punteros a los nodos hijo. En los nodos _hoja_ , que están enlazados, están los valores de clave ordenados junto con los RIDs ue apuntan a las tuplas que contienen ese valor de clave.

También existen las Tablas Organizadas por Índice. En este caso, las hojas contienen las tuplas en lugar del RID. Así, una IOT solo puede estar organizada de esta forma mediante una clave aunque se pueden definir índices adicionales basados en otras claves.

|                        Tabla normal                        |                                  IOT                                 |
|:----------------------------------------------------------:|:--------------------------------------------------------------------:|
| Identificador único ROWID (RID)                            | Identificado por clave primaria                                      |
| ROWID implícito Soporta varios índices                     | No ROWID Sólo un índice IOT, varios B-tree                           |
| Una recuperación completa devuelve las tuplas desordenadas | Una recuperación completa devuelvelas  las tuplas ordenadas según CP |

## Índices Clave invertida
Los índices por clave invertida invierten los datos del valor de la clave. Es adecuado para búsquedas basadas en predicados y mejora el rendimiento de la inserción de tuplas si se insertan de forma ascendente para valores de la clave. También mejora accesos concurrentes.

## Índices BITMAP

En los índices BITMAP, para cada valor que toma la clave almacena una secuenia de bits (tantos como tuplas contenga la tabla), en los que hay un 1 si el valor está presente en la tupla y un 0 si no lo está.


|                       B-tree                      |                     BITMAP                     |
|:-------------------------------------------------:|:----------------------------------------------:|
| Adecuado para  columnas  que tomen muchos valores | Adecuado para columnas que tomen pocos valores |
| Actualización de claves poco costosa              | Actualización de claves muy costosa            |
| Ineficiente para consultas usando predicados OR   | Eficiente para consultas usando predicados OR  |


## Acceso directo

El acceso directo es una forma de acceder a un registro almacenado. En este caso, no tenemos estructura adicional sino que usamos un algoritmo para identificar la posición del registro deseado. Para ello, debemos tener un campo que identifique unívocamente al registro.

Lo usual es qu eno se pueda establecer una clave física totalmetne correlativa y única, por lo que nuestro algoritmo deberá tener una entrada de un campo clave y proporcionará una salida que será un valor entero positivo transformable en RID.

Estos algoritmos de direccionamiento no suelen mantener el orden de la clave. Los registros no están almacenados según el orden de su clave física. Es por ello por lo que tendremos problemas a la hora de recuperar intervalos de datos.

Los algoritmos usados son variados. Si la clave es alfanumérica, se transforma a un valor numérico. Algunos comunes son los de los cuadrados centrales, congruencias, desplazamiento o conversión de base.

Estos algoritmos tienen varios problemas:
* Es muy dificil encontrar una transformación que dé un valor entero positivo en un rango de valores limitado tal que dos claves diferentes den siempre valores distintos.

* Producen huecos , zonas vacías del rango de salida, no asignadas por el algoritmo, que generan huecos en el fichero de datos.

* Para gestionar colisiones y huecos tenemos que combinar acceso directo y listas de colisión, que mantienen los registros con claves que producen colisión en dichas lista. Si estas listas crecen el acceso directo no resulta adecuado pues hay que mantener las listas y la zona de desbordamiento es casi como el fichero original.

## Hashing básico

Aparece para solucionar el problema del acceso directo. Ya que los valores de las claves no estaban uniformemente distribuidos en un intervalo, sino que se acumulan en una parte de él, lo que se hace es asignar más espacio a esa parte.

Así, se divide el fichero en _buckets_ (cubos) y el algoritmo asingará cubos, no direcciones concretos. En cada bucket habrá más de un registro y ciertos rangos de valores tendrán asignados más buckets que otros. Complementamos esto con el uso de cubos de desbordamiento.

Tendremos como parámetros por tanto:
* Número de cubos
* Tamaño de los cubos
* La transformada clave/dirección, que tiene en cuenta la distrubución de la clave para que los cubos queden equitativamente rellenos.


Para _insertar_ un registro, trasnformamos la clave, localizamos su cubo, se inserta si hay sitio y si no se sitúa en el cubo de desbordamiento conectando el cubo a donde realmente le corresponde el registro.

Para _buscar_ un registro, transformamos la clave, localizamos su cubo y dentro del cubo buscamos secuencialmente y luego en los cubos de desbordamiento.

## Hashing dinámico

El hashing básico tiene el problema de que hay que conocer la distribución previa de las claves para asignar los buckets, de lo contrario sigue habiendo huecos y colisiones. Además, al aumentar el número de registro,s hay más registros en las páginas de desbordamiento y a veces hay que reorganizar los datos.

El Hashing dinámico trabaja partiendo de una configuración uniforme y de pocos cubos y generando los restantes cuando los necesite, asignando a los rangos conforme la afluencia de registros lo pide.

¿Cómo se hace?

El valor transformado del campo clave da una entrada de una tabla índice que está en memoria. Allí está la dirección del cubo donde están los registros que tienen asociado este valor transformado (puede que varias entradas de la tabla lleven al mismo cubo). Cuando se insertan más registros, se generan nuevos cubos y cambian las saldias de la tabla índice.

Partimos de:
* k una clave física para direccionar
* k' = h(k) un entero en un intervalo
* n un número de bits que tiene k' en binario
* d, los primeros d dígitos de k', que seleccionan el cubo donde está el registro(pseudoclave)
* $b < d <= n$, pues inicialmente el archivo tiene $2^b$ cubos distintos y como máximo tendrá $2^d$.

Entonces, si tenemos una tabla índice con $2^d$ filas, en la primera columna se sitúan las posibles soluciones de $d$ dígitos binarios (d es llamada la profundidad global de la tabla). Entonces, las entradas cuyos $b$ primeros dígitos son iguales apuntan al mismo cubo. Todos los cubos suelen tener profundidad local igual a b. Por último, al llenar un cubo se divide en dos, poniendo en uno los registros con el dígito $b+1$ de k' a 0 y en otro los que tienen el dígito $b+1$ igual a 1. Aumenta entonces la profundidad local en uno.

De este modo, solventamos los problemas del acceso directo, aunque tenemos inconvenientes pues tenemos que usar una tabla índice adicional( y por tanto acceder más a disco si no cabe en memoria) , y el tamaño de la tabla depende de $d$ (primeros dígitos de $k' = h(k)$. 



