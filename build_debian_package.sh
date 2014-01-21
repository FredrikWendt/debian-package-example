#!/bin/bash

# ----------------
#
# UPDATE THESE!!!
#
# ----------------
VERSION=1.0.0
PACKAGE='deb-test'
DESCRIPTION='This is a simple example package'


export LANG=C

# directories
BASE=`pwd`
TARGET_DATA=$BASE/target/deb/data
TARGET_CONTROL=$BASE/target/deb/control


# clean target, create folders
rm -rf target 2> /dev/null
mkdir $TARGET_DATA -p
mkdir $TARGET_CONTROL -p


# prepare to package
echo
echo "Preparing to package, copying files into place"
echo "2.0" > $BASE/target/deb/debian-binary
cp --verbose -r $BASE/to_install/* $TARGET_DATA
cp --verbose src/debian/* $TARGET_CONTROL


# control file needs special treatment
echo
echo "Updating control file"
cat src/debian/control | \
	sed -e "s/DESCRIPTION/$DESCRIPTION/" | \
	sed -e "s/PACKAGE/$PACKAGE/" | \
	sed -e "s/VERSION/$VERSION/" \
	> $TARGET_CONTROL/control


# package
echo 
echo "Packaging data.tar.gz"
cd $TARGET_DATA ; tar cvzf ../data.tar.gz *

echo 
echo "Packaging $TARGET_CONTROL"
cd $TARGET_CONTROL ; tar cvzf ../control.tar.gz *

echo 
cd $BASE/target/deb ; ar -r ../$PACKAGE-$VERSION.deb debian-binary control.tar.gz data.tar.gz
