val binary = Bootstrap_slider_min_js_c.binary
val text = Bootstrap_slider_min_js_c.text
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "text/javascript")
val geturl = url(blobpage {})
val propagated_urls = 
    []
