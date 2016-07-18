module Components.Header exposing (view)

import Html exposing (img, nav, div, button, text, a)
import Html.Attributes exposing (src, class, classList, href)


view { isLoggedIn, firstName, lastName } =
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
        button [ class "btn btn-primary bg-red white" ] [ text "Logout" ]
      ]
    ]


logo = img [ src "//placehold.it/100x50" ] []


navigatorItem { isVisible, mr, ml } children =
  div [
    classList [
      ("truncate", True),
      ("hide", not isVisible),
      ("mr2", mr),
      ("ml2", ml)
    ]
  ] children


navigator children =
  nav [ class "flex items-center p1 bg-white border-bottom" ] children
