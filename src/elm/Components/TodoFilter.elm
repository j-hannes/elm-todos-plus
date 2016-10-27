module Components.TodoFilter
    exposing
        ( State
        , init
        , update
        , render
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Entities exposing (FilterState(..))


-- STATE


type alias State =
    { filterState : FilterState
    }


init : State
init =
    { filterState = All
    }



-- UPDATE


update : Message -> State -> State
update message state =
    case message of
        ChangeFilter filterState ->
            { state | filterState = filterState }

        _ ->
            state



-- VIEW


render : State -> Html Message
render state =
    let
        buttons =
            [ ( "all", All )
            , ( "active", Active )
            , ( "done", Done )
            ]
    in
        div [ class "btn-group pull-right", style [ ( "margin-top", "20px" ) ] ]
            (List.map (renderButton state) buttons)


renderButton : State -> ( String, FilterState ) -> Html Message
renderButton state ( buttonText, filterState ) =
    button
        [ classList
            [ ( "active", state.filterState == filterState )
            , ( "btn btn-primary", True )
            ]
        , onClick (ChangeFilter filterState)
        ]
        [ text buttonText ]
