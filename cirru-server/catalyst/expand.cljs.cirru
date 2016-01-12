
ns catalyst.expand
  :require
    [] cljs.nodejs :as nodejs

defn expand (db state-id)
  get-in db $ [] :states state-id
