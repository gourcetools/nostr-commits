#!/bin/bash
# Configuration
PRIVKEY="PUT A HEX PRIVKEY HERE"
RELAY="wss://nostr.mutinywallet.com"
RELAYBIS="wss://relay.nostr.band"
RELAYFALLBACK="wss://relay.damus.io"
POW=10
ASKINTERVAL=30



while true; do

	# Save NOTE to REPOURLOLD variable before checking note, so 
	# we can compare them later to see if there is a new event id.
 	REPOURLOLD=$REPOURLNEW
	cp ./COMMIT-ID.txt ./OLD-ID.txt
	echo " ==  Running check-commits.js ..."
	echo " == ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ="
	# NODE node.js for new commits 
	node ./check_commits.js 
		echo " == Done.  ="
	# Set the outputs of crawl.js as id and pubkey
	NAME=$(cat ./COMMIT-NAME.txt)
	REPOTITLE=$(cat ./REPO-TITLE.txt)
	URL=$(cat ./COMMIT-URL.txt)
	ID=$(cat ./COMMIT-ID.txt)
	OLDID=$(cat ./OLD-ID.txt)
	echo " "
	echo "repo:	$REPOTITLE "
	echo "commit:	$URL "
	
	echo " "
		if [ "$OLDID" == "$ID" ]; then   	
        	echo " == ❌ Nothing new... checking again in $ASKINTERVAL seconds"
		else
		echo " == 🆕 ✅ New stuff found, let's publish about it!"
		# Reply to message using nostril

		nostril --envelope --pow "$POW" --sec "$PRIVKEY" --content "$REPOTITLE : $NAME
$URL " | tee >(websocat $RELAY) >(websocat $RELAYBIS) >(websocat $RELAYFALLBACK)
		

		echo " == OK . EVENT ID ABOVE. "
		echo " "
		echo " == ⌛Checking again in $ASKINTERVAL seconds..."
		echo " "
	fi
sleep $ASKINTERVAL
done
