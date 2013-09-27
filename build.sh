#!/bin/bash

__git_ver() {
	pushd ./
	cd $1
	local tag=`git tag |tail -n 1`
	echo ${tag#*-}
	popd
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

check_release_note() {
	local f=$1
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
	[ "$correct" == "y" ]
	return $?
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

pushd ./
cd $current/php5-yaf
t=debian/changelog.template
f=debian/changelog
[ -f $f ] && rm $f

if [ -f $current/release.note ]; then
	check_release_note $current/release.note
	[ $? -eq 0 ] && cp -f $current/release.note $f
fi

if [ ! -f $f ]; then
	cp -f $t $f
	sed -i -e "s/#DATE#/`date --rfc-2822`/g" $f
	sed -i -e "s/#VER#/$VERSION/g" $f
	sed -i -e "s/#INC#/$INC/g" $f
	sed -i -e "s/#CODENAME#/$CODENAME/g" $f

	printf "Please enter the Release Note: "
	read COMMIT_MSG
	sed -i -e "s/#COMMIT-MSG#/${COMMIT_MSG}/" $f

	check_release_note $f
	[ $? -ne 0 ] && exit
	cp $f $current/release.note
fi

popd

if [ ! -f $TAR ]; then
    echo $TAR
	pushd ./
    cd $SOURCE_DIR
    git pull 
    git checkout $TAG
	popd
    tar zcvf $TAR `basename $SOURCE_DIR` && \
   	ln -sf $TAR php-yaf_$VERSION.orig.tar.gz
fi

printf "Start to build source package? [y/n]"
read correct
[ "$correct" != "y" ] && exit

pushd ./
cd $current/php5-yaf
debuild -S -k9C309C28

printf "Upload to PPA? [y/n]"
read correct
[ "$correct" != "y" ] && exit

popd
dput ppa:mikespook/php5-yaf php-yaf_${VERSION}-${INC}~${CODENAME}_source.changes
