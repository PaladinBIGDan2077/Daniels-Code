;Copyright (C) 1981,1982 by Manx Software Systems
; Copyright (C) 1981  Thomas Fenwick
	public .stlp
	public strcmp_
strcmp_:
	LXI H,2
	DAD SP
	PUSH B
	LXI B,32767
	MOV E,M
	INX H
	MOV D,M
	INX H
	MOV A,M
	INX H
	MOV H,M
	MOV L,A
.stlp:
	MOV A,B
	ORA C
	JZ .stex
	LDAX D
	CMP M
	JNZ .stne
	ORA A
	JZ .stex
	INX H
	INX D
	DCX B
	JMP .stlp
.stex:
	POP B
	LXI H,0
	RET
.stne:
	POP B
	JC .stlt
	LXI H,1
	mov a,l
	ora h
	RET
.stlt: LXI H,-1
	mov a,l
	ora h
	RET
;
	public .sylp
	public strcpy_
strcpy_:
	LXI H,2
	DAD SP
	PUSH B
	LXI B,32767
	MOV E,M
	INX H
	MOV D,M
	PUSH D
	INX H
	MOV A,M
	INX H
	MOV H,M
	MOV L,A
.sylp:
	MOV A,B
	ORA C
	JZ .syex
	MOV A,M
	STAX D
	ORA A
	JZ .syex
	INX H
	INX D
	DCX B
	JMP .sylp
.syex:
	POP H	;return destination address
	POP B
	RET
;
	public strlen_
strlen_: LXI H,2
	DAD SP
	MOV A,M
	INX H
	MOV H,M
	MOV L,A
	LXI D,0
	XRA A
.stl: CMP M
	JZ	.stlx
	INX D
	INX H
	JMP .stl
.stlx: XCHG
	mov a,l
	ora h
	RET
;
	public strncmp_
strncmp_:
	LXI H,2
	DAD SP
	PUSH B
	MOV E,M
	INX H
	MOV D,M
	PUSH D
	INX H
	MOV E,M
	INX H
	MOV D,M
	INX H
	MOV C,M
	INX H
	MOV B,M
	XCHG
	POP D
	JMP .stlp
;
	public strncpy_
strncpy_:
	LXI H,2
	DAD SP
	PUSH B
	MOV E,M
	INX H
	MOV D,M
	PUSH D
	PUSH D
	INX H
	MOV E,M
	INX H
	MOV D,M
	INX H
	MOV C,M
	INX H
	MOV B,M
	XCHG
	POP D
	JMP .sylp
;
	public strcat_
strcat_:
	push	b
	lxi	b,7fffH		;copy big # of bytes
	lxi	h,4
	dad	sp
	mov	e,m		;DE = destination
	inx	h
	mov	d,m
	push	d		;save for return value
	inx	h
	mov	a,m
	inx	h
	mov	h,m
	mov	l,a		;HL = source
	xchg
escan:
	MOV A,B
	ORA C
	JZ .syex
	mov	a,m		;scan for end of string
	ora	a
	jz	fndend
	inx	h
	dcx	b
	jmp	escan
;
fndend:
	xchg			;put back into correct registers
	jmp	.sylp		;use common code to copy data
;
	public strncat_
strncat_:
	LXI H,2
	DAD SP
	PUSH B
	MOV E,M
	INX H
	MOV D,M			;destination
	PUSH D
	PUSH D
	INX H
	MOV E,M
	INX H
	MOV D,M			;source
	INX H
	MOV C,M			;max # to move
	INX H
	MOV B,M
	POP H
	xra	a
	JMP 	escan
;
	public index_
index_:
	push b
	lxi	h,4
	dad	sp
	mov	e,m		;DE = destination
	inx	h
	mov	d,m
	inx	h
	mov	l,m
	xchg		;e has char to look for
scan:
	mov a,m
	ora	a		;scan for end of string
	jz	noluck
	cmp e
	jz	foundit
	inx	h
	jmp	scan
;
noluck:
	lxi h,0
	xra a
	pop b
	ret
;
foundit:
	mov a,h
	ora l
	pop b
	ret
;
	public rindex_
rindex_:
	push b
	lxi	h,4
	dad	sp
	mov	e,m		;DE = destination
	inx	h
	mov	d,m
	inx	h
	mov	l,m
	xchg		;e has char to look for
	lxi b,0
	xra a
toend:
	cmp	m		;scan for end of string
	jz	havend
	inx h
	inx b
	jmp toend

havend:
	mov a,b
	ora c
	jz	noluck
	dcx b
	dcx h
	mov a,m
	cmp e
	jnz havend
	jmp	foundit
	end
