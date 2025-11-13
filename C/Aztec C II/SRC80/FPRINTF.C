/* Copyright (C) 1981,1982 by Manx Software Systems */
/* Copyright (C) 1982  Thomas Fenwick */
#include "stdio.h"

static FILE *Stream;

printf(fmt,args)
char *fmt; unsigned args;
{
	int fpsub();

	Stream = stdout;
	format(fpsub,fmt,&args);
}

fprintf(stream,fmt,args)
FILE *stream; char *fmt; unsigned args;
{
	int fpsub();

	Stream = stream;
	format(fpsub,fmt,&args);
}

static
fpsub(c)
{
	return aputc(c,Stream);
}
