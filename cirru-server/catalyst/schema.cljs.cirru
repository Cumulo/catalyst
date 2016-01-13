
ns catalyst.schema
  :require
    [] cljs.nodejs :as nodejs

def database $ {}
  :states $ {}
  :tasks $ {}
  :users $ {}

def task $ {}
  :text |
  :done false
  :id nil

def state $ {}
  :user-id nil
  :counter 0
