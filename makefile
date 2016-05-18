
CC = gcc-5
GR = yacc
AL = flex

GRNAME = lm.y
EXECNAME = lm
ALNME = lm.l


LIBLDIR=
#include
INCLUDE= 

#flags
CFLAGS= 
GFLAGS = -d -v

lex.yy.c : $(ALNAME)
	$(AL) $(ALNAME)

y.tab.c : $(GRNAME)
	$(GR) $(GFLAGS) $(GRNAME)

lm: lex.yy.c y.tab.c
	$(CC) $(INCLUDE)  $(CFLAGS) -o $(EXECNAME) y.tab.c  

all: lm

.PHONY: clean
clean:
	rm  *.o && rm y.tab.c && rm lex.yy.c && rm lm
