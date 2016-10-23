module Components.TodoInput exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Actions exposing (..)


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
        Input input ->
            { state | input = input }

        Add _ ->
            initialState



-- VIEW


view : State -> Html Action
view state =
    Html.form
        [ class "form-group"
        , onSubmit (Add state.input)
        ]
        [ input
            [ class "form-control"
            , type' "text"
            , placeholder "Add new todo"
            , onInput Input
            , value state.input
            ]
            []
        ]
