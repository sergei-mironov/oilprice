module Cake_Oilprice where

import Development.Cake3
import Development.Cake3.Ext.UrWeb as UW
import qualified Cake_Bootstrap as Bootstrap hiding(main)
import qualified Cake_BootstrapMisc as BootstrapMisc hiding(main)
import qualified Cake_Prelude as Prelude hiding(main)
import qualified Cake_MonadPack as MonadPack hiding(main)
import Cake_Oilprice_P

project = do

  let pn = file "Oilprice.urp"

  a <- uwapp "-dbms postgres" pn $ do
    allow mime "text/javascript";
    allow mime "text/css";
    allow mime "image/jpeg";
    allow mime "image/png";
    allow mime "image/gif";
    allow mime "application/octet-stream";
    allow url "https://github.com/grwlf/*"
    allow url "https://camo.githubusercontent.com/*"
    sql (pn.="sql")
    database ("dbname="++(takeBaseName pn))
    library (Bootstrap.lib)
    library (BootstrapMisc.lib)
    library (MonadPack.lib)
    library (Prelude.thelib)
    ur (sys "list")
    ur (sys "option")
    ur (sys "string")
    ur (sys "char")
    ur (single $ file "XmlGen.ur")
    bin (file "Oilprice.css") []
    ur (pair $ file "Oilprice.ur")

  db <- rule $ do
    let sql = urpSql (toUrp a)
    let dbn = takeBaseName sql
    shell [cmd|dropdb --if-exists $(string dbn)|]
    shell [cmd|createdb $(string dbn)|]
    shell [cmd|psql -f $(sql) $(string dbn)|]
    shell [cmd|touch @(sql.="db")|]

  rule $ do
    phony "dropdb"
    depend db

  rule $ do
    phony "all"
    depend a

main = do
  writeMake (file "Makefile") (project)

