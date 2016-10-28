module View exposing (render)

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
            (List.map (renderButton visibility) buttons)


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


filterTodos : Visibility -> List Todo -> List Todo
filterTodos visibility todos =
    case visibility of
        All ->
            todos

        Active ->
            List.filter (\t -> t.completed == False) todos

        Done ->
            List.filter (\t -> t.completed == True) todos


renderTodos : List Todo -> Visibility -> Html Action
renderTodos todos visibility =
    ul [ class "list-group" ]
        (List.map renderTodo (filterTodos visibility todos))


renderTodo : Todo -> Html Action
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
