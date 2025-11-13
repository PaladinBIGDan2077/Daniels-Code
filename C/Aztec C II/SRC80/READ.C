#include "io.h"
#include "errno.h"
#include "fcntl.h"

int badfd(), filerd(), conin(), bdosrd();

static int (*readtab[])() = {
	badfd, filerd, conin, bdosrd,
};
extern int errno;

read(fd, buff, len)
char *buff;
{
	register struct channel *chp;

	if (fd < 0 || fd > MAXCHAN) {
		errno = EBADF;
		return -1;
	}
	chp = &chantab[fd];
	return (*readtab[chp->c_read])(chp->c_arg, buff, len);
}

#define Wrkbuf ((char *)0x80)

filerd(afp,buffer,len)
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
		if (getsect(fp, buffer, l))
			return -1;
	}
	if (k = (len-l)/128)
		if ((j = blkrd(&fp->fcb, buffer+l, k)) != 0)
			return (k-j)*128 + l;
	l += k*128;
	if (l < len)
		if (getsect(fp, buffer+l, len-l))
			return l;
	return len;
}

getsect(fp, buf, len)
register struct fcbtab *fp; char *buf; unsigned len;
{
	bdos(SETDMA, Wrkbuf);
	if ((errno = bdos(READRN, &fp->fcb)) != 0)
		return -1;
	blockmv(buf, Wrkbuf+fp->offset, len);
	if ((fp->offset = (fp->offset + len) & 127) == 0)
		++fp->fcb.f_record;
	return 0;
}

conin(x,buff,len)
char *buff;
{
	static char buffer[258] = { 0,0,0,0,0 };
	static int used = 0;
	register int l;

	if (buffer[1] == 0) {
		buffer[0] = 255;
		buffer[1] = buffer[2] = 0;
		bdos(10,buffer);
		bdos(2,'\n');
		if (buffer[2] == 0x1a) {
			buffer[1] = 0;
			return 0;
		}
		buffer[++buffer[1] + 1] = '\r';
		buffer[++buffer[1] + 1] = '\n';
		used = 2;
	}
	if ((l = buffer[1]) > len)
		l = len;
	blockmv(buff, buffer+used, l);
	used += l;
	buffer[1] -= l;
	return l;
}

bdosrd(kind, buff, len)
register char *buff;
{
	register int count;

	for (count = 0 ; count < len ; ++count) {
		if ((*buff++ = bdos(kind)) == 0x1a)
			break;
	}
	return count;
}
