; asmsyntax=nasm
global _load_idt
_load_idt:
    mov eax, [esp+4]
    lidt [eax]

    ret

