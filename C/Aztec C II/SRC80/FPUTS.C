/* Copyright (C) 1981,1982 by Manx Software Systems and Thomas Fenwick */
#include "stdio.h"

puts(str)
register char *str;
{
	while (*str)
		if (putchar(*str++) == EOF)
			return EOF;
	return putchar('\n');
}

fputs(s,fp)
register char *s;
FILE *fp;
{
	while ( *s )
		if (aputc(*s++,fp) == EOF)
			return(EOF);
	return 0;
}

aputc(c,ptr)
register int c; register FILE *ptr;
{
	c &= 127;
	if (c == '\n')
		if (putc('\r',ptr) == EOF)
			return EOF;
	return putc(c,ptr);
}

