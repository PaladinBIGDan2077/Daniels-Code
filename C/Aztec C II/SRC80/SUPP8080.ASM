;Copyright (C) 1981,1982 by Manx Software Systems
; Copyright (C) 1981  Thomas Fenwick
	ext	.begin
	public .an
.an: MOV A,H
	ANA	D
	MOV	H,A
	MOV	A,L
	ANA	E
	MOV	L,A
	ora h
	RET
;
	public .cm
.cm:	MOV	A,H
	CMA
	MOV	H,A
	MOV	A,L
	CMA
	MOV	L,A
	ora h
	RET
;
	public .chl
.chl:	PCHL
;
	public .sav
.sav: POP H
	PUSH	B
	mov e,m
	inx h
	mov d,m
	inx h
	MOV	B,H
	MOV	C,L
	LXI	H,0
	DAD	SP
	XCHG
	DAD	SP
	SPHL
	PUSH	D
	mov	h,b
	mov l,c
	call .chl
;
.ret:	XCHG
	POP	H
	SPHL
	POP	B
	XCHG
	MOV A,H
	ORA L
	RET
;
	public .dv,.ud
.dv: 			; DE has dividend, HL has divisor
	mov	a,d
	xra	h		;check if signs differ
	sta	sign	;and remember
	CALL divsub	;use same routine as modulo
	XCHG		;and swap results
	lda	sign
	ora a
	jm	.ng		;negate result if signs of operands differ
	mov a,l
	ora h
	RET
;
.ud:
	CALL .um	;use same routine as modulo
	XCHG		;and swap results
	mov a,l
	ora h
	RET
;
	public .false
	public .true
	public .eq,.ne
.eq: mov a,l
	sub e
	jnz .false
	mov a,h
	sub d
	jz .true
.false: lxi h,0
	xra a
	ret
;
.ne: mov a,l
	sub e
	jnz .true
	mov a,h
	sub d
	jz .false
.true: lxi h,1
	mov a,l
	ora h
	RET
;
	public .le,.ge
.ge:		; ge
	XCHG
.le:	mov a,h
	xra	d
	jm	.lediff	; signs differ
				; signs alike
	mov a,l
	sub e
	mov a,h
	sbb d
	cmc
	mvi a,0
	aci 0
	mov l,a
	mvi h,0
	ret
.lediff: mov a,d
	rlc
	ani 1
	mov l,a
	mvi h,0
	ret
;
	public .lt,.gt
.lt:
	XCHG
.gt:	mov a,h
	xra	d
	jm	.gtdiff	; signs differ
				; signs alike
	mov a,l
	sub e
	mov a,h
	sbb d
	mvi a,0
	aci 0
	mov l,a
	mvi h,0
	ret
.gtdiff: mov a,h
	rlc
	ani 1
	mov l,a
	mvi h,0
	ret
;
	public .rm,.um
.rm:
	mov	a,d
	sta	sign
	call divsub
	lda sign
	ora a
	jm	.ng		;negate result if dividend was signed
	mov a,h
	ora l
	ret
;
divsub:
	mov a,h
	ora a
	jp	hlpos
	cma
	mov h,a
	mov a,l
	cma
	mov l,a
	inx h
hlpos:
	mov a,d
	ora a
	jp	.um
	cma
	mov	d,a
	mov a,e
	cma
	mov e,a
	inx d
	jmp .um
;
.um: PUSH B		;save for C
	MOV	B,H
	MOV	C,L
	LXI H,0
	MVI A,16	;iteration count
	sta temp
.dlp: DAD H		;shift hl left
	XCHG
	DAD H		;shift de left
	XCHG
	JNC .dj1
	INX H		;carry into high part
.dj1:
	mov a,l
	sub c
	mov l,a
	mov a,h
	sbb b
	mov h,a
	jnc	.dj2
	DAD B		;restore
	lda temp
	DCR A		;count times thru
	sta temp
	JNZ .dlp
	POP B		;restore for C
	mov a,l
	ora h
	RET			;done after 16 times
.dj2: INX D		;set quotient bit
	lda temp
	DCR A		;count times thru
	sta temp
	JNZ .dlp
	POP B		;restore for C
	mov a,l
	ora h
	RET			;done after 16 times
;
	dseg
temp: ds 1
sign: ds 1
	cseg
	public .ml
.ml: PUSH B
	MOV	B,H
	MOV	C,L	
	LXI H,0		;CLEAR RESULT
	MVI A,16	;ITERATION COUNT
.mlp: DAD H		;SHIFT LEFT
	XCHG		; NOW SHIFT DE LEFT
	DAD H
	XCHG
	JNC .msk
	DAD B
.msk: DCR A		;COUNT TIMES THRU
	JNZ .mlp	;go thru 16 times
	POP	B
	mov a,l
	ora h
	RET
;
	public .ng
.ng:	MOV A,L
	CMA
	MOV L,A
	MOV A,H
	CMA
	MOV H,A
	INX H
	mov a,l
	ora h
	RET
;
	public .nt
.nt:	MOV	A,H
	ORA	L
	jz .true
	jmp .false
;
	public .or
.or: MOV A,H
	ORA	D
	MOV	H,A
	MOV	A,L
	ORA	E
	MOV	L,A
	ora h
	RET
;
	public .rs
.rs:	XCHG
	mov a,e
	ani	31
	mov	e,a
	jz	setcc
	MOV A,H
	ORA H
	JP .arloop
;
.sign:	MOV	A,H
	STC
	RAR
	MOV	H,A
	MOV	A,L
	RAR
	MOV	L,A
	DCR E
	JNZ	.sign
	ora h
	ret
;
	public .ls
.ls:	XCHG
	mov a,e
	ani	31
	mov	e,a
	jz	setcc
lslp:
	DAD H
	DCR E
	JNZ	lslp
setcc:
	mov a,l
	ora h
	ret
;
	public .sb
.sb: XCHG
	mov a,l
	sub e
	mov l,a
	mov a,h
	sbb d
	mov h,a
	ora l
	ret
;
	public .jmp
.jmp:
	xchg
	pop h
	push b
	mov c,m
	inx h
	mov b,m
	inx h
	xchg
	dad b
	xchg
	mov c,m
	inx h
	mov b,m
	inx h
	mov a,d
	cmp b
	jc jok
	mov a,e
	cmp c
	jnc jdflt
jok:
	inx h
	inx h		;skip over default address
	dad d
	dad d		;compute address in jump table
jdflt:
	mov e,m
	inx h
	mov d,m
	xchg
	pop b
	pchl
;
	public .swt
.swt:	xchg
	pop	h
	PUSH B
	MOV B,D
	MOV C,E
	MOV E,M
	INX H
	MOV D,M
swt.1: DCX D
	MOV A,D
	ORA A
	JM	swt.def
	INX H
	MOV A,C
	CMP M
	JZ	swt.3
	INX H
swt.2: INX H
	INX H
	JMP swt.1
swt.3: INX H
	MOV A,B
	CMP M
	JNZ swt.2
swt.def:	INX H
	MOV A,M
	INX H
	MOV H,M
	MOV L,A
	POP B
	PCHL
;
	public .ue,.uf
.uf:		; uge
	XCHG
.ue: mov a,l	; ule
	sub e
	mov a,h
	sbb d
	mvi a,0
	cmc
	aci 0
	mov l,a
	mvi h,0
	ret
;
	public .ug,.ul
.ul:		; ult
	XCHG
.ug: mov a,l
	sub e
	mov a,h
	sbb d
	mvi a,0
	aci 0
	mov l,a
	mvi h,0
	ret
;
	public .ur
.ur: XCHG
	mov a,e
	ani	31
	mov	e,a
	jz	setcc
.arloop:	MOV	A,H
	ORA	A
	RAR
	MOV	H,A
	MOV	A,L
	RAR
	MOV	L,A
	DCR E
	JNZ	.arloop
	ora h
	ret
;
	public .xr
.xr: MOV A,H
	XRA	D
	MOV	H,A
	MOV	A,L
	XRA	E
	MOV	L,A
	ora h
	RET
;
;	move - move BC bytes from (HL) to (DE)
;
	public .move
.move:
	mov a,m
	stax d
	inx h
	inx d
	dcx b
	mov a,b
	ora c
	jnz .move
	ret
;
	public	.ARG1,.ARG2,.ARG3,.asave
;
.asave:		;support for assembly routines which must save IX and IY
	pop	d		;save return address
	lxi	h,2		;compute address of arguments
	dad	sp
	PUSH B
	push	d		;put return addr back
	lxi	d,.ARG1
	mvi	b,6
cpyloop:			;copy args to known place
	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	cpyloop
	lxi	h,asmret
	xthl
	pchl
;
asmret:
	POP B
	mov a,h
	ora l
	RET
;
	public prctyp
prctyp:	
	ana	a	;clear carry for 8080 processor
	ret
;
	dseg
.ARG1:	ds	2
.ARG2:	ds	2
.ARG3:	ds	2
	end
