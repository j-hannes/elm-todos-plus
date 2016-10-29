module View exposing (app)

import List exposing (..)
import Maybe exposing (withDefault)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Actions exposing (..)
import State exposing (..)
import Json.Decode as Json


-- APP


app : List State -> Html Action
app states =
    let
        { input, todos, visibility } =
            withDefault init <| head states
    in
        div [ class "container" ]
            [ visibilityFilter visibility
            , h1 [ style [ ( "margin-bottom", "20px" ) ] ] [ text "Todos" ]
            , todoInput input
            , todoList todos visibility
            , undoButton <| length states
            ]



-- UNDO


undoButton : Int -> Html Action
undoButton numStates =
    button
        [ class "btn btn-default"
        , onClick Undo
        , disabled (numStates == 1)
        ]
        [ text "Undo" ]



-- VISIBILITY


visibilityFilter : Visibility -> Html Action
visibilityFilter visibility =
    let
        visibilityOptions =
            [ ( "all", All )
            , ( "active", Active )
            , ( "done", Done )
            ]

        visibilityButtons =
            visibilityOptions
                |> map (changeVisibilityButton visibility)
    in
        div
            [ class "btn-group pull-right"
            , style
                [ ( "margin-top", "20px" )
                , ( "white-space", "nowrap" )
                ]
            ]
            visibilityButtons


changeVisibilityButton : Visibility -> ( String, Visibility ) -> Html Action
changeVisibilityButton currentVisibility ( buttonText, visibility ) =
    button
        [ classList
            [ ( "active", visibility == currentVisibility )
            , ( "btn btn-primary", True )
            ]
        , style
            [ ( "float", "none" )
            ]
        , onClick (ChangeVisibility visibility)
        ]
        [ text buttonText ]



-- INPUT


todoInput : String -> Html Action
todoInput inputText =
    Html.form
        [ class "form-group"
        , onSubmit <| AddTodo inputText
        ]
        [ input
            [ class "form-control"
            , type' "text"
            , placeholder "Add new todo"
            , onInput UpdateInput
            , value inputText
            ]
            []
        ]



-- LIST


filterByVisibility : Visibility -> List Todo -> List Todo
filterByVisibility visibility =
    case visibility of
        All ->
            identity

        Active ->
            filter <| \t -> t.completed == False

        Done ->
            filter <| \t -> t.completed == True


todoList : List Todo -> Visibility -> Html Action
todoList todos visibility =
    let
        todoList =
            todos
                |> filterByVisibility visibility
                |> map todoItem
    in
        ul [ class "list-group" ] todoList


todoItem : Todo -> Html Action
todoItem todo =
    let
        todoVariant =
            if todo.completed then
                completedTodoItem
            else
                activeTodoItem
    in
        li [ class "list-group-item" ]
            [ input
                [ type' "checkbox"
                , onClick <| ToggleTodo todo.text
                , style [ ( "margin-right", "15px" ) ]
                , checked todo.completed
                ]
                []
            , todoVariant todo.text
            , button
                [ class "close"
                , onClick <| DeleteTodo todo.text
                ]
                [ span [] [ text "x" ] ]
            ]


completedTodoItem : String -> Html Action
completedTodoItem todoText =
    span
        [ style
            [ ( "text-decoration", "line-through" )
            , ( "color", "#ccc" )
            , ( "width", "calc(100% - 50px)" )
            , ( "display", "inline-flex" )
            , ( "white-space", "nowrap" )
            , ( "overflow", "hidden" )
            , ( "padding", "1px" )
            ]
        ]
        [ text todoText ]


activeTodoItem : String -> Html Action
activeTodoItem todoText =
    span []
        [ input
            [ value todoText
            , style
                [ ( "border", "none" )
                , ( "width", "calc(100% - 50px)" )
                ]
            , on "blur" <| Json.map (UpdateTodo todoText) targetValue
            ]
            []
        ]
