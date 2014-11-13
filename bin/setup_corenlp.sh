#!/bin/bash

EXTERNALS_PATH=externals
TOOLS_PATH=tools

if [ ! -d "bin" ]
then
	echo "Usage: bin/setup_corenlp.sh"
	echo "    Download and set up Stanford CoreNLP tools."
	echo "    This script should be run from the root of the git repo."
	echo
	exit -1
fi

function __setup_corenlp__ {
	EXTERNALS_SUBPATH=$EXTERNALS_PATH/corenlp-3.3.1
	TOOLS_SUBPATH=$TOOLS_PATH/corenlp-3.3.1
	SYMLINK_SUBPATH=$TOOLS_PATH/corenlp
	SYMLINK=corenlp-3.3.1

	if [ ! -d "$TOOLS_SUBPATH" ]
	then
		echo "# Setting up Stanford CoreNLP tools..."

		if [ ! -d "$EXTERNALS_SUBPATH" ]
		then
			echo "    Creating folder '$EXTERNALS_SUBPATH'..."
			mkdir -p $EXTERNALS_PATH
			mkdir -p $EXTERNALS_SUBPATH
			echo "    Downloading..."
			curl --insecure --location http://nlp.stanford.edu/software/stanford-corenlp-full-2014-01-04.zip > $EXTERNALS_SUBPATH/stanford-corenlp-full-2014-01-04.zip
			echo "    Extracting license..."
			unzip -q $EXTERNALS_SUBPATH/stanford-corenlp-full-2014-01-04.zip stanford-corenlp-full-2014-01-04/LICENSE.txt -d $EXTERNALS_SUBPATH &&\
				mv $EXTERNALS_SUBPATH/stanford-corenlp-full-2014-01-04/LICENSE.txt $EXTERNALS_SUBPATH/ &&\
				rmdir $EXTERNALS_SUBPATH/stanford-corenlp-full-2014-01-04
			echo "You may delete downloaded files in this folder without affecting the topic model server." > $EXTERNALS_SUBPATH/safe-to-delete.txt
		fi

		echo "    Creating folder '$TOOLS_SUBPATH'..."
		mkdir -p $TOOLS_PATH
		mkdir -p $TOOLS_SUBPATH
		echo "    Uncompressing..."
		unzip -q $EXTERNALS_SUBPATH/stanford-corenlp-full-2014-01-04.zip stanford-corenlp-full-2014-01-04/* -d $TOOLS_SUBPATH &&\
			mv $TOOLS_SUBPATH/stanford-corenlp-full-2014-01-04/* $TOOLS_SUBPATH/ &&\
			rmdir $TOOLS_SUBPATH/stanford-corenlp-full-2014-01-04 &&\
			ln -s $SYMLINK $SYMLINK_SUBPATH

		echo "    Available: $TOOLS_SUBPATH"
		echo
	else
		echo "    Available: $TOOLS_SUBPATH"
	fi
}

__setup_corenlp__
