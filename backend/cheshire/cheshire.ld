OUTPUT_ARCH( "riscv" )

BOOT_MEM  = 0x80000000;
DRAM_BASE = 0x80000000;
DRAM_TOP  = 0x80010000;

SECTIONS
{
  . = BOOT_MEM;

  .text   : { *.o(.text) }
  .bss    : { *.o(.bss) }
  .data   : { *.o(.data) }
  .rodata : { *.o(.rodata*) }
}
