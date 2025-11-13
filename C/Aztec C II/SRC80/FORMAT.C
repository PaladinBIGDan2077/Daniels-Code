/* Copyright (C) 1981,1982 by Manx Software Systems */
/* Copyright (C) 1981  Thomas Fenwick */

#define CII 1
#ifdef CII
typedef long val_t, uval_t;
#else
typedef int val_t;
typedef unsigned uval_t;
#define uconvert convert
#endif

static char *buff;

sprintf(str,fmt,args)
char *str, *fmt; unsigned args;
{
	int spsub();

	buff = str;
	format(spsub,fmt,&args);
	*buff = 0;
}

static
spsub(c)
{
	return (*buff++ = c)&0xff;
}

format(putsub, fmt, args)
register int (*putsub)(); register char *fmt; unsigned *args;
{
	register int c;
	int rj, fillc;
	int maxwidth, width;
	val_t value;
	int i, k;
	char *cp;
	char s[40];
#ifdef CII
	double dval;
#endif

	while ( c = *fmt++ ) {
		if ( c == '%' ) {
			s[14] = 0;
			rj = 1;
			fillc = ' ';
			maxwidth = 0x7fff;
			if ( (c = *fmt) == '-' ) {
				rj = 0;
				c = *fmt++;
			}
			if ( c == '0' )
				fillc = '0';
			for ( width = 0 ; (c = *fmt++) >= '0' && c <= '9' ; )
				width = width*10 + c - '0';
			if ( c == '.' ) {
				for ( maxwidth = 0 ; (c = *fmt++) >= '0' && c <= '9' ; )
					maxwidth = maxwidth*10 + c - '0';
			}
#ifdef CII
			if (c == 'l') {
				c = *fmt++;
				value = *((long *)args)++;
			} else if (c == 'd')
				value = (int)*args++;
			else if (c == 'e' || c == 'f' || c == 'g')
				dval = *((double *)args)++;
			else
#endif
				value = *args++;

			switch ( c ) {
			case 'o':
				cp = uconvert(value, 8, s+14);
				break;
			case 'd':
				if ( value < 0 ) {
					cp = convert(-value, 10, s+14);
					*--cp = '-';
				} else
					cp = convert(value, 10, s+14);
				break;
			case 'u':
				cp = uconvert((val_t)(uval_t)value, 10, s+14);
				break;
			case 'x':
				cp = uconvert(value, 16, s+14);
				break;
			case 's':
				i = strlen(cp = (char *)(unsigned)value);
				goto havelen;
#ifdef CII
			case 'e':
			case 'f':
				ftoa(dval, s, maxwidth==0x7fff?6:maxwidth, c=='e'?0:1);
				i = strlen(cp = s);
				maxwidth = 200;
				goto havelen;
#endif

			case 'c':
				c = value;
			default:
				*(cp = s+13) = c;
				break;
			}

			i = (s+14) - cp;
		havelen:
			if ( i > maxwidth )
				i = maxwidth;
			
			if ( rj ) {
				while ( width-- > i )
					(*putsub)(fillc);
			}
			for ( k = 0 ; *cp && k < maxwidth ; ++k )
				(*putsub)(*cp++);
			
			if ( !rj ) {
				while ( width-- > i )
					(*putsub)(' ');
			}
		} else
			(*putsub)(c);
	}
}

static char digits[]="0123456789abcdef";

static char *
convert(n, base, s)
register int base; register char *s; register uval_t n;
{
	do {
		*--s = digits[(int)(n%base)];
	} while ( (n /= base) != 0 );
	return s;
}

#ifdef CII
static char *
uconvert(n, base, s)
register int base; register char *s; long n;
{
	register int t;

	if (n < 0) {
		t = (int)n&1;
		n = (n>>1)&0x7fffffff;
		*--s = digits[((int)(n%(base>>1))<<1)+t];
		n /= base>>1;
	}
	return convert(n,base,s);
}
#endif
