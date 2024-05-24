; asmsyntax=nasm
global _k_entry

global k_halt
global k_stop
extern k_main

MULTIBOOT_MAGIC     equ 0x1BADB002

MULTIBOOT_PAGEALIGN equ 1
MULTIBOOT_MEMINFO   equ 1<<1

MULTIBOOT_FLAGS     equ MULTIBOOT_PAGEALIGN | MULTIBOOT_MEMINFO

MULTIBOOT_CHECKSUM  equ -(MULTIBOOT_MAGIC+MULTIBOOT_FLAGS)

KERNEL_STACK_SIZE   equ 0x4000

section .text
align 4

    ; Multiboot header

    dd MULTIBOOT_MAGIC
    dd MULTIBOOT_FLAGS
    dd MULTIBOOT_CHECKSUM

    _k_entry:
        mov esp, stack+KERNEL_STACK_SIZE

        push ebx ; Multiboot structure
        push eax ; Multiboot magic value

        call k_main

        k_halt:
            hlt
            jmp k_halt

        k_stop:
            cli
            hlt
            jmp k_stop

section .bss
align 4
    stack:
        resb KERNEL_STACK_SIZE

