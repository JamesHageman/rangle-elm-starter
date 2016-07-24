module Components.About exposing (view)

import Html exposing (div, h2, p, text)
import Html.Attributes exposing (class)
import Components.UI.Container as Container


view =
    let
        content =
            "Rangle.io is a next-generation HTML5 design and development firm"
                ++ "dedicated to modern, responsive web and mobile applications."
    in
        Container.view { center = True, size = 4 }
            [ h2 [ class "caps" ] [ text "About Us" ]
            , p [] [ text content ]
            ]
