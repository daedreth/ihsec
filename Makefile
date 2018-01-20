# ihsec Makefile - I don't know why it's here.

TARGET = /usr/bin/ihsec

.PHONY : install bash

install: bash

bash:
	cp ihsec.sh ${TARGET}
