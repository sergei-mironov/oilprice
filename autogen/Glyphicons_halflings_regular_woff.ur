val binary = Glyphicons_halflings_regular_woff_c.binary
val text = Glyphicons_halflings_regular_woff_c.text
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "application/font-woff")
val geturl = url(blobpage {})
val propagated_urls = 
    []
