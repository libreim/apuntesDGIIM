# RESUMEN MÓDULO II #

## SESIÓN 1. Llamadas al sistema para el SA ##

**Llamadas básicas de E/S:**

* **open**
```c
	int open(const char *pathname, int flags);
	int open(const char *pathname, int flags, mode_t mode);

	/* Donde "pathname" es la ruta del archivo que queremos abrir,
	   "flags" donde se incluyen el modo de acceso O_RDONLY, O_WRONLY, O_RDWR,
	   destacaremos O_CREAT para crear el archivo en caso de que no exista,
	   "mode" en caso de crear un nuevo archivo le otorga una serie de permisos, se usan constantes simbólicas como S_IRWXU (consultar man 2 open).
	   
	   RETURN VALUE: File descriptor del archivo abierto (-1 en caso de error)
   */
```
	
* **read**
```c
	ssize_t read(int fd, void *buf, size_t count);
	
	/* Donde "fd" es el descriptor del archivo a leer,
	   "*buf" es la dirección del buffer donde se almacenará lo escrito,
	   "count" es el número bytes que se intentarán leer del descriptor.
	   
	   RETURN VALUE: Número de bytes leídos del descriptor (-1 en caso de error)
   */
```

* **write**
```c
	ssize_t write(int fd, const void *buf, size_t count);
		
	/* Donde "fd" es el descriptor del fichero en el que se escribirá,
	   "*buf" la dirección del buffer de donde procede lo escrito,
       "count" el número de bytes que se intentarán escribir en el descriptor.
		
	   RETURN VALUE: Número de bytes escritos en el descriptor (-1 en caso de error)
	*/
```

* **lseek**
```c
	off_t lseek(int fd, off_t offset, int whence);

	/* Donde "fd" es el descriptor del fichero donde se cambiará el offset,
	   "offset" es el desplazamiento de la posición sobre un fichero,
	   "whence" es la directiva (constante) con la que se aplicará el offset, SEEK_SET (establece el offset al valor indicado), SEEK_CUR (Se desplaza de la posición actual), SEEK_END (Se situa al final del fichero más el valor indicado).
	   
	   RETURN VALUE: El offset resultante (-1 en caso de error)
   */
```
* **close**
```c
	int close(int fd);
	
	/* Donde "fd" es el valor del descriptor a cerrar
	
	   RETURN VALUE: 0 si lo cierra, -1 en caso de error
   */
```


**Descriptores simbólicos**

* **STDIN_FILENO**, la entrada estándar con valor numérico 0. 
* **STDOUT_FILENO**, la salida estándar con valor numérico 1.
* **STDERR_FILENO**, la salida error estándar, con valor 2.




