module Components.UI.Form exposing (label, input, group)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class, placeholder, type', name, value)
import Html.Events exposing (onInput)


label : String -> Html msg
label name =
  Html.label [] [
    text name
  ]


input : (String -> msg) -> String -> String -> String -> Html msg
input inputMsg elementName elementType elementValue =
  Html.input
    [ class "block col-12 mb1 input"
    , placeholder elementName
    , value elementValue
    , onInput inputMsg
    , type' elementType
    ] []


group : List (Html msg) -> Html msg
group children =
  div [ class "py2" ] children
