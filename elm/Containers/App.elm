module Containers.App exposing (view)

import Types exposing (Model, Msg)
import Html exposing (Html, div, a, p, main', text)
import Html.Attributes exposing (href)
import Html.App
import Routes

import Components.Header as Header
import Components.About as About
import Components.Counter as Counter


view : Model -> Html Msg
view model =
  let
    headerProps = {
      isLoggedIn = True,
      firstName = "James",
      lastName = "Hageman"
    }
  in
    div [] [
      Header.view headerProps,
      main' [] [
        matchRoute model.route model
      ]
    ]


matchRoute : Routes.Route -> Model -> Html Msg
matchRoute route model =
  case route of
    Routes.Home ->
      Html.App.map Types.CounterMsg (Counter.view model.counter)

    Routes.About ->
      About.view

    Routes.NotFound ->
      div [] [
        p [] [ text "Not found" ]
      , a [ href "#/" ] [ text "Go Home" ]
      ]
