#!/bin/bash

usage() {
    echo "Usage: `basename $0` [-s source dir] [-v version to build]"
    exit 1
}

while getopts 's:v:' o &>> /dev/null; do
    case "$o" in
    s)
        SOURCE_DIR="$OPTARG";;
    v)
        VERSION="$OPTARG";;
    *)
        usage;;
    esac
done

if [ "$SOURCE_DIR" == "" ]; then
    usage
fi
if [ "$VERSION" == "" ]; then
    usage
fi

if [ "$VERSION" != "master" ] ; then
	TAG=yaf-$VERSION
	TAR=$TAG.tar.gz
else
	TAG=master
	TAR=yaf-$TAG.tar.gz
fi
current="`pwd`"
cd $SOURCE_DIR 
git pull 
git checkout $TAG
cd $current/php5-yaf
tar zcvf $TAR `basename $SOURCE_DIR` && \
	mv $TAR ../ && \
	ln -s $TAR ../php-yaf_$VERSION.orig.tar.gz

debuild
