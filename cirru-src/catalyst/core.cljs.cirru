
ns catalyst.core
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] reagent.core :as r
    [] catalyst.ws-client :as ws-client
    [] catalyst.component :as component
    [] differ.core :as differ
    [] devtools.core :as devtools

enable-console-print!

devtools/set-pref! :install-sanity-hints true
devtools/install!

defonce data-center $ r/atom $ {}

defn send (action-type action-data)
  go
    >! ws-client/send-chan $ {} :type action-type :data action-data

defn mountit ()
  r/render-component
    [] component/page data-center send
    .querySelector js/document |#app

mountit

go $ loop ([])
  reset! data-center $ differ/patch @data-center (<! ws-client/receive-chan)
  .info js/console "|store:" @data-center
  mountit
  recur
