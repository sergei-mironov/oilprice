
structure B = Bootstrap
structure BM = BootstrapMisc
structure X = XmlGen
structure P = Prelude

val swap = @@P.swap
val ap = @@P.ap
val fst = @@P.fst
val snd = @@P.snd
val cl = @@CSS.list
val nest = @@X.nest
val lift = @@X.lift
val push_back = @@X.push_back
val push_front = @@X.push_front
val push_back_ = @@X.push_back_
val push_front_ = @@X.push_front_
val push_back_xml = @@X.push_back_xml
val data = data_attr data_kind
val aria = data_attr aria_kind

fun template mb : transaction page =
  let
  Uru.run (
  JQuery.add (
  Bootstrap.add (
  BootstrapMisc.add (
  Uru.withStylesheet (Oilprice_css.url) (
  Uru.withBody (fn _ =>
      b <- X.run mb;
      return
      <xml>
        <div class={B.container}>

          {b}

          <a href={bless "https://github.com/grwlf/uru3"}>
            <img style="position:absolute; top:0; right:0; border:0;" src={bless "https://camo.githubusercontent.com/365986a132ccd6a44c23a9169022c0b5c890c387/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f7265645f6161303030302e706e67"} alt="Fork me on GitHub" data={data_attr data_kind "canonical-src" "https://s3.amazonaws.com/github/ribbons/forkme_right_red_aa0000.png"}/>
          </a>

        </div> <!-- /container -->
      </xml>

    ))))))
  where
  end

fun push_slider o =
  s <- lift (source 0);
  i <- lift fresh;
  push_back_xml
  <xml>
    <ctextbox id={i}/>
    <active code={
      BM.slider_add i
        (o ++ 
         { Label = "Current value",
         Tooltip = "hide",
         OnSlide = (fn v => set s v) 
         });
      return <xml/>
    }/>
  </xml>;
  return s

fun main {} : transaction page =
  template (
    
    push_back_xml
    <xml>
      <h1>Oil price</h1>
    </xml>;

    s1 <- push_slider { Min=1, Max=20, Step=1, Value=1 };
    push_back_xml <xml><br/></xml>;
    s2 <- push_slider { Min=1, Max=20, Step=1, Value=13 };
    push_back_xml <xml><br/></xml>;

    push_back_xml
    <xml>
      <dyn signal={
        v1 <- signal s1;
        v2 <- signal s2;
        return <xml>Value: {[v1 + v2]}</xml>}
      />
    </xml>
  )

