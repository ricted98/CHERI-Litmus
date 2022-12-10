HARTID=0xf14
TO_HOST=0x7c0

  # Get hardware thread id
  csrr a0, HARTID

  # Set stack pointer to DRAM_TOP - (id * 2K)
  la sp, DRAM_TOP
  sll a0, a0, 13
  sub sp, sp, a0

  # Allocate 32 bytes of stack space
  add sp, sp, -32

  # Jump-and-link to main
  jal main

  j .
