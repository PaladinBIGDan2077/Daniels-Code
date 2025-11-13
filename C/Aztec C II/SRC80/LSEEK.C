/* Copyright (C) 1982 by Manx Software Systems and Thomas Fenwick */
#include "io.h"
#include "errno.h"

long lseek(fd, pos, how)
long pos;
{
	register struct fcbtab *fp;

	if (fd < 0 || fd > MAXCHAN || chantab[fd].c_seek == 0) {
		errno = EBADF;
		return -1L;
	}
	fp = chantab[fd].c_arg;

	switch (how) {
	case 2:
		/*
		 * Close the file because CP/M doesn't know how big an open file is.
		 * However, the fcb is still valid.
		 */
		if (bdos(CLSFIL, &fp->fcb) == 255) {
			errno = EBADF;
			return -1L;
		}
		bdos(FILSIZ, &fp->fcb);
		fp->offset = 0;
	case 1:
		pos += fp->offset + ((long)fp->fcb.f_record << 7);
	case 0:
		break;

	default:
		errno = EINVAL;
		return -1L;
	}

	fp->fcb.f_overfl = 0;
	if (pos < 0) {
		fp->offset = fp->fcb.f_record = 0;
		errno = EINVAL;
		return -1L;
	}
	fp->offset = (unsigned)pos & 127;
	fp->fcb.f_record = pos >> 7;
	return pos;
}

