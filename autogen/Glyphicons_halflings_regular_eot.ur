val binary = Glyphicons_halflings_regular_eot_c.binary
val text = Glyphicons_halflings_regular_eot_c.text
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "application/vnd.ms-fontobject")
val geturl = url(blobpage {})
val propagated_urls = 
    []
