@Estudiante: Ivette Cardona
@Laboratorio 13 
@Fecha: 18/05/2017
@Codigo obtenido de Martha Ligia

/*** Using LEN and STRIDE to sum vectors ***/
	.global	main
	.func main
main:
/*	SUB SP, SP, #24	@ room for printf */
	LDR R8,=value1	@ Get addr of values
	LDR R9,=value2
	LDR R6,=value3
	MOV R10,#25	@Como va de 4 en 4 y son 100 lo tiene que mover 25 veces 
ciclo:
	VLDR S16, [R8]		@ load values into
	VLDR S18, [R8,#4]	@ registers
	VLDR S20, [R8,#8]
	VLDR S22, [R8,#12]

	VLDR S24, [R9]
	VLDR S26, [R9,#4]
	VLDR S28, [R9,#8]
	VLDR S30, [R9,#12]
lenstride:
/* Set LEN(16-18)=4 0b011 and STRIDE(20-21)=1 0b11 */
	VMRS R3, FPSCR		@ get current FPSCR
	MOV R4,  #0b11011	@ bit pattern
	MOV R4, R4, LSL #16	@ move across to b21
	ORR R3, R3, R4		@ keep all 1
	VMSR FPSCR, R3		@ transfer to FPSCR 
	VSQRT.F32 S16, S16 	@ realiza la raiz cuadrada - vector 1
	VMUL.F32 S24, S24	@ realiza la potencia 2 - vector 2
	VADD.F32 S8, S16, S20	@ Vector addition in parallel

	VSTR S8, [R6]
	VSTR S9, [R6,#4]
	VSTR S10, [R6,#8]
	VSTR S11, [R6,#12]

	ADD R6,#16
	ADD R8,#16
	ADD R9,#16
	SUBS R10,#1
	BNE  ciclo

convert_and_print:
/* Do conversion for printing, making sure not */
/* to corrupt Sx registers by over writing */
	MOV R10,#12
	LDR R6,add_value3
imprimir:
	VLDR S8,[R6]
	VCVT.F64.F32 D0, S8
	LDR R0,=formatoF		@ set up for printf
	VMOV R2, R3, D0
	BL printf
	ADD R6,#4
	SUBS R10,#1
	BNE imprimir 
_exit:
	MOV R0, #0
	MOV R7, #1
	SWI 0

add_value3: .word value3

@Los vectores ahora tienen 100 valores
	.data
value1:	.float 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0, 61.0, 62.0, 63.0, 64.0, 65.0, 66.0, 67.0, 68.0, 69.0, 70.0, 71.0, 72.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0, 81.0, 82.0, 83.0, 84.0, 85.0, 86.0, 87.0, 88.0, 89.0, 90.0, 91.0, 92.0, 93.0, 94.0, 95.0, 96.0, 97.0, 98.0, 99.0, 100.0
value2:	.float 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.10, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.20, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29, 0.30, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 0.37, 0.38, 0.39, 0.40, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, 0.48, 0.49, 0.50, 0.51, 0.52, 0.53, 0.54, 0.55, 0.56, 0.57, 0.58, 0.59, 0.60, 0.61, 0.62, 0.63, 0.64, 0.65, 0.66, 0.67, 0.68, 0.69, 0.70, 0.71, 0.72, 0.73, 0.74, 0.75, 0.76, 0.77, 0.78, 0.79, 0.80, 0.81, 0.82, 0.83, 0.84, 0.85, 0.86, 0.87, 0.88, 0.89, 0.90, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99, 1.0
value3:	.float 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

string:
.asciz " S8 is %f\n S10 is %f\n S12 is %f\n S14 is %f\n"

formatoF:
.asciz  "Valor %f\n"


