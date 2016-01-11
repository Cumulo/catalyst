
ns catalyst.server
  :require
    [] cljs.nodejs :as nodejs

nodejs/enable-util-print!

defn -main ()
  println "|Hello world 2!"

set! *main-cli-fn* -main
