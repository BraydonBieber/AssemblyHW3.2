;Author Braydon Bieber
;WSU ID: removed

.586
.MODEL FLAT

INCLUDE io.h				; header file for input/output

.STACK 4096

.DATA

index	DWORD ? 
avar	DWORD ?
bvar	DWORD ?
HighC	DWORD ?
;CSigned DWORD ? 
;ABSigned DWORD ?
;HighAB	DWORD ? 
cvar	DWORD ?
entera	BYTE	"Enter The Number for Variable A", 0
enterb  BYTE    "Enter The Number for Variable B", 0
enterc  BYTE    "Enter The Number for Variable C", 0
StrMemory BYTE 60 DUP (?), 0
quotientResult  BYTE  "The Quotient Is ", 0
remainderResult BYTE  "The Remainder Is ", 0
quotientStr		BYTE	40 DUP (?)
remainderStr	BYTE	40 DUP (?)
.CODE
_MainProc PROC
; our formula ((a * b) + (5 * c)) / 13
Init:
	input	entera, StrMemory, 60
	atod	StrMemory
	mov		avar, eax
	
	input	enterb, StrMemory, 60
	atod	StrMemory
	mov		bvar, eax

	input	enterc, StrMemory, 60
	atod	StrMemory
	mov		cvar, eax
	mov		eax, 5
CheckVars:
	mov		index, 1
	mov		ebx, cvar
	;mov		CSigned, -1
	cmp		ebx, 0
	jl		SignedMult	
	;mov		CSigned, 1
	jmp		UnsignedMult
Location1:
	mov		index, 2
	mov		cvar, eax
	mov		HighC, edx
	mov		eax, avar
	mov		ebx, bvar
;	mov		ABSigned, -1 
	cmp		eax, 0
	jl		SignedMult
	cmp		ebx, 0
	jl		SignedMult
;	mov		ABSigned, 1 
	jmp		UnsignedMult
	
SignedMult:
	imul	ebx
	cmp		avar, eax
	je		Location1
	jmp		Continue1
UnsignedMult:
	mul		ebx
	cmp		index, 1
	je		Location1
	jmp		Continue1

	
Continue1:
	add		eax, cvar
	jc		Add1
	jmp		Continue2	
Add1:
	add		edx, 1
Continue2:
	add		edx, HighC
	mov		ebx, 13
	cmp		edx, 0
	jl		SignedDiv
	jmp		UnsignedDiv
SignedDiv:
	idiv	ebx
	jmp		FinishUp
UnsignedDiv:
	div		ebx
FinishUp:
	dtoa	quotientStr, eax
	dtoa	remainderStr, edx
	output	quotientResult, quotientStr
	output	remainderResult, remainderStr
	mov     eax, 0			; exit with return code 0
	ret
_MainProc ENDP

END					; end of source code
