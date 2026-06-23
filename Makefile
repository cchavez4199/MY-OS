GPP= i686-elf-g++
AS= i686-elf-as
LD= i686-elf-ld

GPPPARAMS= -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-exceptions -fno-rtti -fno-leading-underscore
ASPARAMS=
LDPARAMS=

objects = loader.o kernel.o

%.o: %.cpp
	$(GPP) $(GPPPARAMS) -o $@ -c $<
%.o: %.s
	$(AS) $(ASPARAMS) -o $@ $<

mykernel.bin: linker.ld $(objects)
	$(LD) $(LDPARAMS) -T $< -o $@ $(objects)

run: mykernel.bin
	qemu-system-i386 -kernel $<