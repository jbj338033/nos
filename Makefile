# Makefile for Mac
ASM=nasm
CC=x86_64-elf-gcc
LD=x86_64-elf-ld

ASMFLAGS=-f elf64
CFLAGS=-m64 -ffreestanding -fno-stack-protector -fno-pie -no-pie -c
LDFLAGS=-T linker.ld

all: os.img

boot.o: boot.asm
	$(ASM) $(ASMFLAGS) boot.asm -o boot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) kernel.c -o kernel.o

os.img: boot.o kernel.o
	$(LD) $(LDFLAGS) -o os.img boot.o kernel.o

clean:
	rm -f *.o os.img