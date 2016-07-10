module App.Components.TodoList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Actions exposing (..)


-- MODEL


type alias State =
    { input : String
    }


initialState : State
initialState =
    { input = ""
    }



-- UPDATE


update : Action -> State -> State
update action state =
    case action of
        Input _ ->
            state

        Add ->
            state



-- VIEW


view : State -> Html Action
view state =
    div []
        [ text "todo-list" ]
