#include "io.h"
#include "errno.h"

int bdoswr(), filewr(), badfd();

static int (*wrt_tab[])() = {
	badfd, filewr, bdoswr, bdoswr
};

write(fd, buff, len)
char *buff;
{
	register struct channel *chp;

	if (fd < 0 || fd > MAXCHAN) {
		errno = EBADF;
		return -1;
	}
	chp = &chantab[fd];
	return (*wrt_tab[chp->c_write])(chp->c_arg, buff, len);
}

#define Wrkbuf ((char *)0x80)

filewr(afp,buffer,len)
struct fcbtab *afp;
char *buffer; unsigned len;
{
	register unsigned l = 0;
	register struct fcbtab *fp;
	unsigned k,j;

	fp = afp;
	if (fp->offset) {
		if ((l = 128 - fp->offset) > len)
			l = len;
		if (putsect(fp, buffer, l))
			return -1;
	}
	if (k = (len-l)/128)
		if ((j = blkwr(&fp->fcb, buffer+l, k)) != 0)
			return (k-j)*128 + l;
	l += k*128;
	if (l < len)
		if (putsect(fp, buffer+l, len-l))
			return l;
	return len;
}

putsect(fp, buf, len)
register struct fcbtab *fp; char *buf; unsigned len;
{
	bdos(SETDMA, Wrkbuf);
	if ((errno = bdos(READRN, &fp->fcb)) == 1 || errno == 4) {
		errno = 0;
		clear(Wrkbuf, 128, 0x1a);
	} else if (errno)
		return -1;
	blockmv(Wrkbuf+fp->offset, buf, len);
	if ((errno = bdos(WRITRN, &fp->fcb)) != 0)
		return -1;
	if ((fp->offset = (fp->offset + len) & 127) == 0)
		++fp->fcb.f_record;
	return 0;
}

bdoswr(kind, buff, len)
register char *buff;
{
	int c;
	register int count;

	for (count = 0 ; count < len ; ++count) {
		c = *buff++;
		if ( c == '\n' )
			bdos(kind,'\r');
		bdos(kind,c);
	}
	return count;
}

