
ns catalyst.core
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] reagent.core :as r
    [] catalyst.ws-client :as ws-client
    [] differ.core :as differ

enable-console-print!

defonce data-center $ atom $ {}

go
  reset! data-center $ differ/patch @data-center (<! ws-client/receive-chan)
  println @data-center ws-client/send-chan
