module State exposing (..)


type alias State =
    { input : String
    , todos : List Todo
    , visibility : Visibility
    }


init : State
init =
    { input = ""
    , todos = []
    , visibility = All
    }


type alias Todo =
    { text : String
    , completed : Bool
    }


newTodo : String -> Todo
newTodo text =
    { text = text
    , completed = False
    }


type Visibility
    = All
    | Active
    | Done
