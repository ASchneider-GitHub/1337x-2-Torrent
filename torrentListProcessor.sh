#!/bin/bash

# MADE TO WORK SPECIFICALLY WITH 1337x.to
# Call script with `torrentListProcessor.sh $urlString` where $urlString is a list of 1337x.to torrent page URLs with a space between each one

# Prompts for output folder for .torrent files
echo ""
echo "Enter path to output folder. Make sure it has a / at the end of it."
read -p "Path to output folder > " outputFolder

# Set up required arrays
urlArray=()
infoHashArray=()

# Read space-delimited URL string into array
# URL string must be one line, with URLs separated by a single space
read -r -a urlArray <<< "$*"

echo ""
echo "Starting infohash retrieval"
for url in "${urlArray[@]}"; do

	# Curls torrent's webpage, grabs the HTML for the infohash, and trims out the <span> tag
	tempInfoHash=$(curl -s "$url" | grep "Infohash :" | cut -d">" -f5 | cut -f1 -d"<")

	# Adds whatever infohash is found to the infoHashArray array
	infoHashArray+=("$tempInfoHash")

done

echo ""
echo "Infohash retrieval completed. Total infohashes = ${#infoHashArray[@]}"
echo "Starting torrent file retrieval"

infohashCounter=0
for infoHash in "${infoHashArray[@]}"; do
	
	# Uses curl request to itorrents.org to retrieve a cached .torrent file based on the info hash
	curl -s "https://itorrents.org/torrent/$infoHash.torrent" -o "$outputFolder${infoHashArray[$infohashCounter]}".torrent

	# Increment infohashCounter to sync with next curl request
	# This should allow the output .torrent file to have the correlated infohash as it's name
	let infohashCounter++

done

echo ""
echo "Torrent file retrieval complete. Files available in script directory."