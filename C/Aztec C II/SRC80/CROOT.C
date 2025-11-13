/* Copyright (C) 1981,1982 by Manx Software Systems */
/* Copyright (C) 1982  Thomas Fenwick */
#include "errno.h"
#include "fcntl.h"
#include "io.h"

int badfd(), noper();

/*
 * channel table: relates fd's to devices
 */
struct channel  chantab[] = {
	{ 2, 0, 1, 0, noper, 2 },
	{ 0, 2, 1, 0, noper, 2 },
	{ 0, 2, 1, 0, noper, 2 },
	{ 0, 0, 0, 0, badfd, 0 },
	{ 0, 0, 0, 0, badfd, 0 },
	{ 0, 0, 0, 0, badfd, 0 },
	{ 0, 0, 0, 0, badfd, 0 },
	{ 0, 0, 0, 0, badfd, 0 },
	{ 0, 0, 0, 0, badfd, 0 },
	{ 0, 0, 0, 0, badfd, 0 },
	{ 0, 0, 0, 0, badfd, 0 },
};

#define MAXARGS 30
static char *Argv[MAXARGS];
static char Argbuf[128];
static int Argc;

Croot()
{
	register char *cp, *fname;
	register int k;

	blockmv(Argbuf, (char *)0x81, 127);
	Argbuf[*(char *)0x80 & 0x7f] = 0;
	Argv[0] = "";
	cp = Argbuf;
	Argc = 1;
	while (Argc < MAXARGS) {
		while (*cp == ' ' || *cp == '\t')
			++cp;
		if (*cp == 0)
			break;
		if (*cp == '>') {		/* redirect output */
			k = 1;
			goto redirect;
		} else if (*cp == '<') {	/* redirect input */
			k = 0;
redirect:
			while (*++cp == ' ' || *cp == '\t')
				;
			fname = cp;
			while (*++cp)
				if (*cp == ' ' || *cp == '\t') {
					*cp++ = 0;
					break;
				}
			close(k);
			if (k)
				k = creat(fname, 0666);
			else
				k = open(fname, O_RDONLY);
			if (k == -1) {
				strcpy(0x80, "Can't open file for redirection: ");
				strcat(0x80, fname);
				strcat(0x80, "\n");
				write(2, 0x80, strlen(0x80));
				exit(10);
			}
		} else {
			Argv[Argc++] = cp;
			while (*++cp)
				if (*cp == ' ' || *cp == '\t') {
					*cp++ = 0;
					break;
				}
		}
	}
	exit(main(Argc,Argv));
}

exit(code)
{
	closall_();
	if ( code )
		unlink("A:$$$.SUB");
	boot_();
}

badfd()
{
	errno = EBADF;
	return -1;
}

noper()
{
	return 0;
}

