
ns catalyst.updater.task
  :require
    [] cljs.nodejs :as nodejs
    [] catalyst.schema :as schema

defn create (db action-data action-meta)
  assoc-in db
    [] :tasks (:id action-meta)
    assoc schema/task :id (:id action-meta) :text action-data
      , :time (:time action-meta)

defn remove-one (db action-data action-meta)
  update db :tasks $ fn (tasks)
    dissoc tasks action-data

defn text (db action-data action-meta)
  update-in db
    [] :tasks (:id action-data)
    fn (task)
      assoc task :text (:text action-data) :time (:time action-meta)
