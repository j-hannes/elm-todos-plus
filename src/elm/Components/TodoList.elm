module Components.TodoList
    exposing
        ( State
        , init
        , update
        , render
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Entities exposing (Todo, newTodo)
import Messages exposing (..)


-- STATE


type alias State =
    { todos : List Todo
    }


init : State
init =
    { todos = []
    }



-- UPDATE


update : Message -> State -> State
update message state =
    case message of
        AddTodo description ->
            let
                nextTodos =
                    List.filter (\t -> t.text /= description) state.todos
            in
                { state | todos = newTodo description :: nextTodos }

        DeleteTodo description ->
            let
                filteredTodos =
                    List.filter (\t -> t.text /= description) state.todos
            in
                { state | todos = filteredTodos }

        ToggleTodo description ->
            let
                nextTodos =
                    List.map
                        (\t ->
                            if t.text == description then
                                { t | completed = not t.completed }
                            else
                                t
                        )
                        state.todos
            in
                { state | todos = nextTodos }

        _ ->
            state



-- VIEW


render : State -> Html Message
render state =
    ul [ class "list-group" ]
        (List.map renderTodo state.todos)


renderTodo : Todo -> Html Message
renderTodo todo =
    li [ class "list-group-item" ]
        [ span [ style (todoStyle todo), onClick (ToggleTodo todo.text) ]
            [ text todo.text ]
        , button [ class "close", onClick (DeleteTodo todo.text) ]
            [ span [] [ text "x" ] ]
        ]


todoStyle : Todo -> List ( String, String )
todoStyle todo =
    [ ( "cursor", "pointer" ) ]
        ++ if todo.completed then
            [ ( "text-decoration", "line-through" )
            , ( "color", "#ccc" )
            ]
           else
            []
