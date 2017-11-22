#!/usr/local/bin/bash
set -euo pipefail							# make robust shell scripts :-)
#set -x

# =============================================================================
# NASA DSCOVR EPIC near real-time satellite wallpaper (and some ImageMagick)
#
# Fetch the most recent images with NASA's API. Back-story & documentation at:
#
# https://github.com/mickeys/nasa_dscovr_epic_wallpaper/blob/master/README.md?ts=4
# =============================================================================
# URLs useful while I was coding this:
#
# https://epic.gsfc.nasa.gov/about/api		# NASA API documention
# https://epic.gsfc.nasa.gov/api/natural	# the JSON returned by a basic call
# https://stedolan.github.io/jq/tutorial/	# jq reasonably in-depth tutorial
# -----------------------------------------------------------------------------

readonly nasa='epic.gsfc.nasa.gov'			# NASA host server
readonly jurl="https://${nasa}/api/natural"	# JSON metadata & fns
readonly purl="https://${nasa}/epic-archive/jpg/"	# image directories
readonly outd='./pix'						# store fetched images here
readonly extn='jpg'							# the image format

curl_args='-L '								# follow redirects to destination
curl_args+='-#O'							# derive fn from source URL

# -----------------------------------------------------------------------------
# Get the JSON from $jurl, placing into $outd each image described.
# -----------------------------------------------------------------------------
mkdir -p "$outd"							# make destination directory
pushd "$outd"								# fetch files in destination dir
while IFS= read -r fn; do					# one image filename per line
	curl $curl_args "${purl}${fn}.$extn"	# fetch and store that image
done < <(jq --raw-output '. | .[] | .image' <<<$( curl "$jurl" ))	# until done
popd										# pop back to previous directory

# -----------------------------------------------------------------------------
# That's all, folks!
# -----------------------------------------------------------------------------