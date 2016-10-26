module Messages exposing (..)

import Entities exposing (FilterState)


type Message
    = UpdateInput String
    | AddTodo String
    | DeleteTodo String
    | ToggleTodo String
    | ChangeFilter FilterState
