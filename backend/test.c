#include "io.h"
#include "test.h"
#include "arch.h"
#include "rand.h"
#include "heap.h"

// ================
// Global variables
// ================

test_t test;

// =========
// Functions
// =========

void test_init(uint32_t* seed)
{
  //put_string("test_init started\r\n");
  // Randomize variable locations
  uint32_t rs[NUM_VARS];
  for (int i = 0; i < NUM_VARS; i++) {
    retry:
      rs[i] = rand_k(seed, NUM_LOCS - 1);
      for (int j = 0; j < i; j++)
        if (rs[i] == rs[j]) goto retry;
  }
  // Intialise variables
  test.locs = (var_t*) LOCS_BASE;
  for (int i = 0; i < NUM_VARS; i++) {
    test.vars[i] = &test.locs[rs[i]*LOC_GRAIN];
    *test.vars[i] = 0;
  }
  // Set random start delays
  uint32_t max = 0;
  for (int i = 0; i < NUM_PROCESSES; i++)
    if (test.start_times[i] > max) max = test.start_times[i];
  for (int i = 0; i < NUM_PROCESSES; i++){
    test.delays[i] = (max-test.start_times[i])/3; 
    test.delays[i] += rand_k(seed, 50);  
  }

}

inline void delay(int n)
{
  for (int i = 0; i < n; i++)
    asm volatile ("nop\n");
}

// Include the automatically-generated litmus test
#include "testcase.c"
