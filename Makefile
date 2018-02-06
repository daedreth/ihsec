# ihsec Makefile

TARGET = /usr/local/bin/ihsec

.PHONY : install bash

install: bash

bash:
	if [[ "$OSTYPE" == "darwin"* ]]; then cp ihsec.sh ${TARGET}; chmod 755 ${TARGET}; else install -D -m 755 ihsec.sh ${TARGET}; fi

