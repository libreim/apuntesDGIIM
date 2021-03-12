\section{Conceptos básicos}

\subsection{Definiciones de conceptos}

En esta primera sección del temario se introducirán conceptos relacionados con la programación orientada  a objetos, al igual que sus definiciones y explicaciones. Los conceptos a tener en cuenta son los siguientes:

\begin{itemize}
\item \textbf{Objeto:} entidad perfectamente delimitada, queencapsula estado y funcionamiento y posee una identidad. Otra definición sería: elemento, unidad o entidad individual e identificable, real o abstracta, con un papel bien definido en el dominio del problema.

\item \textbf{Clase:} la clase, entre otras cosas, actúa de molde o plantilla para la creación de objetos y crea un tipo de dato. En algunos lenguajes las clases son también objetos a todos los efectos. Los objetos creados a partir de una clase se denominan \textbf{instancias} de esa clase.

\item \textbf{Identidad:} la identidad la define la posición de memoria. Independientemente de su estado, objetos distintos residirán en zonas de memoria distintas. Cada instancia tiene su propia identidad.

\item \textbf{Estado y Comportamiento:} el \textbf{estado} de un objeto vendrá definido por los valores de sus atributos. Cada objeto tiene unazona de memoria propia para el almacenamiento de sus atributos. Los objetos exhiben textbf{comportamiento}. Disponen de una serie de métodos (funciones o procedimientos) que pueden ser llamados/invocados.

\item \textbf{Paradigma:} teoría o conjunto de teorías cuyo núcleo central se acepta sin cuestionar y que suministra la base y modelo para resolver problemas y avanzar en el conocimiento.

\item \textbf{Paradigma de programación:} conjunto de reglas que indican como desarrollar software.

\item \textbf{Base de la orientación a objetos:} se unen los datos y el procesamiento en entidades denominadas objetos.

\end{itemize}

En la \textbf{Programación Orientada a Objetos (POO)}, los objetos son las entidades que se manejan en el software. \textbf{Programar} consiste en modelar el problema mediante un universo dinámico de objetos. Cada objeto pertenece a una clase y tiene una responsabilidad en la aplicación. El \textbf{funcionamiento del programa} se consigue mediante el envío de mensajes a otros objetos para que realicen la ejecución de métodos. El objetivo es obtener \textbf{alta cohesión} y \textbf{bajo acoplamiento}.

\bigskip

El diseño de objetos no es una tarea sencilla, pero siempre se trata de que las clases cumplan las siguientes propiedades:

\begin{itemize}

\item Deben tener una \textbf{responsabilidad muy concreta}.

\item Deben ser, en cierta medida, \textbf{autónomas}, es decir, tener poca dependencia de otras clases.

\item Deben ser \textbf{introvertidas y no altruistas}, es decir, su estado solo puede modificarse desde la misma clase y no debe realizar funciones que ya estén implementadas aparte.

\end{itemize}

\subsection{Atributos y Métodos}

\subsubsection{Atributos y Métodos de Instancia}

Los \textbf{atributos de instancia} son variables que están asociadas acada objeto. Cada instancia tiene su propio espacio de atributos de instancia, teniendo así los mismos atributos que cualquier otra instancia de la clase pero en zonas de memoria distintas. El \textbf{estado} de cada instancia es descrito por los valores de estos atributos.

De la misma forma, los \textbf{métodos de instancia} son funciones definidos en una clase y que estarán asociados a los objetos de dicha clase. Estos métodos pueden acceder a los atributos de instancia de ese mismo objeto.

EJEMPLO:

\subsubsection{Atributos y Métodos de Clase}

Los \textbf{atributos de clase} almacenan información asociada \textbf{a la propia clase}, no a cada instancia y por tanto, son globales a todas las instancias de la clase. Estos deberán usarse cuando haya información que sea común a todas las instancias de la clase, como lo pueden ser un contador de instancias o constantes.

\begin{nota}

Para cualquier número que se vaya a utilizar (exceptuando 0, 1 o -1 para índices, inicializar una variable vacía o casos similares), es muy recomendable declararlo como constante, pues no sabemos cuando podrán volver a necesitarse en un futuro y mejora la legibilidad del código.

\end{nota}

Los \textbf{métodos de clase}, al igual que los atributos de clase, son funciones y procedimientos asociados a la propia clase.  Estos métodos pueden acceder y modificar los atributos de clase.

EJEMPLOS Y RUBY/JAVA

\subsubsection{Pseudovariables}

Las \textbf{pseudovariables} son palabras reservadas que referencian al propio objeto o a la propia clase. Las más comunes en la mayoría de los lenguajes son \textbf{this} (Java, C++, C#...) y \textbf{self} (Ruby, Python, Rust...).

EJEMPLO

\subsubsection{Especificadores de acceso (Visibilidad)}

A pesar de que en este aspecto hay diferencias notables entre distintos lenguajes, podemos distinguir distintos niveles de acceso a atributos y métodos.

En general son:
\begin{itemize}
\item \textbf{Privado:} no se puede acceder desde otras instancias o clases.
\item \textbf{Público:} no tiene ningún tipo de restricción de acceso.
\item \textbf{Paquete:} no tiene restricciones en un mismo paquete.
\end{itemize}

En concreto en Java, se puede acceder a elementos privados desde una instancia a otra de la misma clase, desde el ámbito de clase a una instancia de la clase y desde el ámbito de instancia a la clase de la que se es instancia. Sin embargo, en Ruby ninguna de estas acciones están permitidas y los atributos son siempre privados.

A la hora de elegir el tipo de visibilidad a utilizar, siempre deberemos usar \textbf{la más restrictiva} según su necesidad; los \textbf{atributos} deberán ser \textbf{privados}, se accederán a ellos con un \textbf{consultor (getter) con visibilidad de paquete o público} y los que se modifiquen desde fuera de la clase se deberá crear un \textbf{modificador (setter)}; los \textbf{atributos de objetos} sólo se podrán \textbf{modificar por métodos del propio objeto} y sólo \textbf{se crearán los consultores y modificadores necesarios.}

\subsection{Construcción de Objetos}

Los lenguajes orientados a objetos suelen disponer de unos métodos especiales denominados **constructores**. Estos métodos solo se encargan de la **inicialización de las instancias**. Se deben inicializar **todos los atributos** de instancia. No son métodos de instancia y no especifican ningún tipo de retorno. Existen diferencias importantes a este respecto en los distintos lenguajes de programación orientados a objetos.

\subsubsection{Clases-plantilla / Clases-objeto}

[ENTENDER QUE SON]Clases-plantilla I En muchos casos tienen el mismo nombre de la clase. Son invocados automáticamente utilizando la palabra reservada new. Clases-objeto I Pueden tener un nombre arbitrario. Suelen ser métodos de clase.

En **Java**, el constructor tiene el mismo nombre que la clase y no devuelve ningún valor; se usa para inicializar los atributos; se pueden sobrecargar y reutilizar un constructor desde otro; podemos construir un objeto con ***new*** *NombreClase* y si no se crea uno, Java tiene un constructor por defecto sin parámetros.

En **Ruby**, el equivalente al constructor es el método ***initialize***, el cual es un método de instancia privado que es llamado por el método de clase ***new***. Crea e inicializa los atributos de instancia, y aunque cualquier método de instancia pueda crearlos, es recomendable hacerlo solo en el constructor. **No se pueden sobrecargar**, si se declaran varios solo se tendrá en cuenta el último declarado. La única forma de crear varios constructores es crear métodos de clase que actúen como *new* o haciendo que initialize admita un número variable de argumentos (se hace poniendo **nombreArgumento*).

EJEMPLOS

\subsubsection{Memoria Dinámica y Pila}

En Java y Ruby todos los objetos se crean en **memoria dinámica** (heap). En ambos, **las variables referencian a objetos** (es decir, son punteros), excepto los tipos primitivos de Java (int ,float, double...) y los strings, por lo que es algo a tener en cuenta. Si no queremos que sea modificable, una solución es devolver una copia del valor referenciado. La memoria se libera automáticamente, gracias al recolector de basura que libera automáticamente la memoria de los objetos no referenciados.

\section{Clases, objetos y mensajes}

\section{Reutilización y polimorfismo}

\subsection{Mecanismos de reutilización}

En la programación orientada a objetos existen diferentes mecanismos de reutilización de código, \textit{herencia}, \textit{interfaces} y \textit{clases parametrizables}.

\subsubsection{}

\subsubsection{Definición y propiedades de la herencia}

La herencia es un mecanismo que permite derivar nuevas clases (subclases o clases hija) a partir de clases existentes (superclase o clase padre).

Las clases padre e hija comparten un código común que es definido en la clase padre y que hereda la clase hija. Se reutiliza el código definido en la clase padre. Podemos hablar de reutilización  de código cuando la clase hija hereda el comportamiento de la clase padre pero no modifica la forma de llevarlo a cabo. Hablamos de reutilización de concepto cuando la clase hija hereda el comportamiento de la clase padre y modifica la forma de llevarlo a cabo.

La clase hija es a la vez una extensión de la clase padre, desde el punto de vista de la clase como un módulo, y una especialización o restricción de la clase padre.

Una forma de saber si es conveniente utilizar herencia en cierto caso es mediante el \textit{test de especialización}. Supongamos que tenemos una clase A padre y una clase B que pretendemos que sea hija de A. Si podemos decir que "B es un A" entonces podemos establecer una relación de herencia entre A y B.

\subsubsection{}

\subsubsection{}

\subsubsection{}

\subsubsection{}

\subsubsection{}

\subsubsection{}

\subsubsection{}

\subsubsection{}

\subsubsection{El concepto de Interfaz: Java}

FIXME: Qué es una Interfaz

Los métodos pueden implementarse en las interfaces. Se hace con dos métodos
diferentes: \texttt{default} y \texttt{static}.

Los métodos \texttt{static} son código \textit{estático} en la clase que no se
redefine.

En Java las interfaces se utilizan para simular \textit{herencia múltiple}.

\begin{lstlisting}[language=Java]
  interface A {
    default void met1() {
      System.out.println("A");
    }
  }

  interface B {
    default void met1() {
      System.out.println("B");
    }
  }

  class Prueba implements A,B {

    // Tenemos que redefinir el método porque está
    // implementado en las dos interfaces.
    @Override
    void met(1) {
      B.super.met1();
    }

  }

  public class Interaces {

    public static void main(String[] args) {
    
      B b = new Prueba();
      b.met1();
    
    }

  }
\end{lstlisting}

Produce la salida:

\begin{lstlisting}[language=bash, style=terminal]
  run:
  B
\end{lstlisting}

\subsubsection{Simulando herencia múltiple}

En Java

En Java se presenta un conflicto de nombres con los métodos default cuando una
clase implementa varias interfaces o cuando una interfaz hereda de varias
interfaces con miembros del mismo nombre. Para evitarlo podemos o bien
proporcionar una nueva implementación, elegir una de las implementaciones que
hay o crear un método abstracto.

En Ruby

Para simular herencia múltiple en Ruby hay una forma posible llamada comúnmente
\textit{mixin} que consiste en heredar de una clase \texttt{e} e incluir un
módulo dentro de la clase.

\subsubsection{Clases parametrizables}


Una clase parametrizable presenta un alto grado de reutilización, pero tiene
limitaciones. Encapsulan operaciones válidas para varios tipos de datos,
generalizando los tipos y sus operaciones.

Su uso  más frecuente es cuando sus atributos están formados por varios objetos
del mismo tipo, siendo este un parámetro que tomará valor uando usemos la clase
parametrizable. En Ruby no existe este concepto.

\begin{lstlisting}[language=Java] 
public class Tienda<T> {

    String nombre;
    ArrayList<T> stock;
    float ganancias;
    
    Tienda (String n) {
    
      nombre=n;
      stock = new ArrayList();
      ganancia=0;
    }
    
    public void comprarAProveedr(T objeto, float precioCoste) {
    
      stock.add(objeto);
      ganancias = ganancias-precioCoste;
    
    }
    
    public void venderACliente(T objeto, float pvp) {
    
      stock.remove(objeto);
      ganancias=ganancias+pvp;
    
    }
    
    public float getGanancias() {
      return ganancias
    }

  }

\end{lstlisting}

\section{Polimorfismo}
\subsection{Definición de polimorfismo}
Se define como la capacidad de una entidad (indentificador) de referenciar a objetos de diferentes clases (tipo) durante la ejecución de un programa.

\subsection{Tipo estático y dinámico}
\begin{itemize}
\item \textbf{Tipo estático:} Tipo(clase) del que se declara la variable, no cambia durante la ejecución.
\item \textbf{Tipo dinámico:} Clase a la que pertenece el objeto al que va referenciando una variable a lo largo de la ejecución Puede cambiar durante la ejecución.
\end{itemize}

Java es un lenguaje con tipo estático y dinámico. Dado que Ruby no es un lenguaje fuertemente tipado, no tiene sentido hablar de tipo estático, todos los tipos son dinámicos.
Un ejemplo es el siguiente. Supongamos que tenemos una clase Persona y una clase Alumno, la cual hereda de persona.
\begin{lstlisting}[language=Java]
Persona p = new Persona();
\end{lstlisting}

El tipo estático de \textit{p} es Persona, su tipo dinámico es Persona. No obstante, como Alumno hereda de Persona, podemos cambiar su tipo dinámico a Alumno:
\begin{lstlisting}[language=Java]
p = new Alumno();
\end{lstlisting}
Ahora el tipo dinámico de \textit{p} es Alumno.

\subsection{Polimorfismo y ligadura dinámica}
\begin{itemize}
\item \textbf{Ligadura estática:} el enlace del método al mensaje se basa en el tipo estático de la variable y se realiza en tiempo de compilación. Se debe especificar el C++ y Objetive C. Java y Ruby no permiten hacer esto.

\item \textbf{Ligadura dinámica:} el enlace del método al mensaje se basa en el tipo dinámico de la variable y se realiza en tiempo de ejecución. Es lo que emplean Java y Ruby.
\end{itemize}

No existe polimorfismo sin ligadura dinámica, ya que ésta permite que una variable referencia en tiempo de ejecución a objetos de diferente clase, así como que un mensaje se ligue a un método y otro dependiendo de la clase del objeto receptor en ese momento.

En los lenguajes con tipo estático, las clases de objetos que puede referenciar una variable está limitada por el tipo estático de la variable. Existen unas reglas de compatibilidad en orientación a objetos:
\begin{itemize}
\item \textbf{Entre clases (a través de herencia):} el tipo dinámico de una variable puede ser la clase declarada, coincidiendo con su tipo estático, pero también puede ser de alguna de sus subclases, como veíamos en el ejemplo de la Persona. Podemos aplicar la regla \textit{es un}, \textit{un alumno es una persona}, luego está permitido referenciar a Alumno.

\item \textbf{Entre interfaz y clases (a través de la realización):} el tipo dinámico de una variable puede ser el tipo estático de la interfaz que implementa. En este caso solo abordamos Java, ya que Ruby no cuenta con el concepto de interfaz.
\end{itemize}
Daremos un par de conceptos más antes de pasar a ilustrar ejemplos.

\subsection{Errores de compilación y ejecución}
\begin{itemize}
\item \textbf{Error de compilación:} aunque la decisión del método a ejecutar dependa del objeto al que se haga referencia, si el tipo estático no dispone del método, obtendremos un error en tiempo de compilación. Podemos solucionarlo mediante un casting, con el que no convertimos el tipo, pero indicamos el tipo dinámico que se espera tener en tiempo de ejecución.
\item \textbf{Error de ejecución:} se produce cuando no se corresponde el tipo dinámico de la variable con el tipo que se le ha indicado para evitar un error de compilación.
\end{itemize}

\subsection{Ejemplos prácticos y realizando casting}
Con todos estos conceptos teóricos expuestos, ponemos unos ejemplos que ayudarán a entender los conceptos. Disponemos de una clase Persona, de la cual heredan una clase Alumno y una clase Profesor. El código de las clases es el siguiente:
\textit{Clase Persona}
\begin{lstlisting}[language=Java]
package polimorfismo;

/**
  * @author victor
 */
public class Persona {
    protected String nombre;
    Persona (String n) {
        nombre = n;
    }
    void hablar() {
        System.out.println("Soy una persona que habla. Me llamo " + nombre);
    }

}
\end{lstlisting}

\textit{Clase Alumno}
\begin{lstlisting}[language=Java]
package polimorfismo;

/**
 *
 * @author victor
 */
public class Alumno extends Persona {
    Alumno(String n) {
        super(n);
    }

    @Override
    void hablar() {
        System.out.println("Soy un alumno que habla, me llamo " + nombre);
    }

    void Estudiar() {
        System.out.println("Soy un alumno que estudia");
    }

}
\end{lstlisting}

\textit{Clase Profesor}
\begin{lstlisting}[language=Java]
package polimorfismo;

/**
 *
 * @author victor
 */
public class Profesor extends Persona {
    Profesor(String n) {
        super(n);
    }

    @Override
    void hablar() {
        System.out.println("Soy un profesor que habla, me llamo " + nombre);
    }

    void Enseñar() {
        System.out.println("Soy un profesor que enseña");
    }

}
\end{lstlisting}

Creamos una clase Test para probar el código anterior.
\begin{lstlisting}[language=Java]
public class Test {
    public static void main(String args[]) {
        Persona p; //Tipo estático de p: Persona
        p = new Persona("Pepe"); //Tipo dinámico de p: Persona
        p.hablar();
}
\end{lstlisting}

La ligadura dinámica del método hablar() de p se realiza en tiempo de ejecución. Por tanto, durante la ejecución se decide qué método hablar se va a utilizar. Como  el tipo dinámico es Persona, se llamará al método hablar() que se implementó en la clase Persona. Se produce la siguiente salida
\begin{lstlisting}[language=bash, style=terminal]
Soy una persona que habla. Me llamo Pepe
\end{lstlisting}

Si cambiamos el tipo dinámico a Alumno, se decide en tiempo de ejecución que el método hablar() que se utilizará es el que se implementó en la clase.
\begin{lstlisting}[language=Java]
p = new Alumno("Pepe");
p.hablar()
\end{lstlisting}

Produce como salida:
\begin{lstlisting}[language=bash, style=terminal]
Soy un alumno que habla, me llamo Pepe
\end{lstlisting}

Esto se puede hacer ya que ambas clases tienen implementado el método hablar. Para no producir un error en tiempo de de compilación, el método debe estar implementado en la clase del tipo estático con el que hemos declarado la variable p. Aunque el tipo dinámico sea Alumno, como Persona no dispone del método Estudiar(), el siguiente código produce un error de compilación.
\begin{lstlisting}[language=Java]
Persona p = new Alumno("Pepe");
p.Estudiar();
\end{lstlisting}

\subsection{Resolviendo errores con casting}
Para resolver el problema anterior podemos realizar un casting, indicarle al compilador el tipo dinámico esperado durante la ejecución. Es importante tener en cuenta que un casting no convierte tipos, simplemente indica explícitamente el tipo dinámico esperado.
\begin{lstlisting}[language=Java]
Persona p = new Alumno("Pepe");
((Alumno)p).Estudiar();
\end{lstlisting}

Compila y produce como salida:

\begin{lstlisting}[language=bash, style=terminal]
Soy un alumno que estudia
\end{lstlisting}

No obstante, debemos tener cuidado con el casting que realizamos. El siguiente código compilaría, pero obtendríamos un error de ejecución ya que aunque nos quitemos el error de compilación, cuando ejecutemos, nuestro tipo dinámico es Profesor, y un Profesor no puede ser un Alumno, por lo que no se puede realizar el cast.

\begin{lstlisting}[language=Java]
Persona var4 = new Profesor("Pedro");
((Alumno)var4).Estudiar();
\end{lstlisting}

El error obtenido es este:
\begin{lstlisting}[language=bash, style=terminal]
Exception in thread "main" java.lang.ClassCastException: polimorfismo.Profesor cannot be cast to polimorfismo.Alumno
\end{lstlisting}

Nótese que el tipo estático era Persona. Si ahora decidimos que el tipo estático es Profesor, obtenemos un error de compilación. NetBeans nos notifica con el siguiente error:
\begin{lstlisting}[language=bash, style=terminal]
incompatible types: Profesor cannot be converted to Alumno
\end{lstlisting}

Para finalizar, vamos a ver dos o tres ejemplos más, complentado así el listado de casos enrevesados a los que nos podemos enfrentar en Java.
El siguiente código produce un error en compilación.
\begin{lstlisting}[language=Java]
Persona persona = new Persona("Pepe");
Alumno alumno = new Alumno("Juan");
alumno = persona;
\end{lstlisting}
Una persona no es un alumno, por lo que no podemos tener como tipo estático Alumno y como tipo dinámico Persona. Si fuera al revés y hubiéramos hecho `persona = alumno` sería correcto, ya que un Alumno es una Persona, Tendríamos como tipo estático Persona y como tipo dinámico, Alumno. No hay problema si hubiéramos referenciado persona a Alumno en vez de a Persona.

Sin embargo, en este código lo que obtenemos es un error en ejecución
\begin{lstlisting}[language=Java]
Persona persona = new Persona("Pepe");
Alumno alumno = new Alumno("Juan");
alumno = (Alumno) persona;
\end{lstlisting}

El compilador no se queja, ya que estamos indicando que el tipo dinámico que recibirá la variable *alumno* es del tipo Persona. Pero al igual que nos ocurría antes, al ejecutar, obtenemos una excepción, ya que una Persona no es un Alumno, por lo que no se puede realizar el cast de Persona a Alumno.

Veamos ahora este caso:
\begin{lstlisting}[language=Java]
Persona persona = new Alumno("Pepe");
Alumno alumno = new Alumno("Juan");
alumno = persona;
\end{lstlisting}

No compila, Persona no se puede convertir en alumno, aunque el tipo dinámico de persona sea alumno. Podemos realizar un casting, consiguiendo que el código compile y ejecute correctamente.
\begin{lstlisting}[language=Java]
Persona persona = new Alumno("Pepe");
Alumno alumno = new Alumno("Juan");
alumno = (Alumno) persona;
\end{lstlisting}

Los ejemplos, aunque cortos, han sido densos, poniendo de manifiesto las diferencias entre tipos estáticos y dinámicos, así como su respectiva relación con la compilación y ejecución

\subsection{Polimorfismo en lenguajes sin tipo estático}
En aquellos lenguajes sin tipo estático, como Ruby, no hya una limitación en cuanto a la "forma" que puede tomar una variable, es decir, puede referenciar a cualquier objeto de cualquier clase durante la ejecución. La variable responderá al mensaje que reciba en función de la clase del objeto que se esté referenciando en ese momento

\subsection{Qué no es Polimorfismo}
La sobrecarga de operadores, funciones o métodos y los tipos y clases parametrizables no son considerados polimorfismos.

