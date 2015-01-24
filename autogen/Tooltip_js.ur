val binary = Tooltip_js_c.binary
val text = Tooltip_js_c.text
val enable_tooltips = Tooltip_js_js.enable_tooltips
val popover = Tooltip_js_js.popover
val tooltip = Tooltip_js_js.tooltip
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "text/javascript")
val geturl = url(blobpage {})
val propagated_urls = 
    []
