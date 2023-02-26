.target "65c02"
.format "bin"

VIA  .equ $6000
DDRB .equ $6002

.org $fffc
.word Initialize
.word $0000

.org $8000

Initialize  lda #$ff
            sta DDRB   ;DDRB to output

@Loop       lda #$55
            sta VIA   ;on off pattern

            lda #$aa
            sta VIA   ;off on pattern

            jmp @Loop
