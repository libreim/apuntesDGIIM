\part{Teoría}

# Introducción

## Sistemas de comunicación y redes

Un sistema de comunicación es una infraestructura que permite el intercamio de información.

De una forma más extensa: Entendemos por una red como un sistema de comunicación con sistemas finales autónomos que facilita el intercambio eficaz y transparente de la información.

Debemos saber que los sistemas finales son aquellos que tienen capacidad de procesar información; que un intercambio se considera eficaz si maximiza el uso de los recursos como el ancho de banda entre otros y que es transparente si actúa con independencia de las diferencias del sistema entre la fuente y el destino.

Razones para usar redes:

- Nos permiten compartir recursos
- Son escalables
- Son fiables y robustas
- Permiten ahorrar costes

Podemos clasificar las redes:

- Por escala:
    * LAN (Local Area Network) $\simeq$ 1km
    * MAN (Metropolitan Area Network) $\simeq$ 10km
    * WAN (Wide Area Network) $\geq$ 10km
- Por tecnología de transmisión o uso del canal de comunicación
    * Difusión
    * Punto a punto


Tenemos varios problemas a resolver respecto a la transparencia y eficacia en la transmisión de información con una red, entre ellos: El método de transmisión de la información y su traducción; compartición del medio y la segmentación de la información; control del flujo y de errores, en el enlace y también extremo a extremo; control del encaminamiento o enrutamiento de los mensajes; control de congestión; entrega ordenada de los mensajes; gestión del diálogo o turno de palabra; representación o sintaxis de los datos; significado o semántica de los datos.

Aprendereos a solucionar todo esto utilizando el modelo OSI(Open System Interconnection) de la ISO que pese a ser un modelo estándar tiene un interés puramente académico. Pese a ello, este modelo de 7 capas es la base del modelo TCP/IP que es el que realmente se utiliza a día de hoy.


### Estructura y elementos de una red

Los **hosts** son los sistemas finales autónomos y la *subred* es la infraestructura para el transporte de información. Las subredes están formadas por nodos que se conectan mediante nodos o elementos de conmutación.

## Diseño y estandarización de redes

## Terminología y servicios

## Internet: arquitectura y direccionamiento

\part{Prácticas}

# Práctica 1

¡Reiniciar el servicio correspondiente tras los cambios en sus archivos
de configuración!

Información
-----------

### Telnet

Para habilitar el servicio telnet hay que editar el archivo
`/etc/xinetd.d/telnet` y cambiar la variable correspondiente. Para que
el equipo solo sea accesible desde una IP específica añadimos la línea
`only_from = <IP>` al archivo telnet.

Para registrar los intentos de log con telnet añadimos en el archivo
telnet las líneas:

-   Escoger dónde y cómo se guardarán los logs:
    `log_type = FILE <file>`.\
-   Quá información guardamos de los logs fallidos:
    `log_on_failure += HOST`.\
-   Qué información guardamos de los logs válidos:
    `log_on_success += HOST`.\

### FTP

Para que ftp no funcione en *standalone* sino que utilice el servidio
xinetd, hay que editar en `/etc/vsftpd.conf` y cambiar `listen = no`.
Para impedir el acceso anónimo `anonymous_enable = no`. Para permitir
acceder a cuentas locales descomentamos `local_enable = yes`.\
Para crear una lista de usuarios que se puedan conectar añadimos al
fichero `/etc/vsftpd.conf`, `userlist_enable=YES`
`userlist_file=/etc/vsftpd.user_list` `userlist_deny=NO` Esto último
significa que la lista no es para denegar acceso. Los usuarios en
cuestión deben estar escritos en el fichero `/etc/vsftpd.user_list`.\
Para aceptar la subida de ficheros descomentamos en el archivo
`/etc/vsftpd.conf` la línea `write_enable = YES`.

### Apache

Para alterar la página de inicio cambiamos el archivo
`/var/www/index.html`.\
El puerto se cambia en los archivos `/etc/apache2/ports.conf` y
`/etc/apache2/sites-enabled/000-default`.\
Para crear unos usuarios restringidos:
`htpasswd -c <ruta/fichero usuarios restringidos> <usuario>`

En la ruta `/var/www/<pagina restringida>.htaccess` añadimos las líneas:

``` {.ssh}

AuthType Basic
AuthName "Restricted Content"
AuthUserFile "<fichero de usuarios restringidos>"
Require valid-user

```

Es necesario editar el archivo `/etc/apache2/apache2.config` y añadir
las siguientes líneas:

``` {.ssh}

<Directory "/var/www/<pagina restringida>">
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>

```
