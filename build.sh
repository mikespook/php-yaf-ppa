#!/bin/bash

__git_ver() {
	local current=`pwd`
	cd $1
	local tag=`git tag |tail -n 1`
	echo ${tag#*-}
	cd $current
}

SOURCE_DIR=php5-yaf/yaf-src/
VERSION=`__git_ver $SOURCE_DIR`
CODENAME=`lsb_release -cs`

usage() {
    echo "Usage: `basename $0` [-s=$SOURCE_DIR] [-v=$VERSION] [-i] [-c=$CODENAME]"
	printf "\t -s : Source dir\n"
	printf "\t -v : Upstream version\n"
 	printf "\t -i : Index version\n"
 	printf "\t -c : Distribution's codename\n"
    exit 1
}

while getopts 's:v:i:c:' o &>> /dev/null; do
    case "$o" in
    s)
        SOURCE_DIR="$OPTARG";;
    v)
        VERSION="$OPTARG";;
    i)
        INC="$OPTARG";;
    c)
        CODENAME="$OPTARG";;
    *)
        usage;;
    esac
done

if [ "$INC" == "" ]; then
    usage
fi

if [ "$VERSION" != "0.0.0" ] ; then
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
	mv -f $TAR ../ && \
	ln -sf $TAR ../php-yaf_$VERSION.orig.tar.gz

t=debian/changelog.template
f=debian/changelog
cp -f $t $f
sed -i -e "s/#DATE#/`date --rfc-2822`/" $f
sed -i -e "s/#VER#/$VERSION/" $f
sed -i -e "s/#INC#/$INC/" $f
sed -i -e "s/#CODENAME#/$CODENAME/" $f

debuild -S
