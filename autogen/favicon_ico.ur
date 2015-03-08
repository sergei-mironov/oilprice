open Favicon_ico_c
fun content {} = b <- blob () ; returnBlob b (blessMime "image/vnd.microsoft.icon")
val propagated_urls : list url = 
    []
val url = url(content {})
val geturl = url
