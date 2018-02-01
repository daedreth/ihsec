# ihsec Makefile

TARGET = /usr/local/bin/ihsec

.PHONY : install bash

install: bash

bash:
	install -D -m 755 ihsec.sh ${TARGET}

