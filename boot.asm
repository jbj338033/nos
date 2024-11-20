; boot.asm - 부트로더
section .boot
global start
start:
    mov ax, 0x07C0      ; 부트섹터 시작 주소
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, msg_hello   ; 메시지 출력
    call print_string

    jmp $               ; 무한 루프

print_string:           ; 문자열 출력 루틴
    push ax
    push si
    mov ah, 0x0E       ; BIOS teletype 출력
.loop:
    lodsb              ; SI에서 한 문자 로드
    test al, al        ; 널 문자 체크
    jz .done
    int 0x10           ; BIOS 인터럽트
    jmp .loop
.done:
    pop si
    pop ax
    ret

msg_hello: db 'Simple Linux Boot Loader', 13, 10, 0

times 510-($-$$) db 0   ; 부트섹터 패딩
dw 0xAA55               ; 부트 시그니처