module App exposing (..)

import Debug exposing (log)
import Html.App exposing (beginnerProgram)
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class, style)
import Messages exposing (..)
import TodoInput
import TodoList


main : Program Never
main =
    beginnerProgram
        { model = init
        , update = update
        , view = render
        }



-- STATE


type alias State =
    { todoInput : TodoInput.State
    , todoList : TodoList.State
    }


init : State
init =
    { todoInput = TodoInput.init
    , todoList = TodoList.init
    }



-- UPDATE


updateWithLog : Message -> State -> State
updateWithLog action state =
    update (log "Main.action" action) (log "Main.state" state)


update : Message -> State -> State
update action state =
    { state
        | todoInput = TodoInput.update action state.todoInput
        , todoList = TodoList.update action state.todoList
    }



-- VIEW


render : State -> Html Message
render state =
    div [ class "container" ]
        [ h1 [ style [ ( "margin-bottom", "20px" ) ] ] [ text "Todos" ]
        , TodoInput.render state.todoInput
        , TodoList.render state.todoList
        ]


styles : { wrapper : List ( String, String ) }
styles =
    { wrapper =
        [ ( "padding-top", "10px" )
        , ( "padding-bottom", "20px" )
        , ( "text-align", "center" )
        ]
    }
