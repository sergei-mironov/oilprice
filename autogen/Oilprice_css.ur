val binary = Oilprice_css_c.binary
val text = Oilprice_css_c.text
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "text/css")
val geturl = url(blobpage {})
val propagated_urls = 
    []
