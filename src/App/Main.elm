module App.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Debug exposing (log)
import App.Actions exposing (..)
import App.Components.TodoInput as TodoInput
import App.Components.TodoList as TodoList


-- APP


main : Program Never
main =
    App.beginnerProgram
        { model = initialState
        , update = updateWithLog
        , view = view
        }



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
    , todoInput : TodoInput.State
    , todoList : TodoList.State
    }


initialState : State
initialState =
    { todos = []
    , todoInput = TodoInput.initialState
    , todoList = TodoList.initialState
    }



-- UPDATE


updateWithLog : Action -> State -> State
updateWithLog action state =
    update (log "Main.action" action) (log "Main.state" state)


update : Action -> State -> State
update action state =
    case action of
        Input input ->
            { state
                | todoInput = TodoInput.update (Input input) state.todoInput
            }

        Add input ->
            { state
                | todoInput = TodoInput.update (Add input) state.todoInput
                , todoList = TodoList.update (Add input) state.todoList
                , todos = state.todos ++ [ newTodo state.todoInput.input ]
            }



-- VIEW


view : State -> Html Action
view state =
    div [ class "container" ]
        [ h1 [ style [ ( "margin-bottom", "20px" ) ] ] [ text "Todos" ]
        , TodoInput.view state.todoInput
        , TodoList.view state.todoList
        ]



-- CSS STYLES


styles : { wrapper : List ( String, String ) }
styles =
    { wrapper =
        [ ( "padding-top", "10px" )
        , ( "padding-bottom", "20px" )
        , ( "text-align", "center" )
        ]
    }
