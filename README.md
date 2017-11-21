# NASA DSCOVR EPIC near real-time satellite wallpaper

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Dscovrepicmoontransitfull.gif/496px-Dscovrepicmoontransitfull.gif" align="right" width="50%" border="15">
Static wallpapers for my digital devices has always vexed me. I've streamed webcams to my desktop and, a while ago, wondered whether I could find near-real-time satellite images of earth ("[blue marble](https://en.wikipedia.org/wiki/The_Blue_Marble)"-style, the opposite of the [pale blue dot](https://en.wikipedia.org/wiki/Pale_Blue_Dot)) to use.

There are a good number of satellites providing weather images of parts of the earth (for example, the USA is covered in two images) but it wasn't until I came across NASA's [Deep Space Climate Observatory](https://en.wikipedia.org/wiki/Deep_Space_Climate_Observatory) (DSCOVR) satellite did I find the entire planet captured in one image. Located at the Earth-Sun Lagrange point, DSCOVR's Earth Polychromatic Imaging Camera (EPIC) generates "[blue marble](https://en.wikipedia.org/wiki/The_Blue_Marble)"-style images that are perfect for background wallpaper for digital devices.

NASA stores the images for public and research consumption, but provides no static links to the latest and greatest images; nothing like `http://epic.nasa.gov/latest.jpg` was deemed worthwhile for the ease-of-use of sharing. So one must spelunk into the published [API to the DISCOVR EPIC images](https://epic.gsfc.nasa.gov/about/api) to get at the things.

`wp.sh` fetches the latest batch of natural<sup>1</sup> images into `./pix`. I do no post-processing, no soft-linking `latest` for [GeekTool](https://www.tynsoe.org/v2/geektool/) to use, no generation of animated GIFs -- at the moment nothing at all. That may change.

1. As of today the `enhanced` images aren't found on the EPIC website. When restored I'll update `wp.sh` to handle both kinds of images.
2. There's no error-handling, not a good idea when the website was down last weekend and the enhanced images are missing today. Another thing to add.