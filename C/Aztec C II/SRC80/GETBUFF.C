/* Copyright (C) 1981,1982 by Manx Software Systems and Thomas Fenwick */
#include "stdio.h"

char *Stdbufs = 0;

FILE Cbuffs[MAXSTREAM] = {
	{ 0,0,0, _BUSY,0,0,BUFSIZ },
	{ 0,0,0, _BUSY,1,0,1 },
	{ 0,0,0, _BUSY,2,0,1 },
	{ 0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0 },
	{ 0,0,0,0,0,0,0 },
};

getbuff(ptr)
register FILE *ptr;
{
	char *buffer;

	if (ptr->_buflen == 1) {
smlbuff:
		ptr->_buff = &ptr->_bytbuf;
		return;
	}
	if (Stdbufs) {
		buffer = Stdbufs;
		Stdbufs = *(char **)Stdbufs;
	} else if ((buffer = alloc(ptr->_buflen)) == NULL) {
		ptr->_buflen = 1;
		goto smlbuff;
	}
	ptr->_flags |= _ALLBUF;
	ptr->_buff = buffer;
	return;
}


