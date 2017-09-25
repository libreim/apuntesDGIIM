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

\section{Tema 1 - Relación}
\begin{ejer}
	Describir el lenguaje generado por la siguiente gramática,
	\begin{center}
		\begin{tabular}{ccc}
			$S \rightarrow XYX$ \\
			$X \rightarrow aX | bX | \epsilon$ \\
			$Y \rightarrow bbb$
		\end{tabular}
	\end{center}
\end{ejer}

\begin{sol}
	$L(G) = \{ub^3w: u,w \in {\{a,b\}}^{*}\}$ $\equiv$ Palabras que contienen al menos 3 $b$ seguidas.
\end{sol}

\begin{ejer}
	Describir el lenguaje generado por la siguiente gramática,
	\begin{center}
		\begin{tabular}{cc}
			$S \rightarrow aX$ \\
			$X \rightarrow aX | bX | \epsilon$
		\end{tabular}
	\end{center}
\end{ejer}

\begin{sol}
	$L(G)=\{au: u\in\{{a,b\}^{*}}\}$ $\equiv$ Palabras que empiezan por $a$.
\end{sol}

\begin{ejer}
	Describir el lenguaje generado por la siguiente gramática,
	\begin{center}
		\begin{tabular}{cc}
			$S \rightarrow XaXaX$ \\
			$X \rightarrow aX | bX | \epsilon$
		\end{tabular}
	\end{center}
\end{ejer}

\begin{sol}
	$L(G) = \{ uavaw : u,v,w \in {\{a,b\}}^{*} \}$ $\equiv$ Palabras que al menos tienen 2 $a$.

	Este lenguaje se puede generar por una gramática de tipo 3, luego es de tipo 3, con las siguientes reglas:

	\begin{center}
		\begin{tabular}{ccc}
			$S \rightarrow bS | aX$ \\
			$X \rightarrow bX | aY$ \\
			$Y \rightarrow bY | aY | \epsilon$
		\end{tabular}
	\end{center}
\end{sol}

\begin{ejer}
	Describir el lenguaje generado por la siguiente gramática,
	\begin{center}
		\begin{tabular}{cc}
			$S \rightarrow SS | XaXaX | \epsilon $ \\
			$ X \rightarrow bX | \epsilon $
		\end{tabular}
	\end{center}
\end{ejer}

\begin{sol}
	$ L(G) = \{ {(b^iab^jab^k)}^{m}: i,j,k \in \mathbb{N}, m $ $es par\}$ $\equiv$ Palabras con el patron siguiente repetido un número $n$ par, 2 $a$ con posibilidad de $b$ a los lados.

	Este lenguaje es de tipo 3, ya que se puede generar por la siguiente gramática de tipo 3:

		\begin{center}
			\begin{tabular}{cccc}
				$ S \rightarrow \epsilon | X $ \\
				$ X \rightarrow bX | aY $ \\
				$ Y \rightarrow bY | aZ  | aS $ \\
				$ Z \rightarrow aY | bZ | \epsilon $
			\end{tabular}
		\end{center}
\end{sol}

\begin{ejer}
	Encontrar la gramática libre de contexto que genera el lenguaje sobre el alfabeto $\{ a,b \}$ de las palabras que tienen más $a$ que $b$ (al menos una más).
\end{ejer}

\begin{sol}
	(Por confirmar)
	\begin{center}
		\begin{tabular}{cc}
			$ S \rightarrow aX | bSS $ \\
			$ X \rightarrow bS | S | \epsilon $
		\end{tabular}
	\end{center}
\end{sol}

\begin{ejer}
	Encontrar gramáticas de tipo 2 para los siguientes lenguajes sobre el alfabeto $\{ a,b \}$. En cada caso determinar si los lenguajes generados son de tipo 3, estudiando si existe una gramática de tipo 3 que los genera.
\end{ejer}
