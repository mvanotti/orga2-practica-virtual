; Esto es un archivo en assembler, que utiliza la sintaxis 'intel'.
; Los puntos y coma definen comentarios, similar a // en C.

; Los programas suelen tener areas designadas para distintos propositos,
; llamadas secciones. Las secciones que mas van a usar son:
;  * .text: almacena el codigo del programa.
;  * .data: almacena las variables inicializadas.
;  * .bss: almacena las variables sin inicializar.
;  * .rodata: almacena las variables de solo lectura.
;
; Utilizando la directiva SECTION, le indicamos a nasm que a partir de ahi
; ubique las cosas en la seccion deseada.

; La seccion .rodata de un binario almacena datos de solo lectura.
; Estos no pueden ser modificados por el programa en tiempo de ejecucion.
section .rodata

; A partir de la etiqueta 'mensaje' definimos una tira de bytes que contiene
; los caracteres que nos interesa imprimir en pantalla.
; El operando 'db' define bytes individuales, estos pueden estar separados por
; comas o pueden ser parte de una cadena de caracteres.
; El byte 10 representa el caracter de 'nueva linea'.
mensaje: db 'hola, mundo', 10

; Queremos calcular la longitud de mensaje, para ello, trataremos de
; calcular la cantidad de bytes que hay entre el final del mensaje y el
; principio.
;
; El comando 'EQU' nos permite definir una etiqueta con un valor constante,
; equivalente al valor de la expresion usada como argumento.
;
; Cuando usamos el simbolo '$' en una expresion, hace referencia a la
; posicion del ensamblador al principio de la expresion.
;
; En este caso, msglen va a ser igual a la posicion actual (inmediatamente
; despues de mensaje), menos la posicion donde comienza mensaje.
msglen: equ $ - mensaje

; Notar que el simbolo 'mensaje' tiene como valor la posicion en memoria en
; donde comienza nuestra cadena de texto, mientras que el simbolo 'msglen'
; tiene como valor la longitud de 'mensaje'.

; La seccion .text contiene el codigo de nuestro programa.
section .text

; Definimos _start como un simbolo global, para que el linker pueda verlo.
; El linker usa '_start' como la direccion donde comienzan los programas.
global _start

; Los defines son reemplazos sintacticos. Son utiles para definir constantes.
%define SYS_write 1
%define SYS_exit 60
%define FD_stdout 1

; La etiqueta '_start' nos define un simbolo, esto es similar a definir una
; funcion. Esta etiqueta va a tener como valor la direccion de memoria donde
; comienzan las instrucciones que siguen a continuacion.
_start:

  ; Los programas interactuan con el sistema operativo mediante 'llamadas a
  ; sistema' ('system calls' en ingles). En este programa, vamos a usar dos
  ; llamadas a sistema: una para escribir texto (write), y otra para terminar
  ; el programa (exit).
  ;
  ; Las llamadas a sistema en linux se realizan con la instruccion 'syscall'
  ; En 'rax' se ubica el numero de la llamada a sistema.
  ; Se pasan hasta 6 parametros, usando los registros rdi, rsi, rdx, r10, r8
  ; y r9 (en ese orden). Las syscalls pueden retornar valores en el registro
  ; rax.

  ; La syscall write tiene el siguiente formato:
  ; ssize_t write(int fd, const void* buf, size_t size)
  ; donde fd es un descriptor de archivo, en este caso, usamos el que
  ; corresponde a la salida estandar (1).
  ; buf un puntero a la tira de bytes que queremos escribir.
  ; size es la cantidad de bytes a escribir.
  ; el valor de retorno es la cantidad de bytes escritos.
  mov rax, SYS_write
  mov rdi, FD_stdout
  mov rsi, mensaje
  mov rdx, msglen
  syscall
  
  ; La syscall exit sirve para finalizar el programa actual inmediatamente.
  ; Toma un unico parametro que es el codigo de error que queremos retornar al
  ; programa que nos llamo. 0 en caso de finalizar correctamente.
  mov rax, SYS_exit
  xor rdi, rdi
  syscall
