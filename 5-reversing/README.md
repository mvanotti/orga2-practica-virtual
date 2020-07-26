# Ejercicio 5: Reversing

### Ejercicios

El último ejercicio contiene varios problemas integradores con una dificultad
incremental, en donde el usuario no tiene acceso al código de fuente. Solo a los
binarios. El objetivo es que utilice los conceptos anteriores para resolver los
problemas. A continuación se listan algunas ideas de ejercicios, pero se puede
seguir expandiendo.

* El primer programa se resuelve usando objdump para desensamblar el código del
  programa y encontrar la entrada necesaria para que el texto "Ganaste".

* El segundo programa contiene una lógica un poco más rebuscada que el ejercicio
  anterior, y se puede resolver siguiendo el código con gdb (se tienen símbolos
  de depuración).

* El tercer programa es similar al anterior, pero no se tienen símbolos de
  depuración.

* El cuarto programa contiene una corrupción de memoria de tipo buffer overrun.
  Con gdb es posible que sea difícil darse cuenta de cuál es el problema, pero
  al ejecutarlo con valgrind se nota dónde está el problema.
