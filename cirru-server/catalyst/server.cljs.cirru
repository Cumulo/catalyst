
ns catalyst.server
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] cljs.nodejs :as nodejs
    [] catalyst.schema :as schema
    [] catalyst.ws-server :as ws-server
    [] catalyst.expand :refer
      [] expand
    [] catalyst.updater.core :refer
      [] updater
    [] cljs.core.async :as a :refer
      [] >! <! chan
    [] differ.core :as differ

nodejs/enable-util-print!
defn -main ()
  println "|server started"
set! *main-cli-fn* -main

defonce data-center $ atom schema/database

defonce client-caches $ atom $ {}

go $ loop ([]) $ let
    msg (<! ws-server/receive-chan)
    new-data $ updater @data-center (:type msg) (:data msg) (:meta msg)
  println :msg msg
  doseq
    [] state-entry (:states new-data)
    let
        state-id $ first state-entry
        new-store $ expand new-data state-id
        old-store $ or (get @client-caches state-id) ({})
        changes $ differ/diff old-store new-store
      println "|old-store" old-store "|->" new-store "|∆:" changes
      >! ws-server/send-chan $ {} :target state-id :changes changes
      swap! client-caches assoc state-id new-store
  reset! data-center new-data
  recur
