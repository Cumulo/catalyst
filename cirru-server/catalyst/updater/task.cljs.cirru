
ns catalyst.updater.task
  :require
    [] cljs.nodejs :as nodejs
    [] catalyst.schema :as schema

def create $ fn (db action-data action-meta)
  println "|creating task "
  assoc-in db
    [] :tasks (:id action-meta)
    assoc schema/task :id (:id action-meta) :text action-data
