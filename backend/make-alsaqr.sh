PLATFORM="alsaqr"
[ -z "$RISCV" ] && RISCV="riscv -riscv64-gcc-8.5.0"

CC="${RISCV}${RISCV:+ }riscv64-unknown-elf-gcc"
AS="${RISCV}${RISCV:+ }riscv64-unknown-elf-as"
LD="${RISCV}${RISCV:+ }riscv64-unknown-elf-ld"
OBJCOPY="${RISCV}${RISCV:+ }riscv64-unknown-elf-objcopy"
OBJDUMP="${RISCV}${RISCV:+ }riscv64-unknown-elf-objdump"

OPT="-O -fno-builtin"          #optimize even more and avoid to use standard c functions
CFLAGS="$OPT -I. -I$PLATFORM -mcmodel=medany -g"  #include actuar directory to search directories
LDFLAGS="-G 0 -T $PLATFORM/$PLATFORM.ld"

CFILES="main io log hash rand riscv/arch $PLATFORM/platform $PLATFORM/uart $PLATFORM/util test"
OFILES=""
for F in $CFILES
do
  OFILES="$OFILES `basename $F.o`"
  $CC $CFLAGS -std=gnu99 -Wall -c -o `basename $F.o` $F.c  #-std define the standard used
done

$AS -o entry.o $PLATFORM/entry.s
$LD $LDFLAGS -o main.elf entry.o $OFILES
$OBJDUMP -S main.elf > main.dump
#elf2hex 16 65536 main.elf >
