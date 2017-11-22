# SISTEMAS CONCURRENTES Y DISTRIBUIDOS

## Tema 1. Introducción

### 1. Conceptos básicos y motivación

#### 1.1 Modelos básicos relacionados con la concurrencia

- **Programa secuencial**: Declaraciones de datos y conjunto de instrucciones sobre dichos datos que se deben ejecutar en secuencia.

- **Programa concurrente**: conjunto de programas secuenciales ordinarios que se pueden ejecutar *lógicamente* en paralelo.

- **Proceso**: Ejecución de un programa secuencial.

- **Concurrencia**: Describe el potencial para ejecución paralela, es decir, el solapamiento real o virtual de varias actividades en el tiempo.

- **Programación concurrente**: Conjunto de notaciones y técnicas de programación usadas para expresar paralelismo potencial y resolver problemas de sincreonización y comunicación. La programación concurrente es independiente de la implementación del paralelismo. Es una abstracción.

- **Programación paralela**: Su principal objetivo es acelerar la resolución d eproblemas concretos mediante el aprovechamiento de la capacidad de procesamiento en paralelo del hardware disponible.

- **Programación distribuida**: Su principal objetivo es hacer que varios componentes software localizados en diferentes ordenadores trabajen juntos.

- **Programación de tiempo real**: Se centra en al programación de sistemas que están funcionando continuamente, recibiendo entradas y enviando salidas a/desde componentes hardware en los que se trabaja con restricciones muy estrictas en cuanto a la respuesta temporal.



### 2. Modelo abstracto y consideraciones sobre el hardware

#### 2.1 Consideraciones sobre el hardware
#### 2.2 Modelo abstracto de concurrencia

##### Sentencia atómica
Una sentencia o instrucción de un proceso en un programa concurrente es atómica (indivisble) si siempre se ejecuta de principio a fin sin verse afectada por otras sentencias en ejecución de otros procesos del programa. No se verá afectada cuando el funcionamiento de dicha instrucción no dependa nunca de como se estén ejecutando otras instrucciones. El funcionamiento de una instrucción se define por su efecto en el estado de ejecución del programa justo cuando acaba. El estado de ejecución está formado por los valores de las variables y los registros de todos los procesos.

Algunos ejemplos de intrucciones atómicas son:

- Leer una celda de memoria y cargar su valor en ese momento en un registro del procesador.
- Incrementar el valor de un regristro (u otras operaciones aritméticas entre registros).
- Escribir el valor de un regristro en una celda de memoria.

La mayoría de sentencias en lenguajes de alto nivel son típicamente no atómicas. Por ejemplo, la sentencia

*x = x+1*

consta en realidad de una secuencia de 3 sentencias:

1. Leer el valor de x y cargarlo en un registro *r* del procesador.
2. Incrementar en una unidad el valor almacenado en el regristro *r*.
3. Escribir el valor del registro r en la variable *x*.

El resultado depende de que haya o no otras sentencias ejecutándose a la vez y escribiendo simultáneamente sobre la variable *x*. Hay indeterminación (no se puede predecir el estado final a partir del inicial).

Si tenemos un programa *C* compuesto por dos procesos *P_A* y *P_B* que se ejecutan a la vez, las ejecución sentencias atómicas de cada uno de estos procesos pueden darse en múltiples órdenes (interfoliaciones). Las sentencias atómicas se ordenan en función del instante en que acaban. El modelo basado en el estudio de las posibles secuencias de ejecución entrelazadas de los procesos constituye una abstracción:
- Se consideran exclusivamente caracterísitcas relevantes que determinan el resultado del cálculo.
- Esto permite simplificar el análisis y diseño de los programas concurrentes.

Se ignoran los detalles no relevantes para el resultado, como or ejemplo:

- Las áreas de memoria asignadas a los procesos.
- Los registros particulares que están usando.
- El costo de los cambios de contexto entre procesos.
- La política del SO relativa a la asignación de CPU.
- Las diferencias entre entornos multiprocesador o monoprocesador.

##### El entrelazamiento preserva la consistencia

El resultado de una instrucción individual sobre un dato no depende de las circunstancias de la ejecución. Supongamos que un programa *P* se compone de dos instrucciones atómicas, *I_0* e *I_1* que se ejecutan concurrentemente. Entonces:
- Si *I_0* e *I_1* nmo acceden a la misma celda de memoria o registro, el orden de ejecución no afecta al resultado final.
- Si *I_0* carga en la posición *M* de memoria un dato 1, e *I_1* carga un dato 2, entonces al final de la ejecución se dará *M = 1* o *M = 2*, pero nunca *M = 3*.

##### Progreso finito

No se puede hacer una suposición acerca de las velocidades absolutas o relativas de ejecución de los procesos, salvo que son mayores que 0. Un programa concurrente se entiende en basesa a sus componentes (procesos) y sus interacciones, sin tener en cuenta el entorno de ejecución.

Si se cumple la hipótesis, la velocidad de ejecución de cada proceso será no nula, lo cual tiene dos consecuencias. Desde el puntod e vista global, durante la ejecución del programa concurrente, en cualquier momento existirá al menos 1 proceso preparado. Desde el punto de vista local, cuando un proceso concreto de un programa concurrente comienza la ejecución de una sentencia, completará la ejecución de la sentencia en un intervalo de tiempo finito.

##### Estado e historia de ejecución de un programa concurrente

El estado de un programa concurrente son los valores de las variables del programa en un momento dado. Incluyen variables declaradas explícitamente y variables con información de estado oculta.
Un programa concurrente comienza su ejecución en un estado inicial y los procesos van modificando el estado conforme se van ejecutando sus sentencias atómicas.

La hostoria o traza de un rpograma concurrente son secuencias de estados producidas por una secuencia concreta de interfoliación.

##### Grafo de sincronización

El *grafo de sincronizació* es un grafo dirigido acíclico donde cada nodo representa una secuencia de sentencias del programa.

Dadas dos actividaddes *A* y *B*, una arista desde *A* hacia *B* significa que *B* no puede comenzar su ejecución hasta que *A* haya finalizado.

El grafo de sincronización muestra las restricciones de precedencia que determinan cuándo una actividad puede empezar en un programa.

##### Definición estática de procesos

El número de procesos (arbitrario) y el código que ejecutan no cambian entre ejecuciones. Cada proceso se asocia con su identificador y su código mediante la palabra clave process.

El programa acaba cuando acaban todos los procesos. Las variables compartidas se inicializan antes de comenzar ningún proceso.

Sew pueden usar definiciones estáticas de grupos de procesos similares que solo se diferencian en el valor de una constante (vectores de procesos).

##### Creación de procesos no estructurada con fork-join

**fork**: sentencia que especifica que la rutina nombrada puede comenzar su ejecución al mismo tiempo que comienza la sentencia siguiente (bifurcación).

**join**: sentencia que espera la terminación de la rutina nombrada, antes de comenzar la sentencia siguiente (unión).

##### Creación de procesos no estructurada con cobegin-coend

Las sentencias en un bloque delimitado por cobegin-coend comienzan su ejecución todas ellas a la vez.

En el coend es espera a que se terminen todas las sentencias. Hace explícuto qué rutinas van a ejecutarse concurrentemente.

### 3. Exclusión mutua y sincronización

#### 3.1  Concepto de exclusión mutua

Según el modelo abstracto, los procesos concurrentes ejecutan sus instrucciones atómicas de forma que, en principio, el entremezclado en el tiempo es arbitrario. Sin embargo, en un conjunto de porcesos que no son independientes entre sí (cooperativos) algunas de las posibles formas de combinar las secuencias no son válidas.

En general, se dice que hay una condición de sincronización cuando esto ocurre, es decir, que hay alguna restricción sobre el orden en el que se pueden mezclar las instrucciones de distintos procesos.

Un caso particular es la exclusión mutua, secuencias finitas de intrucciones que deben ejecutarse de principio a fin por un único proceso, sin que a la vez otro proceso las esté ejecutando también.

La restricción se refiere a una o varias secuencias de instrucciones consecutivas que aparecen en el texto de uno o varios procesos. Al conjunto de dicas secuencias de instrucciones se le denomina sección crítica (SC). Ocurre exclusión mutua (EM) cuando los procesos solo funcionan correctamente si, en cada instante de tiempo, hay como mucho uno de ellos ejecutando cualquier instrucciuón de la serie crítica.

El solapamiento de las instrucciones debe ser tal que cada secuencia de instrucciones de la SC se ejecuta como mucho por un proceso de principio a fin, sin que durante ese tiempo otros procesos ejecuten ninguna de estas instrucciones ni otras de la misma SC.

Un ejemplo típico de EM ocurre en procesos con memoria compartida que acceden para leer y modificar variables o estructuras de datos comunes usando operaciones no atómicas.

#### 3.2 Condición de sincronización

En general, en un programa concurrente compuesto de varios procesos, una condición de sincronización establece que no son correctas todas las posibles interfoliaciones de las secuencias de instrucciones atómicas de los procesos. Eso ocurre típicamente cuando, en un punto concreto de su ejecución, uno o varios procesos deben esperar a que se cumpla una determinada condición global.

Ejemplo: productor-consumidor

### 4. Propiedades de los sistemas concurrentes

Una propiedad de un programa concurrente es un atributo del programa que es cierto para todas las posibles secuencias de interfoliación. Hay de dos tipos

##### Propiedades de seguridad

Son condiciones que deben cumplirse en cada instante (nunca sucederá algo malo). Requeridas en especificaciones estáticas del programa. Son fáciles de demostrar y para cumplirlas se suelen restringir las posibles interfoliaciones.

Ejemplos:

- Exclusión mutua: 2 procesos nunca entrelazan ciertas subsecuencias de operaciones.
- Ausencia de interbloqueo: nunca ocurrirá que los procesos se encuentren esperando algo que nunca sucederá.
- Propiedad de seguridad en el productor-consumidor: el consumidor debe consumir todos los datos producidos por el productor en el orden en el que se van produciendo.

##### Propiedades de vivacidad

Son propiedades que deben cumplirse eventualmente (realmente sucede algo bueno). So propiedades dinámicas, más difíciles de probar.

Ejemplos:

- Ausencia de inanición: un proceso o grupo de procesos no puede ser indefinidamente pospuesto. En algún momento, podrá avanzar.
- Equidad: tipo particular de propiedad de vivacidad. Un proceso que desee progresar debe hacerlo con justicia relativa con respecto a los demás. Más ligado a la implementación y a veces incumplida: existen distintos grados.

### 5. Verificación de programas concurrentes

#### 5.1 Introducción

¿Cómo demostrar que un programa cumple una determinada propiedad?

- Posibilidad: realizar diferentes ejecuciones del programa y comprobar que se verifica la propiedad. Problema: sólo permite considerar un número limitado de historias (interfoliaciones) de ejecución y no demuestra que no existan casos indeseables.

- Enfoque operacional: Análisis exhaustivo de casos. Se chequea la corrección de todas las posibles historias. Problema: su utilidad está muy limitada cuando se aplica a programas concurrentes complejos ya que el número de interfoliaciones crece exponencialmente con el número de instrucciones de los procesos.

#### 5.2 Enfoque axiomático

Se define un sistema lógico formal que permite establecer propiedades de programas en base a axiomas y reglas de inferencia. Se usan formas lógicas (asertos) para caracterizar un conjunto de estados. Las sentencias atómicas actúan como transformadores de predicados (asertos). Los teoremas en la la lógica tienen la forma:
*{P} S {Q}*
Si la ejecución de la sentencia *S* empieza en algún estado en el que es verdadero el predicado *P* (precondición), entonces el predicado *Q* (poscondición) será verdadero en el estado resultante.

El trabajo que conlleva la prueba de corrección es proporcional al número de sentencias atómicas del programa.

Invariante global es un predicado que referencia variables globales siendo cierto en el estado inicial de cada proceso y manteniéndose cierto ante cualquier asignación dentro de los procesos.

Ejemplo para productor consumidor:

*consumidos <= producidos <= consumidos + 1*

## Tema 2. Sincronización en memoria compartida

### 1. Introducción a la sincronización en memoria compartida

En este tema estudiaremos solcuiones para exclusión mutua y sincronización basadas en el uso de memoria compartida entre los procesos involucrados. Las soluciones pueden ser
- Bajo nivel con espera ocuapda. Basadas en programas que contienen explícitamente instrucciones de bajo nivel para la lectura y escritura directamente a la memoria compartida y bucles para realizar las esperas.

- Alto nivel. Partiendo de las anteriores, se diseña una capa software por encima que ofrece un interfaz a las aplicaciones. La sincronización se consigue bloqueando un proceso cuando deba esperar.

#### Soluciones a bajo nive con espera ocupada

Cuando un proceso debe esperar a que ocurra un evento o sea cierta determinada condición, entra en un bucle indefinido el cual continuamente comprueba si la situación ya se da o no (espera ocupada). Este tipo de solcuoines se pueden dividir en dos categorías:

- Soluciones software. Operaciones sencillas de lectura y escritura de datos simples en la memoria compartida.
- Soluciones hardware (cerrojos). Basadas en la existencia de instrucciones máquina específicas dentro del repertorio de instrucciones de los procesadores involucrados.

Las soluciones de bajo nivel con espera ocupada se prestan a errores, producen algoritmos complicados y tienen un impacto negativo en la eficiencia. En las soluciones de alto nivel se ofrecen interfaces de acceso a estructuras de datos y además se usa bloqueo de procesos en lugar de espera ocupada.

### 2. Semáforos para sincronización

#### 2.1. Introducción

Los semáforos constituyen un mecanismo que soluciona o aminora los problemas de las soluciones de bajo nivel, y tienen un ámbito más amplio:

- No se usa espera ocupada, sino bloqueo de procesos (uso más eficiente de CPU).
- Resuelven fácilmente el problema de exclusión mutua con esquemas de uso sencillos.
- Se pueden usar para resolver problemas de sincronización.
- El mecanismo se implmenta mediante instancias de una estructura de datos a las que se accede únicamente mediante subprogramas específicos. Esto aumenta la seguridad y la simplicidad.

Los semáforos exigen que los procesos en espera no ocupen la CPU, esto implica que:

- Un proceso en ejecución debe poder solicitar quedarse bloqueado.
- Un proceso bloqueado no puede ejecutar instrucciones en la CPU.
- Un proceso en ejecución debe poder solicitar que se desbloquee (se reanude) algún otro proceso bloqueado.
- Deben poder existir simultáneamente varios conjuntos de procesos bloqueados.
- Cada petición de bloque o desbloqueo se debe referir a alguno de estos conjuntos.

Todo esto requiere el uso de servicios externos proporcionados por el sistema operativo o la librería de hebras.

#### 2.2. Estructura de un semáforo

Un semáforo es una instancia de una estructura de datos que contiene los siguientes elementos:

- Un conjunto de procesos bloqueados (de estos procesos decimos que están esperando al semáforo).

- Un valor natural (entero no negativo) al que llamaremos por simplicidad valor del semáforo.

Estas estructuras de datos residen en memoria compartida. Al inicio de un programa que los usa debe poder inicializarse cada semáforo:

- El conjunto de procesos asociados estará vacío.
- Se deberá indicar un valor inicial del semáforo.

#### 2.3. Operaciones sobre los semáforos

Además de la inicializacíon, solo hay dos operaciones básicas que se pueden realizar sobre una variable del tipo semáforo (que llamamos ses):

- sem_wait(s)
  1. Si el valor de s es 0, bloquear el proceso, que será reanudado después en un isntante en el que el valor ya es 1.
  2. Decrementar el valor del semáforo en una unidad.

- sem_signal(s)
  1. Incrementar el valor de s en una unidad.
  2. Si hay procesos esperando en s, reanudar uno de ellos.

Este diseño implica que el valor del semáforo nunca es negativo, ya que antes de decrementar se espera a que sea 1. Además, solo puede haber procesos esperando cuando el valor es 0.

Dado un semáforo s, en un instante de tiempo cualquiera t su valor será el valor iniciar más el número de llamadas sem_signal completadas menos el número de llamadas sem_wait completadas. Este valor nunca es negativo.

#### 2.4. Uso de semáforos. Patrones sencillos

Veremos la solución de tres problemas mediante el uso de semáforos.

##### Espera única

Para introducir una espera, usamos un semáforo cuyo valor es 1 solo cuando x tiene un valor ya escrito pero aun está pendiente de leer. La inicialización es, por tanto, a 0.

##### Exclusión mutua

Los semáforos se pueden usar para EM usando un semaforo inicializado a 1, haciendo wait antes de la sección crítica y signal después.

##### Productor consumidor

La solución es parecida a espera única, pero en un bucle infinito. Se utiliza un nuevo semáforo puede_escribir inicializado a 1.

#### 2.5 Limitaciones de los semáforos

Los semáforos resuelven de una forma eficniente y sencilla el problema de exclusión mutua y problemas sencillos de sincronización, sin embargo:

- los problemas de sincronización más complejos se resuelven de forma más compleja
- al igual que los cerrojos, programas erróneos o malintencionados pueden provocar que haya procesos bloqueados indefinidamente o en estado incorrecto.

En la siguiente sección veremos una solución a más alto nivel sin estas limitaciones.

### 3. Monitores como mecanismos de alto nivel

#### 3.1. Introducción. Definición de monitor

C.A.R. Hoare en 1947 introduce el concepto de monitor. Es un mecanismo de lato nivel que perminte definir objetos abstractos compartidos, que incluyen:

- Una colección de variables encapsuladas (datos) que representan un recurso compartido por varios procesos.

- Un conjunto de procedimientos para manipular el recurso: afectan a las variables encapsuladas.

Ambos conjuntos de elementos perminten al programador invocar los procedimientos de forma que en ellos

- Se garantiza el acceso en exclusión mutua a las variables encapsuladas.
- Se implementa la sincronización requerida por el problema mediante esperas bloqueadas.

Un monitor es un recurso compartido que se usa como un objeto al que se accede conscurrentemente.

- El usuario solo puede acceder al recurso mediante un conjunto de operaciones.
- El usuario ignora la/s variable/s que representan al recurso y la implementación de las operaciones asociadas.
- La exclusión mutua en el acceso a los procedimientos del monitor está garantizada por definición.
- La implementación del monitor garantiza que nunca dos procesos estarán ejecutando simultáneamente algún procedimiento del monitor.

Las propiedades descritas de los monitores los hacen preferibles respecto de los emáforos, dado que el uso de monitores facilita el deseño e implementaciónd de programas libres de errores.

- Las variables están protegidas: solo pueden leerse o modificarse desde el código del monitor.

- La exclusión mutua está garantizada: el programador no tiene que usar mecanismos explícitos de exclusión mutua en el acceso a las variables compartidas.

##### Componentes de un monitor.

- Las variables permanentes son el estado interno del monitor. Sólo pueden ser accedidas dentro del monitor. Permianecen sin modificaciones entre dos llamadas consecutivas a procedimientos del monitor.

- Procedimientos. Modifican el estado interno. Pueden tener variables y parámetros locales, que toman un nuevo valor en cada activación del procedimiento. Algunos constituyen una interfaz externa del monitor y podrán ser llamados por los procesos que comparten el recurso.

- Código de inicialización. Fija el estado interno inicial (opcional). Se ejecuta una única vez, antes de cualquier llamada a procedimientos del monitor.

#### 3.2. Funcionamiento de los monitores

*Comunicación monitor-mundo exterior*: Cuando un proceso necesita operar sobre un recurso compartido controlado por un monitor deberá realizar una llamada a uno de los procedimientos exportados por el monitor usando los parámetros actuales apropiados. Mientras el proceso está ejecutando algún proceidmiento del monitor decimos que el proceso está dentro del monitor.

*Exclusión mutua*: Si un proceso P está dentro de un monitor, cualquier otro proceso Q que llame a un procedimiento de ese monitor deberá esperar hasta que P salga del mismo. Esta política de acceso asegura que las variables permanentes nunca sona ccedidas concurrentemente. El acceso exclusivo entre los procedimientos del monitor debe estar garantizado en la implementación de los monitores.

*Monitores son objetos pasivos*: Después de ejecutarse el código de inicialización, un monitor es un objeto pasivo y el código de sus procedimientos solo se ejecuta cuando estos son invocados por los procesos.

*Instancias de monitores*: En algunos casos es conveniente crear múltiples instancias independientes de un monitor. Cada instancia tiene sur variables permanentes propias. La exclusión mutua ocurre en casa instancia por separado. Esto facilita mucho escribir código reentrante.

##### Cola del monitor para exclusión mutua

El control de la exclusión mutua se basa en la existencia de la cola del monitor:
- Si un proceso está dentro del monitor y otro intenta ejecutar un procedimiento del monitor, este último proceso queda bloqueado y se inserta en la cola del monitor.
- Cuando un proceso abandona el monitor, se desbloquea un proceso de la cola, que ya puede entrar al monitor.
- Si la cola del monitor está vacía, el monitor está libre y el primer proceso que ejecute una llamada a uno de sus procedimientos, entrará en el monitor.
- Para garantizar la vivacidad del sistema, la planificación de la cola debe seguir una plítica FIFO.

#### 3.3. Sincronización de monitores

Para implementar la sincronización, se requiere de una facilidad para que los procesos hagan esperas bloqueadas, hasta que sea cierta determinada condición. Para cada condición distinta que los procesos pueden eventualmente tener que esperar en un monitor, se debe declarar una variable permanente de tipo condition. A esas variables las llamamos señales o variables de condición.

Cada variable de condición tiene asociada una lista o cula inicialmente vacía de procesos en espera hasta que la condición se haga cierta.
Para una cualquiera de estas variables, un proceso puede invocar las operaciones wait y signal (esperar a la condición y señalar que la condición ocurre).

Además, cond.queue() devuelve true si hay algún proceso esperando en la cola de cond, y false en caso contrario.

Dado que los procesos pueden estar dentro del monitor, pero bloqueados:

- Cuando un proceso llama a wait y queda bloqueado, se debe liberar la exclusión mutua del monitor, si no se hiciese, se produciría un interbloqueo con seguridad.
- Cuando un proceso es reactivado después de una espera, adquiere d enuevo la exlusión mutua antes de ejecutar la sentencia siguiente a wait.
- Más d eun proceso podrá estar dentro de monitor, aunque solo uno de ellos estará ejecutándose, el resto estarán bloqueados en variables de condición.

#### 3.5. Colas de condición con prioridad

Por defecto se usan colas de espera FIFO. Sin embargo a veces resulta útil disponer de un mayor control sobre la estrategia de planificación, dando la prioridad del proceso en espera como un parámentro entero de wait. cond.signal() reanudará un proceso que especificó el valor mínimo de prioridad de entre todos los que esperan (si hay más de uno con la prioridad mínima se usa política FIFO). Se deben evitar riesgos de inanición. No tiene ningún efecto sobre la lógica del programa: el funcionamiento es similar con y sin colas de prioridad. Sólo mejoran las caracterísiticas dependientes del tiempo.

#### 3.7. Semántica de las señales de los monitores

Cuando un proceso hace signal en una cola no vacía, se denomina proceso señalador. El proceso que espera en la cola y se reactiva se denomina señalado. Suponemos que hay un código restante del monitor tras el wait y el signal. Inmediatamente después de señalar, no es posible que ambos continuen la ejecución de su código restante, ya que no se cumpliría la exclusión mutua del monitor. Uno de los dos pued einmediatamente ejecutar su código restante, pero entonces el otro no puede hacerlo. Se denomina semántica de señales a la política que establece la forma concreta en que se recuelve el conflicto tras hacerse un signal en una cola no vacía.

- El proceso señalador continúa su ejecución tras el signal. El señalado espera bloqueado hasta que puede adquirir la EM de nuevo (SC: señalar y continuar).

- El proceso señalado se reactiva inmediatamente. El señalador:
  - abandola el monitor tras hacer el signal sin ejevutar el código después de dicho signal (SS: señalar y salir).
  - queda bloqueado a la espera en:
    - la cola del monitor, junto con otros posibles procesos que quieren comenzar a ejecutar código del monitor (SE: señalar y esperar)
    - una cola específica para esto, con mayor priotidad que esos procesos (SU: señalar y espera urgente)

##### Señalar y continuar

El proceso señalado continúa su ejecución dentro del monitor después del signal. El proceso señalado abandola la cola de condición y espera en la cola del monitor para readquierir la EM.

Tanto el señalador como otros procesos peuden hacer falsa la condición después de que el señalado abandone la cola de condición. Por tanto, en el proceso señalado no se puede garantizar que la condición asociada a cond es cierta al terminar el cond.wait(), y por lo que es necesario volver a comprobarla entonces. Esta semántica obliga a programar la operación wait en un bucle.

##### Señalar y salir

El proceso señalador sale del monitor después de ejecutar cond.signal(). Si hay código tras el signal, no se ejecuta. El proceso señalado reanuda inmediatamente la ejecución del código del monitor.

En ese caso, la operación signal conlleva liberar al proceso señalado y terminar el procedimiento del monitor que estaba ejecutando el proceso señalador. Está asegurado el estado que permite al proceso señalado continuar la ejecución del procedimiento del monitor en el que se bloqueó. Esta semántica condiciona el estilo de programación ya que obliga a colocar la operación signal como última instrucción de los procedimientos de monitor que la usen.

##### Señalar y esperar

El proceso señalador se bloquea en la cola del monitor justo después de ejecutar signal. El proceso señalado entra de forma inmediata en el monitor.

Está asegurado el estado que permite al proceso señalado continuar la ejecución del procedimiento del monitor en el que se bloqueó. El proceso señalador entra en la cola de procesos del monitor, por lo que está al mismo nivel que el resto de procesos que compiten por la exclusión mutua del monitor. Puede considerarse una semántica injusta respecto al proceso señalador ya que dicho proceso ya había tenido acceso al monitor por lo que debería tener prioridad sobre el resto de procesos que compiten.

##### Señalar y espera urgente

Es similar a SE, pero se intenta corregir el problema de la falta de equitatividad indicado.

El proceso señalador se bloquea justo después de ejecutar signal. El proceso señalado entra de forma inmediata en el monitor. Está asgurado el estado que perminte al rpoceso señalado continuar la ejecución del procedimiento del monitor en el que se bloqueó. El proceso señalador entra en una nueva cola de procesos que espera para acceder al monitor, que podemos llamar cola de procesos urgentes. Los porcesos de la cola de procesos urgentes tienen preferencia para acceder al monitor frente a los procesos que esperan en la cola del monitor. Es la semántica que se supone en los ejemplos vistos.

##### Análisis comparativo d elas diferentes semánticas

- Potencia expresiva: todas las semánticas son capaces de resolver los mismos problemas.
- Facilidad de uso: La semántica SS condiciona el estilo de programación y puede llevar a aumentar de forma artificial el número de procedimientos.
- Eficiencia
  - Se y SU resultan ineficientes cuando no hay código tras signal, ya que en ese caso implican que el señalador emplea tiempo en desbloquearse y después reactivarse, pero justo a continuación abandona el monitor sin hacer nada.
  - La semánctica SC es un poco ineficiente al obligar a usar un bucle para cada instrucción signal.

