module Update exposing (..)

import List exposing (..)
import Debug exposing (log)
import Actions exposing (..)
import State exposing (..)


updateWithLog : Action -> State -> State
updateWithLog message state =
    let
        m =
            log "Action" message

        s =
            log "State" state
    in
        update m s


update : Action -> State -> State
update message state =
    case message of
        UpdateInput input ->
            { state | input = input }

        AddTodo description ->
            { state
                | input = ""
                , todos = addTodo description state.todos
            }

        DeleteTodo description ->
            { state | todos = deleteTodo description state.todos }

        ToggleTodo description ->
            { state | todos = toggleTodo description state.todos }

        ChangeVisibility visibility ->
            { state | visibility = visibility }


addTodo : String -> List Todo -> List Todo
addTodo description todos =
    newTodo description :: deleteTodo description todos


deleteTodo : String -> List Todo -> List Todo
deleteTodo description todos =
    filter (\t -> t.text /= description) todos


toggleTodo : String -> List Todo -> List Todo
toggleTodo description todos =
    map (toggleByText description) todos


toggleByText : String -> Todo -> Todo
toggleByText description todo =
    if todo.text == description then
        toggle todo
    else
        todo


toggle : Todo -> Todo
toggle todo =
    { todo | completed = not todo.completed }
