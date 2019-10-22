\section{Algoritmos Greedy}


\begin{ejer}
  Sea $G$ un grafo no dirigido y conexo y $M$ un número máximo de
  colores. Encontrar la asignación de colores mínima entre los colores y los
  nodos del grafo de tal forma que no existan dos vértices adyacentes con el mismo color.
\end{ejer}

\begin{sol}
  Supongamos que tenemos el siguiente grafo:

  \begin{tikzpicture}
    \GraphInit[vstyle=Normal]
    \Vertex[L=M]{1}
    \Vertex[x=2,y=0,L=V]{2}
    \Vertex[x=3,y=1,L=M]{3}
    \Vertex[x=3,y=-1,L=M]{4}
    \Vertex[x=4,y=0,L=V]{5}

    \Edges(1,2,3,5)
    \Edges(2,4,5)
  \end{tikzpicture}

  Veamos los elementos de un algoritmo Greedy aplicados a este problema:

  \begin{itemize}
  \item Lista de candidatos: los $M$ colores.
  \item Lista de candidatos utilizados: los colores usados.
  \item Función de selección: escoger un color cualquiera.
  \item Función de factibilidad: dos ndos adyacentes no pueden tener el mismo
    color.
  \item Función solución: todos los nodos están rellenos.
  \item Función objetivo: minimizar el número de colores a utilizar.
  \end{itemize}

  \begin{lstlisting}[mathescape=true]
    $C \leftarrow M$
    $K \leftarrow \emptyset$
    T[i] = $\emptyset \ \ \forall i$ // Sin color en ningún nodo

    Mientras ($\exists$ i T[i] = 0 y K < C) {
      $K \leftarrow K +1$ // Escojo el siguiente color
      Para cada nodo $j \in V$ : T[j] = $\emptyset$
      Si $\nexists w \in V \ \exists a=(j, w) \in A$ ^ $T(w) = k$.
      T[j] = K
    }
    Devolver T
  \end{lstlisting}
\end{sol}

\begin{ejer}
  
\end{ejer}

\begin{ejer}
  Dado un conjunto de puntos de planos $p_i = (x_i,y_i)$ que forman un grafo $G =
  (P, A)$ no dirigido y completo, se desea encontrar el mínimo conjunto de aristas
  que forman la \textit{envolvente convexa}.  
\end{ejer}

\begin{sol}\hfill

  Veamos gráficamente lo que representa la \textit{envolvente conexa}. A la
  izquierda tenemos un conjunto de nodos y a la derecha, la envolvente conexa de
  este conjunto de nodos.

  \vspace{1em}

  \begin{minipage}[c]{0.45\textwidth}
    \begin{tikzpicture}
      \GraphInit[vstyle=Normal]

      \Vertex{1}
      \Vertex[x=1, y=1]{2}
      \Vertex[x=1.5, y=2]{3}
      \Vertex[x=2, y=-1]{4}
      \Vertex[x=-0.5, y=1.5]{5}
      \Vertex[x=-2, y=0]{6}
      \Vertex[x=-3, y=2]{7}
      \Vertex[x=1, y=-1]{8}
    \end{tikzpicture}
  \end{minipage}\hfill
  \begin{minipage}[c]{0.1\textwidth}
    $$\Rightarrow$$
  \end{minipage}\hfill
  \begin{minipage}[c]{0.45\textwidth}\hfill
    \begin{tikzpicture}
      \GraphInit[vstyle=Normal]

      \Vertex{1}
      \Vertex[x=1, y=1]{2}
      \Vertex[x=1.5, y=2]{3}
      \Vertex[x=2, y=-1]{4}
      \Vertex[x=-0.5, y=1.5]{5}
      \Vertex[x=-2, y=0]{6}
      \Vertex[x=-3, y=2]{7}
      \Vertex[x=1, y=-1]{8}

      \Edges(7,3,4,8,6,7)
    \end{tikzpicture}
  \end{minipage}
  
  \vspace{1em}

  Diseñemos el algoritmo Greedy para resolver este problema. Enumeremos los
  elementos de este tipo de algoritmos:

  \begin{itemize}
  \item Lista de candidatos: el conjunto de puntos.
  \item Lista de candidadatos usados: el conjunto de puntos insertados en la
    solución.
  \item Función solución: que no queden candiadatos válidos.
  \item Criterio de selección: seleccionar un punto $P$ tal que la recta que une
    $P$ con un punto en la solución deje a todos los puntos a un lado de la
    recta.
  \item Criterio de factibilidad: siempre se cumple dado el criterio de
    selección escogido.
  \item Función objetivo: minimizar aristas que forman la \textit{envolvente convexa}.
  \end{itemize}

  $f(c, t, p)$ es una función que traza la recta entre $c$ y $y$. Devuelve $0$ si
  $p$ está en la recta, $> 0$ si está por encima y $< 0$ si está por debajo. El
  pseudocódigo de este algoritmo es el siguiente:

  \begin{lstlisting}[mathescape=true]
    T = {($p$)} $\leftarrow$ Greedy ($P$ es el conjunto de puntos $p_i
    = (x_i, y_i)$.

    V $\leftarrow$ Seleccionar nodo de valor $y$ máximo.
    C $\leftarrow$ $P \setminus \{v\}$.
    T $\leftarrow$ $\emptyset$

    Mientras queden candidatos válidos {
      $c \leftarrow$ nodo en C : $\exists t \in T$ donde $\forall p \in P f(c,
      t, p) \geq 0 \vee f(c, t, p) \leq 0$.
      C $\leftarrow$ C $\setminus \{c \}$.
      T $\leftarrow$ T $\cup \{c\}$.
    }

    Ordenar T en el sentido de las agujas del reloj.
    Devolver T.
    
  \end{lstlisting}

  \begin{lstlisting}
    {
      wha
    }
  \end{lstlisting}
  
\end{sol}