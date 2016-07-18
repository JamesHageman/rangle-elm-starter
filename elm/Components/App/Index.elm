module Components.App.Index exposing (init, view, update, subscriptions)

import Location
import Routes
import Components.App.Update as Update
import Html exposing (Html, div, text)

import Components.Header.Index as Header

init = Update.init

update = Update.update

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
      matchRoute model.route
    ]


matchRoute : Routes.Route -> Html Update.Msg
matchRoute route =
  case route of
    Routes.Home ->
      div [] [ text "Home" ]

    Routes.About ->
      div [] [ text "About" ]

    Routes.NotFound ->
      div [] [ text "Not found" ]


subscriptions model =
  Sub.batch [ Location.pathUpdates Update.PathUpdated ]
