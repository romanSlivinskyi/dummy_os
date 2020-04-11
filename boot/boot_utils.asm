; ------ Function: Print string ------
; TODO: improve(checks, etc.), for now thats ok
; For more info: https://en.wikipedia.org/wiki/INT_10H
; Parameters:
;    si - register that hold the address of null terminated string
print_string:
    cld                ; set DF flag in EFLAGS (to increment in lodsb)
    lodsb              ; al = [si++]

    mov ah, 0x0E       ; call interrupt service for teletype output
    int 0x10           ; call BIOS interrupt

    cmp al, 0          ; int10 may set ax, but it works for now
    jnz print_string

    ret