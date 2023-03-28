#!/bin/bash
# Configuration
PRIVKEY=<PRIVEY IN HEX FORMAT>
RELAY="wss://nostr.mutinywallet.com"
RELAYBIS="wss://relay.nostr.band"
RELAYFALLBACK="wss://relay.nostriches.org"
POW=10
ASKINTERVAL=30


# List of emojis

emoji_list=("🎉" "🎊" "🥳" "🍾" "🎈" "🎇" "🙌" "🎉" "🎊" "🥳" "🌻" "🌼" "🌸" "🙌" "🌺" "🌹" "🌷" "😊" "😃" "😄" "😍" "😘" "😎" "😜" "😛" "😇" "🙂" "🤗" "🤩" "🥰" "😊")


while true; do
	# Use "shuf" to randomly select an emoji
	random_emoji=$(printf "%s\n" "${emoji_list[@]}" | shuf -n 1)
	
	# Save NOTE to REPOURLOLD variable before checking note, so 
	# we can compare them later to see if there is a new event id.
 	REPOURLOLD=$REPOURLNEW
 	
	
	cp ./COMMIT-ID.txt ./OLD-ID.txt
	sleep 3
	echo " == ❓Asking github for new commits..."
	echo " == ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ="
	# NODE node.js for new commits 
	node ./check_commits.js 
		echo " == ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ⌛ ="
	# Set the outputs of crawl.js as id and pubkey
	NAME=$(cat ./COMMIT-NAME.txt)
	REPOTITLE=$(cat ./REPO-TITLE.txt)
	URL=$(cat ./COMMIT-URL.txt)
	ID=$(cat ./COMMIT-ID.txt)
	OLDID=$(cat ./OLD-ID.txt)
	echo " "
	echo "name:	$NAME "
	echo "url:	$URL "
	echo "id	$ID "
	echo "old-id:	$OLDID "	
	echo " "
		if [ "$OLDID" == "$ID" ]; then   	
        	echo " == ❌ No new commits... checking again in $ASKINTERVAL seconds"
		else
		echo " == 🆕 ✅ New commits found, let's publish!"
		# Reply to message using nostril

		nostril --envelope --pow "$POW" --sec "$PRIVKEY" --content "$random_emoji $NAME
$URL " | tee >(websocat $RELAY) >(websocat $RELAYBIS) >(websocat $RELAYFALLBACK)
		

		echo " == OK . EVENT ID ABOVE.  RELAY: "$RELAY" "
		echo " "
		echo " == ⌛Checking for new commits in $ASKINTERVAL seconds..."
		echo " "
	fi
sleep $ASKINTERVAL
done
