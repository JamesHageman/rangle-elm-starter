module Components.UI.Alert exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (classList)
import Dict exposing (Dict)


statusClasses = Dict.fromList
  [ ("info", "bg-blue white")
  , ("warning", "bg-yellow black")
  , ("success", "bg-green black")
  , ("error", "bg-red white")
  ]


view : String -> List (Html msg) -> Html msg
view status children =
  div
    [ classList
      [ ("p2 bold", True)
      , (Dict.get status statusClasses
          |> Maybe.withDefault "", True)]
    ] children
