module Entities exposing (..)


type alias Todo =
    { text : String
    , completed : Bool
    }


newTodo : String -> Todo
newTodo text =
    { text = text
    , completed = False
    }
