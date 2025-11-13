#define BUFF ((char *)0x80)
#define BSIZE	128
#define OVMAGIC	0xf0
#define E_OVSMALL	-5
#define E_NOMEM		-6
#define E_NOTOVLY	-7

int errno;

struct header {
	int magic;
	unsigned ovaddr;
	unsigned ovsize;
	int (*ovbgn)();
};

#define EXTRA (BSIZE - sizeof(struct header))

ovloader(ovname, args)
char *ovname;
{
	int fd, flag = 0;
	char *topmem, *settop();
	unsigned size;
	static struct header hdr;
	
	strcpy(BUFF, ovname);
again:
	strcat(BUFF, ".ovr");
	if ((fd = open(BUFF, 0)) < 0) {
		if (flag++)
			return -1;
		strcpy(BUFF, "a:");
		strcat(BUFF, ovname);
		goto again;
	}
	if (read(fd, BUFF, BSIZE) < 0)
		return -1;
	blockmv(&hdr,BUFF,sizeof(struct header));
	/* check magic number on overlay file */
	if (hdr.magic != OVMAGIC) {
		errno = E_NOTOVLY;
		return -1;
	}
	topmem = settop(0);
	if (topmem < hdr.ovaddr + hdr.ovsize) {
		if (settop(hdr.ovaddr + hdr.ovsize - topmem) == 0) {
			errno = E_NOMEM;
			return -1;
		}
	}
	blockmv(hdr.ovaddr,BUFF+sizeof(struct header),EXTRA); 
	if (hdr.ovsize > EXTRA) {
		size = hdr.ovsize - EXTRA;
		if (read(fd, hdr.ovaddr+EXTRA, size) < size) {
			if (errno == 0)
				errno = E_OVSMALL;
			return -1;
		}
	}
	close(fd);
	return (*hdr.ovbgn)(&args);
}
