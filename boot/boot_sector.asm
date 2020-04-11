; BUIL: nasm -f bin {file-name.asm} -o {target-name}
;       -f --format: {bin} - raw binary
; QEMY: Quemy works with virtual files, so we have to extend
;       our file to at least 512 bytes
; NASM: {$} - address of the current instructon
;       {$$} - address of the beginning of the current section
;       {times [count] instruction} - repeat instruction N times
;       {ort [addr]} - sets where the programm expects to be loaded 
; BIOS: BIOS loads first sector(512) at the 0x7C00
; BOOT: BIOS checks if the first sector is bootable looking at 
;       magic number at final two bytes
; BOOT: Magic number is 0x55AA

; We know for sure that our programm will be loaded at 0x7C00
[org 0x7C00]

; --------------- START -----------------
mov si, c_msg_welcome_real_mode
call print_string


; Jump to infinite loop
jmp $
; ---------------------------------------


; --------------- DATA -----------------
c_msg_welcome_real_mode:
    db "Starting dummy_os in real mode...", 0
; ---------------------------------------


; Bad idea to place it here, but looks nice
; --------------- INCLUDES -----------------
%include "boot/boot_utils.asm"
; ---------------------------------------



; --------------- FIN -----------------
; Boot sector ending
; Make sure we reach 510 bytes
times 510-($-$$) db 0

; 2 bytes for magic number. Remember we use little endian
c_magic_number:
    dw 0xAA55
; ---------------------------------------