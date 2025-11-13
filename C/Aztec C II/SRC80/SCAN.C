/* Copyright (C) 1982 by Manx Software Systems and Thomas Fenwick */
#include "stdio.h"

static int maxwidth;
static int (*gsub)();
char *index();

static char *scnstr;
static char quit;

sscanf(string, fmt, arg)
char *string, *fmt; int *arg;
{
	int sgetc();

	scnstr = string;
	quit = 0;
	return scanfmt(sgetc, fmt, &arg);
}

static
sgetc(what)
{
	if (what == 0) {
		if (*scnstr)
			return *scnstr++ & 255;
		quit = 1;
	} else {
		if (!quit)
			return *--scnstr & 255;
	}
	return EOF;
}

scanfmt(getsub, fmt, args)
int (*getsub)(); register char *fmt; int **args;
{
	double getflt(), d;
	long getnum(), lv;
	int c, count, suppress, lflag, base;
	char *cp;
	char tlist[130];
	static char list[] = "ABCDEFabcdef9876543210";
	static char vals[] = {
			10,11,12,13,14,15,10,11,12,13,14,15,9,8,7,6,5,4,3,2,1,0
	};

	count = 0;
	gsub = getsub;
	while (c = *fmt++) {
		if (c == '%') {
			lflag = suppress = 0;
			maxwidth = 127;
			if (*fmt == '*') {
				++fmt;
				suppress = 1;
			}
			if (isdigit(*fmt)) {
				maxwidth = 0;
				do {
					maxwidth = maxwidth*10 + *fmt - '0';
				} while (isdigit(*++fmt));
			}
			if (*fmt == 'l') {
				lflag = 1;
				++fmt;
			}
	
			switch (*fmt++) {
			case '%':
				c = '%';
				goto matchit;
			case 'h':			/* specify short (for compatibility) */
				lflag = 0;
				goto decimal;
			case 'D':
				lflag = 1;
			case 'd':
	decimal:
				c = 12;
				base = 10;
				goto getval;

			case 'X':
				lflag = 1;
			case 'x':
				c = 0;
				base = 16;
				goto getval;

			case 'O':
				lflag = 1;
			case 'o':
				c = 14;
				base = 8;
	getval:
				if (skipblank())
					goto ateof;
				lv = getnum(&list[c], &vals[c], base);
				if (!suppress) {
					if (lflag)
						*(long *)(*args++) = lv;
					else
						**args++ = lv;
					++count;
				}
				break;

			case 'E':
			case 'F':
				lflag = 1;
			case 'e':
			case 'f':
				if (skipblank())
					goto ateof;
				d = getflt(tlist);
				if (!suppress) {
					if (lflag)
						*(double *)(*args++) = d;
					else
						*(float *)(*args++) = d;
					++count;
				}
				break;
			case '[':
				lflag = 0;
				if (*fmt == '^' || *fmt == '~') {
					++fmt;
					lflag = 1;
				}
				for (cp = tlist ; (c = *fmt++) != ']' ; )
					*cp++ = c;
				*cp = 0;
				goto string;
			case 's':
				lflag = 1;
				tlist[0] = ' ';
				tlist[1] = '\t';
				tlist[2] = '\n';
				tlist[3] = 0;
		string:
				if (skipblank())
					goto ateof;
				if (!suppress)
					cp = *args++;
				while (maxwidth--) {
					if ((c = (*gsub)(0)) == EOF)
						break;
					if (lflag ? (index(tlist,c) != 0) : (index(tlist,c) == 0)) {
						(*gsub)(1);	/* unget last character */
						break;
					}
					if (!suppress)
						*cp++ = c;
				}
				if (!suppress) {
					*cp = 0;
					++count;
				}
				break;

			case 'c':
				if ((c = (*gsub)(0)) == EOF)
					goto ateof;
				if (!suppress) {
					*(char *)(*args++) = c;
					++count;
				}
				break;
			}
		} else if (isspace(c)) {
			if (skipblank()) {
ateof:
				if (count == 0)
					return EOF;
				return count;
			}
		} else {
matchit:
			if (skipblank())
				goto ateof;
			if ((*gsub)(0) != c)
				return count;
		}
	}
	return count;
}

skipblank()
{
	while (isspace((*gsub)(0)))
		;
	if ((*gsub)(1) == EOF)
		return EOF;
	return 0;
}

double getflt(buffer)
char *buffer;
{
	register int c;
	char decpt, sign, exp;
	register char *cp;
	double atof();

	cp = buffer;
	sign = exp = decpt = 0;

	while (maxwidth--) {
		c = (*gsub)(0);
		if (!sign && (c == '-' || c == '+'))
			sign = 1;
		else if (!decpt && c == '.')
			decpt = 1;
		else if (!exp && (c == 'e' || c == 'E')) {
			sign = 0;
			exp = decpt = 1;
		} else if (!isdigit(c)) {
			(*gsub)(1);
			break;
		}
		*cp++ = c;
	}
	*cp = 0;
	return atof(buffer);
}

long getnum(list, values, base)
char *list; char *values;
{
	int c;
	long val;
	int sign;
	register char *cp;

	if (maxwidth <= 0)
		return 0L;
	val = sign = 0;
	if ((c = (*gsub)(0)) == '-') {
		sign = 1;
		--maxwidth;
	} else if (c == '+')
		--maxwidth;
	else
		(*gsub)(1);

	while (maxwidth--) {
		if ((cp = index(list, (*gsub)(0))) == NULL) {
			(*gsub)(1);
			break;
		}
		val *= base;
		val += values[cp-list];
	}
	if (sign)
		val = -val;
	return val;
}

