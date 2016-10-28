module Actions exposing (..)

import State exposing (Visibility)


type Action
    = UpdateInput String
    | AddTodo String
    | DeleteTodo String
    | ToggleTodo String
    | ChangeVisibility Visibility
