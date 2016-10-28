module Update exposing (..)

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

        ChangeVisibility visibility ->
            { state | visibility = visibility }

        AddTodo description ->
            let
                filteredTodos =
                    List.filter (\t -> t.text /= description) state.todos

                nextTodos =
                    newTodo description :: filteredTodos
            in
                { state
                    | input = ""
                    , todos = nextTodos
                }

        DeleteTodo description ->
            let
                filteredTodos =
                    List.filter (\t -> t.text /= description) state.todos
            in
                { state
                    | todos = filteredTodos
                }

        ToggleTodo description ->
            let
                nextTodos =
                    List.map toggleTodo state.todos

                toggleTodo t =
                    if t.text == description then
                        { t | completed = not t.completed }
                    else
                        t
            in
                { state | todos = nextTodos }
