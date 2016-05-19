
CC = gcc
GR = yacc
AL = flex

GRNAME = algebric_cc.y
EXECNAME = algebric
ALNME = algebric_cc.l


LIBLDIR=
#include
INCLUDE= 

#flags
CFLAGS= 
GFLAGS = -d -v

all: algebric

y.tab.c: $(GRNAME)
	$(AL) $(ALNAME)

lex.yy.c: $(ALNAME)
	$(GR) $(GFLAGS) $(GRNAME)

algebric: lex.yy.c y.tab.c y.tab.h
	$(CC) -o $(EXECNAME) $(INCLUDE) $(CFLAGS) y.tab.c lex.yy.c -lfl

clean:
	rm  *.o && rm y.tab.c && rm lex.yy.c && rm algebric
