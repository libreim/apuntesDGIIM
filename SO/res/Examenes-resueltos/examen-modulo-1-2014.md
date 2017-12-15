# Resolución SO Exámen Módulo I 2014

> Este exámen fue propuesto por el profesor José Antonio Gómez del departamento de LSI de la
> ETSIIT, de la Universidad de Granada. 
> Resuelto por Víctor Castro Serrano, alumno del DGIIM de la Universidad de Granada.
> Toda aportación o modificación puede ser comunicada a LibreIM para su actualización.

###  Ejercicio 1
***1. [20% puntuación] Un bash shell restringido (bash -r) permite limitar algunas acciones del usuario que los usa, por ejemplo, no permite cambiar de directorio, ni utilizar nombres de archivos que contienen una barra /, ni cambiar las variables PATH y SHELL, ni redirigir las entradas/salidas, ni tampoco definir funciones. Se pide crear un usuario, denominado anonimo, que debe usar un shell restringido, tiene un UID con valor 590 y pertenecerá a un grupo denominado limitados con GID 1010. Su directorio homes será /home/anonimo y su cuenta debe estar activa solo 10 días.***



Primero creamos el usuario y lo añadimos a un grupo, en este caso, no existe ni el grupo ni el usuario.
~~~
	useradd anonimo
	groupadd limitados
~~~
	
Cambiamos el id del grupo y del usuario
~~~
	usermod -u 590 anonimo
	groupmod -g 1010 limitados
~~~

Añadimos el usuario al grupo
~~~
	[root@localhost ~]# gpasswd -a anonimo limitados
	Adding user laura to group limitados
~~~

También podríamos crear el grupo y añadir el usuario directamente con un archivo. Creamos un txt con la siguiente sintaxis(el grupo tiene que estar creado, con el guid correspondiente)
~~~
	anonimo:x:590:1010::/home/anonimo:/bin/bash -r
~~~


Creamos el usuario con *newusers*, donde *addanonimo.txt* es el fichero que contiene la línea anteriormente indicada.
~~~
	newusers /root/addanonimo.txt
~~~

Cambiamos la fecha de expiración a 10 días a partir de hoy
~~~
	usermod -e 2017-11-31 anonimo
~~~

También se puede hacer con el siguiente comando
~~~
	chage -E 2017-10-28 usuario
~~~

Restringimos la shell si no creamos el usuario pasándole el archivo con la opción ya incluida.
~~~
	usermod --shell="/bin/bash -r" anonimo
~~~

El ejercicio lo hemos realizado asignando eliminados como grupo principal, si queremos que pertenezca a eliminados pero sin ser el principal, en el fichero de texto:
~~~
	anonimo:x:591:591::/home/anonimo:/bin/bash -r
~~~
*591 es el guid de su grupo principal*

Creamos el usuario
~~~
	newusers /root/addanonimo.txt
~~~
Creamos el grupo secundario eliminados, cambiamos el guid del grupo y añadimos el usuario.
~~~
	addgroup eliminados
	groupmod -g 1010 eliminados
	gpasswd -a anonimo eliminados
~~~
Podemos comprobar los grupos del usuario con groups
~~~
	groups anonimo
~~~
	




###  Ejercicio 2
***2. [10% puntuación] Crear en el directorio /root un enlace duro y un enlace simbólico a cualesquiera de los programa que aparecen en /bin. Una vez creados hacer un ls -l del directorio /root y pegar el resultado. Idem para la oden stat sobre estos dos archivos.***

Escojo el programa zcat arbitrariamente. Creamos el enlace simbólico:
~~~
	ln -s /bin/zcat enlacesoft
~~~
Ahora el enlace físico o duro:
~~~
	ln /bin/zcat enlacehard
~~~
Salida del ejercicio con ls -l:


~~~
	[root@localhost ~]# ls -l
	total 8
	-rwxrwxrwx 1 root root   49 Oct 21 06:53 addanonimo.txt
	-rwxr-xr-x 2 root root 1937 Mar 16  2010 enlacehard
	lrwxrwxrwx 1 root root    9 Oct 21 07:04 enlacesoft -> /bin/zcat
~~~
Salidas con stat:
La orden es *stat nombre_enlace*
~~~
		[root@localhost ~]# stat enlacehard
	  File: `enlacehard'
	  Size: 1937      	Blocks: 8          IO Block: 4096   regular file
	Device: 6200h/25088d	Inode: 7396        Links: 2
	Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
	Access: 2010-03-16 12:16:41.000000000 -0400
	Modify: 2010-03-16 12:16:41.000000000 -0400
	Change: 2017-10-21 07:05:58.114544629 -0400

~~~
~~~
	[root@localhost ~]# stat enlacesoft
	  File: `enlacesoft' -> `/bin/zcat'
	  Size: 9         	Blocks: 0          IO Block: 4096   symbolic link
	Device: 6200h/25088d	Inode: 13061       Links: 1
	Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
	Access: 2017-10-21 07:04:44.514547241 -0400
	Modify: 2017-10-21 07:04:44.514547241 -0400
	Change: 2017-10-21 07:04:44.514547241 -0400
~~~


###  Ejercicio 3
***3. [20% puntuación] Modifique los elementos que sean necesarios en el sistema UML para cada vez que arrancamos  la máquina virtual se realice el montaje de nuestro directorio home del anfitrión en un directorio de la máquina virtual en lugar de tener que hacerlo a mano.***

Se puede hacer editando el fichero ``/etc/fstab`` y añadiendo  en una línea ``none / hostfs defaults 1 1``. Otra opción es hacer un script con el siguiente comando 
~~~
	mount none /tmp -t hostfs -o /home/victor
~~~
Lo montamos en tmp o donde queramos.
Abrimos el fichero de crontab con *crontab -e* y añadimos
~~~
	@reboot /root/script.sh
~~~
Tener cuidado con la ruta. Con *@reboot*, le decimos que lo ejecute 1 vez, cada vez que inicie el sistema.

### Ejercicio 4
***4. [15% puntuación] Acceder al repositorio http://rpm.pbone.net y descargar la versión del paquete sysstat para la  Fedora 14 y el kernel de UML de 32 bits que utilizamos. Este paquete contiene la orden sar que muestra estadísticas de uso del sistema. Indica todos los pasos, a partir de la descarga, para instalar y ejecutar la orden sar con la opción -w para mostrar estadísticas sobre la creación de procesos y cambios de contexto mostrando un listado del  resultado de la misma. Modifica los elementos necesarios del sistema UML para que esta estadística se ejecute todos los lunes y jueves de todas las semanas a las 10:30 horas.***

En primer lugar descargamos el paquete y lo guardamos en nuestro ordenador. En mi caso lo tengo guardado en la ruta ``/home/victor/SistemasOperativos``.
Tenemos que montar la ruta en la UML para poder acceder al paquete. Usamos la siguiente orden:
~~~
mount none /root -t hostfs -o /home/victor/SistemasOperativos/paquetes
~~~
Procedemos a instalarlo
~~~
rpm -i sysstat-9.0.6-3.fc13.i686.rpm
~~~

Habría que utilizar el comando *sar -w* y copiar la salida de la terminal. No obstante, durante la realización de este ejercicio, falló la instalación, probablemente porque el paquete proporcionado por el profesor estaría defectuoso.

Finalmente, editamos el fichero de crontab con *crontab -e* y añadimos la siguiente línea:
~~~
30 10 * * 1,4 sar -w
~~~
*Crontab asigna el 0 al domingo, 1 al lunes, y así sucesivamente*



###  Ejercicio 5
***5. [20% puntuación] Crear una sistema de archivos de tipo ext3 dentro de un archivo utilizando el dispositivo /dev/loop. Este sistema de archivos debe tener 15 MB de tamaño y  un tamaño de bloque de 4KB. Tras su creación hay que montarlo de solo lectura y sin que se puedan ejecutar archivos desde el. Indicar las ordenes necesarias para realizar estos pasos y mostrar la información de los metadatos del sistema de archivos creado.***
Primero, creamos el dispositivo */dev/loop0* en caso de no tenerlo.
~~~
mknod /dev/loop0 b 7 0
~~~

Creamos un archivo de 15MB en nuestro sistema de archivos.
~~~
dd if=/dev/zero of=/root/archivo_SA20 bs=1500 count=10000
~~~
*Nótese que en bs=1500, sustitumos el 1500 por el tamaño requerido. Si fuera 30MB, sería bs=3000*

Genera la siguiente salida, podemos ver que se han asignado bien los 15MB
~~~
[root@localhost ~]# dd if=/dev/zero of=/root/archivo_SA20 bs=1500 count=10000
10000+0 records in
10000+0 records out
15000000 bytes (15 MB) copied, 0.17595 s, 85.3 MB/s
~~~

Ahora asociamos un archivo de dispositivo loop al archivo creado.
~~~
losetup /dev/loop0 /root/archivo_SA20
~~~

Con la siguiente orden podemos comprobar al configuración que hemos realizado.
~~~
fdisk -l /dev/loop0 /dev/loop1
~~~
Que nos genera la siguiente salida:
~~~
[root@localhost ~]# fdisk -l /dev/loop0           

Disk /dev/loop0: 14 MB, 14999552 bytes
255 heads, 63 sectors/track, 1 cylinders, total 29296 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/loop0 doesn't contain a valid partition table
~~~

Ahora tenemos que crear una partición. Tenemos que abrir el menú de configuración de fsdisk con la orden 
~~~
fdisk /dev/loop0
~~~
Con *m* consultamos la ayuda. Tenemos que escribir *n*, seleccionamos partición primaria con *p*, le ponemos los valores que queramos (yo lo dejaré por defecto) y finalmente, con *w* escribirmos la partición. Todo esto tiene la siguiente salida en la temrinal:
~~~
[root@localhost ~]# fdisk /dev/loop0
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
Building a new DOS disklabel with disk identifier 0x2af3dc06.
Changes will remain in memory only, until you decide to write them.
After that, of course, the previous content won't be recoverable.

Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)

Command (m for help): n\n/
Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4, default 1): 
Using default value 1
First sector (2048-29295, default 2048): 
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-29295, default 29295): 
Using default value 29295

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 22: Invalid argument.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.

~~~

Finalmente creamos el archivo *ext3* que nos pide el ejercicio. Además, lo etiquetaremos con LABEL_ext3 para identificarlo mejor, aunque no es necesario. Con *-b* asignamos el tamaño de los bloques, se expresa en btes.
~~~
mke2fs -b 4096 -L LABEL_ext3 -t ext3 /dev/loop0
~~~

Podemos comprobar nuestra configuración con  `` tune2fs -l /dev/loop0 ``

Para montarlo con permisos de lectura usamos la opción *-r*, y para no ejecución utilizamos *-noexec-*. En definitiva, utilizamos la siguiente orden:
~~~
mount -L LABEL_ext3 -r -noexec /mnt/SA_ext3
~~~
*Importante: el destino de montaje, en nuestro caso /mnt/SA_ext3 tiene que existir. Podemos crearlo simplemente con mkdir o usar un punto de montaje que ya exista en nuestro sistema*

### Ejercicio 6
***6. [15% puntuación] Construir una orden para ver que proceso esta consumiendo mayor porcentaje de tiempo de CPU y una vez detectado le rebaje la prioridad 5 unidades.***

La idea es volcar una ejecución de top una vez a un archivo, cogerle la línea en la que está el primer proceso(*top* ordena por % de consumo de cpu) y con cut, cortarle el primer campo, usando un espacio de delimitador. El campo va en -fn donde n es el campo.
~~~

	renice -n 5 `top -n 1 | sed -n 8p | sed "s/ \+/ /g" | cut -d " " -f2`

~~~

*Teóricamente con la orden renice puedes aumentar o rebajar la prioridad, no obstante, renice asigna directamente la prioridad. Es decir, -5 asigna la prioridad -5, no rebaja la prioridad en 5 unidades*
*En cuanto a la orden sed, lo que le hacemos es sustituir todos los espacios en blanco por uno solo, para poder cortarlo correctamente con cut.*

