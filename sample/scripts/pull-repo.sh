#!/bin/bash

# This scripts clones or pull repository.
# Clone is partial when branch is specified.
# If folder is exists, iit will try to clean working directory, switch branch
# and pull the repo.
# Keep in mind that existing repo can be incompatible, as you may've been clone
# it with your local credentials and not SSH key.

usage() {
	echo "Usage: $0 <path>" 1>&2
	echo "  Clone (or pull existing) repository." 1>&2
	echo "" 1>&2
	echo "  Set following environment variables:" 1>&2
	echo "  REPO_URL          (Required) Repository URL" 1>&2
	echo "  REPO_BRANCH       (Optional) Repository Branch" 1>&2
	echo "  COMMIT_SHA        (Optional) SHA of commit to checkout" 1>&2
	echo "  SSH_KEY           (Optional) Repository SSH key" 1>&2
	exit 1
}

pushd() {
	command pushd "$@" > /dev/null
}

popd() {
	command popd "$@" > /dev/null
}

# Path
if [ -z "$1" ]; then
	echo "Missing path" 1>&2
	echo "" 1>&2
	usage
else
	directory=$1
fi

# Repo URL
if [ -z "${REPO_URL}" ]; then
	echo "Missing REPO_URL variable" 1>&2
	echo "" 1>&2
	usage
else
	repo_url=$REPO_URL
fi

# Repo key
if [ -n "${SSH_KEY}" ]; then
	key=$(realpath $SSH_KEY)
fi

# Branch argument
if [ -n "${REPO_BRANCH}" ]; then
	branch=$REPO_BRANCH
	branch_arg="-b $branch --single-branch"
else
	branch_arg=""
fi

# Branch argument
if [ -n "${COMMIT_SHA}" ]; then
	commit=$COMMIT_SHA
else
	commit=""
fi

# Create path to dir
if [ ! -d $directory ]; then
	mkdir -p $directory
	rmdir $directory
fi

#####

if [ -n "${key}" ]; then
	echo "Git will use $key SSH key."

	export GIT_SSH_COMMAND="ssh -i $key -o IdentitiesOnly=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" 
fi

clean() {
	git reset --hard HEAD || exit 1
	git clean -f -d || exit 1
}

pull() {
	clean || exit 1
	if [ -z "${commit}" ]; then
		if [ -n "${branch}" ]; then
			git checkout --recurse-submodules -f $branch || exit 1
		fi
		git pull || exit 1
	else
		git fetch --depth 1 origin $commit || exit 1
		git checkout --recurse-submodules FETCH_HEAD || exit 1
	fi
}

pull_dir() {
	pushd $directory || exit 1
	pull || exit 1
	popd || exit 1
}

clone() {
	if [ -n "${commit}" ]; then
		git clone --depth 1 --recurse-submodules --no-checkout $repo_url $directory || exit 1
		pull_dir
	else
		git clone --depth 1 --recurse-submodules $branch_arg $repo_url $directory || exit 1
	fi
}

if [ -d $directory ]; then
	pull_dir || {
		rm -rf $directory
		echo "Failed to update repo, attempting to clone from a scratch" 1>&2
		clone
	}
else
	clone
fi

if [ -d $directory ]; then
	pushd $directory
	git show -s --no-color
	popd
else
	echo "Repo directory is missing, no clone or pull was successful" 1>&2
	echo "" 1>&2
	exit 1
fi

exit 0
