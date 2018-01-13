global start


section .text
bits 32
start:
  ; size  - place  - thing
  ; mov => 'move' thing into place
  mov word [0xb8000], 0x1248 ; Puts letter H (0x0248) in the upper left (oxb8000)
  mov word [0xb8002], 0x1265 ; Puts letter e (0x1265) in the upper left (0xb8002)
  mov word [0xb8004], 0x126c ; Puts letter l (0x126c) in the upper left (0xb8004)
  mov word [0xb8006], 0x126c ; Puts letter l (0x126c) in the upper left (oxb8006)
  mov word [0xb8008], 0x126f ; Puts letter o (0x126f) in the upper left (oxb8008)
  hlt ; halt
