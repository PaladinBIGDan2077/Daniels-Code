	public	.lngused
	common /.lnprm/
.lngused:
lnprm:	dw	acc1
lnsec:	dw	acc2
	dseg
retsave:ds	2
acc1:	ds	4
acc2:	ds	4
	cseg
	public	.llis		;load long immediate secondary
.llis:
	pop	d		;get return addr
	lxi	h,4		;size of long
	dad	d
	push	h		;put back correct return addr
	xchg
			;fall through into .llds
;
	public	.llds		;load long into secondary accum
.llds:
	xchg
	lhld	lnsec
	jmp	lload
;
	public	.llip		;load long immediate primary
.llip:
	pop	d		;get return addr
	lxi	h,4		;size of long
	dad	d
	push	h		;put back correct return addr
	xchg
			;fall through into .lldp
;
	public .lldp		;load long into primary accum
.lldp:
	xchg
	lhld	lnprm
lload:
	ldax	d
	mov	m,a
	inx	h
	inx	d
	ldax	d
	mov	m,a
	inx	h
	inx	d
	ldax	d
	mov	m,a
	inx	h
	inx	d
	ldax	d
	mov	m,a
	ret
;
	public .lst		;store long at addr in HL
.lst:
	xchg
	lhld	lnprm
	mov	a,m
	stax	d
	inx	d
	inx	h
	mov	a,m
	stax	d
	inx	d
	inx	h
	mov	a,m
	stax	d
	inx	d
	inx	h
	mov	a,m
	stax	d
	ret
;
	public .lpsh		;push long onto the stack
.lpsh:				;from the primary accumulator
	pop	h		;get return address
	shld	retsave		;and save for later
	lhld	lnprm
	lxi	d,3
	dad	d
	mov	d,m		;bytes 2 and 3
	dcx	h
	mov	e,m
	dcx	h
	push	d
	mov	d,m		;bytes 0 and 1
	dcx	h
	mov	e,m
	push	d
	lhld	retsave
	pchl
;
	public	.lpop		;pop long into secondary accum
.lpop:
	pop	h		;get return address
	shld	retsave		;and save
	lhld	lnsec
	pop	d		;bytes 0 and 1
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	pop	d		;bytes 2 and 3
	mov	m,e
	inx	h
	mov	m,d
	lhld	retsave
	pchl
;
	public	.lswap		;exchange primary and secondary
.lswap:
	lhld	lnsec
	xchg
	lhld	lnprm
	shld	lnsec
	xchg
	shld	lnprm
	ret
;
	public	.lng		;negate primary
.lng:
	lhld	lnprm
negate:
	xra	a
	mvi	d,4
ngloop:
	mvi	a,0
	sbb	m
	mov	m,a
	inx	h
	dcr	d
	jnz	ngloop
	ret
;
	public	.ltst		;test if primary is zero
.ltst:
	lhld	lnprm
	mvi	d,4
tstlp:
	mov	a,m
	ora	a
	jnz	true
	inx	h
	dcr	d
	jnz	tstlp
	jmp	false
;
	public	.lcmp		;compare primary and secondary
;
			;return 0 if p == s
p.lt.s:			;return < 0 if p < s
	xra	a
	dcr	a
	pop	b
	ret
;
p.gt.s:			;	> 0 if p > s
	xra	a
	inr	a
	pop	b
	ret
;
.lcmp:
	push	b
	lhld	lnprm
	xchg
	lhld	lnsec
	inx	h
	inx	h
	inx	h
	inx	d
	inx	d
	inx	d
	ldax	d
	ora	a
	jm	pneg
;			primary is positive
	xra	m		;check if signs the same
	jm	p.gt.s		;differ then p > s
	jmp	docomp
pneg:
			;primary is negative
	xra	m		;check if signs the same
	jm	p.lt.s		;differ the p < s
docomp:
	mvi	b,4
cmploop:
	ldax	d
	cmp	m
	jc	p.lt.s
	jnz	p.gt.s
	dcx	h
	dcx	d
	dcr	b
	jnz	cmploop
			;return 0 if p == s
	xra	a
	pop	b
	ret
	public .lad		;add secondary to primary
.lad:
			;DE is used as primary address
			;and HL is used as secondary address
	push	b
	lhld	lnprm
	xchg
	lhld	lnsec
	xra	a	;clear carry
	mvi	b,4
adloop:
	ldax	d
	adc	m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	adloop
	pop	b
	ret
;
	public	.lsb		;subtract secondary from primary
.lsb:
	push	b
	lhld	lnprm
	xchg
	lhld	lnsec
	xra	a	;clear carry
	mvi	b,4
sbloop:
	ldax	d
	sbb	m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	sbloop
	pop	b
	ret
;
	public	.lan		;and primary with secondary
.lan:
	push	b
	lhld	lnprm
	xchg
	lhld	lnsec
	mvi	b,4
ndloop:
	ldax	d
	ana	m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	ndloop
	pop	b
	ret
;
	public	.lor		;or primary with secondary
.lor:
	push	b
	lhld	lnprm
	xchg
	lhld	lnsec
	mvi	b,4
orloop:
	ldax	d
	ora	m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	orloop
	pop	b
	ret
;
	public	.lxr		;exclusive or primary with secondary
.lxr:
	push	b
	lhld	lnprm
	xchg
	lhld	lnsec
	mvi	b,4
xrloop:
	ldax	d
	xra	m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	xrloop
	pop	b
	ret
;
	public	.lcm		;complement primary
.lcm:
	lhld	lnprm
	mvi	d,4
cmloop:
	mov	a,m
	cma
	mov	m,a
	inx	h
	dcr	d
	jnz	cmloop
	ret
;
	public	.lls		;shift primary left by secondary
.lls:
	lhld	lnsec
	mov	a,m
	ani	03fH		;restrict to 63 bits
	rz
	push	b
	mov	b,a
	lhld	lnprm
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	mov	a,m
	inx	h
	mov	h,m
	mov	l,a
lsloop:
	dad	h		;shift high word
	xchg
	dad	h		;shift low word
	xchg
	jnc	lsnc
	inx	h		;carry into high word
lsnc:
	dcr	b
	jnz	lsloop
	mov	b,h
	mov	c,l
	lhld	lnprm		;now put result back
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	mov	m,c
	inx	h
	mov	m,b
	pop	b
	ret
;
	public	.lrs		;right shift primary by secondary bits
.lrs:
	lhld	lnsec
	mov	a,m
	ani	03fH		;limit to 63 places
	rz
	mov	d,a
	lhld	lnprm
	inx	h
	inx	h
	inx	h
	mov	a,m
	ora	a
	jm	rsneg
rslp1:
	push	h
	mvi	e,4
	ora	a	;clear carry
rslp2:
	mov	a,m
	rar
	mov	m,a
	dcx	h
	dcr	e
	jnz	rslp2
	pop	h
	dcr	d
	jnz	rslp1
	ret
;
rsneg:
	push	h
	mvi	e,4
	stc		;shift in sign set
rslpn:
	mov	a,m
	rar
	mov	m,a
	dcx	h
	dcr	e
	jnz	rslpn
	pop	h
	dcr	d
	jnz	rsneg
	ret
;
	dseg		;work area for divide and multiply routines
sign:	ds	1	;sign of result
lcnt:	ds	1	;iterations left
tmpa:	ds	4	;quotient 
tmpb:	ds	4	;remainder work area
tmpc:	ds	4	;temp for divisor
	cseg
;
setup:
	push	d
	mvi	b,4
setloop:
	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	setloop
	pop	h
	mov	c,a		;save for main line code
	ora	a		;check
	rp
	jmp	negate		;force positive
;
	public	.ldv
.ldv:		;long divide	(primary = primary/secondary)
	push	b
	lhld	lnprm
	lxi	d,tmpa		;copy dividend into work area
	call	setup
	mov	a,c
	sta	sign		;sign of dividend
	lhld	lnsec
	lxi	d,tmpc		;copy divisor into work area
	call	setup
	lda	sign
	xra	c
	sta	sign		;sign for result
	call	dodivide
	lxi	d,tmpa
	lhld	lnprm
	mvi	b,4
divsave:
	ldax	d
	mov	m,a
	inx	d
	inx	h
	dcr	b
	jnz	divsave
	pop	b
	lda	sign
	ora	a
	jm	.lng
	ret
;
	public	.lrm
.lrm:		;long remainder	(primary = primary%secondary)
	push	b
	lhld	lnprm
	lxi	d,tmpa		;copy dividend into work area
	call	setup
	mov	a,c
	sta	sign		;sign of dividend is sign of result
	lhld	lnsec
	lxi	d,tmpc		;copy divisor into work area
	call	setup
	call	dodivide
	lxi	d,tmpb
	lhld	lnprm
	mvi	b,4
remsave:
	ldax	d
	mov	m,a
	inx	d
	inx	h
	dcr	b
	jnz	remsave
	pop	b
	lda	sign
	ora	a
	jm	.lng
	ret
;
;
dodivide:
	mvi	b,4
	lxi	h,tmpb		;clear quotient buffer
	xra	a
quinit:
	mov	m,a
	inx	h
	dcr	b
	jnz	quinit

	mvi	a,32
	sta	lcnt		;initialize loop counter
divloop:
	lxi	h,tmpa
	mvi	b,8
	ora	a		;clear carry
shlp:
	mov	a,m
	adc	a		;shift one bit to the left
	mov	m,a
	inx	h
	dcr	b
	jnz	shlp
	sbb	a
	ani	1
	mov	c,a

	mvi	b,4
	lxi	d,tmpb
	lxi	h,tmpc
	ora	a		;clear carry
sublp:
	ldax	d
	sbb	m
	stax	d
	inx	d
	inx	h
	dcr	b
	jnz	sublp
	mov	a,c
	sbi	0
	jnz	zerobit
onebit:
	lxi	h,tmpa
	inr	m
	lxi	h,lcnt
	dcr	m
	jnz	divloop
	ret
;
zerobit:
	lxi	h,lcnt
	dcr	m
	jz	restore
	lxi	h,tmpa
	mvi	b,8
	ora	a		;clear carry
zshlp:
	mov	a,m
	adc	a		;shift one bit to the left
	mov	m,a
	inx	h
	dcr	b
	jnz	zshlp
	sbb	a
	mov	c,a

	mvi	b,4
	lxi	d,tmpb
	lxi	h,tmpc
	ora	a		;clear carry
daddlp:
	ldax	d
	adc	m
	stax	d
	inx	d
	inx	h
	dcr	b
	jnz	daddlp
	mov	a,c
	aci	0
	jnz	zerobit
	jmp	onebit
;
restore:			;fix up remainder if still negative
	mvi	b,4
	lxi	d,tmpb
	lxi	h,tmpc
	ora	a		;clear carry
resloop:
	ldax	d
	adc	m
	stax	d
	inx	d
	inx	h
	dcr	b
	jnz	resloop
	ret
;
;
	public	.lml
.lml:		;long multiply	(primary = primary * secondary)
	push	b
	lhld	lnsec
	mvi	b,4
	lxi	d,tmpc		;copy muliplicand into work area
msav1:
	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	msav1
;
	lhld	lnprm
	mvi	b,4
	lxi	d,tmpb	;copy multiplier into work area
msav2:
	mov	a,m
	stax	d
	inx	h
	inx	d
	dcr	b
	jnz	msav2
	mvi	b,4
	lxi	h,tmpa		;clear buffer
	xra	a
clrmul:
	mov	m,a
	inx	h
	dcr	b
	jnz	clrmul

	mvi	a,32
	sta	lcnt		;initialize loop counter
muloop:
	lxi	h,tmpa
	mvi	b,8
	ora	a		;clear carry
mshlp:
	mov	a,m
	adc	a		;shift one bit to the left
	mov	m,a
	inx	h
	dcr	b
	jnz	mshlp
	jnc	mnext

	mvi	b,4
	lxi	d,tmpa
	lxi	h,tmpc
	ora	a		;clear carry
maddlp:
	ldax	d
	adc	m
	stax	d
	inx	d
	inx	h
	dcr	b
	jnz	maddlp
;
	mvi	b,4
madclp:
	ldax	d
	aci	0
	stax	d
	jnc	mnext
	inx	d
	dcr	b
	jnz	madclp
;
mnext:
	lxi	h,lcnt
	dcr	m
	jnz	muloop

	lhld	lnprm
	lxi	d,tmpa
	mvi	b,4
msav:
	ldax	d
	mov	m,a
	inx	d
	inx	h
	dcr	b
	jnz	msav
	pop	b
	ret
;
;
	public .leq
.leq:
	call	.lcmp
	jz	true
false:
	lxi	h,0
	xra	a
	ret
;
	public .lne
.lne:
	call	.lcmp
	jz	false
true:
	lxi	h,1
	xra	a
	inr	a
	ret
;
	public .llt
.llt:
	call	.lcmp
	jm	true
	jmp	false
;
	public .lle
.lle:
	call	.lcmp
	jm	true
	jz	true
	jmp	false
;
	public .lge
.lge:
	call	.lcmp
	jm	false
	jmp	true
;
	public .lgt
.lgt:
	call	.lcmp
	jm	false
	jz	false
	jmp	true
;
	public	.utox
.utox:
	xchg
	lhld	lnprm
	mov	m,e
	inx	h
	mov	m,d
	inx	h
posconv:
	mvi	m,0
	inx	h
	mvi	m,0
	ret
;
	public	.itox
.itox:
	xchg
	lhld	lnprm
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	mov	a,d
	ora	a
	jp	posconv
	mvi	m,0ffH
	inx	h
	mvi	m,0ffH
	ret
;
	public	.xtoi
.xtoi:
	lhld	lnprm
	mov	e,m
	inx	h
	mov	d,m
	xchg
	ret
