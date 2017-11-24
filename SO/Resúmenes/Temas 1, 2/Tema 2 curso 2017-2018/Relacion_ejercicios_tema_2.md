# Ejercicios de la relación 2 de Sistemas Operativos
> Doble Grado Ingeniería Informática y Matemáticas, Universidad de Granada
> Los ejercicios fueron propuestos por el profesor José Antonio Gómez Hernández, curso 2017/2018

<!--Víctor Castro Serrano, alumno DGIIM, UGR. El autor no se hace responsable de los posibles errores que contenga el documento-->

***1. Si invocamos la función clone() con los argumentos que se muestran a continuación, indicar que tipo de hebra/proceso estamos creando. Justificarlo mostrando como quedarían los descriptores de las tareas. clone(funcion,...,CLONE_VM|CLONE_FILES|CLONE_FS|CLONE_TRHEAD, ...)***

Estamos creando un proceso que comparte el espacio de direcciones, los ficheros abiertos, el directorio de trabajo y el mismo grupo (GID y TID) que el proceso/hebra padre. También se comparte la terminal (*tty_struct*), ya que por defecto, los procesos hijos utilizan la misma terminal que el padre, salvo que se especifique lo contrario.

***2. La llamada al sistema clone() en Linux se utiliza tanto para crear procesos como hilos(hebras). Indicar cómo la utilizaríamos, y dibujar los descriptores de procesos, cuando:***
***a) Un proceso crea otro proceso independiente.***
***b) Un proceso crea un hilo de la misma tarea.***

a) clone(SIGHAND,0)
b) clone(funcion...,CLONE_VM, CLONE_FILES, CLONE_SIGHAND, CLONE_THREAD...)

***3.El algoritmo de planificación CFS (Completely Fair Scheduler) de Linux reparte imparcialmente la CPU entre los procesos de la clase correspondiente. Justificar como es posible que un proceso que realiza muchas entradas-salidas (por tanto, tiene ráfagas de CPU muy cortas) obtenga un trato imparcial respecto de un proceso acotado por computo (pocas entradas-salidas y que consume las ráfagas asignadas completamente). Para el razonamiento, podemos suponer que solo hay un proceso de cada tipo y que la prioridad base de ambos es 120.***

El algoritmo de planificación de tiempo compartido CFS no tiene en cuenta cómo es el proceso en sí, sino la prioridad que tiene. El % de CPU lo calcula como *peso del proceso / suma total del peso de los procesos*. El tiempo de CPU = *(peso del proceso / suma total del peso de los procesos) * latencia de planificación*

Eligirá primero los procesos que tienen un *vruntime* menor, que es el tiempo de ejecución normalizado por el número de procesos en ejecución. En otras palabras, el tiempo que necesita para ejecutarse la próxima vez que entre en el procesador.
*vruntimer = (tiempo de ejecución * 1024) / peso cola*

Así, sabemos que el vruntime de un proceso acotado por E/S es menor, muy bajo, ya que se bloquea al poco de entrar en la PCU ya que necesita esperar a la E/S. El tiempo de ejecución de un programa acotado por cómputo será mayor (agotará la rodaja de tiempo, *slice time*). No obstante, el acotado por E/S entrará y saldrá más veces de la CPU, por lo que en definitiva, ambos estarán el mismo tiempo en CPU (tienen la misma prioridad), tal y como cabe esperar por la primera aclaración de la respuesta.

***4. En un sistema Linux pueden existir procesos que pertenecen a diferentes clases de planificación. Indicar:***
***a) ¿Qué clases son estas y que algoritmo implementan?***
***b) Si en un momento dado, hay en el sistema al menos un proceso que pertenece a cada una de las clases, indicar en que orden se planificarán.***
***c) Si en la clase de tiempo compartido tenemos tres procesos: P1 y P2 con prioridad 120 y P3 con prioridad 110 ¿qué porcentaje de CPU la asignará en planificador a cada uno sabiendo que la prioridad 120 tiene un peso de 1024 y a la prioridad 110 le corresponde un peso de 110?***

a) Dos implementan algoritmos de tiempo real y uno de tiempo compartido, respectivamente son:
*SCHED_FIFO: implementa un algoritmo FIFO. Elige el proceso que más tiempo lleva en la cola.
*SCHED_RR: implementa un algoritmo RoundRobin. Genera una interrupción cada cierto tiempo, donde el proceso actualmente en ejecucuión, aunque pudiera continuar, se bloquea y pasa a la cola de preparado, para que entre el siguiente proceso según FIFO.
*SCHED_NORMAL: manejado por el CFS. Dentro encontramos SCHED_BATCH (cierta iteracción con el usuario) y SCHED_IDLE (nula interacción con el usuario y muy baja prioridad)

b) Tiempo real (FIFO o RR, según prioridad) > Proceso CFS > Proceso IDLE

c) % CPU P1 = (1024 /1024+1024+110) = 0.475 ~ 47.5%
% CPU P2 = (1024 /1024+1024+110) = 0.475 ~ 47.5%
% CPU P3 = (110 /1024+1024+110) = 0.05 ~ 0.05%

***5. Entre los diferentes pasos que sigue el planificador de Linux, función schedule() , está el de seleccionar la siguiente tarea a ejecutar (función pick_next_task() ). A la vista de lo estudiado, esbozar los pasos que debe seguir esta función para seleccionar el proceso teniendo en cuenta que existen tres clases de planificación ( SCHED_FIFO , SCHED_RR y SCHES_NORMAL ) y de las características/propiedades de los procesos dentro de cada clase.***

Primero se ejecutan los de tiempo real que son los que tienen mayor prioridad, de tener dos con la misma prioridad, el que lleve más tiempo esperando.
Los de tiempo real son los SCHED_FIFO Y SCHED_RR que tienen que cumplir un plazo de ejecución (deadline). Después, se ejecutan los procesos CFS, *SCHED_NORMAL*, en los que encontramos los *SCHED_BATCH* que tienen baja prioridad, pero al ser un poco interactivos con el usuario, se ejeuctan antes que los SCHED_IDLE, que son los menos prioritarios y de nula interactividad.

***6. ¿Qué son los Gobernadores (Governors) en un sistema Linux? Indicar cuales son los dos gobernadores de usuario y su función.***

Son políticas de configuración, restricciones, que tienen los sistemas operativos con el fin de ahorrar energía o mejorar el rendimiento, según el tipo de gobernador. Se dividen en gobernadores a nivel kernel y a nivel usuario. Los de nivel usuario son dos, agrupados dentro del gobernador *userspace* del kernel. Son el cpuspeed, que tiene como objetivo maximizar el rendimiento del sistema y el powersave, cuyo objetivo es ahorrar energía.

***7.El planificador a medio plazo de Linux implementa una política apropiativa denominada “apropiatividad mediante puntos de apropiación”.***
***a) ¿En qué consiste y/o cómo se implementa?***
***b) ¿Qué ventajas e inconvenientes presenta respecto a una política totalmente apropiativa?***

a) Consiste en que solo se puede replanificar, es decir, sacar al proceso de la CPU para que entre otro hasta que no se llegue a un punto de apropiación. Estos puntos son secciones del código donde se puede realizar un cambio de contexto seguro, sin conllevar en condiciones de carrera que podría darse en partes críticas del proceso. Cada vez que se llega a un punto de apropiación, se revisa la bandera TIF_NEED_RESCHED que indica si es necesario replanificar, y de serlo, se invoca a schedule() para que entre el otro proceso en la CPU.

Una definición más formal de punto de apropiación: son puntos del flujo de ejecución kernel donde es posible apropiar el proceso sin incurrir a una condición de carrera.

b) Como ventaja, evitamos condiciones de carrera, que existan conflictos entre procesos a causa de haber realizado el cambio de contexto en puntos críticos. Como desventaja tenemos que existe una peor responsividad del sistema, ya que al aumentar la fase de conflicto, se incrementa la latencia de despacho.

***8.En el algoritmo de planificación de la clase CFS siempre se elige como siguiente proceso para ejecución al proceso cuyo vruntime  es menor. Indicar que representa este parámetro y como se calcula.***

Es el tiempo real de ejecución real normalizado por el número de procesos en ejecución.
Se calcula con la siguiente formula: 
`vruntime = tiempo_ejecución_actual * 1024 / (peso rq) = (PesoNice0 / (peso cola)) * tiempo_real `

***9. Justificar por qué el kernel de Linux no es apto para la ejecución de aplicaciones de tiempo real duras, es decir que tienen plazos estrictos de ejecución. Observación, recordad la definición de latencia de apropiación y la implementación que hace de esta el kernel.***

Dado que los kernel linux utilizan en la planificación puntos de apropiación, aumenta la latencia ya que hay que esperar a llegar a un punto de apropiación para planificar. Como consecuencia, ya que las tareas de tiempo real duras no admiten que el tiempo de ejecución se alargue un poco, puede ser que debido a la latencia comentada, los plazos dados por los deadlines no lleguen a cumplirse en algunas ocaciones.

***10.¿Qué mecanismos utiliza el kernel de Linux para gestionar el consumo de energía de los procesadores?***
Los gobernadores

***11.Sobre los grupos de control (cgroups) en Linux:***
***a) ¿Qué utilidades tiene esta construcción?***
***b) ¿Cómo dan soporte a la virtualización?***
***c) Indicar al menos tres subsistemas de grupos de control.***

a) Permiten asignar y restringir los recursos del sistema a un conjunto de procesos, los que están en el mismo grupo, de forma simultánea.
b) Limitan los recursos de la máquina virtual
c) Bklio, cpu, cpuset, memory...
