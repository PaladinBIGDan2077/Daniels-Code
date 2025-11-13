;Copyright (C) 1981,1982 by Manx Software Systems
; Copyright (C) 1981  Thomas Fenwick
BASE	equ	0
BDOS	equ	5

	ext Croot_
	CSEG
	public	.begin
	public	boot__
.begin:
	LHLD 6
	SPHL
	CALL Croot_
boot__:
	lxi b,0
	call BDOS
	JMP boot__
;
	ext	.ARG1,.ARG2,.ARG3,.asave
;
	public	bdoshl_
bdoshl_:
	call	.asave
	call	combdos
	xchg			;get back original hl value
	ret
;
	public	bdos_,CPM_
bdos_:
CPM_:
	call	.asave
combdos:
	lhld	.ARG1
	mov	b,h
	mov	c,l
	lhld	.ARG2
	xchg
	CALL BDOS
	xchg		;save for bdoshl call
	mov	l,a
	mvi	h,0
	RET
;
	public	bios_
bios_:
	call	.asave
	call	combios
	mov	l,a
	mvi	h,0
	ret
;
	public	bioshl_
bioshl_:
	call	.asave
combios:
	lhld	.ARG1
	xchg
	lhld	BASE+1
	dcx	h
	dcx	h
	dcx	h
	dad	d
	dad	d
	dad	d
	xchg			;bios jump addr in DE

	lhld	.ARG2
	mov	b,h
	mov	c,l
	lhld	.ARG3
	xchg			;now arg3 in DE, and bios jump in HL
	pchl
;
;
	public fcbinit_
fcbinit_:
	push b
	lxi h,4
	dad sp
	mov c,m		; BC contains name
	inx h
	mov b,m
	inx h
	mov e,m		; DE contains fcb address
	inx h
	mov d,m
;				clear name to blanks
	mov	l,e		;copy fcb address into HL
	mov	h,d
	mvi	m,0		;clear drive #
	inx	h
	mvi a,11		;clear name and ext to blanks
clrlp:
	mvi m,' '
	inx h
	dcr a
	jnz clrlp
	mvi	a,4
zrlp:
	mvi	m,0
	inx	h
	dcr	a
	jnz	zrlp
	xchg			; now HL contains fcb addr
;
	inx b
	ldax b
	cpi ':'
	dcx b
	mvi a,0
	jnz nodrive
;
	ldax b
	ani 127
	cpi 'A'
	jc	badname
	cpi 'Z'+1
	jnc	lowerc
	sui 'A'-1
	jmp setdrive
;
lowerc:
	cpi 'a'
	jc 	badname
	cpi 'z'+1
	jnc	badname
	sui 'a'-1
setdrive:
	mov m,a
	inx b
	inx b
nodrive:
	inx h
;				move name in mapping to upper case
	mvi e,8
nameskp:
	inr e
namelp:
	ldax b
	inx b
	cpi '.'
	jz	namedn
	ora a
	jz	alldone
	dcr e
	jz	nameskp
	call toupper
	mov m,a
	inx h
	jmp namelp
;
namedn:
	dcr e
	mov a,e
	add	l
	mov l,a
	mov a,h
	aci 0
	mov h,a
;					move extension mapping to upper case
	mvi e,3
extlp:
	ldax b
	inx b
	ora a
	jz	alldone
	call toupper
	mov m,a
	inx h
	dcr e
	jnz	extlp
;
alldone:
	lxi h,0
	xra a
	pop	b
	ret
;
badname:
	lxi h,-1
	mov a,h
	ora a
	pop	b
	ret
;
toupper:
	cpi 'a'
	rc
	cpi 'z'+1
	rnc
	sui 'a'-'A'
	ret
;
	public $MEMRY
	DSEG
$MEMRY: dw 0ffffH
	CSEG
;
; settop(size): return address of current top & bump by size bytes
;
	public settop_,sbrk_
settop_:
sbrk_:
	lxi h,2
	dad sp
	mov e,m		; get size to allocate
	inx h
	mov d,m
	lhld $MEMRY
	dad d
	xchg		;save for compare
	lxi h,-512	;allow some slop
	dad sp
	mov a,l		;check for stack/heap overflow
	sub e
	mov a,h
	sbb d
	jc sbrk.ov
	lhld $MEMRY	;get old value
	xchg
	shld $MEMRY	;new value is good so save it away
	xchg		;return original value
	mov a,h
	ora l
	ret
; no space left!!
sbrk.ov:
	lxi h,0
	xra a
	ret
	end	.begin
