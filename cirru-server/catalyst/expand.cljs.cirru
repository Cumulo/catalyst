
ns catalyst.expand
  :require
    [] cljs.nodejs :as nodejs
    [] catalyst.schema :as schema

defn expand (db state-id)
  assoc schema/store
    , :state $ get-in db $ [] :states state-id
    , :tasks $ :tasks db
    , :users $ :users db
