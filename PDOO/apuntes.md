\section{}

\section{}

\section{}

\subsection{Mecanismos de reutilización}

En la programación orientada a objetos existen diferentes mecanismos de reutilización de código, \textit{herencia}, \textit{interfaces} y \textit{clases parametrizables}.

\subsubsection{}

\subsubsection{Definición y propiedades de la herencia}

La herencia es un mecanismo que permite derivar nuevas clases (subclases o clases hija) a partir de clases existentes (superclase o clase padre).

Las clases padre e hija comparten un código común que es definido en la clase padre y que hereda la clase hija. Se reutiliza el código definido en la clase padre. Podemos hablar de reutilización  de código cuando la clase hija hereda el comportamiento de la clase padre pero no modifica la forma de llevarlo a cabo. Hablamos de reutilización de concepto cuando la clase hija hereda el comportamiento de la clase padre y modifica la forma de llevarlo a cabo.

La clase hija es a la vez una extensión de la clase padre, desde el punto de vista de la clase como un módulo, y una especialización o restricción de la clase padre.

Una forma de saber si es conveniente utilizar herencia en cierto caso es mediante el \textit{test de especialización}. Supongamos que tenemos una clase A padre y una clase B que pretendemos que sea hija de A. Si podemos decir que ""B es un A"" entonces podemos establecer una relación de herencia entre A y B.

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
\textbf{Tipo estático:} Tipo(clase) del que se declara la variable, no cambia durante la ejecución.
\textbf{Tipo dinámico:} Clase a la que pertenece el objeto al que va referenciando una variable a lo largo de la ejecución Puede cambiar durante la ejecución.

Java es un lenguaje con tipo estático y dinámico. Dado que Ruby no es un lenguaje fuertemente tipado, no tiene sentido hablar de tipo estático, todos los tipos son dinámicos.
Un ejemplo es el siguiente. Supongamos que tenemos una clase Persona y una clase Alumno, la cual hereda de persona.
\begin{lstlisting}[language=Java]
Persona p = new Persona();
\end{lstlisting}

El tipo estático de *p* es Persona, su tipo dinámico es Persona. No obstante, como Alumno hereda de Persona, podemos cambiar su tipo dinámico a Alumno:
\begin{lstlisting}[language=Java]
p = new Alumno();
\end{lstlisting}
Ahora el tipo dinámico de \textit{p} es Alumno.

\subsection{Polimorfismo y ligadura dinámica}
\textbf{Ligadura estática:} el enlace del método al mensaje se basa en el tipo estático de la variable y se realiza en tiempo de compilación. Se debe especificar el C++ y Objetive C. Java y Ruby no permiten hacer esto.
\textbf{Ligadura dinámica:} el enlace del método al mensaje se basa en el tipo dinámico de la variable y se realiza en tiempo de ejecución. Es lo que emplean Java y Ruby.

No existe polimorfismo sin ligadura dinámica, ya que ésta permite que una variable referencia en tiempo de ejecución a objetos de diferente clase, así como que un mensaje se ligue a un método y otro dependiendo de la clase del objeto receptor en ese momento.

En los lenguajes con tipo estático, las clases de objetos que puede referenciar una variable está limitada por el tipo estático de la variable. Existen unas reglas de compatibilidad en orientación a objetos:
\textbf{Entre clases (a través de herencia):} el tipo dinámico de una variable puede ser la clase declarada, coincidiendo con su tipo estático, pero también puede ser de alguna de sus subclases, como veíamos en el ejemplo de la Persona. Podemos aplicar la regla " es un", "un alumno es una persona", luego está permitido referenciar a Alumno.
\textbf{Entre interfaz y clases (a través de la realización):} el tipo dinámico de una variable puede ser el tipo estático de la interfaz que implementa. En este caso solo abordamos Java, ya que Ruby no cuenta con el concepto de interfaz.

Daremos un par de conceptos más antes de pasar a ilustrar ejemplos.

\subsection{Errores de compilación y ejecución}

\textbf{Error de compilación:} aunque la decisión del método a ejecutar dependa del objeto al que se haga referencia, si el tipo estático no dispone del método, obtendremos un error en tiempo de compilación. Podemos solucionarlo mediante un casting, con el que no convertimos el tipo, pero indicamos el tipo dinámico que se espera tener en tiempo de ejecución.
\textbf{Error de ejecución:} se produce cuando no se corresponde el tipo dinámico de la variable con el tipo que se le ha indicado para evitar un error de compilación.

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
\begin{lstlisting}
Soy una persona que habla. Me llamo Pepe
\end{lstlisting}

Si cambiamos el tipo dinámico a Alumno, se decide en tiempo de ejecución que el método hablar() que se utilizará es el que se implementó en la clase.
\begin{lstlisting}[language=Java]
p = new Alumno("Pepe");
p.hablar()
\end{lstlisting}

Produce como salida:
\begin{lstlisting}
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

\begin{lstlisting}
Soy un alumno que estudia
\end{lstlisting}

No obstante, debemos tener cuidado con el casting que realizamos. El siguiente código compilaría, pero obtendríamos un error de ejecución ya que aunque nos quitemos el error de compilación, cuando ejecutemos, nuestro tipo dinámico es Profesor, y un Profesor no puede ser un Alumno, por lo que no se puede realizar el cast.

\begin{lstlisting}[language=Java]
Persona var4 = new Profesor("Pedro");
((Alumno)var4).Estudiar();
\end{lstlisting}

El error obtenido es este:
\begin{lstlisting}
Exception in thread "main" java.lang.ClassCastException: polimorfismo.Profesor cannot be cast to polimorfismo.Alumno
\end{lstlisting}

Nótese que el tipo estático era Persona. Si ahora decidimos que el tipo estático es Profesor, obtenemos un error de compilación. NetBeans nos notifica con el siguiente error:
\begin{lstlisting}
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


\begin{lstlisting}

\end{lstlisting}

\subsection{}

\subsection{}

\begin{lstlisting}

\end{lstlisting}
