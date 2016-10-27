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
import Entities exposing (..)
import Messages exposing (..)


-- STATE


type alias State =
    { todos : List Todo
    , visibleTodos : List Todo
    }


init : State
init =
    { todos = []
    , visibleTodos = []
    }



-- UPDATE


filterTodos : FilterState -> List Todo -> List Todo
filterTodos filterState todos =
    case filterState of
        All ->
            todos

        Active ->
            List.filter (\t -> t.completed == False) todos

        Done ->
            List.filter (\t -> t.completed == True) todos


update : Message -> State -> State
update message state =
    case message of
        AddTodo description ->
            let
                filteredTodos =
                    List.filter (\t -> t.text /= description) state.todos

                nextTodos =
                    newTodo description :: nextTodos
            in
                { state
                    | todos = nextTodos
                    , visibleTodos = nextTodos
                }

        DeleteTodo description ->
            let
                filteredTodos =
                    List.filter (\t -> t.text /= description) state.todos
            in
                { state
                    | todos = filteredTodos
                    , visibleTodos = filteredTodos
                }

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
                { state
                    | todos = nextTodos
                    , visibleTodos = nextTodos
                }

        ChangeFilter filterState ->
            { state | visibleTodos = filterTodos filterState state.todos }

        _ ->
            state



-- VIEW


render : State -> Html Message
render state =
    ul [ class "list-group" ]
        (List.map renderTodo state.visibleTodos)


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
