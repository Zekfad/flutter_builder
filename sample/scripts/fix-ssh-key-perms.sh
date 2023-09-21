#!/bin/bash

# This scripts copies (or removes copy) private key with correct permissions

if [ "$1" == "remove-copy" ]; then
	if [[ -n "$SSH_KEY_SRC" && -n "$SSH_KEY" && -e $SSH_KEY_SRC && "$SSH_KEY_SRC" != "$SSH_KEY" ]]; then
		rm -f $SSH_KEY
		export SSH_KEY=$SSH_KEY_SRC
		export SSH_KEY_SRC=
	else
		echo "Invalid values for SSH_KEY_SRC and SSH_KEY" 1>&2
	fi
else
	key_source=$SSH_KEY
	if [ -n "$key_source" ]; then
		export SSH_KEY_SRC=$(realpath $key_source)
		export SSH_KEY="$SSH_KEY_SRC.priv"
		cp -f $SSH_KEY_SRC $SSH_KEY
		chmod 400 -R $SSH_KEY
	fi
fi
