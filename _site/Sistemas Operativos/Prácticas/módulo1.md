# Apuntes

## Módulo 1.

### Archivos _/etc/passwd_ y _/etc/shadow_.

En el archivo __passwd__ encontramos informacion relevante a los usuarios creados en el sistema y cierta información sobre estos de la forma:

_Usuario(Login) : Contraseña : UID : GID : Nombre de usuario : Directorio de trabajo : Intérprete de shell_

En el archivo __shadow__ se encuentran codificadas cada una de las contraseñas de los usuarios que aparecen en __passwd__, de forma que en el archivo passwd aparecerá una x en el campo de contraseña, indicando que esta se encuentra codificada en __shadow__.

### Diferencia entre _fstab_, _mtab_, _filesystems_ y _mounts_.

Los cuatro archivos citazos son archivos FHS que guardan diferente información relevante al mismo tema, la primera diferencia es donde se encuentran los archivos.
1. _fstsab_ y _mtab_ se encuentran en la carpeta _etc_.
2. _filesystem_ y _mounts_ se encuentran en la carpeta _proc_.

La informacion que encontramos en cada uno de estos archivos es:

- __Fstab__: Es una lista de los sistemas de archivos que se inician con el arranque del equipo, con una serie de información sobre cada uno de ellos. Aqui es donde el usuario puede editar información.
- __Mtab__: Es una lista de los sistemas de archivos que se encuentran montados. Este archivo no se edita.
- __Fylesistems__: Es una lista de todos los sistemas de archivos que se encuentran disponibles.
- __Mounts__: Es una lista de todos los sistemas de archivos que se encuentran montados ya sea manualmente o con el arraque del sistema.
