module Components.UI.Modal exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (class)

view : List (Html msg) -> Html msg
view children =
  div [ class "fixed top-0 bottom-0 left-0 right-0 z1 bg-darken-3" ] [
    div [ class "p2 z2 bg-white relative" ] children
  ]
