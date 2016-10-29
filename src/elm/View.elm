module View exposing (app)

import List exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Actions exposing (..)
import State exposing (..)


app : State -> Html Action
app { input, todos, visibility } =
    div [ class "container" ]
        [ visibilityFilter visibility
        , h1 [ style [ ( "margin-bottom", "20px" ) ] ] [ text "Todos" ]
        , todoInput input
        , todoList todos visibility
        ]


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



-- filterByVisibility All    = identity
-- filterByVisibility Active = filter ((== False) . completed)
-- filterByVisibility Done   = filter ((== True) . completed)


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
                |> map todoListItem
    in
        ul [ class "list-group" ] todoList


todoListItem : Todo -> Html Action
todoListItem todo =
    li [ class "list-group-item" ]
        [ input
            [ type' "checkbox"
            , onClick <| ToggleTodo todo.text
            , style [ ( "margin-right", "15px" ) ]
            ]
            []
        , span
            [ style <| todoStyle todo
            ]
            [ text todo.text ]
        , button
            [ class "close"
            , onClick <| DeleteTodo todo.text
            ]
            [ span [] [ text "x" ] ]
        ]


todoStyle : Todo -> List ( String, String )
todoStyle todo =
    let
        completedStyle =
            [ ( "text-decoration", "line-through" )
            , ( "color", "#ccc" )
            ]
    in
        [ ( "cursor", "pointer" ) ]
            ++ if todo.completed then
                completedStyle
               else
                []
