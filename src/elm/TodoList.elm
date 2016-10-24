module TodoList
    exposing
        ( State
        , init
        , update
        , render
        )

import Html exposing (Html, li, text, ul)
import Html.Attributes exposing (class)
import Entities exposing (Todo, newTodo)
import Messages exposing (..)


-- STATE


type alias State =
    { todos : List Todo
    }


init : State
init =
    { todos = []
    }



-- UPDATE


update : Message -> State -> State
update message state =
    case message of
        AddTodo description ->
            { state | todos = state.todos ++ [ newTodo description ] }

        _ ->
            state



-- VIEW


render : State -> Html Message
render state =
    ul [ class "list-group" ]
        (List.map renderTodo state.todos)


renderTodo : Todo -> Html Message
renderTodo todo =
    li [ class "list-group-item" ]
        [ text <| .text todo ]
