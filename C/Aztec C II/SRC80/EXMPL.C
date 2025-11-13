#include "libc.h"

main()
{
	char *cp,buffer[100];

	printf("Please enter your name: ");
	gets(buffer);
	printf("Hello %s, welcome to the growing family of AZTEC C users.\n",
		buffer);
	exit(0);
}
