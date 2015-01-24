
structure MT = State.Trans(struct con m = Basis.transaction end)

con state = MT.state

val lift = @@MT.lift

fun source [st:::Type] [t:::Type] (x:t) : MT.state st (source t) =
  MT.lift (Basis.source x)

fun sourceM [st:::Type] [t:::Type] (m:MT.state st t) : MT.state st (source t) =
  x <- m ;
  MT.lift (Basis.source x)

fun run (s : MT.state xbody {}) : transaction xbody =
  (x,_) <- MT.run <xml/> s;
  return x

fun query [ctx ::: {Unit}] [tables ::: {{Type}}] [exps ::: {Type}] [tables ~ exps] [state ::: Type]
  (q:sql_query [] [] tables exps) 
  (st:state)
  (f:$(exps ++ map (fn fields :: {Type} => $fields) tables) -> state -> MT.state (xml ctx [] []) state)
    : MT.state (xml ctx [] []) state =
  x <- MT.get {};
  (x',st') <- MT.lift( Basis.query q (fn r (xx,ss) => MT.run xx (f r ss)) (x,st) );
  MT.set x';
  return st'

fun query_ [ctx ::: {Unit}] [tables ::: {{Type}}] [exps ::: {Type}] [tables ~ exps]
  (q:sql_query [] [] tables exps) 
  (f:$(exps ++ map (fn fields :: {Type} => $fields) tables) -> MT.state (xml ctx [] []) {})
    : MT.state (xml ctx [] []) {} =
  x <- MT.get {};
  x' <- MT.lift( Basis.query q (fn r xx => MT.eval xx (f r)) x);
  MT.set x';
  return {}

fun oneRow [st ::: Type] [tables ::: {{Type}}] [exps ::: {Type}] [tables ~ exps]
  (q : sql_query [] [] tables exps) : MT.state st $(exps ++ map (fn fields :: {Type} => $fields) tables) =
    MT.lift ( Top.oneRow q )

fun oneRow1 [st ::: Type] [nm ::: Name] [fs ::: {Type}]
  (q:sql_query [] [] [nm = fs] []) : MT.state st $fs =
    MT.lift ( Top.oneRow1 q )

(*
    _    ____ ___       ____  
   / \  |  _ \_ _|_   _|___ \ 
  / _ \ | |_) | |\ \ / / __) |
 / ___ \|  __/| | \ V / / __/ 
/_/   \_\_|  |___| \_/ |_____|
                              
*)

fun push_back [ctx:::{Unit}] [a:::Type] (mx:MT.state (xml ctx [] []) (xml ctx [] [] * a)) : MT.state (xml ctx [] []) a =
  (x, a) <- mx;
  MT.modify (fn s => <xml>{s}{x}</xml>);
  return a

fun push_back_ [ctx:::{Unit}] (mx:MT.state (xml ctx [] []) (xml ctx [] [])) : MT.state (xml ctx [] []) {} =
  x <- mx;
  MT.modify (fn s => <xml>{s}{x}</xml>);
  return {}

fun push_back_xml [ctx:::{Unit}] (x:xml ctx [] []) : MT.state (xml ctx [] []) {} =
  push_back_ (return x)

fun push_front [ctx:::{Unit}] [a:::Type] (mx:MT.state (xml ctx [] []) (xml ctx [] [] * a)) : MT.state (xml ctx [] []) a =
  (x,a) <- mx;
  MT.modify (fn s => <xml>{x}{s}</xml>);
  return a

fun push_front_ [ctx:::{Unit}] (mx:MT.state (xml ctx [] []) (xml ctx [] [])) : MT.state (xml ctx [] []) {} =
  x <- mx;
  MT.modify (fn s => <xml>{x}{s}</xml>);
  return {}

fun nest [a ::: Type] [ctx:::{Unit}] [ctx2 :::{Unit}]
    (f:xml ctx2 [] [] -> xml ctx [] [])
    (s:MT.state (xml ctx2 [] []) a)
      : MT.state (xml ctx [] []) (xml ctx [] [] * a) =
  (x,a) <- MT.lift (MT.run <xml/> s);
  return (f x, a)

