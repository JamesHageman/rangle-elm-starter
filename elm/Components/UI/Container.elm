module Components.UI.Container exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (class, classList)


view : { size : Int, center : Bool } -> List (Html a) -> Html a
view { size, center } children =
    div
        [ classList
            [ ( "clearfix px1", True )
            , ( "mx-auto", center )
            , ( "max-width-1", size == 1 )
            , ( "max-width-2", size == 2 )
            , ( "max-width-3", size == 3 )
            , ( "max-width-4", size == 4 )
            ]
        ]
        children
