val binary = Glyphicons_halflings_regular_ttf_c.binary
val text = Glyphicons_halflings_regular_ttf_c.text
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "application/x-font-ttf")
val geturl = url(blobpage {})
val propagated_urls = 
    []
