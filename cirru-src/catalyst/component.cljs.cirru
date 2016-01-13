
ns catalyst.component
  :require
    [] reagent.core :as r
    [] catalyst.layout :as layout
    [] catalyst.widget :as widget

defn page (store send)
  let
      click-add $ fn (event) (send :state/counter-add)
    [] :div ({} :style layout/fullscreen)
      [] :div ({} :style widget/button :on-click click-add) "|Add"
      [] :div ({}) "|result: " (:counter store)
