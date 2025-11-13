#ifdef UNIX
#include <stdio.h>
#define FNSIZE 100
#define EXTEND	".rel"
#else
#define EXTEND	".o"
#ifdef MPU6502
#include	"/usr/xbin/mtuio.h"
#else
#include "stdio.h"
#define FNSIZE 20
#endif
#endif
#include "object.h"
#define MAXMOD	256
#define GRAIN	128		/* boundary to start new modules on within the file */
#define GRSHFT	7		/* log base 2 of GRAIN */

long ftell();
int append, extract, table;
FILE *libfp;

main(argc,argv)
int argc; char **argv;
{
	FILE *fp, *outfp;
	register char *cp, *tp;
	char *libname, templib[FNSIZE];
	struct header head;
	unsigned i, size, lastone, global;
	struct library lib;
	struct l_item *item;
	struct gbltab sym;
	int count;
	long next, origpos, lastdir;
	struct {
		char modname[10];
		char filename[FNSIZE];
	} modlist[MAXMOD], *modp, *maxmod;
	char *bufp, cmdbuf[130];

	libname = "libc.lib";
	outfp = NULL;
	if ( argc < 2 ) {
use:
		printf(
			"usage: libutil [-artx] [-o libraryname] name ...\n");
		exit(4);
	}

	while (--argc) {
		cp = *++argv;
		if (*cp++ != '-')
			break;
		while (*cp) {
			switch (*cp++) {
			default:
				printf("bad argument: %s\n",cp);
				goto use;
			case 'o': case 'O':
				libname = *++argv;
				--argc;
				continue;
			case 'a': case 'A':
				append = 1;
				continue;
			case 'r': case 'R':
				append = 1;
				continue;
			case 'x': case 'X':
				extract = 1;
				continue;
			case 't': case 'T':
				table = 1;
				continue;
			}
		}
	}

	makename(templib, libname, ".$$$");
	if (extract || table) {
		if ((libfp = fopen(libname,"r")) == NULL) {
opnerr:
			printf("Cannot open library: %s!\n",libname);
			exit(4);
		}
		if (extract)
			xtrct(argc,argv);
		else
			dir();
		exit(0);
	} else if (append) {
		if ((libfp = fopen(libname, "r")) == NULL)
			goto opnerr;
		if ((outfp = fopen(templib, "w+")) == NULL)
			goto opnerr;
	} else {
		if ((outfp = fopen(templib, "w+")) == NULL)
			goto opnerr;
	}

	if ( argc < 1 )
		goto use;
	clear(&lib, sizeof lib, 0);
	lib.lb_magic = H_LIBRARY;
	item = lib.lb_items;
	lastdir = 0;
	fwrite(&lib, sizeof lib, 1, outfp);

	modp = modlist;
	bufp = cmdbuf;
	*bufp = 0;
	while ( argc ) {
		if (strcmp(*argv, ".") == 0) {
			for (;;) {
				while (*bufp == ' ' || *bufp == '\t')
					++bufp;
				if (*bufp != 0)
					break;
				bufp = cmdbuf;
				if (gets(cmdbuf)==NULL || *bufp==0 || strcmp(bufp, ".")==0) {
					*bufp = 0;
					--argc;
					++argv;
					goto nxtarg;
				}
			}
			for (cp = modp->filename ; *bufp ; *cp++ = *bufp++)
				if (*bufp == ' ' || *bufp == '\t')
					break;
			*cp = 0;
		} else {
			strcpy(modp->filename, *argv++);
			--argc;
		}
		if ((cp = rindex(modp->filename,'/')) != NULL 
				|| (cp = rindex(modp->filename,':')) != NULL)
			++cp;
		else
			cp = modp->filename;

		clear(modp->modname, sizeof modp->modname, 0);
		for (tp = modp->modname, i = 0 ; i < 8 ; ++i) {
			if (*cp == 0 || *cp == '.')
				break;
			*tp++ = tolower(*cp++);
		}

		if (index(modp->filename,'.') == NULL)
			strcat(modp->filename, EXTEND);
		if (++modp >= modlist+MAXMOD) {
			printf("too many module names!\n");
			exit(4);
		}
nxtarg:	;
	}
	maxmod = modp;
	if (modp == modlist) {
		printf("No modules to add or replace.\n");
		fclose(outfp);
		unlink(templib);
		exit(4);
	}

	for (;;) {
		if (libfp)
			fp = libfp;
		else {
			for (modp = modlist ; modp < maxmod ; ++modp)
				if (modp->filename[0])
					goto fndmod;
			break;

	fndmod:
			if ((fp = fopen(modp->filename,"r")) == NULL) {
				printf("cannot open input: %s\n", modp->filename);
				exit(4);
			}
			modp->filename[0] = 0;
			if (libfp)
				printf("replacing module: %s\n", modp->modname);
			else
				printf("adding module: %s\n", modp->modname);
		}

		while (fread(&head,sizeof(head),1,fp) == 1) {
			if (head.h_magic == H_LIBRARY) {
				fseek(fp, (long)(sizeof(struct library)-sizeof(head)), 1);
				continue;
			}
			if (head.h_magic != H_MAGIC)
				break;
			origpos = ftell(fp) - sizeof head;
			next = origpos + head.h_next;
			lastone = ftell(outfp) >> GRSHFT;
			if (head.h_name[0] == 0) {
				strncpy(head.h_name, modp->modname, 8);
			} else {
				if (fp == libfp) {
					for (modp = modlist ; modp < maxmod ; ++modp)
						if (modp->filename[0] != 0 &&
								strncmp(modp->modname,head.h_name,8) == 0) {
							fseek(libfp, next, 0);
							goto fndmod;
						}
				}
				for (cp = head.h_name, i = 0 ; *cp && i < 8 ; ++i, ++cp)
					*cp = tolower(*cp);
			}
			if ((global = head.h_global) != sizeof head) {
				head.h_next = (head.h_end + GRAIN-1) & -GRAIN;
				head.h_global = sizeof head;
				head.h_local = sizeof head + head.h_local - global;
				head.h_end = sizeof head + head.h_end - global;
			}

			if (fwrite(&head,sizeof(head),1,outfp) <= 0) {
	ioerr:
				printf("Error writting library!\n");
				fclose(outfp);
				unlink(templib);
				exit(4);
			}

			if (global == sizeof head) {
				if (copyfile(fp, outfp, head.h_next - sizeof head))
					goto ioerr;
				fseek(fp, origpos+global, 0);
			} else {
				fseek(fp, origpos+global, 0);
				if (copyfile(fp, outfp, head.h_end - head.h_global))
					goto ioerr;
				fseek(fp, origpos+sizeof head, 0);
				if (copyfile(fp, outfp, global-sizeof(head)))
					goto ioerr;
			}
			padout(outfp, GRAIN);

			count = (head.h_local - head.h_global) / sizeof (sym);
			while ( count-- ) {
				fread(&sym, sizeof sym, 1, fp);
				if ((sym.g_flags&S_GLOBL) && sym.g_type != S_UND) {
					if (item >= lib.lb_items+LBSIZE) {
						padout(outfp, GRAIN);
						lib.lb_next = ftell(outfp) >> GRSHFT;
						fseek(outfp, lastdir, 0);
						fwrite(&lib, sizeof lib, 1, outfp);
						lastdir = lib.lb_next << GRSHFT;
						fseek(outfp, lastdir, 0);
						clear(&lib, sizeof lib, 0);
						lib.lb_magic = H_LIBRARY;
						fwrite(&lib, sizeof lib, 1, outfp);
						item = lib.lb_items;
					}
					strncpy(item->li_name, sym.g_name, 8);
					item->li_pos = lastone;
					++item;
				}
			}
			fseek(fp,next,0);
		}
		if (fp == libfp)
			libfp = NULL;
		fclose(fp);
	}

	fseek(outfp, lastdir, 0);
	fwrite(&lib, sizeof lib, 1, outfp);
	if (fclose(outfp) != 0)
		goto ioerr;
	rename(templib, libname);
	exit(0);
}

padout(fp, bound)
unsigned bound; FILE *fp;
{
	register unsigned i, next;

	i = ftell(fp);
	next = (i+bound-1) & -bound;
	for ( ; i < next ; ++i )
		putc(0,fp);		/* pad out block */
}

dir()
{
	struct header head;
	register int i;

	i = 6;
	while (fread(&head,sizeof(head),1,libfp) == 1) {
		if (head.h_magic == H_LIBRARY) {
			fseek(libfp, (long)(sizeof(struct library)-sizeof(head)), 1);
			continue;
		}
		if (head.h_magic != H_MAGIC)
			break;
		printf("%-12.8s", head.h_name);
		if (--i == 0) {
			putchar('\n');
			i = 6;
		}
		fseek(libfp, (long)(head.h_next - sizeof(head)), 1);
	}
	if (i != 6)
		putchar('\n');
	fclose(libfp);
}

xtrct(argc,argv)
char **argv;
{
	struct header head;
	register int i;
	long pos;

	pos = 0;
	for (pos = 0; fread(&head,sizeof(head),1,libfp) == 1; fseek(libfp,pos,0)) {
		if (head.h_magic == H_LIBRARY) {
			pos += sizeof(struct library);
			continue;
		}
		if (head.h_magic != H_MAGIC)
			break;
		pos += head.h_next;
		if (argc != 0) {
			for (i = 0 ; i < argc ; ++i) {
				if (strncmp(argv[i],head.h_name) == 0)
					goto found;
			}
			continue;
		}
	found:
		cpyout(&head);
	}
	fclose(libfp);
}

cpyout(hdr)
register struct header *hdr;
{
	char name[20];
	FILE *fp;
	register int c;
	int i, size;

	if (hdr->h_name[0] == 0)
		return;
	size = hdr->h_next;
	hdr->h_next = (hdr->h_next+255) & -256;
	strncpy(name,hdr->h_name,8);
	name[8] = 0;
	strcat(name, EXTEND);
	printf("Extracting: %s\n",name);
	if ((fp = fopen(name,"w")) == NULL) {
		printf("Cannot create %s\n",name);
		exit(4);
	}

	if (fwrite(hdr, sizeof(struct header), 1, fp) != 1) {
ioerr:
		printf("Error writing file: %s\n",name);
		exit(4);
	}

	for (i = 0 ; i < size ; ++i)
#ifndef UNIX
		if (putc(getc(libfp), fp) < 0)
			goto ioerr;
#else
		putc(getc(libfp), fp);
	if (ferror(fp))
		goto ioerr;
#endif

	for ( ; i < hdr->h_next ; ++i)
		putc(0,fp);		/* pad out file */
	if (fclose(fp) != 0)
		goto ioerr;
}

copyfile(input, output, size)
FILE *input, *output;
{
	while (size-- > 0)
#ifndef UNIX
		if (putc(getc(input), output) < 0)
			return -1;
#else
		putc(getc(input), output);
	if (ferror(output))
		return -1;
#endif
	return 0;
}

#ifdef UNIX
clear(cp, len, val)
register char *cp; register unsigned len;
{
	while (len--)
		*cp++ = val;
}

rename(onam, nnam)
register char *onam, *nnam;
{
	unlink(nnam);
	link(onam, nnam);
	unlink(onam);
}

tolower(c)
register int c;
{
	if (c >= 'A' && c <= 'Z')
		return c - 'A' + 'a';
	return c;
}

#endif

makename(dest,src,ext)
char *dest,*src,*ext;
{
	register char *cp;
	char *rindex();

	strcpy(dest,src);
	if (cp = rindex(dest,'.'))
		strcpy(cp,ext);
	else
		strcat(dest,ext);
}
