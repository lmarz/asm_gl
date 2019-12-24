;;;;;;;;;;;;;;;;;
;;; Variables ;;;
;;;;;;;;;;;;;;;;;
section .rodata
title db "OpenGL Assembly",0

section .bss
window resq 1
width resd 1
height resd 1

;;;;;;;;;;;;
;;; Code ;;;
;;;;;;;;;;;;
section .text

; external functions
extern glfwInit, glfwTerminate, glfwCreateWindow, glfwMakeContextCurrent, glfwWindowShouldClose
extern glClearColor, glClear, glfwSwapBuffers, glfwPollEvents, glBegin, glEnd, glFlush, glViewport
extern glColor3f, glVertex2f, glfwGetFramebufferSize

global _start
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

    ; glClearColor()
    mov rdi, __float32__(0.0) ; Red
    mov rsi, __float32__(0.0) ; Green
    mov rdx, __float32__(0.4) ; Blue
    mov rcx, __float32__(0.0) ; Alpha
    call glClearColor

mainLoop:
    ; glfwGetFramebufferSize()
    mov rdi, [window]
    lea rsi, [width]
    lea rdx, [height]
    call glfwGetFramebufferSize

    ; glViewport()
    mov rdi, 0
    mov rsi, 0
    mov rdx, [width]
    mov rcx, [height]
    call glViewport

    ; glClear()
    mov rdi, 0x00004000 ; GL_COLOR_BUFFER_BIT
    call glClear

    ; glBegin()
    mov rdi, 0x0004 ; GL_TRIANGLES
    call glBegin

    ; glColor3f()
    mov rdi, __float32__(1.0)
    mov rsi, __float32__(0.0)
    mov rdx, __float32__(0.0)
    call glColor3f

    ; glVertex2f
    mov rdi, __float32__(0.0)
    mov rsi, __float32__(-1.0)
    call glVertex2f

    ; glVertex2f
    mov rdi, __float32__(-1.0)
    mov rsi, __float32__(1.0)
    call glVertex2f

    ; glVertex2f
    mov rdi, __float32__(1.0)
    mov rsi, __float32__(1.0)
    call glVertex2f

    ; glEnd()
    call glEnd

    ; glFlush()
    call glFlush

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