# Instrucciones en Ensamblador


__push:__ Decrementa el puntero de pila (ESP) el número de posiciones de memoria que ocupe el dato a insertar, posteriormente procede a escribir el dato en esas posiciones reservadas, a partir de donde apunta ESP ahora

    push %edx

__pop:__ Lee el tope de la pila, guardando el valor de esa dirección donde indique el argumento, posteriormente incrementa el puntero de pila (ESP)

    pop %edx

__call:__ Guarda la dirección de retorno en la pila antes de saltar a la subrutina indicada como argumento

    call suma     (llama a la subrutina etiquetada como "suma")

__ret:__ Recupera de la pila la dirección de retorno

    ret

__mov:__ Mueve el src al dest

    mov $0,%eax

__add:__ Suma al registro de destino el src

    add (%ebx,%ebx,4),%eax

    (Con el formato (%ebx,%edx,4) %ebx es el registro base, al cual se le suma el contenido de %edx, multiplicado por 4 y se añade en %eax)

__inc:__ Incrementa en una unidad el registro indicando

    add %edx

__cmp:__ Compara el contenido de dos registros __TODO: ¿Dónde guarda la información de la comparación?__


__CORRIJAN: TODO: FIXME: jne:__ Salta a la subrutina indicada por la etiquetada si
