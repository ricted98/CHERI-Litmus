// Code specific to the rocket-chip platform

#include "util.h"
#include "uart.h"
#include "platform.h"

// =========
// DRAM Base
// =========

char const* HEAP_BASE = (char const*) 0x80001000;

// ==============
// Console output
// ==============

void put_char(char c)
{
  uart_sendchar(c);
}

void plat_exit(int code)
{
  // Write to to_host
  pulp_write32(TO_HOST, (code << 1) | 1);
  asm volatile ("fence");
}

void plat_init_uart()
{
  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
}
