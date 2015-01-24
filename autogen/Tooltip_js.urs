val binary : unit -> transaction blob
val text : unit -> transaction string
val blobpage : unit -> transaction page
val geturl : url
val enable_tooltips : unit -> transaction unit
val popover : string -> string -> transaction unit
val tooltip : string -> string -> transaction unit
val propagated_urls : list url
