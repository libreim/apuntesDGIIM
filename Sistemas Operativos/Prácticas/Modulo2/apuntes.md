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
   * O_RDWR: abre el fichero en modo lectura-escritura

  Algunos permisos:
   * S_IRUSR: el usuario tiene permiso de lectura
   * S_IWUSR: el usuario tiene permisos de escritura

 Podemos indicar varios flags o permisos separándolos mediante |
 `open("archivo",O_CREAT|O_TRUNC|O_WRONLY,S_IRUSR|S_IWUSR)`

* **Read**, que lee una cantidad de bytes del archivo. Además, devuelve el número de bytes que ha leído, por lo que si le indicamos que lea *n* bytes y quedan sólo *m<n*, devolverá *m* y sólo podrá leer m. En caso de error, devuelve -1.
`read(int fd, void* buffer, unsigned byte)`
* **Write**, para escribir dentro del archivo fd, n_bytes desde buffer. Devuelve el número de bytes transferidos, -1 si hubo un error.
Puede ocurrir que se genere un vacío en el archivo si sólo tiene X bytes e intentamos escribir en la posición x+n con n> 1.
`write(int fd, void* buffer, unsigned n_bytes)`
* **lseek** reposiciona el puntero de lectura de un archivo en una posición que se le puede indicar.
Cambiamos la posición de lectura n bytes desde origen.
`lseek(fd, long n, int origen)`
Para que origen sea la posición actual utilizamos SEEK_SET.
Devuelve la posición absoluta del puntero de lectura, -1 en caso de error.
* **Close**, para cerrar el archivo. Si se sale del programa, se cierran todos los que haya abiertos.
Recibe como parámetro un descriptor de fichero. Devuelve 0 si todo salió bien y 1 si hubo problemas.
`close(int fd)`

### Metadatos (stat)

Se trabajan principalmente con la orden **stat**.
