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

readonly nasa='https://epic.gsfc.nasa.gov'	# NASA host server
readonly jurl="${nasa}/api"					# JSON metadata & fns
readonly purl="${nasa}/epic-archive/jpg/"	# image directories
readonly outd='./pix'						# store fetched images here
readonly extn='jpg'							# the image format

curl_args='-L '								# follow redirects to destination
curl_args+='-#O'							# derive fn from source URL

# -----------------------------------------------------------------------------
# Check that the website is up and running, or quit.
# -----------------------------------------------------------------------------
if [[ $( curl -IsLk "$nasa" | head -1 | cut -f2 -d ' ') -ne '200' ]] ; then
	echo "fatal error: site "$nasa" is down; quitting."
	exit
fi

# -----------------------------------------------------------------------------
# Further transformations require ImageMagick be installed. So we test...
# -----------------------------------------------------------------------------
if [[ $( convert -version | grep -c ImageMagick ) -gt 0 ]] ; then
	has_imagemagick=1 ; else has_imagemagick=0 ; fi

# -----------------------------------------------------------------------------
# Loop over and process each of the available images.
# -----------------------------------------------------------------------------
for x in 'natural' ; do						# 'enhanced' images still missing
	# -------------------------------------------------------------------------
	# Get the JSON from $jurl, placing into $outd each image described.
	# -------------------------------------------------------------------------
	mkdir -p "$outd/$x"						# make destination directory
	pushd "$outd/$x"						# fetch files in destination dir
	while IFS= read -r fn; do				# one image filename per line
		curl $curl_args "${purl}${fn}.$extn"	# fetch and store that image
	done < <(jq --raw-output '. | .[] | .image' <<<$( curl "$jurl/$x" ))	# until done
	popd									# pop back to previous directory

	# -------------------------------------------------------------------------
	# Trim unnecessary huge black borders.
	# -------------------------------------------------------------------------
	if [[ $has_imagemagick -eq 1 ]] ; then	# following requires ImageMagick
		for f in $outd/$x/*.$extn ; do			# for each of the fetched images
			convert "$f" -trim "$f"			# trim away the borders
		done
	fi

	# -------------------------------------------------------------------------
	# Create an animated image.
	# -------------------------------------------------------------------------
	if [[ $has_imagemagick -eq 1 ]] ; then	# following requires ImageMagick
		convert -loop 0 -delay 25 -morph 3 "${outd}/$x/*.$extn" dscvr_$x.gif
	fi
done

# -----------------------------------------------------------------------------
# That's all, folks!
# -----------------------------------------------------------------------------