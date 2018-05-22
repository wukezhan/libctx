LIB=libctx.a

ASM=asm.o
OFILES=\
	$(ASM)\
	ctx.o

all: $(LIB)

$(OFILES): ctx.h 386-ucontext.h amd64-ucontext.h mips-ucontext.h power-ucontext.h

AS=gcc -c
CC=gcc
CFLAGS=-Wall -c -I. -ggdb -fPIC

%.o: %.S
	$(AS) $*.S

%.o: %.c
	$(CC) $(CFLAGS) $*.c

$(LIB): $(OFILES)
	ar rvc $(LIB) $(OFILES)

clean:
	rm -f *.o $(LIB)

install: $(LIB)
	cp $(LIB) /usr/local/lib
	cp ctx.h /usr/local/include

build: $(LIB)
	cp $(LIB) ../build/lib
	cp ctx.h ../build/include

