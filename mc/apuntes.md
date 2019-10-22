\part{Teoría}

# Introcucción a la Computación

## Breve introducción histórica a la computación

La computción trata de responder a varias preguntas: ¿qué puede ser resuelto de forma automática? ¿qué puede ser resuelto de forma eficiente? ¿qué estructuras son comunes en la computación con palabras y símbolos...?

### El problema de la parada

¿Existe un programa que lea un programa y unos datos y nos diga si ese programa termina realiza ciclos indefinidamente? Concluimos que no existe, ya que si existiera (programa `Stops(P, x)`) podríamos construir el algoritmo `Turing(P)` con entrada `P`.

```
If Stops(P,P) GOTO 1
```

¿Cuál sería el resultado de `Turing(Turing)`? El programa comprueba si `Turing` termina con `Turing` como dato. Por lo tanto existe un programa que termina y que puede no terminar.

## Alfabetos

\begin{ndef}[Alfabeto]
Un alfabeto es un conjunto finito $A$. Sus elementos se llamarán \emph{símbolos} o \emph{letras}. Notaremos los alfabetos con letras mayúsculas $(A, B, C, ...)$ y a los símbolos con letras minúsculas o números $(a, b, c, 1, 2, ...)$.
\end{ndef}

\begin{ejemplo}
$A = \{0, 1\}$, $B = $ <!-- compeltar el ejemplo -->
\end{ejemplo}

\begin{ndef}[Palabra]
Una palabra sobre el alfabeto $A$ es una sucesión finita de elementos de $A$
\end{ndef}

El conjunto de todas las palabras sobre un alfabeto $A$ se denota como $A^*$.

\begin{ndef}[Longitud de palabra]
Si $u \in A^*$ entonces la longitud de la palabra $u$ es el número de símbolos de $A$ que contiene. Lo notamos como $|u|$.
\end{ndef}

La palabra vacía es la palabra de longitud cero. La notaremos $\varepsilon$.

<!-- falta algo -->

Si $u, v \in A^*$, $u = a_1 \hdots a_n$, $v = b_1 \hdots b_m$ se llama concatenación de $u$ y $v$ a la cadena $u.v$ (o simplemente $uv$).

\begin{ndef}[Prefijo]
Si $u \in A^*$ entonces $v$ es un \emph{prefijo} de $u$ si $\exists z \in A^*$ tal que $vz = u$. Un prefijo $v$ de $u$ se dice \emph{propio} si $v \neq \varepsilon$ y $v \neq u$.
\end{ndef}

<!-- falta definición de sufijo -->

La iteración n-ésima de una cadena ($u^n$) como la concatenación de ella misma $n$ veces.

\begin{ejemplo}
Si $u = 010$, entonces $u^3 = 010010010$.
\end{ejemplo}

\begin{nprop}
El conjunto de lenguajes sobre $A^*$ (si $A$ no es vacío) nunca es numerable.
\end{nprop}

\begin{ndef}
	Llamamos \textit{lenguaje generado} por una gramática $G = (V, T, P, S)$ al conjunto de cadenas formadas por símbolos terminales que son derivables a partir del símbolo de partida.
\end{ndef}

\subsubsection{Jerarquía de Chomsky} % (fold)
\label{ssub:jerarquía_de_chomsky}
- Tipo 0: Cualquier gramática, sin restricciones. Son los lenguajes recursivamente enumerables.
- Tipo 1: Si todas las producciones tienen la formaa $\alpha_1A\alpha_2 \rightarrow \alpha_1 \beta \alpha_2$, donde 
- Tipo 2: Si cualquier producción tiene la forma $A \rightarrow \alpha$, donde $A \in V, \alpha \in (V \cup T)^*$. Los lenguajes que se generan son lenguajes independientes del contexto.
- Tipo 3: Son independientes del contecxto y además toda producción es de la forma: $A \rightarrow uB$ ó $A \rightarrow u$, donde $u \in T^*$ y $A, B \in V$. Se generan conjuntos regulares.

\subsubsection{Clases de lenguajes} % (fold)
\label{ssub:clases_de_lenguajes}

Un lenguaje se dice que es de tipo $i (i = 0, 1, 2, 3)$ si y solo si es generado por una gramática de tipo $i$. La clase o familia de languajes de tipo $i$ se denota por $L_i$.

\begin{nprop}
 	$L_3 \subseteq L_2 \subseteq L_1 \subseteq L_0$
 \end{nprop} 

\section{Autómatas finitos y expresiones regulares} % (fold)
\label{sec:autómatas_finitos_y_expresiones_regulares}

\subsection{Autómata finito determinista} % (fold)
\label{sub:autómata_finito_determinista}

Veamos un ejemplo. Supongamos que queremos reconocer palabras que son direcciones de correo electrónico del tipo `nombre@dominio.exten`, donde `nombre` es una palabra formada por dígitos y caracteres alfabéticos, y `ddominio` y `extensión` son palabras formadas por símbolos alfabéticos. ¿Cómo podemos especificar un algoritmo que identifique las palabras que corresponden a este patrón?

\begin{ndef}
	Un \textit{autómata finito} es una quintupla $M = (Q, A, \delta, q_0, F)$ donde:
	\begin{itemize}
		\item $Q$ es un conjunto finito llamado \textit{conjunto de estados}
		\item $A$ es un alfabeto llamado \textit{alfabeto de entrada}.
		\item $\delta$ es una aplicación llamada \textit{función de transición} $\delta: Q \prod A \rightarrow Q$.
		\item $q_0$ es un elemento de $Q$, llamado \textit{estado inciial}.
		\item $F$ es un subconjunto de Q, llamado conjunto de \textit{estados finales}.
	\end{itemize}
\end{ndef}

\begin{ndef}[Diagrama de transición]
	Es un grafo en el que:
	\begin{itemize}
		\item Hay un nodo por cada estado
		\item Por cada transición $\delta(q, a) = p$ hay un arco de $q$ a $p$ con la etiqueta $a$.
		\item El estado inicial está indicado con un ángulo entrante. Los estados finales están indicados con una doble circunferencia.
	\end{itemize}

	% Insertar grafo
\end{ndef}
