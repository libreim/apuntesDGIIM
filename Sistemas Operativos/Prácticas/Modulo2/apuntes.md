# Apuntes Llamadas al sistema

Primero, recordamos que en man hay varias opciones. Si queremos consultar las opciones de llamadas al sistema, tenemos que incluir la opción *2* en la orden que ejecutemos. Ejemplo: man 2 stat
## Trabajo con archivos

### Datos de un archivo

Tenemos 5 llamadas principales para trabajar con archivos:
* **Open**, que devuelve **fd** (file descriptor), un entero que indica cuál es el estado que tenemos respecto del archivo, es decir los permisos y dónde se encuentra si existe.
`open(*char nombre, int creation_flags, int permisos)`
Algunos flags:
   * O_CREAT: si el archivo no está creado, lo crea
   * O_TRUNC: abre el fichero y trunca su longitud a 0
   * O_WRONLY: abre el fichero en modo escritura

  Algunos permisos:
   * S_IRUSR: el usuario tiene permiso de lectura
   * S_IWUSR: el usuario tiene permisos de escritura

 Podemos indicar varios flags o permisos separándolos mediante |
 `open("archivo",O_CREAT|O_TRUNC|O_WRONLY,S_IRUSR|S_IWUSR)`

* **Read**, que lee una cantidad de bytes del archivo. Además, devuelve el número de bytes que ha leído, por lo que si le indicamos que lea *n* bytes y quedan sólo *m<n*, devolverá *m* y sólo podrá leer m.
* **Write**, para escribir dentro del archivo. Puede ocurrir que se genere un vacío en el archivo si sólo tiene X bytes e intentamos escribir en la posición x+n con n> 1
* **lseek** reposiciona el puntero de lectura de un archivo en una posición que se le puede indicar.
* **Close**, para cerrar el archivo. Si se sale del programa, se cierran todos los que haya abiertos.

### Metadatos (stat)

Se trabajan principalmente con la orden **stat**.
