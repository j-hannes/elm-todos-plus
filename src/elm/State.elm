module State exposing (..)


type alias State =
    { input : String
    , todos : List Todo
    , visibility : Visibility
    }


testData : List Todo
testData =
    [ Todo "buy some milk" False
    , Todo "walk the dog" True
    , Todo "buy more beer" False
    ]


init : State
init =
    { input = ""
    , todos = testData
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
