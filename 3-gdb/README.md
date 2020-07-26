# Ejercicio 3: GDB

## Parte 1: Depurando código en C.

Se le pide al estudiante que compile y ejecute un programa en C relativamente
sencillo (pide un número y si el número es distinto de 161 falla). El programa
falla. Se guía al estudiante en el proceso de depuración del programa,
comenzando por imprimir la pila de llamadas, establecer breakpoints y
watchpoints, step, next, finish, ver el contenido de variables, analizar el
contenido de memoria, listar código de fuente, hasta entender por qué falla el
programa. Se detalla cómo consultar la ayuda.

### Ejercicios

* Utilizar el comando `x` para imprimir el contenido del arreglo foo, agrupados
  de a 1, 2, 4 y 8 bytes, en hexadecimal.

* Utilizar el comando `x` para imprimir las primeras 10 instrucciones de la
  función `main`.

* Utilizar la instrucción `disasm` para desensamblar la función `main`.

* Establecer 3 breakpoints en distintos lugares del programa. Listarlos
  con info break. Deshabilitar el segundo breakpoint.

* Establecer un breakpoint condicional en la función `bar`, si el parámetro
  vale 50.

* Cuando se encuentra en el breakpoint de la función anterior, ejecutar en
  gdb:
  `call printf("Puedo llamar funciones de mi programa! %d\n", parametro);`

## Parte 2: Depurando código en ASM.

Se le pide al estudiante que compile y ejecute un programa relativamente
sencillo: un main en C que llama a código en assembler y falla). Al ejecutar el
programa en GDB, se nota que la función que falla está en assembler. Se indican
los comandos de gdb para interactuar en assembler: ver registros, si, ni, print
con casteos.

### Ejercicios

* Poner un breakpoint condicional en la función en assembler que frene si el
  valor de rdi es 50.

* Poner un breakpoint en la función printf e imprimir todos los parámetros
  usando los registros directamente.

* Recorrer una lista enlazada usando p y casteos.
