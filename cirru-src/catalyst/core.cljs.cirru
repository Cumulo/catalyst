
ns catalyst.core
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] reagent.core :as r
    [] catalyst.ws-client :as ws-client
    [] catalyst.components :as components
    [] differ.core :as differ
    [] devtools.core :as devtools

enable-console-print!

devtools/set-pref! :install-sanity-hints true
devtools/install!

defonce data-center $ r/atom $ {}

go
  reset! data-center $ differ/patch @data-center (<! ws-client/receive-chan)
  println @data-center ws-client/send-chan

defn mountit ()
  r/render-component
    [] components/page @data-center
    .querySelector js/document |#app

mountit
