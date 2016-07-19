module Components.Header exposing (view)

import Html exposing (Html, img, nav, div, button, text, a)
import Html.Attributes exposing (src, class, classList, href)
import Html.Events exposing (onClick)


type alias HeaderProps msg =
  { isLoggedIn : Bool
  , firstName : String
  , lastName : String
  , onLogout : msg
  }


view : HeaderProps msg -> Html msg
view { isLoggedIn, firstName, lastName, onLogout } =
  let
    navItemDefault = navigatorItem { isVisible = isLoggedIn, mr = True, ml = False }
  in
    navigator [
      navItemDefault [
        logo
      ],
      navItemDefault [
        a [ href "#/" ] [ text "Counter" ]
      ],
      navItemDefault [
        a [ href "#/about" ] [ text "About Us" ]
      ],
      div [ class "flex flex-auto" ] [],
      navItemDefault [
        div [ class "h3" ] [
          text (firstName ++ " " ++ lastName)
        ]
      ],
      navItemDefault [
        button
          [ class "btn btn-primary bg-red white"
          , onClick onLogout
          ] [ text "Logout" ]
      ]
    ]


logo : Html msg
logo = img [ src "//placehold.it/100x50" ] []


navigatorItem : { isVisible : Bool, mr : Bool, ml : Bool} ->
  List (Html msg) -> Html msg
navigatorItem { isVisible, mr, ml } children =
  div [
    classList [
      ("truncate", True),
      ("hide", not isVisible),
      ("mr2", mr),
      ("ml2", ml)
    ]
  ] children


navigator : List (Html msg) -> Html msg
navigator children =
  nav [ class "flex items-center p1 bg-white border-bottom" ] children
