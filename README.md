# cva6-litmus

This is a lightweight clone of the [Litmus Tool](http://diy.inria.fr/)
for running litmus tests (tiny concurrent programs) on bare-metal
hardware, i.e. with no OS or POSIX implementation required.  

It lets us run litmus tests earlier in the design process, on hardware
that isn't yet capable of booting an OS.  It also allows litmus tests
to run on an RTL simulator in reasonable time, simplifying debugging.

On the downside, the random perturbations due to OS background
activities, which can affect the observable behaviours, are no
longer present.

cva6-litmus currently supports one architecture:

1. [CVA6](https://github.com/openhwgroup/cva6) (RISCV ISA).

## Directory layout

  * *backend*: the infrastructure to run a generic litmus test

  * *frontend*: convert litmus files into C which when compiled with the
    backend produce an executable.

  * *tests*: sets of litmus files produced by the
    [diy tool](http://diy.inria.fr/)(https://github.com/litmus-tests/litmus-tests-riscv).

  * *model-results*: results allowed by the RISCV consistency model produced by
    [diy tool](http://diy.inria.fr/)

  * *binaries*: the make script here takes a path to a set of litmus
    files and produces a set of binaries.

  * *ci*: useful bash script.



## Instructions

To build the frontend (which converts litmus files to C files), type
`./make.sh` in the `frontend` directory.  The dependencies for
building the frontend are:

  * `sudo apt-get install ghc`

  * `sudo apt-get install haskell-platform`

To generate bare-metal binaries:

  * set the cross compile toolchain in ./backend/make-riscv.sh

  * type `./make-riscv.sh ../tests/`
    in the `binaries` directory.

The tests are standlone, requiring no input, and emit information
about whether the behaviour described by the test is observed or not.

To merge all results in a single text file:

  * specify where to save results ('dest' variable in ci/merge-tests.sh)

  * specify the directory where the output of litmus tests are saved ('source' variable in ci/merge-tests.sh)

  * run ci/merge-tests.sh

To compare the hw results with the model allowed results:

  * install herdtools7 suite (https://diy.inria.fr/sources/index.html)

  * specify where hw and model results are saved ('model_result' and 'hw_result' inside ci/compare_models.sh)

  * run ./ci/compare_model.sh

If you see at the end of the output the line "!!! Warning negative differences in: [...]", the hardware has exhibited some behaviour that the model does not allow. This indicates that the hardware is inconsistent with the RISC-V RVWMO memory model.

You are most likely to see the line "!!! Warning positive differences in: [...]". This indicates that the model allows for more behaviour than was exhibited by the hardware. This is to be expected as implementations are unlikely to be as relaxed as the model permits them to be. In addition, it is possible that the test harness just did not trigger the right conditions for a certain behaviour to be exhibited by the hardware.

