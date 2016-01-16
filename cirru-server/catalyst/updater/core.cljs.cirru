
ns catalyst.updater.core
  :require
    [] cljs.nodejs :as nodejs
    [] catalyst.updater.state :as up-state
    [] catalyst.updater.task :as up-task

defn updater (db action-type action-data action-meta)
  let
      handler $ case action-type
        :state/connect up-state/connect
        :state/disconnect up-state/disconnect

        :task/create up-task/create
        :task/remove up-task/remove-one
        :task/text up-task/text

        , identity
    handler db action-data action-meta
