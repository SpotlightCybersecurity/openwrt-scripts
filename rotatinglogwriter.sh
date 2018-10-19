#!/bin/sh
# Copyright 2018. Spotlight Cybersecurity LLC
# Released under an MIT license. See LICENSE file.

# This script requires timeout. Either built-in through busybox or
# install the coreutils-timeout package

# Configure this script by setting the variables below.
# TMPDIR should point to a temporary place on persistent storage
# where we can save the current log file.
# DESTDIR is a directory that will get the log files when they are
# done being written to (either on reboot or timeout)

TMPDIR="/data/log"
DESTDIR="/data/pickup"
FNPREFIX="syslog"
TIMEOUT_SECONDS="600"


if ! which timeout; then
	echo "Can't find timeout utility!"
	exit 1
fi

TIMEOUT_ARGS=""
if [[ "`readlink /usr/bin/timeout`" == "../../bin/busybox" ]]; then
	TIMEOUT_ARGS="-t"
fi

# Check to see if $TMPDIR even exists yet. If not, wait a little while longer
# than try again. If not then bail. TODO
if [[ ! -d "$TMPDIR" ]]; then
	sleep 60
	if [[ ! -d "$TMPDIR" ]]; then
		logger "rotatinglogwriter.sh - can't find $TMPDIR"
		exit 1
	fi
fi

# Clear out stale files from /data/log
mv ${TMPDIR}/${FNPREFIX}_* "$DESTDIR/"

logread -f | {
while /bin/true; do 
	BASEFN="${FNPREFIX}_`date +%Y%m%d_%H%M%S`.log"
	timeout $TIMEOUT_ARGS $TIMEOUT_SECONDS cat > "$TMPDIR/$BASEFN"
	mv "$TMPDIR/$BASEFN" "$DESTDIR/$BASEFN"
done;
}
