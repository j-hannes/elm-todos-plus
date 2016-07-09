module Components.TodoInput exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias State =
    { input : String
    }


initialState : State
initialState =
    { input = ""
    }



-- UPDATE


type Action
    = NoOp
    | Input String
    | Add


update : Action -> State -> State
update action state =
    case action of
        NoOp ->
            state

        Input input ->
            { state | input = input }

        Add ->
            initialState



-- VIEW


view : State -> Html Action
view state =
    Html.form
        [ class "form-group"
        , onSubmit Add
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
