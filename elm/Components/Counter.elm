module Components.Counter exposing (view, update, init, Model, Msg)

import Html exposing (Html, div, h2, button, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Components.UI.Container as Container


-- Model


type alias Model =
    Int


init : Model
init =
    0


type Msg
    = Increment
    | Decrement



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- View


view : Model -> Html Msg
view model =
    Container.view { size = 2, center = True }
        [ h2 [ class "center caps" ] [ text "Counter" ]
        , div [ class "flex" ]
            [ button
                [ class "btn btn-primary bg-black col-2"
                , onClick Decrement
                ]
                [ text "-" ]
            , div [ class "flex-auto center h1" ]
                [ text (toString model) ]
            , button
                [ class "btn btn-primary col-2"
                , onClick Increment
                ]
                [ text "+" ]
            ]
        ]
