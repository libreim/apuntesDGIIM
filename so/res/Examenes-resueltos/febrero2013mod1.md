# Soluciones del exámen de prácticas de febrero 2013 (parte del Módulo I)
>Asignatura de Sistemas Operativos, ETSIIT, UGR
>Resuelto por Víctor Castro Serrano, alumno del DGIIM,UGR


## Ejercicio 1
***1. Indica cómo buscarías si un determinado usuario y grupo se encuentran creados en el sistema. ¿Cómo averiguarías el directorio home de un usuario concreto?***
Bastaría con usar la siguiente orden, para un usuario y despues para un grupo respectivamente:
~~~
cat /etc/passwd | grep usuario
cat /etc/passwd | grep grupo
~~~
Otra forma de verlo es en el archivo ``/etc/group``
~~~
cat /etc/group | grep usuario
cat /etc/group | grep grupo
~~~
Para ver si un usuario pertenece a un grupo, la siguiente orden tiene que mostar al una línea con el formato del archivo ``/etc/group``
~~~
cat /etc/group | grep usuario | grep grupo
~~~
Para ver su directorio home:
~~~
cat /etc/passwd | grep usuario | cut -d ":" -f6
~~~

## Ejercicio 2
***2. Tenemos un archivo en nuestro directorio home que se denonima miarchivo. Crea un enlace duro a dicho archivo denominado enlaceduro y otro simbólico con nombre enlacesimbolico. ¿Cómo comprobarías que realmente enlaceduro y enlacesimbólico son del tipo deseado?***

Creando el enlace duro y simbólico respectivamente:
~~~
ln /home/miarchivo enlaceduro
ln -s /home/miarchivo enlace simbólico
~~~

Si borro "miarchivo", el enlace simóbólico se perdería, el duro no. Si edito en el enlace duro, se edita el archivo, pero los cambios realizados en el simbólico no se reflejan en el archivo original.

Otra forma es usando ``ls -lai``. El enlace duro se verá como un archivo normal, mientras que el sibólico se vería, en la última columna con el formato ``enalcesimbolico -> miarchivo``

## Ejercicio 3
***3.Sea un sistema de archivo tipo ext3 que reside en el dispositivo /dev/sda1. Indica: (a) qué debemos hacer para montarlo en el arranque del sistema, (b) cómo montarlo en un instante dado después del arranque.***

a) En el archivo /etc/fstab habría que añadir la siguiente línea:
~~~
/dev/sda1 /mnt/LABEL_ext3 ext3 ro 0 1
~~~
Donde /mnt/LABEL_ext3 es la ruta donde queremos montarlo, ext3 el formato de archivos, ro los permisos (en este caso, le hemos dado solo lectura de forma arbitraria. El 0 y 1 corresponden a las comprobaciones que queremos que realice el sistema. Para más información, ver ``man mount``

Otra opción sería abrir el fichero de crontab con ``crontab -e`` y añadir en una línea:
~~~
mount /dev/sda1 -r /mnt/SA_ext3
~~~

Para montarlo en un instante después del arranque, por ejemplo, 10 minutos desde este momento, utilizaremos la orden ``at``
~~~
at now + 10 minutes
~~~
Ingresando ``mount /dev/sda1 -r /mnt/SA_ext3`` en la interfaz de ``at``. Para hacerlo justo en el arranque, podemos usar *cron* y añadir en *crontab -e* la siguiente línea:
~~~
@reboot mount /dev/sda1 -r /mnt/SA_ext3
~~~

Por último, se podría crear un script con el siguiente contenido:
~~~
#!/bin/bash
at `mount /dev/sda1 -r /mnt/SA_ext3` now + 10 minutes
~~~
Y posteriormente, ejecutar *crontab -e* y añadir ``@reboot /ruta/miscript.sh``. El defecto de este último método es que tendremos que teclear crtl+D para salirnos de la orden *at*, que se queda abierta por defecto.


## Ejercicio 4
***4. Crea un archivo en tu directorio home llamado ArchivosABorrar y consigue que todos los días de marzo del año 2013 a las 12:00 de la mañana ejecute el guión "programa" y almacene sus resultados en el archivo Datos***

Creamos el archivo y le damos permisos, por lo menos, de ejecución
~~~
touch /home/ArchivosABorrar
chmod 777 /home/ArchivosABorrar
~~~

Lo utilizaremos como un archivo de crontab (según entiendo por el enunciado). Dentro del archivo, escribimos la siguiente línea:
~~~
0 12 * 3 * /ruta/programa >> /ruta/Datos
~~~
*La ruta de "programa" y de "Datos" hay que especificarla explícitamente*

Lanzamos el archivo crontab con la orden ``crontab /home/ArchivosABorrar``

*Nota: para asegurarnos de hacer efectivo cambios en "borrar", cada vez que se edite el archivo, volver a ejecutar la orden crontab archivo*
