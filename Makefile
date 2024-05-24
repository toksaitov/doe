# Soul OS makefile
#
# Author: Toksaitov Dmitrii Alexandrovich

# Names

BIN_DIR = bin

LOADER = loader
KERNEL = kernel

TEST_RUNNER = test

LINKER_SCRIPT = link

FLOPPY_IMAGE   = $(BIN_DIR)/floppy.img
FLOPPY_PADDING = $(BIN_DIR)/pad

GRUB_LEGACY_STAGES = $(BIN_DIR)/stage1 $(BIN_DIR)/stage2

ASM_SRC = $(LOADER).asm \
	  sys/isr_handler.asm \
	  sys/tables/gdt_handler.asm \
	  sys/tables/idt_handler.asm

C_SRC   = $(KERNEL).c \
	  sys/kio.c \
	  sys/isr.c \
	  sys/pic.c \
	  sys/pit.c \
	  sys/kbd.c \
	  sys/panic.c \
	  sys/display/display.c \
	  sys/tables/gdt.c \
	  sys/tables/idt.c \
	  sys/mm/heap.c \
	  sys/mm/paging.c \
	  sys/lib/kctypes.c \
	  sys/lib/kstd.c \
	  sys/lib/kstring.c

C_TESTS_SRC = $(TEST_RUNNER).c \
	      tests/helper.c

ASM_OBJECTS = $(ASM_SRC:.asm=.o)
C_OBJECTS   = $(C_SRC:.c=.o)

C_TESTS_OBJECTS = $(C_TESTS_SRC:.c=.o)

## System configuration

ASM      = nasm
ASMFLAGS = -f elf -g

CC     = i386-elf-gcc
CFLAGS = -g -Wall -Wextra -ansi -nostdlib -nostartfiles -nodefaultlibs

LD      = i386-elf-ld
LDFLAGS = -T $(LINKER_SCRIPT).ld

## Rules

# General rules

.PHONY : all
all : $(KERNEL)

## Specific rules

# Floppy image creation

.PHONY : floppy
floppy : $(FLOPPY_IMAGE)

$(FLOPPY_IMAGE) : $(GRUB_LEGACY_STAGES) $(FLOPPY_PADDING) $(KERNEL)
	cat $^ > $@

$(FLOPPY_PADDING) :
	dd if=/dev/zero of=$@ bs=1 count=750

# Kernel

$(KERNEL) : $(ASM_OBJECTS) $(C_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

$(ASM_OBJECTS) : %.o : %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

$(C_OBJECTS) : %.o : %.c
	$(CC) $(CFLAGS) -o $@ -c $<

.PHONY : clean
clean :
	rm -f $(ASM_OBJECTS) $(C_OBJECTS) $(KERNEL) $(FLOPPY_IMAGE) $(FLOPPY_PADDING)

