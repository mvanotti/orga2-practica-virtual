# Ejercicio 2: Convención C

## Parte 1: C básico

En este ejercicio vamos a compilar un programa puramente en C, tratando de entender el código que emite el compilador.

Crear un archivo llamado `main.c` con el siguiente contenido:

```c
#include <stdio.h>

int main(void) {
  puts("Hola, Mundo");
  return 0;
}
```

Para compilarlo vamos a usar `gcc`:

```shell
$ gcc -Wall -Wextra -std=c99 -no-pie -ggdb main.c -o main
```

```shell
$ ./main
Hola, Mundo
```

Nos gustaría ver el assembler generado por el compilador. Podemos usar el
programa `objdump` para ello, invocándolo con los siguientes parámetros:


* `--disassemble=main` para densensamblar el contenido apuntado por el simbolo
 `main`.

* `-Mintel` especifica que queremos que use sintaxis Intel para desensamblar.

* `-S` indica que queremos que trate de interponer el código fuente del programa
  junto con las instrucciones en ensamblador.

```shell
$ objdump --disassemble=main -Mintel -S ./main
```

**NOTA** El código generado depende de la versión del compilador usado. Es posible
que en su computadora se genere código distinto. Interpretar lo que sigue
como una guia.

```C-ObjDump
main:     file format elf64-x86-64

Disassembly of section .text:

0000000000401136 <main>:
#include <stdio.h>

int main(void) {
  401136:	f3 0f 1e fa          	endbr64 
  40113a:	55                   	push   rbp
  40113b:	48 89 e5             	mov    rbp,rsp
  puts("Hola, Mundo");
  40113e:	48 8d 3d bf 0e 00 00 	lea    rdi,[rip+0xebf]        # 402004 <_IO_stdin_used+0x4>
  401145:	e8 f6 fe ff ff       	call   401040 <puts@plt>
  return 0;
  40114a:	b8 00 00 00 00       	mov    eax,0x0
}
  40114f:	5d                   	pop    rbp
  401150:	c3                   	ret    
```

Podemos ver que dentro de la sección `.text` está definido el símbolo `main` en
la dirección `0x401136`.

Luego de la definición de `main`, podremos encontrar las instrucciones que la
componen, cada linea indica una instrucción, del lado izquierdo podemos ver la
dirección de memoria donde comienza la instrucción, seguida de la codificación
binaria de la instrucción y el mnemónico que usaríamos para programarla.

El prólogo de la función incluye 3 instrucciones:

```asm
endbr64 ; Esta instrucción puede ser ignorada por ahora.
push rbp
mov rbp, rsp
```

Encargadas de armar el *«marco de pila»* (*stack frame*) de la función. El
registro `rbp` se suele usar para apuntar a la base del marco de pila actual.

Al hacer `push rbp`, se pone en el tope de la pila la dirección de la base de la
pila, y al hacer `mov rbp, rsp` se setea como nueva base de la pila la dirección
tope del stack actual.

Al finalizar la función, la base de la pila será restaurada mediante una
instrucción `pop`.

Luego vemos que hay una llamada a `puts("Hola, Mundo")`. `puts` toma un único
parámetro que es la dirección de memoria de un string de C que se desea imprimir
por pantalla. En este caso, el registro `rdi` será usado para pasar ese
parámetro.

La instrucción `lea rdi, [rip + 0xebf]` pone en el registro `rdi` el valor
`rip + 0xebf`. `rip` es un registro que contiene la dirección de la próxima
instrucción a ejecutar.

El compilador sabe en qué parte del programa se encuentra el string, y
calcula el desplazamiento relativo a la dirección de la instrucción que se
está ejecutando.

`rdi` entonces tiene como valor la dirección donde comienza el string
"Hola, Mundo".

Luego de eso, hay una instrucción `call   401040 <puts@plt>`, que se encarga
de llamar a la función `puts` de la librería C, pasando como parámetro
la dirección en memoria donde comienza el string "Hola, Mundo".

La siguiente instrucción `mov eax, 0`, se ejecutará al retornar de la
función `puts`, y corresponde con el `return 0`. Cuando una función devuelve
un entero, lo pone en el registro `eax`.

Finalmente, el epílogo de la función se encarga de desarmar el marco de la
pila haciendo `pop rbp` (recordemos que en el prólogo se había realizado un
`push rbp`), y luego se retorna el control a la función que llamó a `main`,
mediante la instrucción `ret`.

### Ejercicios

* Agregar una variable local a la función `main` de tipo entero, con el valor
  `5`. Imprimirla usando `printf`. User `objump` para desensamblar `main`.
  ¿Dónde se almacena la variable? ¿Dónde se inicializa?

* Agregar una función al programa que tome como parámetro un número entero y
  retorne ese número más 521. Usar `objdump` para desensamblar esa función.
  Identificar prólogo y epílogos de la función, identificar qué instrucciones se
  usan para realizar la suma. ¿Se almacenan variables en la pila?
