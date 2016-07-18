module Routes exposing (..)

import RouteParser exposing (Matcher, static)

type Route
  = Home
  | About
  | NotFound


routeParsers : List (Matcher Route)
routeParsers =
  [ static Home "/"
  , static About "/about"
  ]


decode : String -> Route
decode path =
  RouteParser.match routeParsers path
    |> Maybe.withDefault NotFound


encode : Route -> String
encode route =
  case route of
    Home ->
      "/"

    About ->
      "/about"

    NotFound ->
      ""
