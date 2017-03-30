# RESUMEN PDOO

  - La **identidad** es la propiedad que permite distinguir a un objeto de los demás.
    - Un objeto tiene identidad en tanto que existe.
    - Las características únicas no constituyen su identidad (p.ej. el DNI es único pero no es su identidad. Dos personas con el mismo DNI son personas distintas.)
    - La identidad puede equivaler a la posición de memoria (si dos objetos tienen la misma posición de memoria entonces son idénticos).
  - El **estado** del objeto lo determinan características que pueden ser consultadas.
    - Dos objetos diferentes pueden tener el mismo estado.
    - El estado de un objeto varía a lo largo del tiempo.
    - El estado puede equivaler a comprobar si los atributos de los objetos son iguales.

  - Un objeto es una instancia de una clase.

  - **Ámbito de los atributos**
      - Atributos de instancia: Almacenan los valores que configuran el estado de un objeto.
        - Cada objeto tiene una copia distinta de cada atributo de instancia, las cuales se almacenan en posiciones de memoria diferentes.
        - JAVA -> no se pone *static*
        - RUBY -> se pone solo un *@variable* y no se "declaran"
      - Atributos de clase: Almacenan un único valor para todos los objetos de una clase.
        - El atributo esta asociado a la clase, de forma que toma un valor único para todos los objetos de la clase y está almacenado en una única posición de memoria.
        - JAVA -> se pone *static*
        - RUBY -> se ponen dos @, es decir, *@@variable*, y se declara explícitamente.

    - **Ámbito de los métodos** - Determinan el comportamiento
      - Métodos de instancia:
        - Métodos asociados a los objetos cuya invocación se realizan mediante envío de mensajes entre objetos.
        - JAVA -> no se pone *static*
        - RUBY -> no se pone *self*.
      - Métodos de clase:
        - Métodos asociados a la clase que se pueden invocar sin necesidad de crear ninguna instancia.
        - JAVA -> se pone *static*
        - RUBY -> se pone *self*.

    - **Constructores**
      - Propósitos:
        - Crear instancias de la clase a la que pertenecen (llamando de manera interna a new)
        - Inicializar la instancia
      - Características comunes:
        - No son métodos de instancia (pero no se pone *static* o *self*. son la excepción)
        - No devuelven nada.
      - RUBY
        - Un único initialize (no es un constructor pero se invoca cada vez que se construye un objeto).
        - Se pueden crear más constructores, en cuyo caso sería con *self.* y dentro de este se haría *new(parámetros)*

    - **Consultores y modificadores**
      - RUBY
        - Se les pone el mismo nombre que el atributo de interés.
        - Se hace automáticamente con *attr_accessor* (get y set), *attr_writter*(set) y *attr_reader*(get). Se colocan después del nombre de la clase.

    - **Agrupaciones**
      - JAVA -> Paquetes
        - Permiten agrupar clases.
        - No se pueden anidar paquetes (solo a nivel de nombrado).
        - *import* permite acceder de forma directa a clases de otro paquete.
      - RUBY -> Módulos
        - Permiten agrupar clases, métodos, variables y trozos de código.
        - Pueden agrupar a otros módulos.
        - Para indicar el path del fichero necesitamos *require* o *require_relative* si el fichero está en la carpeta actual.
        - *include* permite incorporar un módulo dentro de una clase (copia todo el código).

    - **Especificadores de acceso**
      - JAVA
        - Visible en :
          - mismo paquete
            - clase
              - private
              - package
              - protected
              - public
            - otra
              - package
              - protected
              - public
          - otro paquete
            - otra
              - public
        - Por defecto es de paquete.
      - RUBY
        - Visible en :
          - propio objeto:
            - private
            - protected
            - public
          - clase
            - protected
            - public
          - otra
            - public
        - La visibilidad de los atributos de instancia y de clase es privada.
        - Las constantes son públicas y no pueden cambiarse.
        - Por defecto los métodos son públicos.
        - La visibilidad se especifica:
          - Antes de los métodos afectados.
          - Una vez ya definidos mediante *private :metodo1, :metodo2*

    - **Colecciones de objetos**
      - Cuando un objeto contiene otros objetos se dice que ese objeto es una colección de objetos.
      - Tamaño: fijas o variables
      - Contenido: homogéneas o heterogéneas.
      - Orden de elementos: sin relación de orden o con orden.

      - Fijas y homogéneas -> Eficientes
      - Variables y heterogéneas -> Flexibles

    - **Pseudovariables**
      - En todos los lenguajes existen pseudovariables que referencian a un objeto especial: el objeto que tiene el control de la ejecución en ese momento.
      - JAVA -> this, super
      - RUBY -> self, super

## RESUMEN UML

- **Clases**

	Nombre ^ [multiplicidad]

	[visibilidad] nombre_atributo [:tipo[multiplicidad]][=valorinicial]

	[visibilidad] nombre_metodo ([lista parámetros])[:tipo retorno]


- **Multiplicidad de clase** -> nº de instancias que puede tener una clase


- **Multiplicidad de atributo** -> nº de elementos en dicho atributo


- **Relaciones** (flechas)

	- De dependencia (flecha discontinua): el receptor depende del emisor, esta dependencia es poco duradera

	- De asociación (línea continua sin flechas): ambas clases tienen una relación o dependencia duradera


- **Visibilidad**

	\+ -> pública

	\- -> privada

	\~ -> paquete

	\# -> protegida


- **Elementos de las asociaciones**:

	- Nombre de la asociación (se coloca encima de la línea). Se puede indicar hacia donde se lee empleando (> negra).

	- Rol (se coloca al comienzo de la línea): Se emplea para explicitar el papel que juega cada clase en la asociación.

	- Navegabilidad (sentido de la flecha si es unidireccional, si es bidireccional sin punta en ningún extremo)
		- Clase A -> Clase B (La clase A tiene un atributo b de tipo B)

	- Multiplicidad (se coloca al comienzo de la línea): Indica el número de objetos de una clase que pueden asociarse con UN objeto de la otra clase.
		- Sintaxis -> valorMínimo..valorMáximo, se puede usar *
		- Si no se indica nada, por defecto es 1.

	NO CONFUNDIR DIRECCIÓN DE LECTURA DEL NOMBRE DE LA ASOCIACIÓN CON LA NAVEGABILIDAD.


- **Asociaciones especiales**

	- Agregación (rombo blanco situado al comienzo de la línea).
		- Clase A (rombo blanco cerca de A) Clase B <-> La clase B es parte de la clase A pero no necesariamente.

	- Composición (rombo negro situado al comienzo de la línea).
		- Clase A (rombo negro cerca de A) Clase B <-> La clase B es parte necesaria de la clase A.


- **Clase asociación**:

	- Cualificadores de la asociación: un cualificador es un atributo de algunas de las clases de la asociación que pasa a ser un atributo asociado a la clase del otro extremo.
		- Clase A (cualificador cerca de A) Clase B <-> Clase A contiene un atributo llamado cualificador de tipo Clase B.
