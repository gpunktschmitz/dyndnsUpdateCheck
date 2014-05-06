#!/bin/bash
# purpose: check if the current ip set on dyndns is equal to the current public ip and update if its not
# version: 1.2
# creation date: 2012-08-15 20:55:18
# author(s): Guenther Schmitz <gpunktscripts@outlook.com>
# license: CC0 1.0 Universal <http://creativecommons.org/publicdomain/zero/1.0/>

DYNDNSDOMAIN=example.dyndns.org                    #your dyndns domain name
DYNDNSBIN=/usr/sbin/ddclient                       #path to the ddclient script
URLTORESOLVEIPFROM=gpunktschmitz.de/yourip-sir/    #you may change this url to another one returning your public ip address e.g. "gpunktschmitz.de/youripandnothingbutyourip/", "ifconfig.me", etc.
OUTPUTDIR=/tmp

#changelog
#--
# version 1.2
# +created and am using an alternative to "ifconfig.me"
#--
# version 1.1
# ~fixed date format
# ~optimized awk
#--
# version 1.0
# +initial release

SCRIPTNAME=$( basename $0 | awk '{ split( $0, arr, "." ); print arr[1] }'  )
LOGFILE=$OUTPUTDIR/$SCRIPTNAME.log
CURRENTDYNDNSIP=$( host $DYNDNSDOMAIN | awk '{ print $4 }' )
CURRENTPUBLICIP=$( curl $URLTORESOLVEIPFROM )
LOGDATE=$( date +"%Y-%m-%d %H:%M:%S" )

if [ $CURRENTDYNDNSIP != $CURRENTPUBLICIP ]; then
    $DYNDNSBIN -use=ip -ip $CURRENTPUBLICIP
    echo "IP UPDATED FROM $CURRENTDYNDNSIP TO $CURRENTPUBLICIP AT $LOGDATE" >> $LOGFILE
fi

