/*
	general support functions for floating point work
*/

double fabs(x)
double x;
{
	if (x < 0.0)
		return -x;
	return x;
}

double amax1(a,b)
double a,b;
{
	if (a > b)
		return a;
	return b;
}

double sign(a,b)
double a,b;
{
	register int s;
	
	s = *(char *)&b & 0x80;
	*(char *)&a = (*(char *)&a & 0x7f) | s;
	return a;
}

#ifdef FOOP
intxp(x)
double x;
{
	register int exp;
	
	if ((exp = (*(char *)&x & 0x7f) - 64) == -64)
		exp = 0;
	return exp;
}

double adx(x,n)
double x; register int n;
{
	if (x == 0.0)
		return x;
	n += (*(char *)&x & 0x7f) - 64;
	if (n < -63 || n > 63)
		return 0.0;
	*(char *)&x = (*(char *)&x & 0x80) | (n + 64);
	return x;
}

double setxp(x,n)
double x;
{
	if (x == 0.0 || n < -63 || n > 63)
		return 0.0;
	*(char *)&x = (*(char *)&x & 0x80) | (n + 64);
	return x;
}
#endif

double ran()
{
	static long iy = 100001;
	
	iy *= 125;
	iy -= (iy/2796203) * 2796203;
	return (double)iy / 2796203.0;
}
