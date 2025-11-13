/* Copyright (C) 1981,1982 by Manx Software Systems and Thomas Fenwick */
#include "stdio.h"
#include "fcntl.h"
#include "errno.h"

extern int errno;

fopen(name,mode)
char *name,*mode;
{
	register FILE *i;
	register int k;
	char *alloc();

	i = Cbuffs;
	while ( i->_flags ) {
		if ( ++i >= Cbuffs+MAXSTREAM )
			return (NULL);
	}

	k = mode[1] == '+';
	switch ( *mode ) {
	case 'r':
		if ((i->_unit = open(name, k?O_RDWR:O_RDONLY)) == -1)
			return (NULL);
		break;

	case 'w':
		if ((i->_unit = open(name, (k?O_RDWR:O_WRONLY)|O_CREAT|O_TRUNC)) == -1)
			return (NULL);
		break;
	
	case 'a':
		if ((i->_unit = open(name, (k?O_RDWR:O_WRONLY)|O_CREAT)) == -1)
			return (NULL);
		lseek(i->_unit,0L,2);
		break;

	default:
		errno = EINVAL;
		return NULL;
	}

	i->_flags = _BUSY;
	i->_buflen = BUFSIZ;
	i->_buff = 
	i->_bend =  /* nothing in buffer */
	i->_bp = 0;
	return (i);
}

