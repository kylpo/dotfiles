#!/bin/sh
# From https://superuser.com/a/781526

DESTFILE=~/backup/install-hotkeys.sh
echo '#!/bin/bash' > $DESTFILE

defaults find NSUserKeyEquivalents | sed -e "s/Found [0-9]* keys in domain '\\([^']*\\)':/defaults write \\1 NSUserKeyEquivalents '/" -e "s/    NSUserKeyEquivalents =     {//"  -e "s/};//" -e "s/}/}'/" >> $DESTFILE
echo killall cfprefsd >> $DESTFILE
chmod a+x $DESTFILE