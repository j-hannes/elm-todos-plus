module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Debug exposing (log)


-- component import

import Components.TodoInput as TodoInput
import Components.TodoInput exposing (Action(..))


-- import Components.TodoInput exposing (Add)
-- APP


main : Program Never
main =
    App.beginnerProgram { model = initialState, update = update, view = view }



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
    }


initialState : State
initialState =
    log "initialState"
        { todos = []
        , todoInput = TodoInput.initialState
        }



-- UPDATE


type Action
    = Input TodoInput.Action


update : Action -> State -> State
update action state =
    case (log "action" action) of
        Input todoInputAction ->
            case todoInputAction of
                Add ->
                    log "state"
                        { state
                            | todoInput = TodoInput.update Add state.todoInput
                            , todos = state.todos ++ [ newTodo state.todoInput.input ]
                        }

                input ->
                    log "state"
                        { state
                            | todoInput = TodoInput.update input state.todoInput
                        }



-- VIEW


view : State -> Html Action
view state =
    div [ class "container" ]
        [ h1 [] [ text "Todos" ]
        , App.map Input (TodoInput.view state.todoInput)
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
