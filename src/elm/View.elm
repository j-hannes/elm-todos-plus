module View exposing (render)

import List exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Actions exposing (..)
import State exposing (..)


render : State -> Html Action
render { input, todos, visibility } =
    div [ class "container" ]
        [ renderVisibility visibility
        , h1 [ style [ ( "margin-bottom", "20px" ) ] ] [ text "Todos" ]
        , renderInput input
        , renderTodos todos visibility
        ]


renderInput : String -> Html Action
renderInput inputText =
    Html.form
        [ class "form-group"
        , onSubmit (AddTodo inputText)
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


renderVisibility : Visibility -> Html Action
renderVisibility visibility =
    let
        buttons =
            [ ( "all", All )
            , ( "active", Active )
            , ( "done", Done )
            ]
    in
        div [ class "btn-group pull-right", style [ ( "margin-top", "20px" ) ] ]
            (map (renderButton visibility) buttons)


renderButton : Visibility -> ( String, Visibility ) -> Html Action
renderButton currentVisibility ( buttonText, visibility ) =
    button
        [ classList
            [ ( "active", visibility == currentVisibility )
            , ( "btn btn-primary", True )
            ]
        , onClick (ChangeVisibility visibility)
        ]
        [ text buttonText ]



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


renderTodos : List Todo -> Visibility -> Html Action
renderTodos todos visibility =
    let
        todoList =
            todos
                |> filterByVisibility visibility
                |> map renderTodo
    in
        ul [ class "list-group" ] todoList


renderTodo : Todo -> Html Action
renderTodo todo =
    li [ class "list-group-item" ]
        [ span
            [ style <| todoStyle todo
            , onClick <| ToggleTodo todo.text
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
