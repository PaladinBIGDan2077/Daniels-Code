/* Copyright (C) 1981,1982 by Manx Software Systems */
/* Copyright (C) 1981  Thomas Fenwick */
atoi(cp)
register char *cp;
{
	register unsigned i;
	register sign;

	sign = 0;
	if ( *cp == '-' ) {
		++cp;
		sign = 1;
	} else if ( *cp == '+' )
		++cp;

	for ( i = 0 ; isdigit(*cp) ; )
		i = i*10 + *cp++ - '0';
	return sign ? -i : i;
}
