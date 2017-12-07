# Sesión 5: Señales #

*Una señal (del inglés signal) es una forma limitada de comunicación entre procesos empleada en Unix y otros sistemas operativos compatibles con POSIX. En esencia es una notificación asíncrona enviada a un proceso para informarle de un evento. ~Wikipedia*

En otras palabras, es un mecanismo que tenemos para comunicarnos con los procesos. Por ejemplo, cuando se está ejecutando una orden en la terminal y hacemos ``ctrl+c`` para detenerlo, le estamos mandando una señal al proceso, en concreto la señal *SIGINT*.

Por defecto, las señales existentes en POSIX tienen una acción asociada, aunque podemos modificar dicho comportamiento en la mayoría de ellas, el cual es uno de los objetivos de esta sesión. Mayoría de ellas, ya que algunas, no podemos ni ignorarlas ni modificar su comportamiento, como por ejemplo las señales SIGKILL y SIGSTOP. Antes de continuar, es importante tener claras las siguientes definiciones:
- Una señal es *depositada* cuando el proceso inicia una acción en base a ella.
- Una señal está *pendiente* si ha sido generada pero todavía no depositada.
- Una señal está *bloqueada* si se encuentra en la denominada *máscara de bloqueo de señales*
  del proceso, en cuyo caso permanece pendiente hasta que es desbloqueada, deja de pertenecer
  a la máscara. Si una señal es recibida varias veces cuando estaba bloqueada se trata como
  una única señal al desbloquearse.
- Una señal se dice *ignorada* si el proceso no le presta atención cuando es generada.

La *máscara de bloqueo de señales* de un proceso es el conjunto de señales bloqueadas que tiene un proceso. Si una señal está bloqueada, el proceso no la interpreta hasta que se desbloquee. Si mientras está bloqueada una señal, se envía varias veces, el proceso solo la tiene en cuenta una vez. Las señales pueden bloquearse y activarse manualmente como veremos a lo largo de eset documento.

Cada señal tiene un valor entero asociado. Así, la señal *SIGINT* que comentamos antes, podemos manejarla el valor *2*, en vez tener que escribir *SIGINT*. Para mandar una señal a un proceso que se está ejecutando, tenemos que abrir una nueva sesión de la terminal (o en la misma si se está ejecutando en segundo plano) y utilizar la orden *kill*, con la siguiente sintaxis:
~~~
kill -s VALUE PID
~~~
Donde la opción ``-s`` indica que le vamos a mandar una señal al proceso, VALUE es la señal a mandar. Comentamos que, sustituir VALUE por *SIGINT* es equivalente a sustituirlo por *2*. PID es el pid del proceso al que queremos mandarle la señal. Para conocer el pid de un proceso, podemos utilizar la orden ``top``.

Dado que el objetivo de este documento es entender y aprender a utilizar las señales en C, no se va a desarrollar mucho la sintaxis ni las opciones de las órdenes relacionadas con las señales. Para ello se puede consultar el documento *LLamadasSistema.md* que recoge lo anteriormente descrito.

## Activación, desactivación y alteramiento de señales
Las señales pueden activarse, desactivarse y alterar su comportamiento mediante las siguientes órdenes. Su funcionamiento se entenderá en los ejemplos puestos a continuación.
+ Activar una señal: ``signal(value,function)``. Donde value es la señal y function la función que queremos asociarle a la señal, en vez de su comportamiento habitual.
+ Desactivar una señal: ``signal(value,SIG_IGN)``. *SIG_IGN* le indica al proceso que la señal dada con *value* debe ignorarla.

Es importante destacar que si le mandamos a un proceso una señal que está desactivada, abortará su ejecución (basándome en pruebas experimentales).

## ¿Cómo se hace un programa en C que interprete señales?
Para la explicación, vamos a utilizar ejemplos, que incrementarán gradualmente su complejidad. 

Como primer ejemplo, vamos a hacer un programa que trabaje solo con dos señales. La señal 1, incrementará en una unidad un contador inicializado en 0, la señal 2, terminará el proceso.

La señales 1 y 2, por defecto, no realizan lo que queremos, tenemos que asociarle una función. El código del programa es el siguiente:
~~~c
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

int contador = 0;

static void handler() {
  contador++;
  printf("\nSe ha recibido la señal, que se ha realizado %d veces.",contador);
}

static void SIGTERMHandler() {
   printf("\nSe termina la ejecucion de este programa.");
   exit(0);
}

int main() {
  setvbuf(stdout, NULL, _IONBF, 0);
  signal(1,handler);
  signal(2,SIGTERMHandler);
  
  while (1);
}
~~~

*Para ejecutarlo, como se comentó anteriormente, lo ejecutamos en una terminal, abrimos otra terminal distinta y escribimos kill -s N PID, donde N es la señal y PID el del proceso al que le queremos mandar la señal.*

La función *setvbuf* es simplemente para desactivar el búffer y que la salida se imprima correctamente.

La función *handler* se encarga de aumentar el contador, mientras que la función SIGTERMHandler es la que abortará el proceso. Por tanto, asociamos dichas funciones a las señales 1 y 2 respectivamente, tal y como se aprecia en el inicio del main. Finalmente, el uso de ``while(1)`` es para que nuestro programa no deje de ejecutarse hasta que le mandemos la señal 2. Cuando le mandamos la señal 2, se ejecuta la función SIGTERMHandler, que hace ``exit(0)`` y cierra el programa. Un equivalente sería tener una variable booleana inicializada en *true*, tener como bucle while(true) y en la función SIGTERMHandler poner en *false* dicha variable, así la ejecución terminaría al acabar el bucle, sin necesidad de hacer un *exit(0)* en la función.

Veamos otro ejemplo, el mecanismo del siguiente programa es muy similar. EL programa se ejecuta, y durante 15 segundos, tenemos que hacer *crtl+c*, o equivalentemente, usar *kill* para mandarle la señal 2 al proceso. Transcurridos los 15 segundos, el programa acaba, diciéndonos cuántas veces hemos mandado la señal 2.

El código está documentado por su autor, por lo que se comentará brevemente. Como mecanismos de seguridad, dentro de las funciones, activa y desactiva algunas señales, utilizando para ello ``signal (value, SIG_IGN)``, comentada anteriormente. El hecho de ignorar la señal, tiene relación con lo explicado de señales bloqueadas e ignoradas.

~~~c
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
 
int num_pulsaciones = 0;  /* Contador de pulsaciones de  CTRL-C */
int bucle = 1;            /* Controlador de salida del bucle de espera */
void terminar_bucle ();   /* Captura la señal de alarma SIGALRM */
void contar ();           /* Captura la señal de interrupción SIGINT */
 
int main () {
    /* Asociamos la señal SIGINT a la función cortar(). La señal SIGINT la recibe el programa cuando
       se pulsa CONTROL+C. */
    signal (SIGINT, contar);
 
    /* Asocia la señal SIGALRM a la función terminar_bucle(). Cuando el programa reciba la señal alarma
       se ejecutará la función terminar_bucle. */
    signal (SIGALRM, terminar_bucle);
 
    printf ("Pulsa varias veces CTRL-C durante 15 segundos.\n");
 
    /* Programamos una alarma para dentro de 15 segundos.
       Cuando pasen 15 segundos este programa
       recibirá una señal SIGALRM. */
    alarm (15);
 
    /* Entramos en un bucle infinito del que solo saldremos 
       cuando la variable bucle cambie su valor. Esto sucederá
       cuando se ejecute la función terminar_bucle(). */
    while (bucle==1);
 
    /* Desactivamos la señal SIGINT porque ya no vamos a contar
       más veces cuando el usuario pulse CTRL+C. */
    signal (SIGINT, SIG_IGN);
 
    printf ("Has pulsado CTRL+C %d veces.\n", num_pulsaciones);
 
    return 0;
    }
 
/* Esta función se ejecutará cuando el proceso reciba la señal SIGALRM al de 15 segundos. */
void terminar_bucle () {
      // Vamos a desactivar la alarma SIGALRM. SIG_IGN hace que se ignore la señal SIGALRM.
      signal (SIGALRM, SIG_IGN);
 
      // Queremos que el bucle infinito que había en la función main se termine. Como hacemos bucle=1
      // el bucle ya no cumple la condición bucle==1 y se termina.
      bucle=0;
      printf ("¡Alarma!\n");
}
 
/* Esta función se ejecuta cada vez que se pulsa CTRL+C (señal SIGINT).
   Cuando se termine esta función el programa seguirá en el punto que se había quedado. */
void contar ()
{
    /* Primero desactivamos la señal SIGINT por si se pulsa CTRL+C 
       mientras se está ejecutando esta función. */
    signal (SIGINT, SIG_IGN);
    printf ("Has pulsado CTRL-C\n");
    num_pulsaciones++;
    // Volvemos a asociar SIGINT con la función cortar() para la próxima vez que el usuario pulse CTRL+C.
    signal (SIGINT, contar);
}
~~~
*La autoría de este código corresponde al blog nideaderedes.urlansoft.com*


Ahora vamos a pasar a resolver el ejercicio 2 de la sesión. Se trata de escribir un programa en C que imprima las veces que se ha enviado la señal e imprima las que no puede manejar, *SIGKILL* y *SIGSTOP*, 9 y 14 respectivamente. El código es el siguiente.
~~~c
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>

//Contador de las veces que se ha usado cada señal
int contador[35];

//Funcion para llevar el contador
static void handler(int sig) {
  contador[sig]++;
  printf("\nSe ha recibido la señal %d, que se ha realizado %d veces.",sig, contador[sig]);
}


int main() {
   setvbuf(stdout, NULL, _IONBF, 0);

  //Pongo a 0 todo el contador de las señales
  int i;
  for(i=0; i < 35; i++)
    contador[i] = 0;

  //Informamos de las señales que no podemos manejar

  printf("No puedo manejar la señal %d\n", SIGKILL);
  printf("No puedo manejar la señal %d\n", SIGSTOP);

  //Ahora trabajamos con las señales recibidas
  //Primero vamos a dar de alta las señales que podemos utilizar, en mi caso, van a hacer todas lo mismo, incrementar en 1 su contador

 //Asociamos las 35 señales a la función handler, para que cuando las llamemos, se incremente su contador 
  for(i=1; i <= 35; i++) 
        signal(i,handler);

  //Bucle infinito para que el programa se ejecute mientras no le mandemos las señales para terminar(9,14)
  while (1);

}
~~~
La explicación del código viene comentada dentro del mismo, en vez de desglosarlo fuera de él para evitar que se alargue demasiado el documento. Notar que aunque en el bucle *for* hayamos intentado modificar las señales 9 y 14, su comportamiento no se ha modificado, ya que el sistema lo impide, pero no da errores ni de ejecución ni de compilación.

Ahora, para afianzar conceptos, vamos a hacerle algunas modificaciones. Contaremos las llamadas de la 1 a la 15, y la 16 la reservamos para abortar el proceso(a parte de la 9 y 14 que lo son por defecto). Cuando mandemos la señal 16, el proceso terminará, mostrando un mensaje por pantalla. El mensaje se muestra ya que lo hemos programado así, a diferencia de lo que ocurre al usar las llamadas 9 y 14.
Las llamadas de la 17 a la 31, las vamos a desactivar, ya que no las usaremos ni queremos tenerlas en cuenta. Si el usuario realiza una de estas llamadas, el sistema, por defecto, termina el proceso.

~~~c
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>

//Contador de las veces que se ha usado cada señal
int contador[15];

//Funcion para llevar el contador
static void handler(int sig) {
  contador[sig]++;
  printf("\nSe ha recibido la señal %d, que se ha realizado %d veces.",sig, contador[sig]);
}

//Función para terminar el proceso cuando realicemos la llamada correspondiente.
void fin_proceso(){
   printf("\nSe termina la ejecucion de este programa.");
   exit(0);
}


int main() {
   setvbuf(stdout, NULL, _IONBF, 0);

  //Pongo a 0 todo el contador de las señales
  int i;
  for(i=0; i < 15; i++)
    contador[i] = 0;

  //Ahora trabajamos con las señales recibidas
  //Primero vamos a dar de alta las señales que podemos utilizar, en mi caso, van a hacer todas lo mismo, incrementar en 1 su contador

 //Asociamos las 15 señales a la función handler, para que cuando las llamemos, se incremente su contador 
  for(i=1; i <= 15; i++) 
        signal(i,handler);

 //Asociamos la señal 16 a la función fin_proceso()
 signal(16,fin_proceso);

 //Ignoramos las llamadas 17-35
 for(i=17; i <=35; i++)
	signal(i,SIG_IGN);

  //Bucle infinito para que el programa se ejeucte mientras no le mandemos las señales para terminar(9,14)
  while (1);

}
~~~

De nuevo, en el mismo código se explica lo que se va haciendo.


## Manejando señales, otra forma de hacerlo. La estructura sigaction
Otra forma de realizar los ejemplos anteriores, es con el uso de la estructura **sigaction**. La idea es la misma, asociar una función creada por nosotros a las señales que queramos. Para ello, en vez de usar la función ``signal(value,function)``, utilizaremos ``sigaction(int value, const struct sigaction *act,NULL)``. Realmente el último parámetro no es NULL siempre, pero nosotros siempre la invocaremos así. Para más información, se puede consultar el *man*. El siguiente código corresponde al 3º ejemplo realizado, es decir, el ejercicio 2. 
~~~c

#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>

static int contador[35];

static void handler(int sig){
  contador[sig]++;
  printf("Se ha recibido la señal %d que se ha llamado %d veces", sig, contador[sig]);
}

int main() {

  //Declaramos la estructura sigaction
  struct sigaction sigUsr;

  setvbuf(stdout, NULL, _IONBF, 0);

  //Incializamos la estructura sigUsr para especificar la nueva acción para la señal
  sigUsr.sa_handler = handler;
  
  //Iniciamos el conjunto de señales dado al conjunto vacío
  sigemptyset(&sigUsr.sa_mask);

  //Reiniciar las funciones que hayan sido interrumpidas por un manejador
  sigUsr.sa_flags = SA_RESTART;

 //Ponemos el contador a 0
  for(int i = 0; i < 35; i++)
    contador[i] = 0;

  printf("No puedo manejar la señal %d\n", SIGKILL);
  printf("No puedo manejar la señal %d\n", SIGSTOP);

  //Asociamos las señales a la función que actualiza nuestro contador. 
  for(int i = 0; i < 35; i++){
    sigaction(i, &sigUsr, NULL);
  }

  while(1);
}
~~~

Creamos la estrucutura *sigaction* y a su campo *sa_handler*, le asociamos nuestra función *handle*, que lleva nuestro contador. Así, cuando invoquemos a *sigaction* como función, se podrá asociar a la señal indicada nuestra función. Es una forma un poco más tediosa de resolver el ejercicio, aunque nos es de utilidad para entender mejor los conceptos que vamos a tratar a continuación.

## Trabajo con las llamadas al sistema sigsuspend y sigprocmask
El siguiente código suspende la ejecución del proceso actual hasta que recibe una señal distinta de SIGUSR1.

~~~c
#include <stdio.h>
#include <signal.h>

int main() {
sigset_t new_mask;

/* inicializar la nueva mascara de señales */
sigemptyset(&new_mask);

sigaddset(&new_mask, SIGUSR1);

/*esperar a cualquier señal excepto SIGUSR1 */
sigsuspend(&new_mask);

}
~~~

En C, podemos suspender la ejecución de un proceso con ayuda de las órdenes sigsuspend y sigprocmask. El codigo anterior, si le mandamos la señal SIGUSR1, sigue suspendido, mientras que si le mandamos cualquier otra termina la suspensión. Para ello, lo que hacemos es crear una máscara de señales(ver definición al principio del documento). Esta máscara contendrá la señal SIGUSR1, que se la pasaremos a la orden sigsuspend, que mantiene en suspensión el proceso mientras le pasemos las señales que contiene la máscara, es decir, mientras le mandemos la señal SIGUSR1.

1. Creamos la máscara con la orden ``sigset_t new_mask``.
2. Vaciamos la máscara de lo que pudiera contener, para poder agregarle lo que queremos correctamente. Para eso utilizamos sigemptyset y le pasamos la máscara que acabamos de crear: ``sigemptyset(&new_mask)``.
3. Añadimos la señal SIGUSR1 (o su equivalente numérico) a la máscara: ``sigaddset(&new_mask, SIGUSR1)``
4. Finalmente, le decimos al proceso que se mantenga en suspensión mientras no le pasemos la orden SIGUSR1, que está en nuestra máscara: ``sigsuspend(&new_mask)``.


Veamos otro ejemplo. Mediante los mismos mecanismos, ahora queremos justo lo contrario. Mientras le pasemos cualquier llamada, el proceso está en suspensión, y cuando le pasemos al proceso la llamada SIGSUR1, saldrá de su estado de suspensión.
¿Qué hacemos? Pues justo lo contrario, meter en la máscara todas las señales excepto SIGUSR1. Dado que meter las señales una a una sería muy tedioso, echamos mano de la función *sigfillset*. El código es el siguiente:
~~~c
#include <stdio.h>
#include <signal.h>

int main() {
  sigset_t new_mask;

  //inicializar la nueva máscara de señales
  sigemptyset(&new_mask);

  //Primero "rellenamos" la máscara con todas las señales
  sigfillset(&new_mask);

  //Ahora borramos de la máscara la señal SIGUSR1, que es la que una vez mandada, saca de la suspensión al proceso.
  //Con el resto de señales, el proceso sigue en suspensión

  sigdelset(&new_mask, SIGUSR1);

  //El proceso sigue en suspensión mientras le mandemos una señal de la máscara que no sea SIGUSR1
  sigsuspend(&new_mask);
}
~~~
La explicación es justo lo que viene comentado dentro del código. Creamos la máscara y la vaciamos como en el ejemplo anterior. Con la función *sigfillset*, le metemos a la máscara todas las llamadas al sistema. Como queremos que con SIGUSR1 acabe la suspensión del proceso, tenemos que borrarla de la máscara, ya que *sigfillset* nos la ha añadido. Finalemente, llamamos a *sigsuspend* pasándole la máscara, tal y como realizamos anteriormente.

### sigprocmask
En las versiones más recientes de Linux, es común utilizar la orden ``sigprocmask`` para manejar las máscaras de señales. Su sintaxis es:
~~~
int sigprocmask(int how, const sigset_t *set, sigset_t *oset);
~~~
Devuelve 0 si se ha ejecutado correctamente, -1 si se ha producido un error. 
Primero, si *oset* no es un puntero nulo, la máscara de señales actual para el proceso es devuelta a través de *oset*.
Segundo, si *set* no es un puntero nulo, entonces el argumento *how* indica como se modifica la máscara actual. Resumiéndolos, los valores de *how* pueden ser:
1. SIG_BLOCK: *set* contiene las señales adicionales que queremos bloquear.
2. SIG_UNBLOCK: *set* contiene las señales que queremos desbloquear.
3. SIG_SETMASK: la nueva máscara de señales para el proceso es a la que viene apuntada por *set*

Un breve ejemplo de uso es el siguiente:
~~~c
sigset_t set;
sigemptyset(&set);
sigaddset(&set, SIGINT);
sigprocmask(SIG_UNBLOCK, &set, NULL);
~~~~
Este fragmento de código crea una nueva máscara(también llamado conjunto de señales), *set*, al que le añade la señal *SIGINT*. Mediante el uso de *sigprocmask*, desbloquea todas las señales que contienen la máscara *set* dada como argumento. En este caso, se desbloquea la señal *SIGINT*, que es la que contenía la máscara.

Para finalizar este documento, vamos a ilustrar un ejemplo algo más elaborado que el código anterior. El ejemplo corresponde al código del ejercicio 4 de la sesión 5 de las pŕacticas de Sistemas Operativos. 
Su funcionamiento es sencillo, desactiva la señal SIGTERM y la vuelve a activar después de una pausa de 10 segundos. El ejemplo es de poca utilidad, pero tiene un buen valor ilustrativo de la función *sigprocmask*.
~~~c
// tarea12.c

#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

static int signal_recibida = 0;

static void manejador (int sig)
{
          signal_recibida = 1;
}

int main (int argc, char *argv[])
{

    //Creamos dos conjuntos de máscaras y una estructura sigaction
    sigset_t conjunto_mascaras;
    sigset_t conj_mascaras_original;
    struct sigaction act;

    //Iniciamos a 0 todos los elementos de la estructura act. Inicia en 0 los n primeros bits de la estructura atc, donde n = sizeof(act). Es decir, la pone entera a 0. Para más información, consultar el man.
    memset (&act, 0, sizeof(act));

    //Asociamos la función manejador creada al sa_handler de act.
    act.sa_handler = manejador;

    //Se asocia la función manejador a la llamada SIGTERM, tal y como se explicó previamente.
    if (sigaction(SIGTERM, &act, 0)) {
        perror ("sigaction");
        exit(EXIT_FAILURE);
    }
    
    //Iniciamos un nuevo conjunto de mascaras
    sigemptyset (&conjunto_mascaras);
    //Añadimos SIGTERM al conjunto de mascaras
    sigaddset (&conjunto_mascaras, SIGTERM);
    
    //Bloqueamos SIGTERM usando la función sigprocmask. Al finalizar el código se explica más detenidamente.
    if (sigprocmask(SIG_BLOCK, &conjunto_mascaras, &conj_mascaras_original) < 0) {
       perror ("primer sigprocmask");
       exit(EXIT_FAILURE);
    }

    //10 segundos en los que podemos mandarle la señal SIGTERM que la tendrá en cuenta cuando la vuelva a activar
    sleep (10);

    //El proceso toma como suya la máscara conj_mascaras_original, así restauramos la señal SIGTERM
    if (sigprocmask(SIG_SETMASK, &conj_mascaras_original, NULL) < 0) {
       perror ("segundo sigprocmask");
       exit(EXIT_FAILURE);
       }

    sleep (1);

   if (signal_recibida)
       printf ("\nSenal recibida\n");
   exit(EXIT_SUCCESS);
}
~~~

La explicación del código viene implícita en el mismo mediante comentarios, solo resaltaremos un par de cosas. En primer lugar:
~~~c
sigprocmask(SIG_BLOCK, &conjunto_mascaras, &conj_mascaras_original)
~~~
Esta orden, en primer lugar, se guarda la máscara de señales actual del proceso en *conj_mascaras_original*. Después, se bloquea la señal contenida en *conjunto_mascaras* y se toma este mismo conjunto como la máscara de señales para el prroceso

En segundo lugar:
~~~c
sigprocmask(SIG_SETMASK, &conj_mascaras_original, NULL)
~~~
Como el tercer argumento es NULL, trabajamos sobre *conj_mascaras_original*. La orden *SIG_SETMASK* le dice al proceso que haga suya, como máscara de señales, *conj_mascaras_original*. Así, nos hacemos con la antigua, que no tenía la señal *SIGTERM* bloqueada


<!--El objetivo de este documento ha sido explicar, como buenamente he podido, el manejo de señales de la sesión 5 de SO, dado que el guión de prácticas apenas contiene la sintaxis de las instrucciones acompañada de algún ejemplo suelto. No obstante, al información es válida para cualquier tarea de manejo de señales en C. Todos los códigos recogidos en el documento son de mi autoría, a excepción de los citados con la correspondiente referencia. Eres libre de añadir, editar y compartir el documento, perteneciente al repositorio de apuntes de github.com/libreim. ~~Víctor Castro Serrano, curso 2017-2018, DGIIM, UGR.-->
