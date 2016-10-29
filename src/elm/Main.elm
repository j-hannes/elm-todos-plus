module Main exposing (..)

import Html.App exposing (beginnerProgram)
import State exposing (init)
import Update exposing (update, updateWithLog)
import View exposing (app)


main : Program Never
main =
    beginnerProgram
        { model = [ init ]
        , update = updateWithLog
        , view = app
        }
