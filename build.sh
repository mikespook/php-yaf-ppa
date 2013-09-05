#!/bin/bash

__git_ver() {
	local current=`pwd`
	cd $1
	local tag=`git tag |tail -n 1`
	echo ${tag#*-}
	cd $current
}

current="`pwd`"
SOURCE_DIR=$current/yaf-src/
VERSION=`__git_ver $SOURCE_DIR`
CODENAME=`lsb_release -cs`

usage() {
    echo "Usage: `basename $0` [-v=$VERSION] [-i] [-c=$CODENAME]"
	printf "\t -v : Upstream version\n"
 	printf "\t -i : Index version\n"
 	printf "\t -c : Distribution's codename\n"
    exit 1
}

while getopts 's:v:i:c:' o &>> /dev/null; do
    case "$o" in
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

cd $current/php5-yaf
t=debian/changelog.template
f=debian/changelog
cp -f $t $f
sed -i -e "s/#DATE#/`date --rfc-2822`/g" $f
sed -i -e "s/#VER#/$VERSION/g" $f
sed -i -e "s/#INC#/$INC/g" $f
sed -i -e "s/#CODENAME#/$CODENAME/g" $f

printf "Please enter the Release Note: "
read COMMIT_MSG
sed -i -e "s/#COMMIT-MSG#/${COMMIT_MSG}/" $f

echo '
changelog is ready:
====================
'
cat $f
echo '
====================
'
printf "Is the changelog correct? [y/n]"
read correct
[ "$correct" != "y" ] && exit

cd $current
if [ ! -f $TAR ]; then
    echo $TAR
    cd $SOURCE_DIR
    git pull 
    git checkout $TAG
    cd $current
    tar zcvf $TAR `basename $SOURCE_DIR` && \
   	ln -sf $TAR php-yaf_$VERSION.orig.tar.gz
fi

printf "Start to build source package? [y/n]"
read correct
[ "$correct" != "y" ] && exit

cd $current/php5-yaf
debuild -S -k9C309C28

printf "Upload to PPA? [y/n]"
read correct
[ "$correct" != "y" ] && exit

dput ppa:mikespook/php5-yaf php-yaf_${CODENAME}-${INC}~${VERSION}_source.changes
