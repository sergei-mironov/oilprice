open Flag_uk_gif_c
fun content {} = b <- blob () ; returnBlob b (blessMime "image/gif")
val propagated_urls : list url = 
    []
val url = url(content {})
val geturl = url
