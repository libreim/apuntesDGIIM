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
