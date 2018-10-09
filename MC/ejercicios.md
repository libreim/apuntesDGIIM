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

% Cambiar listas
	\begin{enumerate}
		\item Palabras en la que el número de $b$ no es tres.
		\item Palabras que tienen 2 o 3 $b$.
		\item Palabras que no contienen la subcadena $ab$.
		\item Palabras que no contienen la subcadena $baa$.
	\end{enumerate}
\end{ejer}

\begin{sol}
	Todos son de tipo 3.

	\begin{enumerate}
		\item Reglas:
		\begin{center}
			\begin{tabular}{ccccc}
				$ S \rightarrow aS | bS_1 | \epsilon $ \\
				$ S_1 \rightarrow aS_1 | bS_2 | \epsilon $ \\
				$ S_2 \rightarrow aS_2 | bS_3 | \epsilon $ \\
				$ S_3 \rightarrow aS_3 | bS_4 $ \\
				$ S_4 \rightarrow aS_4 | bS_4 | \epsilon $
			\end{tabular}
		\end{center}

		\item Reglas:
		\begin{center}
			\begin{tabular}{cccc}
			$ S \rightarrow aS | bS_1 $ \\
			$ S_1 \rightarrow aS_1 | bS_2 $ \\
			$ S_2 \rightarrow aS_2 | bS_3 | \epsilon $ \\
			$ S_3 \rightarrow aS_3 | \epsilon $
			\end{tabular}
		\end{center}

		\item Reglas:
		\begin{center}
			\begin{tabular}{cc}
				$ S \rightarrow aA | bB | \epsilon $ \\
				$ A \rightarrow aA | \epsilon $
			\end{tabular}
		\end{center}

		\item Reglas:
		\begin{center}
			\begin{tabular}{ccc}
				$ S \rightarrow aS | bB | \epsilon $ \\
				$ B \rightarrow bB | aA | \epsilon $ \\
				$ A \rightarrow bB | \epsilon $
			\end{tabular}
		\end{center}
	\end{enumerate}
\end{sol}

\begin{ejer}
	Encontrar una gramática libre del contexto que genere el lenguaje
		\begin{center}
			$ L = \{ 1u1 | u \in {\{0,1\}}^{*} \} $
		\end{center}
\end{ejer}

\begin{sol}
	Gramática tipo 2:
	\begin{center}
	\begin{tabular}{cc}
		$ S \rightarrow 1X1 $ \\
		$ X \rightarrow 0X | 1X | \epsilon $
	\end{tabular}
	\end{center}
	Si es gramática tipo 3:
	\begin{center}
		\begin{tabular}{cc}
		$ S \rightarrow 1A $ \\
		$ A \rightarrow 1A | 0A | 1 $
		\end{tabular}
	\end{center}
\end{sol}

\begin{ejer}
	Encontrar si es posible una gramática lineal por la derecha o una gramática libre del contexto que genere el lenguaje $L$ supuesto que $L \subset {\{a,b,c\}}^{*}$ y verifica:
	\begin{itemize}
		\item $u \in L \iff u$ no contiene dos símbolos $b$ consecutivos.
		\item $u \in L \iff u$ contiene dos símbolos $b$ consecutivos.
		\item $u \in L \iff u$ contiene un número impar de símbolos $c$.
		\item $u \in L \iff u$ no contiene el mismo número de símbolos $b$ que de símbolos $c$
	\end{itemize}
	(Mismo ejercicio que el 19)
\end{ejer}

\begin{sol}
	Todas son de tipo 3 menos el 4.
	\begin{enumerate}
		\item Reglas:
			\begin{center}
				\begin{tabular}{cc}
					$ S \rightarrow aS | bX | cS | \epsilon $ \\
					$ X \rightarrow aS | cS | \epsilon $
				\end{tabular}
			\end{center}
		\item Reglas (comprobar):
			\begin{center}
				\begin{tabular}{cc}
					$ S \rightarrow aS | bS | cS | bbX $ \\
					$ X \rightarrow aX | bX | cX | \epsilon $
				\end{tabular}
			\end{center}
		\item Reglas:
			\begin{center}
				\begin{tabular}{cc}
					$ S \rightarrow aS | bS | cX $ \\
					$ X \rightarrow aX | bX | cS | \epsilon $
				\end{tabular}
			\end{center}
		\item Reglas:
			\begin{center}
				\begin{tabular}{cccccc}
					$ S \rightarrow S_1 | S_2 $ \\
					$ S_1 \rightarrow B | BS_1 $ \\
					$ S_2 \rightarrow C | CS_2 $ \\
					$ B \rightarrow bX | cBB | aB $ \\
					$ C \rightarrow cX | bCC | aC $ \\
					$ X \rightarrow bC | aX | cB | \epsilon $
				\end{tabular}
			\end{center}
	\end{enumerate}
\end{sol}

\begin{ejer}
% Cambiar lista
	Encontrar las gramáticas:
	\begin{enumerate}
		\item Dado el alfabeto $A = \{ a,b \} $ determinar si es posible encontrar una gramática libre de contexto que genere las palabras de longitud impar, y mayor o igual que 3, tales que la primera letra coincida con la letra central de la palabra.

		\item Dado el alfabeto $A = \{ a,b \} $ determinar si es posible encontrar una gramática libre de contexto que genere las palabras de longitud par, y mayor o igual que 2, tales que las dos letras centrales coincidan.

	\end{enumerate}
\end{ejer}

\begin{sol}
	Gramáticas de tipo 2.
	\begin{enumerate}
		\item Reglas:
		\begin{center}
			\begin{tabular}{cccc}
				$ S \rightarrow aAX | bBX $ \\
				$ A \rightarrow a | XAX $ \\
				$ B \rightarrow b | XBX $ \\
				$ X \rightarrow a | b $
			\end{tabular}
		\end{center}
		\item Reglas:
		\begin{center}
			\begin{tabular}{cc}
				$ S \rightarrow aa | bb | XSX $ \\
				$ X \rightarrow a | b $
			\end{tabular}
		\end{center}
	\end{enumerate}
\end{sol}

\begin{ejer}
	Determinar si el lenguaje generado por la gramática
	\begin{center}
		\begin{tabular}{ccc}
			$ S \rightarrow SS $ \\
			$ S \rightarrow XXX $ \\
			$ X \rightarrow aX | Xa | b $
		\end{tabular}
	\end{center}
	es regular. Justificar la respuesta.
\end{ejer}

\begin{sol}
	Obtenemos el lenguaje que es: $ L(G) = \{ u \in {\{ a,b \}}^{*} : N_b(u) = 3k, k \in \mathbb{N} \} \equiv $ Palabras que contienen b un número múltiplo de 3. Con memoria finita podemos reconocer si hay un número múltiplo de b (cada 3), luego debemos encontrar una gramática de tipo 3 (regular):

	\begin{center}
		\begin{tabular}{cccc}
			$ S \rightarrow aS | bS_1 $ \\
			$ S_1 \rightarrow aS_1 | bS_2 $ \\
			$ S_2 \rightarrow aS_2 | bS_3 $\\
			$ S_3 \rightarrow aS_3 | bS_1 | \epsilon $
		\end{tabular}
	\end{center}
\end{sol}

\begin{ejer}
	Dado un lenguaje $L$ sobre un alfabeto $A$, caracterizar cuando $L^* = L$
\end{ejer}

\begin{sol}
	$L$ tiene que cumplir: $\epsilon \in L$ y que L sea submonoide.
	L es submonoide si: $u,v \in L \rightarrow uv \in L$
\end{sol}

\begin{ejer}
	Dado un lenguaje $L$ sobre un alfabeto $A$, determinar si $L^*$ es siempre, nunca o a veces numerable.
\end{ejer}

\begin{sol}
	L* es siempre numerable porque A* es numerable (visto en clase) y L* está contenido en A*.
\end{sol}

\begin{ejer}
	Dados dos homomorfismos $f:A^* \rightarrow B^*, g:A^* \rightarrow B^*$, se dicen que son iguales si $f(x)=g(x), \forall x \in A^{*}$. ¿Existe un procedimiento algorítmico para comprobar si dos homomorfismos son iguales?
\end{ejer}

\begin{sol}

\end{sol}

\begin{ejer}
	Sea $L \subseteq A^*$ un lenguaje arbitrario. Sea $C_0 = L$ y definamos los lenguajes $S_i$ y $C_i$, para todo $i\geq1$, por $S_i = C^{+}_{i-1}$ y $C_{i} = \overline{S_i}$
	\begin{enumerate}
		\item ¿Es $S_i$ siempre, nunca o a veces igual a $C_2$? Justifica la respuesta.
		\item Demostrar que $S_2 = C_3 $, cualquiera que sea $L$. (Pista: Demuestra que $C_3$ es cerrado para la concateación).
	\end{enumerate}
\end{ejer}

\begin{sol}

\end{sol}

\begin{ejer}
	Demuestra que para todo alfabeto $A$, el conjunto de los lenguajes finitos sobre dicho alfabeto es numerable.
\end{ejer}

\begin{sol}

\end{sol}

\begin{ejer}
	Dada la gramática $G = (\{S,A\},\{a,b\},P,S)$ donde $P = \{ S \rightarrow abAS,abA \rightarrow baab, S \rightarrow a, A \rightarrow b \}.$ Determinar el lenguaje que genera.
\end{ejer}

\begin{sol}

\end{sol}

\begin{ejer}
	Sea la gramática $G=(V,T,P,S)$ donde:
		\begin{itemize}
			\item $V = \{ <numero>,<digito>\}$
			\item $T = \{0,1,2,3,4,5,6,7,8,9\}$
			\item $S = <numero>$
			\item Las reglas de producción $P$ son:
				\begin{itemize}
					\item $<numero>\rightarrow <numero><digito> $
					\item $<numero>\rightarrow <digito> $
					\item $<digito>\rightarrow 0|1|2|3|4|5|6|7|8|9 $
				\end{itemize}
		\end{itemize}
	Determinar el lenguaje que genera.
\end{ejer}

\begin{sol}

\end{sol}

\begin{ejer}
	Sea la gramática $G = (\{A,S\},\{a,b\},S,P)$ donde las reglas de producción son:
	 	\begin{center}
			\begin{tabular}{cccc}
				$ S \rightarrow aS $ \\
				$ S \rightarrow aA $ \\
				$ A \rightarrow bA $ \\
				$ A \rightarrow b $
			\end{tabular}
		\end{center}
	Determinar el lenguaje generado por la gramática.
\end{ejer}

\begin{sol}

\end{sol}
