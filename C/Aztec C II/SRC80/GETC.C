/* Copyright (C) 1982 by Manx Software Systems and Thomas Fenwick */
#include "stdio.h"

getw(stream)
FILE *stream;
{
	register int x1,x2;

	if ((x1 = getc(stream)) == EOF || (x2 = getc(stream)) == EOF)
		return EOF;
	return (x2<<8) | x1;
}

getc(ptr)
register FILE *ptr;
{
	register int len;

	if (ptr->_bp >= ptr->_bend) {
		if (ptr->_flags&_EOF)
			return EOF;
		ptr->_flags &= ~_DIRTY;
		if (ptr->_buff == NULL)
			getbuff(ptr);
		if ((len = read(ptr->_unit,ptr->_buff,ptr->_buflen)) <= 0) {
			ptr->_flags |= len==0 ? _EOF : _IOERR;
			return EOF;
		}
		ptr->_bend = (ptr->_bp = ptr->_buff) + len;
	}
	return *ptr->_bp++ & 255;
}
