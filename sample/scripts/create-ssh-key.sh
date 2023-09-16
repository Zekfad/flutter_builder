#!/bin/bash

# This script generates SSH key pair to be used with GitHub deploy keys.

usage() {
	echo "Usage: $0 [-o <owner>] [-r <repo>]" 1>&2
	exit 1
}

while getopts ":o:r:" opt; do
	case "${opt}" in
		o)
			owner=${OPTARG}
			;;
		r)
			repo=${OPTARG}
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND-1))

if [ -z "${owner}" ] || [ -z "${repo}" ]; then
	usage
fi

comment="repo.${owner}.${repo}@github.com"
file="repo_key_ed2519_${owner}_${repo}"

echo Generating $file

ssh-keygen -q -N "" -t ed25519 -f $file -C $comment
