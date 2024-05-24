#include "vendor/multiboot.h"

#include "sys/kio.h"

#include "sys/tables/gdt.h"
#include "sys/tables/idt.h"

#include "sys/isr.h"

#include "sys/mm/heap.h"
#include "sys/mm/paging.h"

#include "sys/lib/kint.h"

void k_main(multiboot_uint32_t magic, multiboot_info_t* info)
{
    k_cls();
    k_puts("Kernel initialization...");

    k_puts("- Setting up GDT.");
    init_gdt();
    k_puts("- Done.");

    k_puts("- Setting up IDT.");
    init_idt();
    k_puts("- Done.");

    k_puts("- Initializing ISR handling.");
    init_isr();
    k_puts("- Done.");

    k_puts("- Initializing basic memory management.");
    init_mm();
    k_puts("- Done.");

    k_puts("- Initializing paging.");
    init_paging();
    k_puts("- Done.");

    uintptr_t *ptr = (uintptr_t *) 0xA0000000;
    ptr = 0;
}

