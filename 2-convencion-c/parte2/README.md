# Ejercicio 2: Convención C

## Parte 2: C -> ASM

En este ejercicio vamos a llamar a código escrito en assembler desde una función
escrita en C. Para ello vamos a tener que respetar la «convención de llamadas»
utilizada en Linux. Esta convención es parte de la «Application Binary
Interface» (ABI), y nos especifica, entre otras cosas, cómo es el proceso de
pasaje de parametros e invocación de funciones a bajo nivel.

Empecemos reusando nuestra función que imprime por pantalla del ejercicio
anterior, aunque esta vez pongamosle un nombre distinto a la función, ya que
`_start` va a ser usado por nuestro programa en C.

Crear un archivo llamado `hola_mundo.s` con el siguiente contenido:

```asm
section .rodata

mensaje: db 'hola, mundo', 10, 0
msglen: equ $ - mensaje

section .text

global hola_mundo

%define SYS_write 1
%define SYS_exit 60
%define FD_stdout 1

hola_mundo:
  mov rax, SYS_write
  mov rdi, FD_stdout
  mov rsi, mensaje
  mov rdx, msglen
  syscall
  
  mov rax, SYS_exit
  xor rdi, rdi
  syscall
```

Este código nos exporta un símbolo llamado `hola_mundo` cuyo valor será la
dirección de la función que queremos ejecutar. La función no toma ni devuelve
ningún parámetro, así que su prototipo es: `void hola_mundo(void)`.

Crear un archivo llamado `main.c` con el siguiente contenido:

```c
extern void hola_mundo(void);

int main(void) {
  hola_mundo();
  return 0;
}
```

Compilar cada archivo en un archivo objeto distinto:

```shell
$ nasm -f elf64 -g -F DWARF hola_mundo.s -o hola_mundo.o
$ gcc -Wall -Wextra -std=c99 -ggdb -c main.c -o main.o
```

Los parámetros que usamos para gcc aquí son los siguientes:

* `-Wall` habilita casi todas las advertencias del compilador.

* `-Wextra` habilita aún más advertencias.

* `-std=c99` indica que nuestro código está programado siguiendo la versión c99 del lenguaje C.

* `-ggdb` agrega símbolos de depuración compatibles con `gdb`.

* `-c` en lugar de generar un programa, generar un archivo objeto.

Y luego linkear todo junto:

```shell
$ gcc -no-pie main.o hola_mundo.o -o main
```

Esta vez usaremos `gcc` para linkear ya que queremos que se linkee el entorno de ejecución de C. Se puede usar `ld` también, pero requiere especificar más parámetros.

Ejecutar el programa:

```shell
$ ./main
hola, mundo
```

La parte fundamental para que esto funcione es cómo declaramos a la función
`hola_mundo` en C: le dijimos al compilador que existe una función en otra [unidad de compilación][translation-unit] que no toma parametros y no retorna nada. Esto le permite a gcc generar el código necesario para llamar a la función.

```C-ObjDump
./main:     file format elf64-x86-64

Disassembly of section .init:
Disassembly of section .text:

0000000000401106 <main>:
extern void hola_mundo(void);

int main(void) {
  401106:	f3 0f 1e fa          	endbr64 
  40110a:	55                   	push   rbp
  40110b:	48 89 e5             	mov    rbp,rsp
  hola_mundo();
  40110e:	e8 0d 00 00 00       	call   401120 <hola_mundo>
  return 0;
  401113:	b8 00 00 00 00       	mov    eax,0x0
}
  401118:	5d                   	pop    rbp
  401119:	c3                   	ret    

Disassembly of section .fini:
```

```
call   401120 <hola_mundo>
```

Como `hola_mundo` no recibe parámetros, no hace falta que gcc emita código para ello, por lo cual, en este caso, alcanza con emitir una simple instrucción `call`.

La instrucción `call` pone en el tope del stack la dirección donde comienza la instrucción siguiente al `call` (en este caso, `mov eax, 0x0`) y transfiere la ejecución a la función que se encuentra en la dirección correspondiente a su operando (en este caso, 0x401120, donde se encuentra la función `hola_mundo`).

En nuestro caso, la función `hola_mundo` termina la ejecución del programa, pero hipotéticamente, en el caso de retornar, lo siguiente a ejecutar sería el `return 0;`. 

### Ejercicios

* Modificar la declaración de la función `hola_mundo` en main.c para que tome como
  parámetro el código de error que recibirá `exit`. Compile. ¿Sigue funcionando el
  programa? Use `objdump` para analizar el nuevo código generado por el
  compilador.

* Modificar la definición de la función `hola_mundo` en `hola_mundo.s` para que use
  el parámetro del ejercicio anterior al llamar a `exit`.

* Modificar el programa para que la función en C le pase el mensaje a imprimir y
  la longitud a la función `hola_mundo` y ésta los imprima.

[translation-unit]: https://en.wikipedia.org/wiki/Translation_unit_(programming)
