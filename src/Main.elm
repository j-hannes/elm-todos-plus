module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App


-- component import

import Components.TodoInput as TodoInput


-- APP


main : Program Never
main =
    App.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { todoInput : TodoInput.Model
    }


model : Model
model =
    Model TodoInput.model



-- UPDATE


type Update
    = Input TodoInput.Update


update : Update -> Model -> Model
update update model =
    case update of
        Input update ->
            { model | todoInput = TodoInput.update update model.todoInput }



-- VIEW


view : Model -> Html Update
view model =
    div [ class "container" ]
        [ h1 [] [ text "Todos" ]
        , App.map Input TodoInput.view
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
