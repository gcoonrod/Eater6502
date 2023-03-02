.target "65c02"
.format "bin"

; 65C22 Addresses
PORTB   .equ $6000
PORTA   .equ $6001
DDRB    .equ $6002
DDRA    .equ $6003

; HD44780U Control Signal masks
DISP_E  .equ %10000000
DISP_RW .equ %01000000
DISP_RS .equ %00100000

.org $fffc      ; Initialize Reset Vector
.word start
.word $0000

.org $8000
start:
    ldx #$ff    ; Initialize stack to 01ff
    txs

w65c22_init:
    lda #$ff    ; Set all Port B pins to output 
    sta DDRB
    lda #$e0    ; Set 3 most significant bits of Port A to outputs
    sta DDRA

lcd_init:
    lda #%00111000  ; Set 8 bit mode, 2 line display, 5x8 font
    jsr lcd_instruction
    lda #%00001110  ; Set display on, cursor on, blink off
    jsr lcd_instruction
    lda #%00000110  ; Increment and shift cursor, don't shift display
    jsr lcd_instruction

print_hello:
    lda #"H"    ; Send H
    jsr lcd_print_char
    lda #"e"
    jsr lcd_print_char
    lda #"l"
    jsr lcd_print_char
    lda #"l"
    jsr lcd_print_char
    lda #"o"
    jsr lcd_print_char
    lda #","
    jsr lcd_print_char
    lda #" "
    jsr lcd_print_char
    lda #"W"
    jsr lcd_print_char
    lda #"o"
    jsr lcd_print_char
    lda #"r"
    jsr lcd_print_char
    lda #"l"
    jsr lcd_print_char
    lda #"d"
    jsr lcd_print_char
    lda #"!"
    jsr lcd_print_char
    
    
wait_loop:
    nop
    jmp wait_loop

lcd_instruction:
    pha
    sta PORTB

    lda #0      ; Clear RS/RW/E bits
    sta PORTA

    lda #DISP_E ; Set display enable high
    sta PORTA
    lda #0      ; Set display enable low
    sta PORTA
    pla
    rts

lcd_print_char:
    pha
    sta PORTB

    lda #DISP_RS      ; Set RS, Clear RW/E bits
    sta PORTA

    lda #(DISP_E | DISP_RS) ; Set display enable and register select high
    sta PORTA
    lda #DISP_RS      ; Set display enable low
    sta PORTA
    pla
    rts