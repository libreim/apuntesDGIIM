\part{Teoría}

# Introducción

## Sistemas de comunicación y redes

Un sistema de comunicación es una infraestructura que permite el
intercambio de información. 

De una forma más extensa: Entendemos por una red como un sistema de
comunicación con sistemas finales autónomos que facilita el
intercambio eficaz y transparente de la información. 

Debemos saber que los sistemas finales son aquellos que tienen
capacidad de procesar información; que un intercambio se considera
eficaz si maximiza el uso de los recursos como el ancho de banda entre
otros y que es transparente si actúa con independencia de las
diferencias del sistema entre la fuente y el destino. 

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


Tenemos varios problemas a resolver respecto a la transparencia y
eficacia en la transmisión de información con una red, entre ellos: El
método de transmisión de la información y su traducción; compartición
del medio y la segmentación de la información; control del flujo y de
errores, en el enlace y también extremo a extremo; control del
encaminamiento o enrutamiento de los mensajes; control de congestión;
entrega ordenada de los mensajes; gestión del diálogo o turno de
palabra; representación o sintaxis de los datos; significado o
semántica de los datos. 

Aprendereos a solucionar todo esto utilizando el modelo OSI(Open
System Interconnection) de la ISO que pese a ser un modelo estándar
tiene un interés puramente académico. Pese a ello, este modelo de 7
capas es la base del modelo TCP/IP que es el que realmente se utiliza
a día de hoy. 



### Estructura y elementos de una red

Los **hosts** son los sistemas finales autónomos y la *subred* es la
infraestructura para el transporte de información. Las subredes están
formadas por nodos que se conectan mediante nodos o elementos de
conmutación. 

## Diseño y estandarización de redes

### **Modelo OSI**
Grupo 1 de capas:
- Capa Física: Conexión ordenador-punto de acceso. Mueven los bits
  dentro de la trama de un nodo al siguiente.

- Capa de Enlace: Permite la comunicación entre dos nodos directamente
  conectados. Delimita la trama (nombre que se le da a los paquetes de
  la capa de enlace) y controla errores y flujo. 
  
Grupo 2:
- Capa de Red: Nos ofrece la capacidad de enrutamiento que permite
  llevar a los paquetes desde un origen a un destino. Controla además
  la congestión, evitando el envío de paquetes a nodos
  congestionados. Incluye el protocolo IP, que es único y hace que se
  haga referencia a esta capa como la capa IP.

Abstrae toda la comunicación para que únicamente se preocupe del nodo
inicial y nodo destino como si estuvieran conectados directamente.

Grupo 3:


- Capa de Transporte: Transporta los mensajes entre los extremos
  finales de la comunicación. Existen dos protocolos de transporte,
  UDP y TCP. Proporciona control de errores y control de flujo.

- Capa de Sesión: Controla el "turno de palabra" y las tareas de
  sincronización, es decir, decide quién y en qué momento envía
  información.

- Capa de Presentación: Permite una traducción desde el "idioma de la
  red" al "idioma de la aplicación", que se puedan entender los datos
  intercambiados. Incluye cifrado y compresión.
  
- Capa de Aplicación: Son las aplicaciones finales, que tienen su
  propio protocolo (http, ftp, por ejemplo). A los paquetes que
  transmite se les conoce como "*mensajes*".

## Terminología y servicios


## Terminología y servicios:

Comunicación **virtual** (horizontal) vs **real**(vertical).

La comunicación virtual es cómo la capa N-ésima de la primera entidad
que se comunica envía un mensaje a la N-ésima capa de la segunda
entidad receptora. Mientras que la real refleja como cada capa se
comunica con su capa inmediatamente inferior hasta que llega a la capa
física que transmite la información y se comunica con la capa
inmediatamente superior hasta llegar a la capa original.

**Retardos en la comunicación:**

El **tiempo de transmisión** es lo que tardan los bits del paquete en
emitirse. Depende de la velocidad de transmisión y el número de bits a
enviar.

$$T_t = \frac{P(b)}{V_t (bps)}$$

El **tiempo de propagación** es el tiempo que el primer bit tarda hasta
llegar a su destino. La velocidad de propagación depende del medio
físico del enlace y se mide en metros por segundo. (Distancia a
recorrer entre velocidad de propagación

$$T_p = \frac{D(m)}{V_p(m/s)}$$

La fibra óptica aumenta el ancho de banda para poder transmitir más
bits a la vez, y por tanto aumenta la velocidad de las transmisiones.

Además de estos tiempos, cuando un nodo recibe un paquete y lo procesa
para reenviarlo se producen **retardos de procesamiento**, cuando el
nodo recibe dicho paquete y procesa su información, y **retardos de
cola**, cuando el mensaje espera en una cola a que todos los mensajes
que llegaron antes que él sean enviados.


**Servicios:**
- **Orientado a conexión (OC)**. Tales como TCP, su objetivo es evitar
  las pérdidas. Se abre una conexión, haciendo que cliente y servidor
  intercambien información de control antes de que se produzca el
  intercambio a nivel de aplicación. Se usa en aplicaciones donde se
  quieran evitar las pérdidas de información.
  
- **No orientado a conexion (NOC)**. Tales como UDP,  proporciona unos
  servicios básicos, sin establecer una conexión previa, por lo que no
  garantiza la correcta entrega del mensaje. Se usa en aplicaciones de
  tiempo real.

- **Confirmado (fiable)**. Pueden garantizar la entrega sin errores y
  en el orden correcto.
  
- **No confirmado (no fiable)**. No garantizan la entrega correcta del
  mensaje.

## Internet: arquitectura y direccionamiento

Existe una jerarquía en el sistema por el cual nos conectamos a
internet:

* Intranets: Wifi, ethernet

* Redes de acceso del ISP (Internet Service Provider): Cable
  telefónico (xDLS,ISDN), cable (coax), HFC(Hybrid Fiber Coax),
  FTTH(Fiber-To-The-Home)

* Redes troncales (ATM, SDH, SONET, etc) de grandes operadores de
  telecomunicaciones.
  
  
**Tipos de Tier de ISP:**

* Tier 1: Los grandes proovedores hacen acuerdos de peering para no
  cobrarse los servicios mutuamente, sino que solo gestionan el
  tráfico entre ellos. Sólo tienen acuerdos de peering. Se conocen
  como redes troncales y tienen cobertura internacional.

* Tier 2: Tienen tanto acuerdos de peering como pagos a otros ISP más
  grandes que puedan gestionar su tráfico. Tienen cobertura
  regional/nacional.

* Tier 3: Pagan por los acuerdos de tránsito. No pueden permitirse
 negociar para hacer peering. Necesitan conectarse a internet a través
 de un ISP de tier 2.
 
 Para conocer cómo se dirigen las conexiones y cómo se identifican los
 destinatarios se usan diversos elementos. La dirección IP, en la capa
 de red, identifica a los hosts. Para los humanos es más sencillo usar
 los nombres de dominio, los cuales traducen las direcciones del
 lenguaje humano a su correspondiente dirección IP.

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
