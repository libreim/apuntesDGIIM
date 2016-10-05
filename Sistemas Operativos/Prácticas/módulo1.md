# Apuntes

## Módulo 1.

### Archivos _/etc/passwd_ y _/etc/shadow_.

En el archivo __passwd__ encontramos informacion relevante a los usuarios creados en el sistema y cierta información sobre estos de la forma:

_Usuario(Login) : Contraseña : UID : GID : Nombre de usuario : Directorio de trabajo : Intérprete de shell_

En el archivo __shadow__ se encuentran codificadas cada una de las contraseñas de los usuarios que aparecen en __passwd__, de forma que en el archivo passwd aparecerá una x en el campo de contraseña, indicando que esta se encuentra codificada en __shadow__.

### Diferencia entre _fstab_, _mtab_, _filesystems_ y _mounts_.

Los cuatro archivos citazos son archivos FHS que guardan diferente información relevante al mismo tema, la primera diferencia es donde se encuentran los archivos.
1. _fstsab_ y _mtab_ se encuentran en la carpeta _etc_.
2. _filesystem_ y _mounts_ se encuentran en la carpeta _proc_.

La informacion que encontramos en cada uno de estos archivos es:

- __Fstab__: Es una lista de los sistemas de archivos que se inician con el arranque del equipo, con una serie de información sobre cada uno de ellos. Aqui es donde el usuario puede editar información.
- __Mtab__: Es una lista de los sistemas de archivos que se encuentran montados. Este archivo no se edita.
- __Fylesistems__: Es una lista de todos los sistemas de archivos que se encuentran disponibles.
- __Mounts__: Es una lista de todos los sistemas de archivos que se encuentran montados ya sea manualmente o con el arraque del sistema.


### Trabajo con sistemas de archivos

#### Asignar un sistema de archivos a una partición


Para crear un sistema de archivos en una partición (ext3,ext4) tenemos que usar la orden __mke2fs__. Tiene varias opciones interesantes como:
* __-L__ para establecer una etiqueta a la partición
* __-t *nombre particion*__ para establecer si queremos ext2,ext3,ext4.
* __-T *tipo de uso*__ Para establecer qué tipo de uso queremos darle al Sistema de archivos.


#### Configurar parámetros del Sistema de Archivos

Para ajustar algunos parámetros de nuestro S.A. usamos la opción **tune2fs**.
* __-l *dispositivo*__ nos da un listado con la información relevante de un S.A.

* __-c max-mount-counts *dispositivo__ Establece el número máximo de montajes que se pueden realizar sin que se realice una comprobación de consistencia del S.A.

* __-L *etiqueta* *dispositivo*__ Pone una etiqueta al S.A.

* __-r *numero*__ indica el numero de bloques del sistema de archivos que queremos reservar para uso exclusivo de un usuario

* __-u *username*__ indica el usuario que tendrá acceso a ese número de bloques asignado con __-r__


### Orden Mount

Nos permite montar un sistema de archivos, con una amplia gama de opciones, de las que hemos utilizado:
* -o ro: Monta en sistema de archivos en solo lectura.
* -o rw: Monta el sistema de archivos en lectura y escritura.
Un ejemplo del formato utilizado para estas ordenes sería:

```
mount /dev/loop0 -o ro mnt/SA_ext3

```

Debemos tener en cuenta que para que esos sistemas de archivos se ejecuten en el arranque debemos añadirlos a /etc/fstab.
añadiendo una linea de la siguiente manera:
```
/dev/loop0 /mnt/SA_ext3 ext3 ro 0 0
```
### Orden Yum

Los archivos de configuracion de Yum se encuentran en /etc/yum/yum.conf.
Yum dispone de una amplica cantidad de acciones distintas, entre ellas estan:
```
# yum erase [paquete]       Permite eliminar un paquete.
# yum install [paquete]     Permite instalar un paquete.
# yum update [paquete]      Permite actualizar un paquete.
```
Con la orden “yum list installed” podemos ver aquellos paquetes que se encuentran instalados.
Utilizando “yum erase [paquete]” podemos eliminar el paquete que queramos y luego utilizando “yum install [paquete]” podemos volver a instalarlo.

### Orden Rpm

Instalador de paquetes que se encuentran descargados en el equipo.
Utilizando “rmp -i [direccion paquete]” o “rpm –install [direccion paquete]”, podemos instalar el paquete que deseemos.
Para postrar la maxima información posible utilizaremos -v (muestra informacion relevante) y -h (muestra hash marks). De forma que para instalar el paquete:
```
# rpm -ivh [direccion del paquete]
```
Para desinstalarlo utilizaremos:
```
# rpm -e -v [paquete]```
