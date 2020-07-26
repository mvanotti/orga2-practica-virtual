# Ejercicio 1: Hola Mundo

En este ejercicio vamos a crear un programa que imprima "hola mundo" por
pantalla en lenguaje ensamblador.  El objetivo es aprender un poco a escribir y
compilar programas con `nasm`.

Crear un archivo llamado `hola_mundo.s` con el siguiente contenido:

```asm
section .rodata

mensaje: db 'hola, mundo', 10, 0
msglen: equ $ - mensaje

section .text

global _start

%define SYS_write 1
%define SYS_exit 60
%define FD_stdout 1

_start:
  mov rax, SYS_write
  mov rdi, FD_stdout
  mov rsi, mensaje
  mov rdx, msglen
  syscall
  
  mov rax, SYS_exit
  xor rdi, rdi
  syscall
```

Compilarlo en un archivo objeto usando `nasm`:

```shell
$ nasm -f elf64 -g -F DWARF hola_mundo.s -o hola_mundo.o
```

Este comando invoca el programa ensamblador `nasm`, y le indica que genere un
archivo objeto en formato `elf` de 64 bits. El resto de los parametros le
indican que agregue, además, símbolos de debug en formato `DWARF`.

Y luego linkearlo usando `ld`:

```shell
$ ld -z noexecstack hola_mundo.o -o hola_mundo
```

El proceso de linkeo toma uno o varios archivos objeto y genera un archivo
ejecutable (también puede generar una biblioteca  o incluso otros archivo
objeto). El parámetro `-z noexecstack` sirve para indicar que las secciones
`.data`, `.rodata` y el stack del programa, entre otras, no deben ser mapeadas
como ejecutables.

Finalmente, ejecutémoslo:

```shell
$ ./hola_mundo
hola, mundo
```

En la carpeta `solucion`, podrán encontrar una versión del código fuente con
explicaciones detalladas sobre cada parte del programa, además, hay un
archivo `Makefile` para automatizar el proceso de compilación. Puede
compilarlo usando el comando `make` estando dentro de la carpeta `solucion`

## Ejercicios

* Modificar el programa para que en lugar de decir «hola, mundo» imprima su
  nombre. ¿Hace falta cambiar el cálculo de la longitud del mensaje?

* Buscar en el manual de referencia del procesador la instrucción `xor`. ¿qué
  flags afecta?

* Cambiar el parámetro de `exit` por `-1`, ¿cómo puede verificar el código de
  salida en Linux?

* ¿Qué cree que debería ocurrir si pone la definición del mensaje dentro de la
  sección `.text`?

  + Use el programa `nm` para ver en qué sección se encuentra cada símbolo.

* ¿Qué cree que debería ocurrir si pone la definición de la función `_start`
  dentro de la sección `.rodata`?
