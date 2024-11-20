/* linker.ld */
ENTRY(start)
SECTIONS {
    . = 0x7C00;
    .text : {
        *(.boot)
        *(.text)
    }
    .data : {
        *(.data)
    }
    .bss : {
        *(.bss)
    }
}