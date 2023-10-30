#############################################################################
# File name:  Makefile
# Author:     chadd williams
# Date:       Sept 1, 2021
# Class:      CS360
# Assignment: 
# Purpose:    
#############################################################################

CC=gcc
CFLAGS=-g -Wall
VALGRIND_FLAGS=-v --leak-check=yes --track-origins=yes --leak-check=full --show-leak-kinds=all
ENSCRIPT_FLAGS=-C -T 2 -p - -M Letter -Ec --color -fCourier8

# -g  include debug symbols in the executable so that the code can be
# 		run through the debugger effectively
#
# -Wall	show all warnings from gcc

.PHONY: clean

# TARGETS is used below to hold the name of all the executables
# built by this Makefile.  This allows us to add the executable name
# in one place and have both all and clean updated. 

# Note that the list is spanning two lines.  The \ character indicates that
# the list continues on the next line.  WARNING: There must be no characters
# other than the newline after the \.  A blank space after the \ gives errors. 

TARGETS=bin/main

all: bin ${TARGETS}

bin:
	mkdir -p bin

# Automatically generate rules
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
bin/%: bin/%.o
	gcc -o $@ -g -Wall $^

bin/%.o: src/%.c
	gcc -c -o $@ -g -Wall $<


# Custom rules
# bin/helloworld: bin/helloworld.o 
# 	${CC} ${CFLAGS} -o bin/functionPointers bin/functionPointers.o 
	
# bin/helloworld.o: src/helloworld.c
# 	${CC} ${CFLAGS} -o bin/helloworld.o -c src/helloworld.c

clean:
	rm -rf bin/*.o ${TARGETS} bin/*.pdf

printAll:
	enscript ${ENSCRIPT_FLAGS} src/main.c  | ps2pdf - bin/main.pdf

valgrind: bin/main
	valgrind ${VALGRIND_FLAGS} bin/main

# https://www.gnu.org/software/make/manual/html_node/Chained-Rules.html
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
.PRECIOUS: bin/%.o
