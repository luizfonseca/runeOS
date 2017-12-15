header_start:
  dd 0xe85250d6                 ; magic number from Multiboot specification
  dd 0                          ; going into protected Mode
  dd header_end - header_start  ; header length

  ; checksum
  dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

  ; required end tag
  dw 0    ; type
  dw 0    ; flags
  dd 8    ; size
header_end:
