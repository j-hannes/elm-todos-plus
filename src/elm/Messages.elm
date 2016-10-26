module Messages exposing (..)


type Message
    = UpdateInput String
    | AddTodo String
    | DeleteTodo String
    | ToggleTodo String
