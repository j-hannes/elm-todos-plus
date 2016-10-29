module Update exposing (..)

import List exposing (..)
import Debug exposing (log)
import Maybe exposing (withDefault)
import Actions exposing (..)
import State exposing (..)


updateWithLog : Action -> List State -> List State
updateWithLog message states =
    let
        m =
            log "Action" message

        s =
            log "State" states
    in
        update m s


update : Action -> List State -> List State
update message states =
    let
        state =
            withDefault init <| head states
    in
        case message of
            UpdateInput input ->
                { state | input = input } :: states

            AddTodo description ->
                { state
                    | input = ""
                    , todos = addTodo description state.todos
                }
                    :: states

            DeleteTodo description ->
                { state | todos = deleteTodo description state.todos } :: states

            ToggleTodo description ->
                { state | todos = map (toggleTodo description) state.todos } :: states

            UpdateTodo description newDescription ->
                { state | todos = map (updateTodo description newDescription) state.todos } :: states

            ChangeVisibility visibility ->
                { state | visibility = visibility } :: states

            Undo ->
                withDefault [ init ] <| tail states


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
