// kernel.c - 커널 메인
#include <stdint.h>

// VGA 텍스트 모드 상수
#define VGA_ADDRESS 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

// VGA 색상 코드
#define VGA_BLACK 0
#define VGA_WHITE 15
#define VGA_DEFAULT_COLOR ((VGA_BLACK << 4) | VGA_WHITE)

// 커서 위치
static uint16_t cursor_x = 0;
static uint16_t cursor_y = 0;

// VGA 메모리에 문자 출력
void putchar(char c) {
    volatile uint16_t* vga = (uint16_t*)VGA_ADDRESS;
    
    if (c == '\n') {
        cursor_x = 0;
        cursor_y++;
        return;
    }
    
    vga[cursor_y * VGA_WIDTH + cursor_x] = (VGA_DEFAULT_COLOR << 8) | c;
    cursor_x++;
    
    if (cursor_x >= VGA_WIDTH) {
        cursor_x = 0;
        cursor_y++;
    }
    
    if (cursor_y >= VGA_HEIGHT) {
        // 화면 스크롤 구현 필요
        cursor_y = VGA_HEIGHT - 1;
    }
}

// 문자열 출력
void print(const char* str) {
    while (*str) {
        putchar(*str++);
    }
}

// 커널 메인 함수
void kernel_main() {
    print("Kernel loaded successfully!\n");
    print("Welcome to Simple Linux\n");
    
    while(1) {
        // 커널 메인 루프
    }
}