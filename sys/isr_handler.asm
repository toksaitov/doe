; asmsyntax=nasm
%macro ISR_WITHOUT_ERROR_CODE 1
    global isr%1

    isr%1:
        cli
        push byte 0
        push byte %1
        jmp isr_common_handler

%endmacro

%macro ISR_WITH_ERROR_CODE 1
    global isr%1

    isr%1:
        cli
        push byte %1
        jmp isr_common_handler

%endmacro

ISR_WITHOUT_ERROR_CODE 0
ISR_WITHOUT_ERROR_CODE 1
ISR_WITHOUT_ERROR_CODE 2
ISR_WITHOUT_ERROR_CODE 3
ISR_WITHOUT_ERROR_CODE 4
ISR_WITHOUT_ERROR_CODE 5
ISR_WITHOUT_ERROR_CODE 6
ISR_WITHOUT_ERROR_CODE 7

ISR_WITHOUT_ERROR_CODE 9

ISR_WITHOUT_ERROR_CODE 15
ISR_WITHOUT_ERROR_CODE 16

ISR_WITHOUT_ERROR_CODE 18
ISR_WITHOUT_ERROR_CODE 19
ISR_WITHOUT_ERROR_CODE 20
ISR_WITHOUT_ERROR_CODE 21
ISR_WITHOUT_ERROR_CODE 22
ISR_WITHOUT_ERROR_CODE 23
ISR_WITHOUT_ERROR_CODE 24
ISR_WITHOUT_ERROR_CODE 25
ISR_WITHOUT_ERROR_CODE 26
ISR_WITHOUT_ERROR_CODE 27
ISR_WITHOUT_ERROR_CODE 28
ISR_WITHOUT_ERROR_CODE 29
ISR_WITHOUT_ERROR_CODE 30
ISR_WITHOUT_ERROR_CODE 31

ISR_WITH_ERROR_CODE 8

ISR_WITH_ERROR_CODE 10
ISR_WITH_ERROR_CODE 11
ISR_WITH_ERROR_CODE 12
ISR_WITH_ERROR_CODE 13
ISR_WITH_ERROR_CODE 14

ISR_WITHOUT_ERROR_CODE 17

global isr_common_handler
extern _isr_router

isr_common_handler:
    pushad

    mov ax, ds
    push eax

    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call _isr_router

    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    popad
    add esp, 8
    sti

    iret

%macro IRQ 2
    global irq%1

    irq%1:
        cli
        push byte 0
        push byte %2
        jmp irq_common_handler

%endmacro

IRQ 0,  32
IRQ 1,  33
IRQ 2,  34
IRQ 3,  35
IRQ 4,  36
IRQ 5,  37
IRQ 6,  38
IRQ 7,  39
IRQ 8,  40
IRQ 9,  41
IRQ 10, 42
IRQ 11, 43
IRQ 12, 44
IRQ 13, 45
IRQ 14, 46
IRQ 15, 47

global irq_common_handler
extern _irq_router

irq_common_handler:
    pushad

    mov ax, ds
    push eax

    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call _irq_router

    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    popad
    add esp, 8
    sti

    iret

