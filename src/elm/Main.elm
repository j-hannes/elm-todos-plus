module Main exposing (..)

import Html.App exposing (beginnerProgram)
import State exposing (init)
import Update exposing (update)
import View exposing (render)


main : Program Never
main =
    beginnerProgram
        { model = init
        , update = update
        , view = render
        }
