module Cake_Oilprice where

import Development.Cake3
import Development.Cake3.Ext.UrWeb as UW
import qualified Cake_Bootstrap as Bootstrap
import qualified Cake_BootstrapMisc as BootstrapMisc
import qualified Cake_Prelude as Prelude
import qualified Cake_MonadPack as MonadPack
import qualified Cake_XMLW as XMLW
import qualified Cake_Soup as Soup
import Cake_Oilprice_P

(app,db) = uwapp_postgres (file "Oilprice.urp") $ do
  allow mime "text/css"
  allow url "https://github.com/grwlf/oilprice*"
  allow url "http://www.rg.ru*"
  allow url "http://www.cbr.ru*"
  library (Bootstrap.lib)
  library (BootstrapMisc.lib)
  library (MonadPack.lib)
  library (Prelude.lib)
  library (XMLW.lib)
  library (Soup.lib)
  embed (file ("favicon.ico"))
  embed (file ("flag_ru.gif"))
  embed (file ("flag_uk.gif"))
  ur (sys "list")
  ur (sys "option")
  ur (sys "string")
  ur (sys "char")
  css (file "Oilprice.css")
  ur (pair $ file "Oilprice.ur")

main = writeDefaultMakefiles $ do
  prebuild [cmd| for l in lib/*;  do test -f $$$$l/.git || { echo $$$$l is empty. Have you forgot to 'git submodule update --init' ? ; exit 1; }; done |]
  rule $ do
    phony "dropdb"
    depend db
  rule $ do
    phony "run"
    shell [cmd|$app|]
  rule $ do
    phony "all"
    depend app

