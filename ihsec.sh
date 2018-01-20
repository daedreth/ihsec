#!/bin/bash

CONFIGDIR=$HOME'/.ihsec/*/'
EMACSDIR=$HOME'/.emacs.d'

if [ "$#" -eq 0 ]; then
    echo -e " Usage:"
    echo -e '\t'"ihsec" - To view this help menu.
    echo -e '\t'"ihsec list" - To view a list of available configurations.
    echo -e '\t'"ihsec set <config>" - To set a configuration.
    echo -e '\t'"ihsec del <config>" - To delete a config.
    exit 1
fi

if [ "$#" -gt 2 ]; then
    echo "Wrong number of arguments entered."
    echo "Use \"ihsec help\" or \"ihsec\" to learn about the usage."
    exit 1
else
    if [ $1 = "list" ]; then
	for DIR in $CONFIGDIR; do
	    if [[ -d $DIR ]]; then
		echo $DIR | cut -c $(($(printf "%s" "$CONFIGDIR" | wc -m) - 1))-$(($(printf "%s" "$DIR" | wc -m) - 1))
	    fi
	done
    elif [ $1 = "set" ]; then
	if [ -d $HOME'/.ihsec/'$2 ]; then
	    unlink $EMACSDIR &> /dev/null
	    ln -s $HOME'/.ihsec/'$2 $EMACSDIR
	    if [[ $? != 0 ]]; then
		echo "Something went wrong."
		echo "Ensure ~/.emacs.d is a symlink or does not exist!"
		exit $?
	    else
		echo "Configuration $2 set!"
	    fi
	else
	    echo "Invalid configuration name, ensure it exists!"
	    exit 1
	fi
    elif [ $1 = "del" ]; then
	if [ -d $HOME'/.ihsec/'$2 ]; then
	    rm -rf $HOME'/.ihsec/'$2
	    if [[ $? != 0 ]]; then
		echo "Something went wrong."
		echo "Ensure ~/.emacs.d is a symlink or does not exist!"
		exit $?
	    else
		echo "Configuration $2 set!"
	    fi
	else
	    echo "Invalid configuration name, ensure it exists!"
	    exit 1
	fi
    else
	echo "Unknown command entered."
	echo "Use \"ihsec help\" or \"ihsec\" to learn about the usage."
    fi
fi
