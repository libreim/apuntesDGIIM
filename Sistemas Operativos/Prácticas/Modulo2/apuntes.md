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


Vamos a ver las funciones de la familia stat, que contiene atributos de un archivo. Veremos cómo modificarlos. Sabemos que tenemos varios tipos de archivos, como pueden ser regulares, de directorio, especial de dispositivo de caracteres, especial de dispositivo de bloques(que representa los dispositivos o discos), FIFO para comunicación entre procesos, enlaces simbólicos o Socket, que se usa para la comunicación red entre procesos.

**STAT** es el siguiente struct:

```c++
struct stat {
dev_t st_dev; /* no de dispositivo (filesystem) */
dev_t st_rdev; /* no de dispositivo para archivos especiales */
ino_t st_ino; /* no de inodo */
mode_t st_mode; /* tipo de archivo y mode (permisos) */
nlink_t st_nlink; /* número de enlaces duros (hard) */
uid_t st_uid; /* UID del usuario propietario (owner) */
gid_t st_gid; /* GID del usuario propietario (owner) */
off_t st_size; /* tamaño total en bytes para archivos regulares */
unsigned long st_blksize; /* tamaño bloque E/S para el sistema de archivos*/
unsigned long st_blocks; /* número de bloques asignados */
time_t st_atime; /* hora último acceso */
time_t st_mtime; /* hora última modificación */
time_t st_ctime; /* hora último cambio */
};

```

Tenemos que saber que **st_blocks** da el tamaño en bloques de 512 bytes.

Existen también las siguientes macros para comprobar el tipo de fichero:

S_ISLNK(st_mode) Verdadero si es un enlace simbólico (soft)
S_ISREG(st_mode) Verdadero si es un archivo regular
S_ISDIR(st_mode) Verdadero si es un directorio
S_ISCHR(st_mode) Verdadero si es un dispositivo de caracteres
S_ISBLK(st_mode) Verdadero si es un dispositivo de bloques
S_ISFIFO(st_mode) Verdadero si es una cauce con nombre (FIFO)
S_ISSOCK(st_mode) Verdadero si es un socket

#### Permisos de acceso a archivos.
El valor **st_mode** codifica el tipo de archivo y los permisos de acceso a este. Recordamos que hay 3 categorías : user, group y other para los permisos.

Los permisos de lectura, ejecución y lectura se usan de forma distinta según la llamada al sistema:

* Al abrir un archivo tenemos que tener permiso de ejecución en cada directorio mencionado en su ruta de acceso
* El permiso de lectura para un directorio y el de ejecución para el mismo son cosas distintas. Leer un directorio es leer una lista de nombres de archivo del directorio, y permiso de ejecución es pasar a través de él.
* El permiso de lectura de lectura para un archivo determina si podemos leer ese archivo, son los flags **O_RDONLY** y **O_RDWD** en la llamada open.
* Debemos tener permiso de escritura para poder especificar el flag **O_TRUNC** en la llamada open. (*O_TRUNC* , que si un archivo ya existe, es regular y permite escritura, pone su longitud a 0 y si no, se ignora.)
* Sólo se puede crear un archivo en un directorio si tenemos permisos de escritura y ejecución en él.Lo mismo para borrar un archivo.

* El permiso de ejecución para un archivo debe estar activado para ejecutarlo

#### El uso de **stat** y **lstat**

1. **stat** muestra el estado de un archivo o de un sistema de archivos. Tiene varias opciones interesantes como son:

* **-L**, que sigue los enlaces
* **-f**, si es un sistema de archivos lo que queremos mostrar
* **-c** usa un formato especificado para mostrarlo
* **-t** muestra la información de forma concisa

2. **lstat**. Sirve para mostrar el estado de un archivo. Su sintaxis en un programa de *C* es:

```c
#include <sys/stat.h>
int lstat(const char* restrict path, struct stat *restict buf);
```

# Llamadas al sistema relacionadas con el permiso de archivos

## Llamada umask

Esta fija la máscara de creación de permisos para el proceso y devuelve el valor que se ha establecido. Lo que hace es restar los permisos indicados en la llamada a umask.

Por tanto, si hacemos *umask(0)*, se restará un 0 al crear el archivo y se creará por tanto con todos los permisos que tenga la función open por defecto.

## Llamada chmod y fchmod

Estas permiten cambiar los permisos de acceso para un archivo que existe en un sistema de archivos.
La diferencia está en que **chmod** trabaja sobre un archivo especificado por su *pathname* y **fchmod** opera sobre un archivo abierto con open.

Sus cabeceras son:

``` c
#include <sys/types.h>
#include <sys/stat.h>
int chmod(const char *path, mode_t mode);
int fchmod(int fildes, mode_t mode);

```

Existen una serie de valores para modificar estos permisos, destacando:


S_ISUID 04000 activar la asignación del UID del propietario al UID efectivo del proceso que
ejecute el archivo.
S_ISGID 02000 activar la asignación del GID del propietario al GID efectivo del proceso que
ejecute el archivo.
S_ISVTX 01000 activar sticky bit. En directorios significa un borrado restringido, es decir, un
proceso no privilegiado no puede borrar o renombrar archivos del directorio
salvo que tenga permiso de escritura y sea propietario. Por ejemplo se utiliza
en el directorio /tmp.
S_IRWXU 00700 user (propietario del archivo) tiene permisos de lectura, escritura y ejecución
S_IRUSR 00400 lectura para el propietario (= S_IREAD no POSIX)
S_IWUSR 00200 escritura para el propietario (= S_IWRITE no POSIX)
S_IXUSR 00100 ejecución/búsqueda para el propietario (=S_IEXEC no POSIX)
S_IRWXG 00070 group tiene permisos de lectura, escritura y ejecución
S_IRGRP 00040 lectura para el grupo
S_IWGRP 00020 escritura para el grupo
S_IXGRP 00010 ejecución/búsqueda para el grupo
S_IRWXO 00007 other tienen permisos de lectura, escritura y ejecución
S_IROTH 00004 lectura para otros
S_IWOTH 00002 escritura para otros
S_IXOTH 00001 ejecución/búsqueda para otros


# Funciones de manejo de directorios

Tendremos que incluir la cabecera **<dirent.h>** y **<sys/types.h>**

Existe una estructura llamada ***dirent*** que es la siguiente:
```c
struct dirent {
long d_ino; /* número i-nodo */
char d_name[256]; /* nombre del archivo */
};
```
La usaremos más adelante.

Las funciones más importantes al manejar directorios son:

* **opendir(pathname)**, que devuelve un puntero a la estructura de tipo dir, llamado stream.Para llamarlo, tenemos que crear un arhivo de tipo DIR de la forma:

```c
DIR *opendir(char *dirname);
```

* **readdir(stream)**, que lee la entrada donde está situado el puntero de lectura de un directorio abierto. stream es el puntero a la estructura de tipo dir

```c
struc dirent *readdir(DIR *dirp)
```

* **closedir()** cierra el directorio

```c
int closedir(DIR *dirp)
```
* **seekdir()** sitúa el puntero de lectura de un directorio (usado en combinación con la siguiente)
```c
void seekdir(DIR *dirp, log loc)
```

* **telldir()** devuelve la posición del puntero de lectura de un directorio
```c
long telldir(DIR *dirp)
```

* **rewinddir()** posiciona el puntero de lectura al principio del directorio
```c
void rewinddir(DIR *dirp)
```

* **getcwd()** devuelve el directorio de trabajo actual para cada proceso

* **chdir(pathname)** para cambiar a un directorio. 

getcwd devuelve el directorio de trabajo actual para cada proceso.