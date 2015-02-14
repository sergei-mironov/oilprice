open Oilprice_css_c
fun content {} = b <- blob () ; returnBlob b (blessMime "text/css")
val propagated_urls : list url = 
    []
val url = url(content {})
val geturl = url
