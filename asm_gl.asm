section .rodata
title db "OpenGL Assembly",0

section .bss
window resq 1

section .text
global _start
extern glfwInit, glfwTerminate, glfwCreateWindow, glfwMakeContextCurrent, glfwWindowShouldClose
extern glClear, glfwSwapBuffers, glfwPollEvents

_start:
    ; glfwInit()
    call glfwInit

    ; glfwCreateWindow()
    mov rdi, 800
    mov rsi, 600
    mov rdx, title
    mov rcx, 0
    mov r8, 0
    call glfwCreateWindow
    mov [window], rax

    ; glfwMakeContextCurrent()
    mov rdi, [window]
    call glfwMakeContextCurrent

mainLoop:
    ; glClear()
    mov rdi, 0x00004000 ; GL_COLOR_BUFFER_BIT
    call glClear

    ; glfwSwapBuffers()
    mov rdi, [window]
    call glfwSwapBuffers

    ; glfwPollEvents
    call glfwPollEvents

    ; glfwWindowShouldClose()
    mov rdi, [window]
    call glfwWindowShouldClose

    ; while loop
    cmp rax, 0
    je mainLoop

    ; glfwTerminate()
    call glfwTerminate

    ; sys_exit
    mov rax, 60
    mov rdi, 0
    syscall