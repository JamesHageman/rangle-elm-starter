module Containers.App exposing (view)

import Types exposing (Model, Msg)
import Html exposing (Html, div, a, p, main', text)
import Html.Attributes exposing (href)
import Html.App
import Routes

import Components.Header as Header
import Components.About as About
import Components.Counter as Counter
import Components.LoginForm as LoginForm
import Components.UI.Modal as Modal


view : Model -> Html Msg
view model =
  let
    isLoggedIn = case model.user of
      Just user -> True
      Nothing -> False

    headerProps = {
      isLoggedIn = isLoggedIn,
      firstName = "James",
      lastName = "Hageman"
    }
  in
    div [] [
      Header.view headerProps,
      main' [] [
        if isLoggedIn then
          (matchRoute model.route model)
        else
          (loginModal model)
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


loginModal : Model -> Html Msg
loginModal model =
  Modal.view [
    Html.App.map Types.LoginFormMsg (LoginForm.view model.loginForm)
  ]
