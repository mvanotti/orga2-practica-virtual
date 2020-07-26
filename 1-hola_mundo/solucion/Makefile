# Este es un archivo Makefile. make es una herramienta que permite automatizar
# el proceso de compilacion de proyectos.  Este archivo define las relaciones
# que hay entre los archivos y programas que queremos compilar.

# make utiliza reglas para determinar que compilar y cuando.  las reglas suelen
# tener el siguiente formato:
# <objetivo>: <pre-requisitos>
#		receta
#		...
#
# <objetivo> suele ser una de dos cosas:
#
# * Un archivo que querramos generar
#   (por ejemplo, los archivos objeto ".o" o el programa "hola_mundo")
# * Acciones que querramos llevar a cabo
#   (por ejemplo, "all" que compila "hola_mundo", 
#   o "clean" que borra todo lo que compilamos).
#
# <pre-requisitos> es una lista de archivos/objetivos que se necesitan para poder
# realizar la <receta> y lograr el <objetivo>. Una regla puede no tener
# pre-requisitos.
#
# <receta> es una accion que make ejecuta. Suele ser un comando (por ejemplo,
# user gcc para compilar los archivos de <pre-requisitos> y generar el archivo
# <objetivo>. Notar que es importante que cada linea de receta debe comenzar por
# un caracter de tabulacion ('\t'), no espacios.
#
# Cuando hacemos 'make <objetivo>', make busca en el Makefile que reglas
# necesita usar para poder cumplir con el objetivo, y asi como tambien todos los
# pre-requisitos, y lleva a cabo todas las recetas necesarias.

# Estas lineas definen variables que van a ser usadas luego en el Makefile.
LD=ld
LDFLAGS=-z noexecstack
AS=nasm
ASFLAGS=-f elf64 -g -F DWARF

# La primer regla del makefile se invoca cuando hacemos 'make' a secas.
# Esto causa que al invocar a 'make' o 'make all' se compile automaticamente
# el programa 'hola_mundo'
all: hola_mundo

# Para satisfacer cualquier regla que termine en .o, vamos a necesitar
# un prerequisito similar pero que termine en .s.
# La regla se satisface invocando el ensamblador para generar el .o.
# $@ y $< son variables automaticas que se substituyen por el nombre
# del archivo objetivo y el nombre del archivo fuente, respectivamente.
%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

# Notar que en esta regla hicimos uso extenso de variables (tanto definidas por
# nosotros como automaticas). La misma regla, para este Makefile, se podria
# escribir como:

# hola_mundo.o: hola_mundo.s
#		nasm -f elf64 -g -F DWARF hola_mundo.s -o hola_mundo.o


# Para generar el programa hola_mundo, vamos a necesitar del archivo
# objeto hola_mundo.o. Una vez satisfecho eso, cumplimos la regla
# hola_mundo invocando al linker para que genere el programa hola_mundo.
hola_mundo: hola_mundo.o
	$(LD) $(LDFLAGS) -o $@ $<

clean:
	rm -f hola_mundo hola_mundo.o 
