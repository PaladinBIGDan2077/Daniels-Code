/* Copyright (C) 1981,1982 by Manx Software Systems */
/* Copyright (C) 1981  Thomas Fenwick */
char *
alloc(size)
unsigned size;
{
	static char *coremax = 0,*corebase = 0;
	register char *cp;

	if ( corebase == 0 )
		corebase = coremax = settop(0);
	cp = corebase;
	if ((corebase += size) < cp) {
nogood:
		corebase = cp;
		return 0;
	}
	if (corebase > coremax) {
		if (settop(size = (corebase-coremax+511) & -512) == 0)
			goto nogood;
		coremax += size;
	}
	return cp;
}
