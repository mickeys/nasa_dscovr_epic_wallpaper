# NASA DSCOVR EPIC near real-time satellite wallpaper

<img src="./images/dscvr_epic.gif" align="right" width="40%" border="5">

Static wallpapers for my digital devices has always vexed me. I've streamed webcams to my desktop and, a while ago, wondered whether I could find the ultime in webcam viewpoints: near-real-time satellite images of earth, those [blue marble](https://en.wikipedia.org/wiki/The_Blue_Marble) -- the opposite of the [pale blue dot](https://en.wikipedia.org/wiki/Pale_Blue_Dot) image.

There are a good number of satellites providing weather images of parts of the earth (for example, the USA is covered in two images) but it wasn't until I came across NASA's [Deep Space Climate Observatory](https://en.wikipedia.org/wiki/Deep_Space_Climate_Observatory) DSCOVR satellite did I find the entire planet captured in one image. Located at the Earth-Sun Lagrange point, DSCOVR's Earth Polychromatic Imaging Camera (EPIC) generates exactly what I wanted.

<br clear="right">

## JSON API

<img src="./images/DSCOVR-Logo_NOAA_NASA_USAF.png" align="right" width="40%">

NASA stores the images for public and research consumption, but provides no static links. One must spelunk into the published [API to the DISCOVR EPIC images](https://epic.gsfc.nasa.gov/about/api)

`bluemarble.sh` fetches the latest batch of natural<sup>1</sup> images into `./pix`. I do no post-processing, no soft-linking `latest` for [GeekTool](https://www.tynsoe.org/v2/geektool/) to use, no generation of animated GIFs -- at the moment nothing at all. That may change.

<sup>1</sup> As of today (2017-11-21) the `enhanced` images aren't back on the EPIC website. I've aded the framework to `bluemarble.sh` to handle both 'natural' and 'enhanced' images.

<br clear="right">

## ImageMagick

Then I use [ImageMagick](https://www.imagemagick.org) to:

* trim the overly-large black borders
* create an animated, morphing, image of the recently-fetched images