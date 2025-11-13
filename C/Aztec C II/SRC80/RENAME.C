rename(old, new)
char *old, *new;
{
	char buff[60];

	fcbinit(new,buff);
	bdos(19,buff);
	fcbinit(old,buff);
	fcbinit(new,buff+16);
	bdos(23,buff);
}
