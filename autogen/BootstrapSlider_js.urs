val binary : unit -> transaction blob
val text : unit -> transaction string
val blobpage : unit -> transaction page
val geturl : url
val bootstrap_slider_add : id -> { Label : string, Min : int, Max : int, Step : int, Value : int, Tooltip : string, OnSlide : (int -> transaction {}) } -> transaction unit
val propagated_urls : list url
