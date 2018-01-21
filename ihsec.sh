#!/bin/bash

CONFIGDIR=$HOME'/.ihsec/*/'
EMACSDIR=$HOME'/.emacs.d'

function displayHelp
{
    echo -e " Usage:";
    echo -e '\t'"ihsec" - To view this help menu.
    echo -e '\t'"ihsec list" - To view a list of available configurations.
    echo -e '\t'"ihsec set <config>" - To set a configuration.
    echo -e '\t'"ihsec del <config>" - To delete a config.
    exit 1    
}

function displayError
{
    echo "Something went wrong."
    echo "Ensure ~/.emacs.d is a symlink or does not exist!"
    exit $?    
}

function displayArgError
{
    echo "Wrong number of arguments entered."
    echo "Use \"ihsec help\" or \"ihsec\" to learn about the usage."
    exit 1
}

if [ "$#" -eq 0 ]; then
    displayHelp
    exit 1
fi

case "$1" in
    list)
	if [ ! "$#" -eq 1 ]; then displayArgError; fi
	CURR_CONFIG=$(readlink -f $HOME/.emacs.d)
	echo -e " Available configurations:"
	for DIR in $CONFIGDIR; do
	    if [[ -d $DIR ]]; then
		if [[ $DIR == *"$CURR_CONFIG"* ]]; then echo -en "[*]"; else echo -en "   "; fi
		echo -en "  \u2022 "; echo -en $DIR | cut -c $(($(printf "%s" "$CONFIGDIR" | wc -m) - 1))-$(($(printf "%s" "$DIR" | wc -m) - 1))
	    fi
	done
	;;
    
    set)
	if [ ! "$#" -eq 2 ]; then displayArgError; fi
	if [ -d $HOME'/.ihsec/'$2 ]; then
	    unlink $EMACSDIR &> /dev/null
	    ln -s $HOME'/.ihsec/'$2 $EMACSDIR
	    if [[ $? != 0 ]]; then
		displayError
	    else
		echo "Configuration $2 set!"
	    fi
	else
	    echo "Invalid configuration name, ensure it exists!"
	    exit 1
	fi
	;;
    
    del)
	if [ ! "$#" -eq 2 ]; then displayArgError; fi
	if [ -d $HOME'/.ihsec/'$2 ]; then
	    read -p "Are you sure? This can not be undone! [y/n]: " yn
	    case $yn in
		[Yy]* )
		    rm -rf $HOME'/.ihsec/'$2
		    if [[ $? != 0 ]]; then
			displayError
		    else
			echo "Configuration $2 removed!"
		    fi
		    ;;
		
		[Nn]* )
		    echo "Exiting..."
		    exit 1
		    ;;
		
		* ) echo "Please answer yes or no.";;
	    esac
	else
	    echo "Invalid configuration name, ensure it exists!"
	    exit 1
	fi
	;;
    
    install)
	if [ ! "$#" -eq 3 ]; then displayArgError; fi
	echo "Installing $3 from $2..."
	git clone $2 $HOME/.ihsec/$3 &> /dev/null
	if [[ $? != 0 ]]; then
	    echo "Something went wrong, ensure your connection is stable and the link is valid."
	else
	    echo "Installed $3 successfully!"
	fi
	;;
    
    help)
	if [ ! "$#" -eq 1 ]; then displayArgError; fi
	displayHelp
	;;
    
    *)
	echo "Unknown command entered."
	echo "Use \"ihsec help\" or \"ihsec\" to learn about the usage."
esac
