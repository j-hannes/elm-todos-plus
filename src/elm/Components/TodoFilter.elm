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
    div [ class "btn-group pull-right", style [ ( "margin-top", "20px" ) ] ]
        [ renderButton "all" (state.filterState == All) All
        , renderButton "active" (state.filterState == Active) Active
        , renderButton "done" (state.filterState == Done) Done
        ]


renderButton : String -> Bool -> FilterState -> Html Message
renderButton buttonText isActive newFilter =
    button
        [ classList
            [ ( "active", isActive )
            , ( "btn btn-primary", True )
            ]
        , onClick (ChangeFilter newFilter)
        ]
        [ text buttonText ]
