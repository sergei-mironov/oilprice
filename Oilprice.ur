
structure B = Bootstrap
structure BM = BootstrapMisc
structure X = XMLW
structure P = Prelude
structure MT = X.MT

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
val push_front_xml = @@X.push_front_xml
val x = @@X.push_back_xml
val data = data_attr data_kind
val aria = data_attr aria_kind

val src = bless "https://github.com/grwlf/oilprice/blob/master/Oilprice.ur"

fun template mb : transaction page =
  let
  Uru.run (
  JQuery.add (
  Bootstrap.add (
  BootstrapMisc.add (
  Soup.narrow (fn nar =>
  Uru.withHeader
  <xml>
    <title>OilPrice</title>
    <link rel="icon" type="image/x-icon" href={Favicon_ico.geturl}/>
  </xml> (
  Uru.withBody (fn _ =>
    b <- X.run mb;
    return
    <xml>
      {nar.Container
      <xml>
        {Soup.forkme_ribbon src}
        <div style="text-align:center">
          {b}
        </div>
      </xml>}

      {nar.Footer
      <xml>
        <hr/>
        <p class={B.text_muted}>
          The site is written in <a href={bless
          "http://impredicative.com/ur/"}>Ur/Web</a>, the general-purpose typed functional
          language.
        </p>
        <p class={B.text_muted}>
        <ul style="padding-left: 0px; margin-top: 20px; color: #999;">
          {Soup.footer_doc_links (
          <xml><a href={src}>Sources</a></xml> ::
          <xml><a href={bless "http://github.com/grwlf/cake3"}>Cake3</a></xml> ::
          <xml><a href={bless "http://github.com/grwlf/uru3"}>Uru3</a></xml> ::
          <xml><a href={bless "http://github.com/grwlf/urweb-monad-pack"}>MonadPack</a></xml> ::
          <xml><a href={bless "http://github.com/grwlf/urweb-xmlw"}>XMLW</a></xml> ::
          <xml><a href={bless "http://github.com/grwlf/urweb-soup"}>Soup</a></xml> ::
          []
          )}
        </ul>
        </p>
      </xml>}

    </xml>

    )))))))
  where
  end

fun push_slider3 o =
  s1 <- lift (source 0);
  i <- lift fresh;
  return {
    Sig = s1,
    XML = <xml>
      <ctextbox id={i}/>
      <active code={
        BM.slider_add i
          (o ++ 
           { Label = "Current value",
           Tooltip = "hide",
           OnSlide = (fn (v:int) => set s1 v)
           });
        return <xml/>
      }/>
    </xml>}

fun xdiv cls st m =
  X.push_back (X.nest (fn x=><xml><div class={cls} style={st}>{x}</div></xml>) m)

val xrow = xdiv B.row (STYLE "")
val xcol1 = xdiv B.col_md_12 (STYLE "")
val xcol2 = xdiv B.col_md_6 (STYLE "")

fun xnest m = X.push_back (X.nest (fn x => x) m)

fun ipow a b = pow (float a) (float b)

fun viewsig [t:::Type] (_:show t) (s : source t) : xbody =
  <xml><dyn signal={v <- signal s; return <xml>{[v]}</xml>}/></xml>

fun mapsig [t1:::Type] [t2:::Type] (s : source t1) (def : t2) (f: t1 -> t2) : MT.state xbody (source t2) =
  s2 <- lift (source def);
  push_back_xml
  <xml>
    <dyn signal={v <- signal s; return <xml><active code={set s2 (f v); return <xml/>}/></xml>}/>
  </xml>;
  return s2

val boxst = STYLE "text-align:justify; padding-top:30px"

datatype lang = RU | EN

type page_state = { Lang : lang, V1 : int, V2 : int, V3 : int, V4 : int }

val defState = {Lang = EN, V1=15, V2=235, V3=50, V4=50}

fun main_ s : transaction page =
  template (

    rf_income_trln <- push_slider3 {Min=10, Max=20, Step=1, Value = s.V1};
    rf_income_rub <- mapsig rf_income_trln.Sig 0.0 (fn x => (float x) * (ipow 10 12));

    oil_share_toe_mln <- push_slider3 {Min=200, Max=300, Step=5, Value = s.V2};
    oil_share_boe_mln <- mapsig oil_share_toe_mln.Sig 0 (fn x => round ((float x) * 7.1428571428571));
    oil_share_toe <- mapsig oil_share_toe_mln.Sig 0.0 (fn x => (float x) * (ipow 10 6));
    oil_share_boe <- mapsig oil_share_toe 0.0 (fn x => x * 7.1428571428571);

    oil_price_usd <- push_slider3 {Min=10, Max=110, Step=1, Value = s.V3};
    rf_income_share_percent <- push_slider3 {Min=0, Max=100, Step=1, Value = s.V4};
    rf_income_share <- mapsig rf_income_share_percent.Sig 0.0 (fn x => (float x) / 100.0);

    xrow(
      xcol1 (
        let
          fun linkme l x =
            <xml>
              <a link={main {}} onclick={fn _ =>
                v1 <- get rf_income_trln.Sig;
                v2 <- get oil_share_toe_mln.Sig;
                v3 <- get oil_price_usd.Sig;
                v4 <- get rf_income_share_percent.Sig;
                redirect (url(main_ ({Lang=l, V1=v1, V2=v2, V3=v3, V4=v4})))}>{x}</a>
            </xml>
        in
          push_back_xml
          <xml>
            <div style="text-align:right; min-height:20px">
              {linkme EN <xml><img src={Flag_uk_gif.geturl}/></xml>}
              {linkme RU <xml><img src={Flag_ru_gif.geturl}/></xml>}
            </div>
          </xml>
        end
      )
    );

    xnest (
      xrow (

        xcol2 (
          push_back_xml
          <xml>
            <p style={boxst}>
              <b>Revenue side of 2015 RF budget</b>, according to the
              <a href={bless "http://www.rg.ru/2014/12/05/budjet-dok.html"}>www.rg.ru</a>
              Note, that oil price near 100 USD per barrel was
              expected at the time of adoption.
            </p>
            <p>
            RUB {viewsig rf_income_trln.Sig} trillion<br/>
            {rf_income_trln.XML}
            </p>
          </xml>
        );

        xcol2 (
          push_back_xml
          <xml>
            <p style={boxst}>
              <b>RF oil market share</b>, measured in million tonnes of oil
              equivalent. The value could be estimated on the basis of
              <a href={bless "http://www.cbr.ru/statistics/print.aspx?file=credit_statistics/crude_oil.htm"}>statistical data</a>,
              published by the Central Bank of Russia.
            </p>
            <p>
            {viewsig oil_share_toe_mln.Sig} mln TOE<br/>
            (approx. {viewsig oil_share_boe_mln} mln barrels)<br/>
            {oil_share_toe_mln.XML}
            </p>
          </xml>
        )
      );

      xrow (
        xcol2 (
          push_back_xml
          <xml>
            <p style={boxst}>
              <b>Annual average oil price, USD per barrel,</b> based on reference data, provided by the
              <a href={bless "http://www.cbr.ru/statistics/print.aspx?file=credit_statistics/crude_oil.htm"}>Central
              Bank of Russia</a>. Note, that 10% of the Russian oil goes to post-soviet
              countries with 50% discount.
            </p>
            <p>
            USD {viewsig oil_price_usd.Sig}<br/>
            {oil_price_usd.XML}
            </p>
          </xml>
        );

        xcol2 (
          push_back_xml
          <xml>
            <p style={boxst}>
            <b>Oil portion of total revenue side of RF budget, speculative.</b>
            Official data states that the oil portion of revenue doesn't exceed
            the value of 25%. In contrast, external analysts point out that
            official calculations are not precise and the ratio should be
            significantly increased.
            </p>
            {viewsig rf_income_share_percent.Sig} %<br/>
            {rf_income_share_percent.XML}
            <p>
            Note, that the higher this value is, the more precise total estimate
            should be
            </p>
          </xml>
        )
      );

      push_front_xml
      <xml>
        <dyn signal={
          income <- signal (rf_income_rub);
          oil <- signal (oil_share_boe);
          price <- signal (oil_price_usd.Sig);
          segm <- signal (rf_income_share);

          let
            val v = (income * segm)/(oil * (float price))

            val fmt = show ((float (round(v * 100.0))) / 100.0)
          in
            return <xml>
              <active code={
                return <xml><h1>RUB/USD: {cdata fmt}</h1></xml>
              }/>
              </xml>
          end
        }/>
      </xml>
    )
  )

and main {} = main_ defState

