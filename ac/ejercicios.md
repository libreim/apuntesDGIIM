\section{Arquitecturas con paralelismo a nivel de thread (TLP)}


\begin{ejer}
  Suponemos que se va a ejecutar en paralelo el siguiente código (inicialmente x
  e y son $0$):

   \begin{tabular}{ll}
     P1 & P2 \\
    \texttt{x=1;}& \texttt{y=1;} \\
     \texttt{x=2;} &\texttt{y=2;} \\
    \texttt{print y;} & \texttt{print x;}
  \end{tabular}

  Qué resulados se pueden imprimir si (considere que el compilador no altera el
  código):

  \begin{enumerate}
  \item Se ejecutan P1 y P2 en un multiprocesador con consistencia secuencial.
  \item Se ejecutan en un multiprocesador basado en un bus que garantiza todos
    los órdenes excepto el orden $W \rightarrow R$. Esto es debido a que los
    procesadores tienen buffer de escritura, permitiendo el procesador que las
    lecturas en el código que se ejecuta adelanten a las escrituras que tiene su
    buffer. Obsérvese que hay varios resultados posibles.
  \end{enumerate}
\end{ejer}

\begin{sol}
    Sabemos que \texttt{x = y = 0}

  \begin{tabular}{lll}
     & P1 & P2 \\
    (1) (W) & \texttt{x=1;}&\texttt{y=1;} (w) (a) \\
    (2) (W) &\texttt{x=2;} &\texttt{y=2;} (w) (b) \\
    (3) (R) &\texttt{print y;} & \texttt{print x;} (R) (C)
  \end{tabular}

  \texttt{
  \begin{tabular}{llll}
    y=0&x=2&y=2&x=0 \\
    y=1&x=2&y=2&x=1\\
    y=2&x=2&y=2&x=2
  \end{tabular}}
\end{sol}

\begin{ejer}
    
\end{ejer}

\begin{ejer}
    Suponga que en un CC-NUMA de red estática de 4 nodos (N0-N3) se implementa un protocolo
MSI basado en directorios sin difusión con dos estados en el directorio (válido e inválido). Cada nodo tiene 8
GBytes de memoria y una línea de cache supone 64 Bytes. Considere que el directorio utiliza vector de bits
completo.

\begin{enumerate}
    \item Calcule el tamaño del directorio de uno nodo en bytes.
    \item Indique cual sería el contenido del directorio, las transiciones de estados (en cache y en el directorio) y la secuencia de paquetes generados por el protocolo de coherencia en los siguientes accesos sobre una dirección D que se encuentra en la memoria del nodo 3 (inicialmente D no está en ninguna caché):
        \begin{itemize}
            \item Lectura generada por el procesador del nodo 1
            \item Escritura generada por el procesador del nodo 1
            \item Lectura generada por el procesador del nodo 2
            \item Lectura generada por el procesador del nodo 3
            \item Escritura generada por el procesador del nodo 0
        \end{itemize}
\end{enumerate}
\end{ejer}

\begin{sol}
    % Aquí se podría hacer el dibujito que ha hecho en la pizarra.

    La memoria principal es de 32Gb (4 nodos de 8Gb). Cada línea de caché (el tamaño de cada bloque de caché) tiene 64 bytes.

    \begin{enumerate}
        \item Teniendo en cuenta que hay una entrada por cada marco de bloque o de línea, tenemos que calcular cuantas líneas hay en cada memoria principal de cada nodo. Multiplicando por el número de bits de cada nodo, tendremos el tamaño que buscamos.
        \begin{align*}
            \label{}
            MPN &= 8GBytes = 2^3 \cdot 2^{30} = 2^{33} \ Bytes \\
            LC &= 64 \ Bytes = 2^6 \ Bytes \\
            \text{Nº líneas } &= \frac{2^{33} \ Bytes}{2^6 \ Bytes} = 2^{27} \text{ líneas } \\
            \text{ Tamaño directorio memoria } &= 2^{27}l \cdot (4+1) \ bits = 5 \cdot 2^{27} bits \cdot \frac{1 \ Byte}{2^3 \ bits} = 5 \cdot 2^{24} \ Bytes \\
                                                &= 5 \cdot 2^4 \cdot 2^{20} \ Bytes = 80 \ MBytes
        \end{align*}
    \item 
    \end{enumerate}
\end{sol}