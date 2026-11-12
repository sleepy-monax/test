KERNEL_VMA = 0xffffffff00000000;

ENTRY(_kstart_phys)

SECTIONS {
    . = KERNEL_VMA + 0x80200000;

    __kernel_start = .;

    .text : AT(ADDR(.text) - KERNEL_VMA) {
        KEEP(*(.text.boot));
        *(.text .text.*);
    }

    _kstart_phys = _kstart - KERNEL_VMA;

    .rodata : AT(ADDR(.rodata) - KERNEL_VMA) ALIGN(4096) {
        *(.rodata .rodata.*);
    }

    .data : AT(ADDR(.data) - KERNEL_VMA) ALIGN(4096) {
        __global_pointer$ = . + 0x800;
        *(.sdata .sdata.* .srodata .srodata.*);
        *(.data .data.*);
    }

    .bss : AT(ADDR(.bss) - KERNEL_VMA) ALIGN(4096) {
        __bss_start = .;
        *(.bss .bss.* .sbss .sbss.*);
        __bss_end = .;
    }

    __kernel_end = .;
}
