val binary = Bootstrap_css_c.binary
val text = Bootstrap_css_c.text
fun blobpage {} = b <- binary () ; returnBlob b (blessMime "text/css")
val geturl = url(blobpage {})
val propagated_urls = 
    Glyphicons_halflings_regular_eot.geturl ::
    Glyphicons_halflings_regular_woff.geturl ::
    Glyphicons_halflings_regular_ttf.geturl ::
    Glyphicons_halflings_regular_svg.geturl ::
    []
