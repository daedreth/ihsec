#!/bin/bash

CONFIGS_DIR=$HOME'/.ihsec/'
# Uncomment to use this script from the same folder as emacs configs
#CONFIGS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo " Configuration directory: "$CONFIGS_DIR
CONFIGDIRS="$CONFIGS_DIR/*/"
EMACSDIR=$HOME'/.emacs.d'

function displayHelp
{
    echo -e " Usage:\n\t'ihsec' - To view this help menu.\n\t'ihsec list' - To view a list of available configurations."
    echo -e "\t'ihsec set <config>' - To set a configuration.\n\t'ihsec del <config>' - To delete a config."
    echo -e "\t'ihsec install <url_to_git_repo> <name_for_the_config>' - To install a configuration via git."; exit 1
}

function displayError
{
    echo -e " Something went wrong!\n Ensure ~/.emacs.d is a symlink or does not exist!"; exit $?
}

function displayArgError
{
    echo -e " Wrong number of arguments entered.\n Use 'ihsec help' or 'ihsec' to learn about the usage."; exit 1
}

if [ "$#" -eq 0 ]; then displayHelp; fi

case "$1" in
    list)
	if [ ! "$#" -eq 1 ]; then displayArgError; fi
	CURR_CONFIG=$(basename $(readlink -f $HOME/.emacs.d/))
	echo -e " Available configurations:"
	for DIR in $CONFIGDIRS; do
	    if [[ -d $DIR ]]; then
		if [[ $DIR == *"$CURR_CONFIG"* ]]; then echo -en "->"; else echo -en "  "; fi
		echo -en "  \u2022" $(basename $DIR)"\n"
	    fi
	done
	;;

    set)
	if [ ! "$#" -eq 2 ]; then displayArgError; fi
	if [ -d "$CONFIGS_DIR/$2" ]; then
	    unlink $EMACSDIR &> /dev/null
	    ln -s "$CONFIGS_DIR/$2" $EMACSDIR
	    if [[ $? != 0 ]]; then
		displayError
	    else
		echo "Configuration $2 set!"
	    fi
	else
	    echo "Invalid configuration name, ensure it exists!"; exit 1
	fi
	;;

    del)
	if [ ! "$#" -eq 2 ]; then displayArgError; fi
	if [ -d "$CONFIGS_DIR/$2" ]; then
	    read -rsn1 -p "Are you sure? This can not be undone! [y/n]: " yn
	    case $yn in
		[Yy]* )
		    rm -rf "$CONFIGS_DIR/$2"
		    if [[ $? != 0 ]]; then
			displayError
		    else
			echo -e "\nConfiguration $2 removed!"
		    fi
		    ;;

		[Nn]* )
		    echo -e "\nExiting..."
		    exit 1
		    ;;

		* ) echo -e "\nPlease answer 'y' or 'n'.";;
	    esac
	else
	    echo " Invalid configuration name, ensure it exists!"
	    exit 1
	fi
	;;

    install)
	if [ ! "$#" -eq 3 ]; then displayArgError; fi
	echo "Installing $3 from $2..."
	git clone $2 "$CONFIGS_DIR/$3" &> /dev/null
	if [[ $? != 0 ]]; then
	    echo "Something went wrong, ensure your connection is stable and the link is valid."
	else
	    echo "Installed $3 successfully!"
	fi
	;;

    help)
	if [ ! "$#" -eq 1 ]; then displayArgError; fi; displayHelp
	;;

    *)
	echo -e " Unknown command entered.\n Use 'ihsec help' or 'ihsec' to learn about the usage."
esac
