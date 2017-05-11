
### 18. Supongamos que tenemos un proceso ejecutándose en un sistema páginado, con gestión de memoria basada en el algoritmo de sustitución frecuencia de faltas de página. El proceso tiene 5 páginas ( 0, 1, 2, 3, 4 ). Represente el contenido de la memoria real para ese proceso (es decir, indique que páginas tiene cargadas en cada momento) y cuándo se produce una falta de página. Suponga que, inicialmente, está cargada la página 2, el resto de páginas están en memoria secundaria y que no hay restricciones en cuanto al número de marcos de página disponibles. La cadena de referencias a página es: 0 3 1 1 1 3 4 4 2 2 4 0 0 0 0 3 y el parámetro es T=3.

|   | 0 | 3 | 1 | 1 | 1 | 3 | 4 | 4 | 2 | 2 | 4 | 0 | 0 | 0 | 0 | 3 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | - | - | - | - | - | 0 | 0 | 0 | 0 | 0 |
| 1 |  |  | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 2 | 2 | 2 | 2 | 2 | 2 | 2 | - | - | 2 | 2 | 2 | 2 | 2 | 2 | 2 | 2 |
| 3 |  | 3 | 3 | 3 | 3 | 3 | 3 | 3 | 3 | 3 | 3 | 3 | 3 | 3 | 3 | 3 |
| 4 |  |  |  |  |  |  | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 4 | 4 |
| Falta de pagina  | * | * | * |   |   |   | * |   | * |   |   | * |   |   |   |   |    |


Cuando se da una falta de página se consulta cuanto tiempo ha pasado de la anterior falta de página. Si la diferencia es menor o igual que T se añade la página a las actuales, si es estrictamente mayor, se quedan en cache únicamente las páginas referenciadas entre el instante actual y la anterior falta de página.

### 23. Disponemos de un ordenador que cuenta con las siguientes características: tiene una memoria RAM de 4KBytes, permite usar memoria virtual páginada, las páginas son de 1KBytes de tamaño y las direcciones virtuales son de 16 bits. El primer marco de página (marco 0) se usa únicamente por el Kernel y los demás marcos están disponibles para su uso por los procesos que se ejecutan en el sistema. Supongamos que tenemos sólo dos procesos, P1 y P2, y que utilizan las siguientes direcciones de memoria virtual y en el siguiente orden:
```
Proceso       Direcciones virtuales
P1                  0-99
P2                  0-500
P1                100-500
P2                501-1500
P1               3500-3700
P2               1501-2100
P1                501-600
```

* ***a) ¿Cuántos marcos de página tiene la memoria RAM de este ordenador?***

RAM = 4KB = $2^{12}$ B
Tamaño de página = 1KB = $2^{10}$ B

Marcos de página = $2^{12}$/$2^{10}$ = 4

* ***b) ¿Cuántos bits necesitamos para identificar los marcos de página?***

4 Marcos de página = $2^{2}$

2 bits para identificarlos

* ***c) Describe los fallos de página que tendrán lugar para cada intervalo de ejecución de los procesos, si la política de sustitución de páginas utilizada es LRU. Suponga que dicho algoritmo es de asignación variable y sustitución global.***

***SOLUCIÓN:***
```
Proceso       Direcciones virtuales     PROCESO.PAGINA
P1                  0-99                    1.1
P2                  0-500                   2.1
P1                100-500                   1.1
P2                501-1500              2.1,2.2,2.3
P1               3500-3700                1.7,1.8
P2               1501-2100              2.3,2.4,2.5
P1                501-600                 1.1,1.2
```

***RAM: MO(kernel), M1, M2, M3***

**MX=Marco X**

Sabemos que las páginas tienen tamaño $2^{10}$ B = 1024 B y las direcciones son de 16 bits = 2B. Así pues, 1024/2 = 512 palabras en cada página.
El algoritmo utilizado es el LRU, por lo tanto quitamos de la RAM la primera página que se introdujo.

|                  | 1.1 | 2.1 | 1.1 | 2.1 | 2.2 | 2.3 | 1.7 | 1.8 | 2.3 | 2.4 | 2.5 | 1.1 | 1.2 |
|:----------------:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|        M0        |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |  -  |
|        M1        | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 2.3 | 2.3 | 2.3 | 2.3 | 2.3 | 2.3 | 1.1 | 1.1 |
|        M2        |     | 2.1 | 2.1 | 2.1 | 2.1 | 2.1 | 1.7 | 1.7 | 1.7 | 2.4 | 2.4 | 2.4 | 1.2 |
|        M3        |     |     |     |     | 2.2 | 2.2 | 2.2 | 1.8 | 1.8 | 1.8 | 2.5 | 2.5 | 2.5 |
| Faltas de página |  *  |  *  |     |     |  *  |     |     |     |     |     |     |     |     |
