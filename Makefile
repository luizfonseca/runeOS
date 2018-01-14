default: run
build: rune_OS.iso
run: rune_OS.iso
	qemu-system-x86_64 -cdrom rune_OS.iso
multiboot_h.o: multiboot_h.asm
	nasm -f elf64 multiboot_h.asm
boot.o: boot.asm
	nasm -f elf64 boot.asm
kernel.bin: multiboot_h.o boot.o linker.ld
	ld -n -o kernel.bin -m elf_x86_64 -T linker.ld multiboot_h.o boot.o


rune_OS.iso: kernel.bin grub.cfg
	mkdir -p isofiles/boot/grub
	cp grub.cfg isofiles/boot/grub
	cp kernel.bin isofiles/boot
	grub-mkrescue -o rune_OS.iso isofiles/
