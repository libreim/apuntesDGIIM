**Ejercicio 3.** En la siguiente figura se representa una tabla *FAT*. Al borde de
   sus entradas se ha escrito, como ayuda de referencia, el número correspondiente
   al bloque en cuestión. También se ha representado la entrada de cierto
   directorio. Como simplificación del ejemplo, suponemos que en cada entrada
   del directorio se almacena: Nombre de archivo/directorio, el tipo (F=archivo,
   D=directorio), la fecha de creación y el número del bloque inicial.

Tenga en cuenta que:
-   el tamaño de bloque es 512 bytes
-   el asterisco indica último bloque
-   todo lo que está blanco en la figura está libre

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="left" />

<col  class="left" />

<col  class="right" />

<col  class="right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="left">Nombre</th>
<th scope="col" class="left">Tipo</th>
<th scope="col" class="right">Fecha</th>
<th scope="col" class="right">Nº bloque</th>
</tr>
</thead>

<tbody>
<tr>
<td class="left">DATOS</td>
<td class="left">F</td>
<td class="right">8-2-90</td>
<td class="right">3</td>
</tr>


<tr>
<td class="left">DATOS1</td>
<td class="left">F</td>
<td class="right">1-3-90</td>
<td class="right">4</td>
</tr>


<tr>
<td class="left">DATOS2</td>
<td class="left">F</td>
<td class="right">2-3-90</td>
<td class="right">5</td>
</tr>


<tr>
<td class="left">D</td>
<td class="left">D</td>
<td class="right">3-3-90</td>
<td class="right">18</td>
</tr>


<tr>
<td class="left">CARTAS</td>
<td class="left">F</td>
<td class="right">13-3-90</td>
<td class="right">12</td>
</tr>
</tbody>
</table>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="right" />

<col  class="left" />

<col  class="right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="right">Nº</th>
<th scope="col" class="left">Comienzo archivo</th>
<th scope="col" class="right">Contenido</th>
</tr>
</thead>

<tbody>
<tr>
<td class="right">1</td>
<td class="left">&#xa0;</td>
<td class="right">&#xa0;</td>
</tr>


<tr>
<td class="right">2</td>
<td class="left">&#xa0;</td>
<td class="right">&#xa0;</td>
</tr>


<tr>
<td class="right">3</td>
<td class="left">DATOS</td>
<td class="right">15</td>
</tr>


<tr>
<td class="right">4</td>
<td class="left">DATOS1</td>
<td class="right">\*</td>
</tr>


<tr>
<td class="right">5</td>
<td class="left">DATOS2</td>
<td class="right">6</td>
</tr>


<tr>
<td class="right">6</td>
<td class="left">&#xa0;</td>
<td class="right">7</td>
</tr>


<tr>
<td class="right">7</td>
<td class="left">&#xa0;</td>
<td class="right">\*</td>
</tr>


<tr>
<td class="right">8</td>
<td class="left">&#xa0;</td>
<td class="right">9</td>
</tr>


<tr>
<td class="right">9</td>
<td class="left">&#xa0;</td>
<td class="right">\*</td>
</tr>


<tr>
<td class="right">10</td>
<td class="left">&#xa0;</td>
<td class="right">11</td>
</tr>


<tr>
<td class="right">11</td>
<td class="left">&#xa0;</td>
<td class="right">13</td>
</tr>


<tr>
<td class="right">12</td>
<td class="left">CARTAS</td>
<td class="right">10</td>
</tr>


<tr>
<td class="right">13</td>
<td class="left">&#xa0;</td>
<td class="right">\*</td>
</tr>


<tr>
<td class="right">14</td>
<td class="left">&#xa0;</td>
<td class="right">&#xa0;</td>
</tr>


<tr>
<td class="right">15</td>
<td class="left">&#xa0;</td>
<td class="right">8</td>
</tr>


<tr>
<td class="right">16</td>
<td class="left">&#xa0;</td>
<td class="right">&#xa0;</td>
</tr>


<tr>
<td class="right">17</td>
<td class="left">&#xa0;</td>
<td class="right">&#xa0;</td>
</tr>


<tr>
<td class="right">18</td>
<td class="left">D</td>
<td class="right">\*</td>
</tr>
</tbody>
</table>

**Ejercicio 4.** Si usamos un Mapa de Bits para la gestión del espacio libre, especifique la
   sucesión  de bits que contendría respecto a los 18 bloques del ejercicio
   anterior.  

`00111111111101001`  

Los 0 indican que el bloque correspondiente está vacío. Los 1 indican que el
bloque correspondiente está ocupado.  

**Ejercicio 9.** Un i-nodo de UNIX tiene 10 direcciones de disco para los diez
primeros bloques de datos, y tres direcciones más para realizar una indexación a
uno, dos y tres niveles. Si cada bloque índice tiene 256 direcciones de bloques
de disco, cuál es el tamaño del mayor archivo que puede ser manejado, suponiendo
que 1 bloque de disco es de 1KByte?  

Tenemos que sumar por separado el tamaño máximo de un archivo direccionable por
los 10 primeros bloques de datos y cada uno de los tamaños máximos
correspondientes a la indexación de 1, 2 y 3 niveles.  

\(10 \cdot 1KB + 256 \cdot 1KB + 256^2 \cdot 1KB + 256^3 \cdot 1KB = 16.843.018KB = 16.843018GB\)  

**Ejercicio 10.** Sobre conversión de direcciones lógicas dentro de un archivo a
direcciones físicas de disco. Estamos utilizando la estrategia de indexación a
tres niveles para asignar espacio en disco. Tenemos que el tamaño de bloque es
igual a 512 bytes, y el tamaño de puntero es de 4 bytes. Se recibe la solicitud
por parte de un proceso de usuario de leer el carácter número N de determinado
archivo. Suponemos que ya hemos leído la entrada del directorio asociada a este
archivo, es decir, tenemos en memoria los datos PRIMERBLOQUE y TAMAÑO. Calcule
la sucesión de direcciones de bloque que se leen hasta llegar al bloque de datos que posee el citado carácter.  

Como cada bloque ocupa 512B y cada puntero ocupa 4B, cada bloque índice puede
direccionar \(\frac{512}{4} = 128B\). Como se trata de un esquema en indexación
a tres niveles y tenemos ya el primer bloque en memoria,  necesitamos realizar
tres accesos a disco. Esto quiere decir que es necesario conocer tres índices
*i, j, k* para obtener el N-ésimo byte del archivo en cuestión.

\[ i = \frac{N}{128 \cdot 128 \cdot 512} \quad N^{\prime} = N \% (128 \cdot 128 \cdot 512) \]

\[ j = \frac{N^{\prime}}{128 \cdot 512} \quad N^{\prime \prime} = N^{\prime} \% (128 \cdot 512) \]

\[ k = \frac{N^{\prime \prime}}{512} \quad N^{\prime \prime \prime} = N^{\prime \prime} \% (512) \]

Entonces, necesitamos traer de disco los bloques apuntados por las direcciones
*i, j* y *k* y leer del bloque de datos con un desplazamiento igual a N<sup>&prime;&prime;&prime;</sup>.  

**Ejercicio 11.** ¿Qué método de asignación de espacio en un sistema de archivos
elegiría para maximizar la eficiencia en términos de velocidad de acceso, uso
del espacio de almacenamiento y facilidad de modificación (añadir/borrar
/modificar), cuando los datos son:

a) modificados infrecuentemente, y accedidos frecuentemente de forma aleatoria

b) modificados con frecuencia, y accedidos en su totalidad con cierta frecuencia

c) modificados frecuentemente y accedidos aleatoriamente y frecuentemente.  

a) **Asignación contigua.** Como se accede infrecuentemente a ese archivo no es
necesario mantener un método de asignación que permita modificarlo
eficientemente. Además es necesario optimizar la velocidad de acceso directo y
el espacio de almacenamiento. Es por esto que la mejor opción sería el método de
asignación contigua.

b) **Asignación no contigua enlazada (tabla FAT).** Como accedemos al archivo en su
totalidad, necesitamos un buen tiempo de acceso secuencial, junto con la
posibilidad de modificar los datos. Esto es eficiente en espacio porque el
archivo puede crecer dinámicamente sin necesidad de mantener los bloques en
posiciones contiguas.

c) **Asignación no contigua indexada.** La asignación no puede ser contigua porque necesitamos facilitar la modificación de los datos. Esto garantiza una modificación eficiente porque el archivo puede crecer dinámicamente sin necesidad de mantener los bloques en posiciones contiguas. Además, la indexación garantiza accesos aleatorios rápidos.
