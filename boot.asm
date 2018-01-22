global start


section .text
bits 32
start:
  ; Point the first entry of the level 4 page table to the first entry in the
  ; p3 table
  mov eax, p3_table
  or eax, 0b11
  mov dword [p4table + 0], eax

  ; Point the first entry of the level 3 page table to the first entry in the
  ; p2 table
  mov eax, p2_table
  or eax, 0b11
  mov dword [p3table + 0], eax

  ; point each page table level two entry to a page / loop
  mov ecx, 0 ; counter variable



  ; size  - place  - thing
  ; mov => 'move' thing into place
  mov word [0xb8000], 0x1248 ; Puts letter H (0x0248) in the upper left (oxb8000)
  mov word [0xb8002], 0x1265 ; Puts letter e (0x1265) in the upper left (0xb8002)
  mov word [0xb8004], 0x126c ; Puts letter l (0x126c) in the upper left (0xb8004)
  mov word [0xb8006], 0x126c ; Puts letter l (0x126c) in the upper left (oxb8006)
  mov word [0xb8008], 0x126f ; Puts letter o (0x126f) in the upper left (oxb8008)
  hlt ; halt

.map_p2_table:
  mov eax, 0x200000  ; 2MiB
  mul ecx
  or eax, 0b10000011
  mov [p2_table + ecx * 8], eax


  inc ecx
  cmp ecx, 512
  jne .map_p2_table




section .bss ;block starting with symbol
align 4096

; paging tables

p4_table:
  resb 4096

p3_table:
  resb 4096

p2_table:
  resb 4096
