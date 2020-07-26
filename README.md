# Práctica Virtual

Este repositorio contiene una guía introductoria de ejercicios para la materia
Organización del Computador 2.

La idea de esta práctica es familiarizar al estudiante con el uso de las
herramientas básicas usadas en la materia.


## Cómo interactuar con la guía.

El repositorio se encuentra dividido en carpetas numeradas, cada carpeta
contiene un ejercicio en el que se presentan uno o varios temas nuevos.

En cada carpeta se encuentra un archivo llamado `README.md` que contiene el
enunciado del ejercicio. Algunos ejercicios cuentan con una solución en la
carpeta `solucion`. Es recomendable que luego de resolver el ejercicio se revise
la solución propuesta para complementar lo aprendido.

Muchos ejercicios cuentan con programas pre-escritos que se deben poner en
archivos. **Es importante que estos programas se tipeen nuevamente y no sean
simplemente copiados**, de esta forma se logra un mejor entendimiento de lo que
se está haciendo.

En varios enunciados, veremos texto de la siguiente forma:

```shell
$ comando
```

Eso significa que se espera que ejecuten el comando en una terminal de linux.

## Dónde encontrar ayuda.

### Bibliografía.

Tanto Intel como AMD proveen manuales de referencia sobre las instrucciones y la
arquitectura de sus procesadores. La web https://cpu.fyi contiene hipervínculos
para acceder a cada uno de los manuales.

Para esta guía será de especial importancia el volumen 2 de los manuales de
intel. El mismo cuenta con una descripción de cada instrucción soportada por el
procesador.

Otra bibliografía que puede ser de utilidad:

* [ABI System V para `x86_64`][system-v-abi].

* [El manual de nasm][nasm-manual].

### `manpages`

A lo largo de los ejercicios mencionaremos varios programas y funciones. Linux
provee manuales de referencia que puede consultar usando el comando `man`.

```shell
$ man cat
```

Mostrará el manual del programa `cat`.


Los manuales de referencia contienen varias secciones, es posible acceder a una
sección particular anteponiendo el número de sección al manual que intenta
acceder.  Por ejemplo `man 2 write` brindará información sobre la llamada a
sistema `write` mientras que `man 3 printf` mostrará información sobre la
función `printf` de la librería estándar de C.

Si no se está seguro en qué manual buscar información, puede usar el comando
`apropos`, que le va a indicar todas las páginas de manuales que contienen una
palabra clave dada.

Para más información, consulte el manual de man, usando `man man`.

### Invocación de programas.

Muchos programas permiten ser invocados con parámetros del estilo `--help` o
`-h` que muestran ayuda sobre cómo deben ser usados.

## Pre requisitos.

Esta guía asume que se está utilizando el sistema operativo Linux.

Debemos instalar los siguientes programas:

```shell
$ sudo apt install nasm gdb build-essential valgrind git
```

[system-v-abi]: https://uclibc.org/docs/psABI-x86_64.pdf
[nasm-manual]: https://www.nasm.us/doc/nasmdoc0.html
