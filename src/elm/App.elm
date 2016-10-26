module App exposing (..)

import Debug exposing (log)
import Html.App exposing (beginnerProgram)
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class, style)
import Messages exposing (..)
import Components.TodoInput as TodoInput
import Components.TodoList as TodoList
import Components.TodoFilter as TodoFilter


main : Program Never
main =
    beginnerProgram
        { model = init
        , update = updateWithLog
        , view = render
        }



-- STATE


type alias State =
    { todoInput : TodoInput.State
    , todoList : TodoList.State
    , todoFilter : TodoFilter.State
    }


init : State
init =
    { todoInput = TodoInput.init
    , todoList = TodoList.init
    , todoFilter = TodoFilter.init
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
        , todoFilter = TodoFilter.update action state.todoFilter
    }



-- VIEW


render : State -> Html Message
render state =
    div [ class "container" ]
        [ TodoFilter.render state.todoFilter
        , h1 [ style [ ( "margin-bottom", "20px" ) ] ] [ text "Todos" ]
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
