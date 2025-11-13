
/* Copyright (C) 1982 by Manx Software Systems */
long
atol(cp)
register char *cp;
{
	long n;
	register sign;

	sign = 0;
	if ( *cp == '-' ) {
		++cp;
		sign = 1;
	} else if ( *cp == '+' )
		++cp;

	for ( n = 0 ; isdigit(*cp) ; )
		n = n*10 + *cp++ - '0';
	return sign ? -n : n;
}
