val binary = BootstrapSlider_js_c.binary
val text = BootstrapSlider_js_c.text
val bootstrap_slider_add = BootstrapSlider_js_js.bootstrap_slider_add
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "text/javascript")
val geturl = url(blobpage {})
val propagated_urls = 
    []
