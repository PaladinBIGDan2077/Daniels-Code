;Copyright (C) 1981,1982 by Manx Software Systems
;	dummy closall subr, for when stdio is not used (i.e. fopen, getc, etc.)
;
	public	closall__
closall__:
	ret
	public	fclose_
fclose_:
	ret
	end
