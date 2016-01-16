
ns catalyst.component
  :require
    [] reagent.core :as r
    [] catalyst.layout :as la
    [] catalyst.widget :as wi

defn task (task)

defn hspace (x)
  [] :div
    {} :style
      merge la/hspace $ {} :width x

defn vspace (x)
  [] :div
    {} :style
      merge la/vspace $ {} :height x

defn page (store send)
  let
      draft $ r/atom |
      on-draft-change $ fn (event)
        reset! draft (-> event .-target .-value)
      on-create $ fn (event)
        if (> (count @draft) 0)
          do
            send :task/create @draft
            reset! draft |
    fn () $ [] :div ({} :style (merge la/fullscreen la/center-content))
      [] :div ({} :style wi/app)
        [] :input ({} :style wi/textbox :value @draft :on-change on-draft-change :placeholder "|draft")
        hspace 10
        [] :button ({} :style wi/button :on-click on-create) |Submit
        map
          fn (entry)
            [] :div ({} :key (get entry 0) :style wi/task)
              [] :input $ {} :value (:text (get entry 1)) :style wi/textbox
          :tasks @store
