{libraries ? {}} :

let

  uwb = (import <urweb-build>) { inherit libraries; };

in with uwb;

rec {

  oilprice = mkExe {
    name = "Oilprice";
    dbms = "sqlite";

    libraries = {
      xmlw = external ./lib/urweb-xmlw;
      soup = external ./lib/urweb-soup;
      prelude = external ./lib/urweb-prelude;
      monad-pack = external ./lib/urweb-monad-pack;
      bootstrap = external ./lib/uru3/Bootstrap;
      uru = external ./lib/uru3/Uru;
      bootstrap-misc = external ./lib/uru3/BootstrapMisc;
    };

    statements = [
      (set "allow mime 'text/css'")
      (set "allow url 'https://github.com/grwlf/oilprice*'")
      (set "allow url 'http://www.rg.ru*'")
      (set "allow url 'http://www.cbr.ru*'")
      (embed ./favicon.ico)
      (embed ./flag_ru.gif)
      (embed ./flag_uk.gif)
      (sys "list")
      (sys "char")
      (sys "string")
      (sys "option")
      (embed-css ./Oilprice.css)
      (src ./Oilprice.ur ./Oilprice.urs)
    ];
  };

}




