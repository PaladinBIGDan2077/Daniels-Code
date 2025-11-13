/* Copyright (C) 1981,1982 by Manx Software Systems and Thomas Fenwick */
#include "stdio.h"

puterr(c)
{
	return putc(c, stderr);
}

putw(w,stream)
register unsigned w;
FILE *stream;
{
	if ( putc(w,stream) < 0 ) 
		return EOF;
	else if ( putc((w>>8),stream) < 0 )
		return EOF;
	return w;
}

putc(c,ptr)
int c; register FILE *ptr;
{
	if (ptr->_bp >= ptr->_bend)
		return flush_(ptr,c&0xff);
	return (*ptr->_bp++ = c) & 0xff;
}

fflush(ptr)
FILE *ptr;
{
	return flush_(ptr,-1);
}

closall_()		/* called by exit to close any open files */
{
	register FILE *fp;

	for ( fp = Cbuffs ; fp < Cbuffs+MAXSTREAM ; )
		fclose(fp++);
}

fclose(ptr)
register FILE *ptr;
{
	int err;

	err = 0;
	if ( ptr->_flags ) {
		if (ptr->_flags&_DIRTY)	/* if modifed flush buffer */
			err = flush_(ptr,-1);
		err |= close(ptr->_unit);
		if (ptr->_flags&_ALLBUF) {
			*(char **)ptr->_buff = Stdbufs;
			Stdbufs = ptr->_buff;
		}
	}
	ptr->_flags = 0;
	return err;
}

flush_(ptr,data)
register FILE *ptr;
{
	register int size;

	if (ptr->_flags & _DIRTY) {
		size = ptr->_bp - ptr->_buff;
		if (write(ptr->_unit, ptr->_buff, size) == -1) {
ioerr:
			ptr->_flags |= _IOERR;
			return EOF;
		}
	}
	if (data == -1) {
		ptr->_flags &= ~_DIRTY;
		ptr->_bend = ptr->_bp = NULL;
		return 0;
	}
	if (ptr->_buff == NULL)
		getbuff(ptr);
	if (ptr->_buflen == 1) {	/* unbuffered I/O */
		if (write(ptr->_unit, &data, 1) == -1)
			goto ioerr;
		return data;
	}
	ptr->_bp = ptr->_buff;
	ptr->_bend = ptr->_buff + ptr->_buflen;
	ptr->_flags |= _DIRTY;
	return (*ptr->_bp++ = data) & 0xff;
}
