/* Copyright (C) 1981,1982 by Manx Software Systems and Thomas Fenwick */
#include "stdio.h"

fread(buffer,size,number,stream)
register char *buffer; unsigned size; int number;
FILE *stream;
{
	int total;
	register int c,i;

	for ( total = 0 ; total < number ; ++total ) {
		for ( i = size ; i ; --i ) {
			if ( (c = getc(stream)) == EOF )
				return total;
			*buffer++ = c;
		}
	}
	return total;
}

fwrite(buffer,size,number,stream)
register char *buffer; unsigned size,number;
FILE *stream;
{
	register unsigned i,max;

	max = size * number;
	for ( i = 0 ; i < max ; ++i ) {
		if ( putc(*buffer++,stream) == EOF )
			return 0;
	}
	return number;
}

