#include "pulp_io.h"

void set_flls() {
  #ifdef FLL_DRIVER
  unsigned int freq_all = 200 * 1000000;
  pi_fll_init_all();
  * ( ( int * ) 0x1a100030 ) = 0x104321;
  pi_freq_set(PI_FREQ_DOMAIN_ALL, freq_all);
  #else
  int data;
  int addr;

  // set clk_div to 2 for clk[2:0]
  addr = 0x1A10002C;
  data = 0x00020202;
  pulp_write32(addr, data);

  // set up fll 0 to output 200MHz
  addr = 0x1A100010;
  data = 0x25C350;
  pulp_write32(addr, data);

  // enable fll 0
  addr = 0x1A100030;
  data = 0x11;
  pulp_write32(addr, data);

  // put fll 0 to open loop
  addr = 0x1A10000C;
  data = 0x40030A73;
  pulp_write32(addr, data);

  // put ffl output clock to every clock
  addr = 0x1A100030;
  data = 0x1111;
  pulp_write32(addr, data);
  #endif
}