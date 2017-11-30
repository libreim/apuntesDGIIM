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
