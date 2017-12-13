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

\begin{lstlisting}

\end{lstlisting}

\subsection{}

\subsection{}

\begin{lstlisting}

\end{lstlisting}