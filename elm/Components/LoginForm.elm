module Components.LoginForm exposing (..)

import Html exposing (Html, form, text, button)
import Html.Attributes exposing (class, type')
import Html.Events exposing (onSubmit, onClick)
import Components.UI.Form exposing (input, label, group, error)
import Components.UI.Alert as Alert
import String


-- Model


type alias Model =
    { username : String
    , password : String
    }


type alias SubmitModel =
    Model


type Msg
    = ChangeUsername String
    | ChangePassword String
    | Clear
    | Submit


init : Model
init =
    Model "" ""



-- Update


update : Msg -> Model -> ( Model, Maybe SubmitModel )
update msg model =
    case msg of
        ChangeUsername name ->
            ( { model | username = name }, Nothing )

        ChangePassword pass ->
            ( { model | password = pass }, Nothing )

        Clear ->
            ( init, Nothing )

        Submit ->
            let
                { username, password } =
                    validate model
            in
                case ( username, password ) of
                    ( Nothing, Nothing ) ->
                        ( model, Just model )

                    _ ->
                        ( model, Nothing )



-- View


view : Maybe String -> Model -> Html Msg
view errorMessage model =
    let
        validations =
            validate model

        usernameMsg =
            validationMessage validations.username

        passwordMsg =
            validationMessage validations.password
    in
        form [ onSubmit Submit ]
            [ case errorMessage of
                Nothing ->
                    text ""

                Just msg ->
                    Alert.view "error" [ text msg ]
            , group
                [ label "Username"
                , input ChangeUsername "username" "text" model.username
                , usernameMsg
                ]
            , group
                [ label "Password"
                , input ChangePassword "password" "password" model.password
                , passwordMsg
                ]
            , group
                [ button
                    [ class "btn btn-primary mr1"
                    , type' "submit"
                    ]
                    [ text "Login" ]
                , button
                    [ class "btn btn-primary bg-red"
                    , onClick Clear
                    ]
                    [ text "Clear" ]
                ]
            ]


validationMessage : Maybe String -> Html msg
validationMessage validation =
    case validation of
        Nothing ->
            text ""

        Just msg ->
            error [ text msg ]


validate : Model -> { username : Maybe String, password : Maybe String }
validate model =
    { username = required "Username" model.username
    , password = required "Password" model.password
    }


required : String -> String -> Maybe String
required label str =
    if String.length str > 0 then
        Nothing
    else
        Just (label ++ " is required.")
