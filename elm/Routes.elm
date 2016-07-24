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


match : String -> Route
match path =
    RouteParser.match routeParsers path
        |> Maybe.withDefault NotFound
