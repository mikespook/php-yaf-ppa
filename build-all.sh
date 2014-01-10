#!/bin/bash
current="`pwd`"
dist="saucy raring quantal precise lucid"

usage() {
    echo "Usage: `basename $0` [-v] [-i]"
	printf "\t -v : Upstream version\n"
 	printf "\t -i : Index version\n"
    exit 1
}

while getopts 'v:i:' o &>> /dev/null; do
    case "$o" in
    v)
        VERSION="$OPTARG";;
    i)
        INC="$OPTARG";;
    *)
        usage;;
    esac
done

if [ -z $INC ] || [ -z $VERSION ]; then
	usage
	exit 1
fi

for d in $dist; do
	$current/build.sh -v $VERSION -i $INC -c $dist
done
