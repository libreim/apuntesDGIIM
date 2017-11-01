# FUNDAMENTOS DE BASE DE DATOS

## Tema 1. Introducción y definiciones iniciales
### 1. Concepto intuitivo de base de datos
Concepto: fondo comúyn de información almacenada en una computadora para que cualquier persona o programa autorizado peuda acceeder a ella, independientemente del lugar de procedencia y del uso que se haga. Operaciones: pedir, modificar, insertar, borrar.

### 2. Bases de datos y sistemas gestores de bases de datos

Base de datos: conjunto de datos comunes a un proyecto al manenados sin redundancia para ser útiles a diferentes aplicaciones.

Sistemas gestor de base de datos: conjunto de elementos software con capacidada para definir, mantener y utilizar una base de datos. Un sistema gestor de bases de datos debe permitir definir estructuras de almacenamiento, acceder a datos de forma eficiente y segura, organizar la actualización multiusuario...

Elementos de una base de datos:
- Datos: integrados (sin redundancia) y compartidos (útiles a varias aplicaciones).
- Software: programas para definir las estructuras y gestionar los datos de la base de datos.
- Usuarios: usuario final, programardor de aplicaciones, administrador.

Dato operativo: pieza de información que necesita una organización para su funcionamiento.
- Item básico: Elemento acerca del que se puede pedir información.
- Atributo: Características de los items básicos.
- Relaciones: Conexiones lógicas entre ítems.

Cuando se determinan y clasifican de esta forma todos los datos operativos, se obtiene el esquema lógico de la base de datos.

### 3. Concepto de independencia

Los datos se origanizan independientemente de las aplicaciones que los vayan a usar y de los ficheros en los que vayan a almacenarse.

Independencia física. El diseño lógico de la BD, a todos los niveles, debe ser independiente del almacenamiento físico de los datos. Esto permite realizar libremente cambios en la estructura física y descargar a las aplicaciones de problemas físicos.

Independencia lógica. Existen dos tipos de estructura lógica: esquema lógico general y vistas de usuario. Cada aplicación debe poder organizar los datos según sus propios esquemas y acceder a los datos que le son necesarios.
- Aumento de la seguridad y fiabilidad
- Menos problemas para las aplicaciones
- Posibilidad de cambios en los esquemas por parte de las aplicaiones y por parte de los administradores.

### 4. Objetivos de un sistema gestor de bases de datos

- Indencia de datos.
- Diseño y utilización orientada al usuario: los datos y aplicaciones deben ser accesibles a los usuarios de la manera más amigable posible. Para ello se debe soportar un modelo de datos teórico, facilidades de definición y un lenguaje de acceso y modificación.
. Centralización: los datos deben gestionarse de forma centralizada e independiente de las palicaciones.
- Para el administrador de la base de datos, utilizades de gestión.
- No redundancia. Los datos no deben estar duplicados. Gestión de accesos concurrentes.
- Consistencia. Los datos deben ser consistentes, sin fallos lógicos. Mecanismos de mantenimiento de integridad.
- Fiabilidad. Los datos deben estar protegidos contra fallos catastróficos. Mecanismos de mantenimiento de recuperación y relanzamiento de transacciones.
- Seguridad. No todos los datos deben ser accesibles a todos los usuarios. Mecanismos de gestión de usuarios y privilegios, mecanismos de protección de información.

### 5. Ventajas de utilizar un SGBD

Para el usuario:
- Usuario final: puede acceder a los datos.
- Programador de aplicaciones: eliminar problemas de diseño lógico y físico, depuración de errores y mantinimiento general.
- No es necesario un administrador de la base de datos.
- Para el sistema: control centralizado, creiterios de uniformación, generación de nuevas aplicaciones, equilibrio entre requerimientos conflictivos.

## Tema 2. Arquitectura de un sistema gestor de bases de datos

### 1. Una arquitectura con tres niveles

¿Por qué organizar en niveles? Los usuarios pueden acceder a los mismos datos desde distintas perspectivas. Si un usuario cambia la forma de ver lso datos no influye al resto. La organización global de los datos puede cambiarse sin afectar a los usuarios. Los usuarios no tienen por qué gestionar aspectos relativos a la representación física de los datos. El administrador de la base de datos puede cambiar la forma de representar los datos sin influir en los usuarios.

La precepción de los datos en un SGBD puede hacerse siguiendo tres niveles de abstracción:
- Nivel interno
- Nivel conceptual
- Nivel externo

Nivel interno: constituye la representación de la BD más cercana a la estructura de almacenamiento físico. Por tanto, es la capa donde se establece la forma en que se implantan las estructuras de datos que organizan los niveles superiores.

Nivel conceptual. Aupone una abstracción global de la BD que integra y aglutina todas las percepciones que los usuarios tienen de ella.

Nivel externo. A este nivel se definen todas las percepciones particulares de la BD por parte de los usuarios. Cada usuario puede tener su propia visión de la BD.

### 2. Correspondencia entre niveles

Transformación o correspondencia entre niveles: conjunto de normas que establece cómo se definen los datos de un nivel en términos de otro. Mecanimo fundamental para el establecimiento de la independencia física y lógica.

#### Transformación conceptual/interna
Cómo se organizan las entidades lógicas del nivel conceptual en términos de registros y campos almacenados en el nivel interno. Independencia física:
- Varía el nivel interno
- Cambia la Correspondencia
- No varía el nivel conceptual

#### Transformación externa/conceptual
Describe un esquema externo en términos del esquema conceptual subyacente.
Independencia lógica:
- Varía el nivel conceptual
- Cambia la Correspondencia
- No varía el nivel externo
Esta transformación no siempre es posible

#### Transformación externa/externa
Algunos SGBD permitin describir esquemas externos en términos de otros esquemas externos.
Independencia lógica:
- Varía el esquema externo subyacente
- Cambia la Correspondencia
- No varía el esquema definido

### 3. Lenguajes de una BD

Recomendación ANSI/SPARC:

Disponer de un lenguaje específico orientado a los datos (definición, control, manipulación). Sublegunaje de datos (DSL) implementado en el propio SGBD. Tiene distintas partes:
- DDL: Data Definition Language. Sublenguaje de definición de datos. Subconjunto del DSL destinado a la definición de estructuras de datos y esquemas en la BD.
- DML: Data Manipulation Lanquage. Sublenguage de manipulación de datos. Subconjunto del DSL mediante el que podemos introducir datos en los esquemas, modificarlos, eliminarlos y consultarlos. Tabmién debe permitir consultar la estructura de los esquemas definidos en la BD.
- DCL: Sublenguaje de control de datos, que permite gestionar los requisitos de acceso a los datos y otras tareas administratibas sobre la BD.

En la práctica todos estos sublenguajes se presentan bajo una implementación única. Cada sentencia trabaja sobre uno o varios niveles. Un sistema de privilegios discrimina quién puede ejecutar qué.

### 4. Arquitectura de un SBD

El concepto de SBD ha evolucionado paralelamente al desarrollo del informática en la forma de gestionar la información, de ejecutar los programas y de interactuar con el usuario.

Ininialmente se utilizaba un sistema centralizado donde toda la carga de gestión y procesamiento de información recaía en servidores centrales. El usuario accedía mediante terminales. En el ordenador principal se entraba pues alojado el SGBD y los programas de aplicación. El principal problema de este sistema es el elevado coste de los ordenadores principales.

Con la aparición del PC, se desplaza la ejecución de los programas de usuario y las interacciones a estos dispositivos. Primera aproximación cliente servidor. El servidor alojaba la base de datos y un servicio de escucha de peticiones, mientras que el cliente, los PCs conectados al servidor, tenían los programas de aplicación y el servicio de enlace cliente que interactúa con el servicio de escucha del serviodor. Con el desarrollo de las comunicaciones este enfoque deriva en un enfoque distribuido. El principal problema coste del mantenimiento de los PCs, que se soluciona separando en plas aplicaciones la parte que interactúa con el usuario de la parte de ejecución lógica del programa.

Actualmente se utiliza una arquitectura articulada entre niveles de procesamiento.

- Nivel de servidor de datos. Posiblemente distribuido. El SGBD permite organizar la información de la mepresa como una BD global. Las peticiones de datos formuladas desde una sede se traducen de forma transparente a peticiones en las sedes donde se encuentran esos dadtos.
- Nivel de servidor de palicaciones.
- Nivel de cliente. PCs ligeros dotados de configuraciones basadas en estándares abiertos. Vasados en el carácter portable con que se distribuyen las aplicaciones desde los servidores de aplicaciones. Menos dependencia del hardware y SO a la hora de abordar la ejecución de las aplicaciones.

Ventajas: Reducción significativa en cuanto al mantenimiento de los clientes. Mayor facilidad y flexibilidad para el usuario.

Inconvenientes: Mayor complejidad en la configuración y administración de los servidores de aplicaciones. El desarrollo de las aplicaciones conforme a este modelo distribuido es más costoso.

### 4. El administrador de la BD

El DBA es una figura de primordial relevancia en el contexto de los SGBD. Algunas de sus funciones son:
- Elaboración del esquema conceptual. Análisis de las necesidades de información de la empresa, identificaión de los datos operativos, elaboración del esquema lógico, implantación del esquema conceptual.
- Decidir la estructura del almacenamiento en nivel interno. Esquema interno. Corrspondencia conceptual/interna asociada.
- Conexión con usuarios. Análsis de requerimientos, diseño lógico, codificación del esquema externo, conrrespondecias externo/conceptual.
- Definir restricciones de integridad. Si es posible, incluir integridad en el esquema conceptual.
- Definir e implantar política de seguridad. Gestión de usuarios, gestión de privilegios.
- Definir e implantar la estrategia de recuperación frente a fallos.
- Optimización del rendimiento. Liberar espacio no utilizado, reorganizar las operaciones para que se ejecuten de forma más rápida, determinar la necesidad de nuevos recursos hardware, establecer prioridades en el uso de los recursos.
- Monitorizar el SGBD. Seguimiento continuo de la actividad del sistema. Auditar el acceso a los usuarios a los diversos recursos de la BD. Comprobar los niveles de uso de los sistemas de almacenamiento. Evaluar la eficiencia con que se realizan las operaciones.

## Tema 3. Modelos de datos

### 1. Cocepto de modelo de datos

Modelo de datos es el mecanismo formal para representar y manipular información de manera general y sistemática. Debe costar de:
1. Notación para describir datos.
2. Notación para describir opetaciones
3. Notación para describir reglas de integridad

Objetico: describir modelos que representen los datos y los describan de una forma entendible y manipulable. En relación a la arquitectura ANSI/SPARC:
- Nivel externo: modelo de datos externo
- Nivel conceptua: modelo de datos conceptual
- Nivel interno: modelo de datos interno

Clasificación:
- Basados en registros
- Basados en objetos
- Físicos

Utilización:
- Registros y físicos: nivel externo y conceptual
- Físimos: nivel interno.

### 2. Modelos de datos basados en registros

#### Modelo jerárquico
Fue el primero en implementarsi físicamente. Carecía de lenguaje de consulta. La estructura de datos básica es el árbol. La base de datos es una colección instanciada de árboles. Esta estructura plasma de forma muy directa relaciones muchos a uno y relaciones uno a uno, pero necesita duplicar información para las relaciones muchos a muchos.

Inconvenientes:
- Almacenar árboles en un fichero es complejo. Varios tipos de registros y punteros que hay que mantener.
- DML difícil de implementar y usar.
- Dependencia existenciar obligatorioa de los registros de tipo decuandrio con respecto a los de tipo raíz.
- Redundacia necesaria para plasmar relaciones muchos a muchos.

#### Modelo en red
La estructura de datos consiste en grafos cuya topología depende d elas conexiones existentes entre las entedades:
- Nodos: registros
- Arcos: enlaces entre registros (punteros)
- Relaciones entre conjuntos de entidades: coenctores (registros especiales). Cada ocurrencia de un conector representa una asociación distinta.

La base de datos es una colección de isntancias de grafos. La estructura es muy genérica. Permite plasmar todo tipo de relaciones e implementar directamente las relaciones muchos a muchos.

Ventajas:
- Estructura más homogénea.
- Permite insertar nuevas entidades en un conjunto de forma independiente.

Problemas:
- La existencia de enlaces entre los registros hace que las operaciones DDL y el DML sigan siendo compleajes de implementar y utilizar.

#### Modelo relacional
El modelo de datos relacional organiza y representa los datos en forma de tablas o relaciones. Una base de datos relacional es una colección de tablas cad auna de las cuales tiene un nombre único.

**Definiciones**:

Esquema de una base de datos relacional: colección de esquemas de relaciones junto con restricciones de integridad.

Instancia o estado de una base de datos: colección de isntancias de relaciones que verifican las restricciones de integridad.

Base de datos relacional: instancia de una base de datos junto con su esquema.

**Claves**:

- **Superclave**: cualquier conjunto de atributos que identifica unívocamente a cada tupla de la relación.

- **Clave candidata**: superclave minimal.

- De entre las candidatas (si hubiera más de una) hay que elegir una como principal que se denomina **clave primaria**.

Pra describir una relación, se subrayan los atributos que forman su clave primaria.

## Tema 4. El modelo de datos relacional

### 1. La estructura de datos relacional

Introducido por E. F. Codd en 1970. El modelo de datos relacional abarca tres ámbitos distintos:
- Las estructuras para almacenarolos. El usario recibe la información de la base de datos estructurada en tablas.
- La ingegridad: las tablas deben satisfacer ciertas condiciones que preservan la integridad y la coherencia de la información que contienen.
- Consulta y manipulación: los operadores empleados por el modelo se aplican sobre tablas y devuelven tablas.

La tabla es la estructura lógica de un sistema relacional. A nivel físico, el sistema es libre de almacenar los datos en el formato más adecuado(archivo secuencial, archivo indexado, lista con apuntadores...).

Atributo: cualqueir elemento de ifnormación susceptible de tomar valores
Dominio: rando de valores donde toma sus datos un atributo.
Relación: dados los atributos A_i, i = 1, 2, ..., n, con dominios Di, i = 1, 2, ..., n no necesariamiente distintos, definimos la relación asociada a A_1, ..., A_n, y lo notaremos como R(A_1, ..., A_n) a cualquier subconjunto de productos cartesianos D_1 x ... x D_n.

Tupla: cada una de las filas de la relación.
Cardiladidad de una relación: número de tuplas que contiene. Es variable en el tiempo.
Grado de una relación: número de atributos de su esquema. Invariable en el tiempo.
Esquema de una relación R: Atributos A1: D1,..., A:Dn
Instancia de una relación: conjunto de tublas que la componene cada momento.

Propiedades:
Condición de normalización. Todos los valores de los atributos de una relación son atómicos. Valor atómico es un valor no estructurado. Cuando una relación cumple la primera condición de normalización se dice que está en Primera Forma Normal. Consecuencias: no hay valores tipo conjunto, tipo registro o tipo tabla. Problema: todas las representaciones son extensivas. Consecuencias de la definición: no hay tuplas duplicadas, no hay orden en las filas ni en los atributos, varias instancias representan la misma relación.

Esquema de una base de datos relacional: colección de esquemas de relaciones junto con restricciones de integridad.

Instancia o estado de una base de datos: colección de instancias de relaciones que verifican las restricciones de integridad.

Base de datos relacional: instancia de una base de datos junto con su esquema.

Algunas veces no se conoce el valor de un atributo de determinada tupla. En esos casos a ese atributo de esa tupla se le asigna un valor nulo. Un valor nulo puede ser un valor descnonocido o un atributo no aplicable. En cualquier caso, ese valor es un valro más de todos los dominios de la base de datos.

### 2. Restricciones de integridad

En una relación puede haber más de un conjunto de atributos que puedan ser elegidos como clave. Estos conjuntos se llaman claves candidatas. Una clave candidatas es un atribujo o conjunto de atributos que identifican a cada tupla en la relación y que, además, no existe un subconjunto de ellos que también identifiquen a la tupla en la relación. Una clave primaria es una clave primaria elegida por el diseñador. Si se verifica la unividad pero no la minimalidad se denomina superclave.

Condiciones de integridad: normas que mantienen la correción semántica d euna base de datos. Son metarreglas (generan reglas de integridad aplicadas a una base de datos concreta). Existen la integridad de entidad y la referencial.

Integridad de entidad: no se debe permitir que una entidad sea representada en la base de datos si no se tienen uan información completa de los atributos que son claves de la entidad. Clave primaria o parte de ella no puede ser valor nulo.

Clave exterana: un conjunto de atributos en una relación que es una clave en otra (o en otra) relación. Podemos ver una clave externa ocmo un conunto de atributos de una relación cuyos valores en las tuplas deben coincidir con los valores de la clave primaria de las tuplas de otra relación. Si PK es la clave primaria de R y FK la clave externa de S con respecto a R verifica que el dominio activo de FK debe estar incluido en el dominio activo de PC para cualquier instancia de la base de datos.

Integridad referencial: una base de datos en la que todos los valores no nulos de una clave externa referencian valores reales de la clave referenciada en la otra relación cumple la regla de integridad referencial. Si una relación incluye una clave externa conectada a una clave primaria, el valor de la clave externa debe ser, bien igual a un valor ya existente en el dominio activo de la clave primaria o bien completamente nulo (si la semántica lo permite). L aintegridad referencial mantiene las conexiones entre las bases de datos relacionales. Puede haber más de una clave externa en una relación, y más de una clave externa a la clave primaria de la propia relación.

El SGBD debe encargarse de mantener las siguientes restricciones:

- La unividad de la clave primaria y las claves candidatas.
- La restricción de integridad de identidad.
- La integridad referencial:
  - En inserción: rechazar tublas insertadas si el calor de la clave externa no concuerda en la relación referenciada para alguna tupla en el valor de su clave primaria. Si el valor para la clave externa es nulo y el diseño no lo permite habrá que rechazar también esa inserción.
  - En actualización: si se actualiza la clave externa, rechazar la modificación si se porducen alguna de las circunstancias descritas en el punto anterios. Si se actualiza la clave primaria de la relación referenciada se deben acutalizar en cadena las claves externas que la referencian.
  - En borrado: si se borran la clave primara de la relación referenciada, se debe borrar en cadena todas las tuplas que la referencian o poner valur nulo en la clave externa de todas esas tuplas.
