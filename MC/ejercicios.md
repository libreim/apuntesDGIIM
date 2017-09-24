\newpage
\part{Ejercicios}
\section{Introducción a la Computación}

\begin{ejer}
	Demostrar que la gramática $$G = ({S}, {a, b}, \{S \rightarrow \varepsilon, S \rightarrow aSb\}$$
\end{ejer}

\begin{ejer}
	Encontrar el lenguaje generado por la gramática $G = (\{A, B, C\}, \{a, b\}, P, S)$ donde $P$ contiene las siguientes producciones

	\begin{center}
		\begin{tabular}{ccc}
			$S \rightarrow aAB$ & $bB \rightarrow a$ & $Ab \rightarrow SBb$ \\
			$Aa \rightarrow SaB$ & $B \rightarrow SA$ & $B \rightarrow ab$\\
		\end{tabular}
	\end{center}
\end{ejer}

\begin{sol}
	Se genera el lenguaje vacío, ya que se entra en un ciclo. Para quitar $S$ hay que añadir una $A$, pero para quitar una $A$ es necesario una $S$.
\end{sol}

\begin{ejer}
	Encontrar una 
\end{ejer}