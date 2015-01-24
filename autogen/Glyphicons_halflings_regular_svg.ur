val binary = Glyphicons_halflings_regular_svg_c.binary
val text = Glyphicons_halflings_regular_svg_c.text
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "image/svg+xml")
val geturl = url(blobpage {})
val propagated_urls = 
    []
