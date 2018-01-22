default: build

.PHONY: default build run clean

build: build/rune_OS.iso

run: build/rune_OS.iso
	qemu-system-x86_64 -cdrom build/rune_OS.iso

build/multiboot_h.o: multiboot_h.asm
	mkdir -p build
	nasm -f elf64 multiboot_h.asm -o build/multiboot_h.o

build/boot.o: boot.asm
	mkdir -p build
	nasm -f elf64 boot.asm -o build/boot.o

build/kernel.bin: build/multiboot_h.o build/boot.o linker.ld
	ld -n -o build/kernel.bin -m elf_x86_64 -T linker.ld build/multiboot_h.o build/boot.o


build/rune_OS.iso: build/kernel.bin grub.cfg
	mkdir -p build/isofiles/boot/grub
	cp grub.cfg build/isofiles/boot/grub
	cp build/kernel.bin build/isofiles/boot
	grub-mkrescue -o build/rune_OS.iso build/isofiles/


clean:
	rm -rf build/
