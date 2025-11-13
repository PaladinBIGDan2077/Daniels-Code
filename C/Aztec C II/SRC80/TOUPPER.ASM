;Copyright (C) 1981,1982 by Manx Software Systems
; Copyright (C) 1981  Thomas Fenwick
	public isspace_
isspace_:
	lxi	h,2
	dad	sp
	mov	a,m
	cpi	' '
	jz	true
	cpi	9		;check for tab
	jz	true
	cpi	10		;check for newline
	jz	true
	jmp	false
;
	public isupper_
isupper_:
	lxi h,2
	dad sp
	mov a,m
	cpi 'A'
	jc  false
	cpi 'Z'+1
	jnc false
true:
	lxi h,1
	mov a,l
	ora a
	ret
;
	public islower_
islower_:
	lxi h,2
	dad sp
	mov a,m
	cpi 'a'
	jc  false
	cpi 'z'+1
	jc true
false:
	lxi h,0
	xra a
	ret
;
	public isdigit_
isdigit_:
	lxi h,2
	dad sp
	mov a,m
	cpi '0'
	jc  false
	cpi '9'+1
	jnc false
	jmp true
;
	public toupper_
;
toupper_:
	lxi h,2
	dad sp
	mov a,m
	cpi 'a'
	jc	out
	cpi 'z'+1
	jnc out
	sui 'a'-'A'
out:
	mov l,a
	mvi h,0
	ora a
	ret
;
;
	public tolower_
;
tolower_:
	lxi h,2
	dad sp
	mov a,m
	cpi 'A'
	jc	skip
	cpi 'Z'+1
	jnc skip
	adi 'a'-'A'
skip:
	mov l,a
	mvi h,0
	ora a
	ret
	end
