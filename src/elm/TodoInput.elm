module TodoInput
    exposing
        ( State
        , init
        , update
        , render
        )

import Html exposing (Html, input)
import Html.Attributes exposing (class, placeholder, type', value)
import Html.Events exposing (onInput, onSubmit)
import Messages exposing (..)


-- STATE


type alias State =
    { input : String
    }


init : State
init =
    { input = ""
    }



-- UPDATE


update : Message -> State -> State
update message state =
    case message of
        UpdateInput input ->
            { state | input = input }

        AddTodo _ ->
            init



-- VIEW


render : State -> Html Message
render state =
    Html.form
        [ class "form-group"
        , onSubmit (AddTodo state.input)
        ]
        [ input
            [ class "form-control"
            , type' "text"
            , placeholder "Add new todo"
            , onInput UpdateInput
            , value state.input
            ]
            []
        ]
