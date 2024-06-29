#!/bin/bash

# This script makes flutter build and pushes artifact into preconfigured
# directory.

if [ -z "$VERBOSE" ]; then
	verbose=""
else
	echo "Enabled verbose logs"
	verbose="--verbose"
fi

if [ -z "$LOCAL_BUILD" ]; then
	echo "Git repo build"
	source /root/scripts/fix-ssh-key-perms.sh || exit 1
	/root/scripts/pull-repo.sh /root/repo || exit 1
	source /root/scripts/fix-ssh-key-perms.sh remove-copy || exit 1
else
	echo "Local build"
	if [ ! -d /root/repo ]; then
		echo "Error: /root/repo doesn't exist"
		exit 1
	fi
fi

cd /root/repo
if [ -z "$DIRTY_BUILD" ]; then
	echo "Clean build"
	flutter clean $verbose || exit 1
else
	echo "Dirty build"
fi
flutter build $verbose apk || exit 1
cp -r build/app/outputs/flutter-apk/* /root/apk/
