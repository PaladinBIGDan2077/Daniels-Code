/* Copyright (C) 1982 by Manx Software Systems and Thomas Fenwick */
#include "io.h"
#include "errno.h"

posit(fd, pos)
unsigned pos;
{
	register struct fcbtab *fp;

	if (fd < 0 || fd > MAXCHAN || chantab[fd].c_seek == 0) {
		errno = EBADF;
		return -1;
	}
	fp = chantab[fd].c_arg;
	fp->fcb.f_record = pos;
	fp->offset = fp->fcb.f_overfl = 0;
	return 0;
}

