#include "io.h"

unlink(name)
char *name;
{
	struct fcb delfcb;

	fcbinit(name,&delfcb);
	return CPM(DELFIL,&delfcb);
}

