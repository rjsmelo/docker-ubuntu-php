#!/bin/bash

FILES="php-qa-tools-install.sh"

for FILE in $FILES ; do
	for DIR in php*-qa ; do
		cp -v $FILE $DIR/
	done
done
