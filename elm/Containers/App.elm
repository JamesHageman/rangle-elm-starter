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

import Dict exposing (Dict)


view : Model -> Html Msg
view model =
  let
    _ = Debug.log "model" model
  in
    case model.user of
      Just user ->
        let headerProps =
          { isLoggedIn = True
          , firstName = user.profile.firstName
          , lastName = user.profile.lastName
          , onLogout = Types.Logout
          }
        in
          div [] [
            Header.view headerProps,
            main' [] [
              matchRoute model.route model
            ]
          ]

      Nothing ->
        loginModal model


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
  let
    loginError = Dict.get "login" model.errors
  in
    Modal.view [
      Html.App.map Types.LoginFormMsg (LoginForm.view loginError model.loginForm)
    ]
