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
            { state | todos = map (toggleTodo description) state.todos }

        UpdateTodo description newDescription ->
            { state | todos = map (updateTodo description newDescription) state.todos }

        ChangeVisibility visibility ->
            { state | visibility = visibility }


addTodo : String -> List Todo -> List Todo
addTodo description todos =
    newTodo description :: deleteTodo description todos


deleteTodo : String -> List Todo -> List Todo
deleteTodo description todos =
    filter (\t -> t.text /= description) todos


toggleTodo : String -> Todo -> Todo
toggleTodo description todo =
    if todo.text == description then
        { todo | completed = not todo.completed }
    else
        todo


updateTodo : String -> String -> Todo -> Todo
updateTodo description newDescription todo =
    if (todo.text == description) then
        { todo | text = newDescription }
    else
        todo
