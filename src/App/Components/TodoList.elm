module Components.TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Actions exposing (..)


-- MODEL


type alias Todo =
    { text : String, completed : Bool }


newTodo : String -> Todo
newTodo text =
    { text = text
    , completed = False
    }


type alias State =
    { todos : List Todo
    }


initialState : State
initialState =
    { todos = []
    }



-- UPDATE


update : Action -> State -> State
update action state =
    case action of
        Add description ->
            { state | todos = state.todos ++ [ newTodo description ] }

        _ ->
            state



-- VIEW


renderTodo : Todo -> Html Action
renderTodo todo =
    li [ class "list-group-item" ]
        [ text <| .text todo ]


view : State -> Html Action
view state =
    ul [ class "list-group" ]
        (List.map renderTodo state.todos)
