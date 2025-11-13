;Copyright (C) 1981,1982 by Manx Software Systems
; Copyright (C) 1981  Thomas Fenwick
	public blockmv_
blockmv_:
	push b
	lxi h,9
	dad sp
	mov b,m
	dcx h
	mov c,m
	dcx h
	mov d,m
	dcx h
	mov e,m
	dcx h
	mov a,m
	dcx h
	mov l,m
	mov h,a
.mvlp:
	mov a,b
	ora c
	jz movdone
	ldax d
	mov m,a
	inx d
	inx h
	dcx b
	jmp .mvlp
movdone: pop b
	ret
	public clear_
clear_: push b
	lxi h,4
	dad sp
	mov e,m
	inx h
	mov d,m
	inx h
	mov c,m
	inx h
	mov b,m
	inx h
	mov l,m
	xchg
.clrlp:
	mov a,b
	ora c
	jz .clrdone
	mov m,e
	inx h
	dcx b
	jmp .clrlp
.clrdone: pop b
	ret
	end
