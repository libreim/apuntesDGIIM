
# Sistemas Operativos.

## Repaso Fundamentos del Software.

Las llamadas al sistema son peticiones que realiza el usuario al sistema operativo.

Las interrupciones son generadas por los componentes de hardware.

Excepciones: Son aquellas operaciones que no pueden ser realizaras por el sistema operativo. Se producen durante la ejecución(a diferencia de las interrupciones) de una instrucción máquina.

### Registros de la CPU

__Registros de instruccion (IR)__: La instrucción actual.

__Contador de programa (CP)__: La direccion de memoria de la siguiente instrucción.

__Puntero de pila (SP)__: Dirección de la "cabeza" de la pila, memoria asignada al programa en ejecución.

__Palabra de estado (PSW)__: Informa del estado del procesos, nos permite saber si se genera algun tipo de excepcion o interrupción y saber cual.

Si por ejemplo se genera una interrupción, el en CP se carga la instrucción de tratamiento de interrupciones. Automaticamente el hardware se encarga de guardar en la pila del proceso el CP y PSW. Lo mismo ocurre con las llamadas al sistema, al realizarse se carga en el CP la instruccion correspondiente a dicha llamada desde la memoria y seguarda el PSW y el CP en la pila.


### Cambio de contexto y modo.

Cuando se realiza un __cambio de contexto__, se interrumpe la ejecucion de un proceso, dando el uso de la CPU a otro proceso, guardandose la información del primero para permitir su reanudación. Podemos decir que es realizar una pausa en la ejecución de un proceso, para ejecutar otro durante un periodo de tiempo.

Un __cambio de modo__ se produce cuando es necesario realizar operaciones en modo supervisor, motivos pueden ser interrupciones, excepciones y llamadas al sistema. En este proceso se cambia un bit de la PSW que indica quien ejecuta la instrucción, guardandose la información del proceso interrumpido para reanudarse en cuanto termina la rutina de interrupciones.

Un __cambio de modo__ es como un __cambio de contexto__ donde el proceso cargado es el de tratamiento de interrupciones para volver a ejecutar el anterior en cuanto la interrupción termine.

### Paginacion y segmentacion

1. __Paginación__: Dividir la memoria principal en marcos de paginas y la informacion a almacenar en paginas, de forma que se introduce cada pagina en un marco, donde informacion conjunta puede estar en marcos de pagina no contiguos. Existe una tabla de páginas para saber en que direccion en memoria principal donde encuentra el marco de pagina correspondiente a cada pagina, isn necesidad de almacenar el tamaño ya que es conocido.

2. __Segmentación__: Dividir la memoria utilizada por el proceso en grupos de tamaño variable bajo un contexto y se cargan en la memoria principal de forma contigua, existe la tabla de segmentos para saber la direccion donde comienza el segmento en memoria principal y el tamaño de dicho segmento.
