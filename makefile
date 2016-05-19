
CC = gcc

EXECNAME = algebric

LIBLDIR=
#include
INCLUDE= 

#flags
CFLAGS= 

all: algebric

y.tab.c: algebric_cc.l
	flex algebric_cc.l

lex.yy.c: algebric_cc.y y.tab.c
	yacc -d -v algebric_cc.y

algebric: y.tab.c lex.yy.c
	$(CC) -o $(EXECNAME) $(INCLUDE) $(CFLAGS) y.tab.c 

clean:
	rm  *.o y.tab.c y.output y.tab.h lex.yy.c algebric
