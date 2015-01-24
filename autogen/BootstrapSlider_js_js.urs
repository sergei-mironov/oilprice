val bootstrap_slider_add : id -> { Label : string, Min : int, Max : int, Step : int, Value : int, Tooltip : string, OnSlide : (int -> transaction {}) } -> transaction unit
