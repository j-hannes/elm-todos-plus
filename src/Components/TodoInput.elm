module Components.TodoInput
    exposing
        ( Model
        , model
        , Update
        , update
        , view
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias Model =
    { todo : String
    }


model : Model
model =
    Model ""



-- UPDATE


type Update
    = Todo String


update : Update -> Model -> Model
update update model =
    case update of
        Todo todo ->
            { model | todo = todo }



-- VIEW


view : Html Update
view =
    div [ class "form-group" ]
        [ input
            [ class "form-control"
            , type' "text"
            , placeholder "Add new todo"
            , onInput Todo
            ]
            []
        ]
