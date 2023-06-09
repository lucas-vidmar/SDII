ORG 80
decaying:
	DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 9, 11, 13, 16, 19, 22, 26, 30, 35, 41, 47, 55, 63, 72, 81, 92, 105, 118, 133, 149, 167, 186, 207, 230, 255
sin:
	DB 0x80,0x8f,0x9f,0xae,0xbd,0xca,0xd7,0xe2,0xeb,0xf3,0xf9,0xfd,0xff,0xff,0xfd,0xf9,0xf3,0xeb,0xe2,0xd7,0xca,0xbd,0xae,0x9f,0x8f,0x80,0x70,0x60,0x51,0x42,0x35,0x28,0x1d,0x14,0xc,0x6,0x2,0x0,0x0,0x2,0x6,0xc,0x14,0x1d,0x28,0x35,0x42,0x51,0x60,0x70
triangle:
	DB 0xa,0x14,0x1f,0x29,0x33,0x3d,0x47,0x52,0x5c,0x66,0x70,0x7a,0x85,0x8f,0x99,0xa3,0xad,0xb8,0xc2,0xcc,0xd6,0xe0,0xeb,0xf5,0xff,0xf5,0xeb,0xe0,0xd6,0xcc,0xc2,0xb8,0xad,0xa3,0x99,0x8f,0x85,0x7a,0x70,0x66,0x5c,0x52,0x47,0x3d,0x33,0x29,0x1f,0x14,0xa,0x0
default:
	DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

SWITCH1 EQU 11111110b
SWITCH2 EQU 11111101b
SWITCH3 EQU 11111011b

ORG 0
JMP main

main:
	CLR P0.7
	MOV A, P2
	XRL A, #SWITCH1
	JZ opcion1
	MOV A, P2
	XRL A, #SWITCH2
	JZ opcion2
	MOV A, P2
	XRL A, #SWITCH3
	JZ opcion3
	JMP opcionDefault ;ninguna de las tres opciones, imprimo la default
	
opcion1:
	MOV DPTR, #decaying
	JMP print
opcion2:
	MOV DPTR, #sin
	JMP print
opcion3:
	MOV DPTR, #triangle
	JMP print
opcionDefault:
	MOV DPTR, #default
	JMP print
print:
	CALL printFunction
	JMP main

printFunction:
	MOV R0, #-1
loopPrint:
	INC R0
	MOV A, R0
	MOVC A, @A+DPTR
	MOV P1, A
	CJNE R0, #50, loopPrint
	RET