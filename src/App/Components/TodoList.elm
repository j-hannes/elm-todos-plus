module App.Components.TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Actions exposing (..)


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
        Input _ ->
            state

        Add todoText ->
            { state | todos = state.todos ++ [ newTodo todoText ] }



-- VIEW


view : State -> Html Action
view state =
    div []
        [ text "todo-list" ]
