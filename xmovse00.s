; Autor reseni: Lilit Movsesian xmovse00
; Pocet cyklu k serazeni puvodniho retezce: 3244
; Pocet cyklu razeni sestupne serazeneho retezce: 4039
; Pocet cyklu razeni vzestupne serazeneho retezce: 254
; Pocet cyklu razeni retezce s vasim loginem: 786
; Implementovany radici algoritmus: Bubble Sort
; ------------------------------------------------

; DATA SEGMENT
                .data
;login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
;login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
;login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
login:          .asciiz "xmovse00"            ; SEM DOPLNTE VLASTNI LOGIN
                                                ; A POUZE S TIMTO ODEVZDEJTE

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize - "funkce" print_string)

; CODE SEGMENT
                .text
main:
           
    daddi r4, r0, login   ;loads the address of the login into r4
    jal bubble_sort   ;calls the bubble_sort 
    daddi r4, r0, login ;loads the address of the sorted login to r4
    jal print_string   ;prints the sorted login
    syscall 0

bubble_sort:
    daddi r1, r4, 0   ;r1 points to the start of the string
    daddi r8, r0, 1   ;sets the swap flag
    loop_outer:
        daddi r8, r0, 0   ;clears the swap flag
        daddi r2, r1, 0   ; r2 points to the current character
        loop_inner:
            lbu r9, 0(r2)   ;loads the current character
            lbu r10, 1(r2)   ;loads the next character
            beq r10, r0, end   ;jumps to end if the end of the string
            sltu r11, r10, r9   ;sets r11 if the next char is less than the current
            beq r11, r0, skip_swap   ;skips the swap if r11 is not set
            sb r10, 0(r2)   ;swaps two chars
            sb r9, 1(r2)
            daddi r8, r0, 1   ;sets the swap flag
            skip_swap:
            daddi r2, r2, 1   ;r2 points to the next char
            j loop_inner
        end:
            bnez r8, loop_outer   ;if the flag is set, continues the outer loop
            jr r31   ;return

print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
