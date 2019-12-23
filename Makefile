TARGET = asm_gl

all: $(TARGET)

$(TARGET): asm_gl.o
	ld -o $(TARGET) asm_gl.o --dynamic-linker=/lib64/ld-linux-x86-64.so.2 -lglfw -lGLEW -lGL

asm_gl.o: asm_gl.asm
	nasm -f elf64 asm_gl.asm

clean:
	rm $(TARGET) asm_gl.o