module Components.LoginForm exposing (..)

import Html exposing (Html, form, text, button)
import Html.Attributes exposing (class, type')
import Html.Events exposing (onSubmit, onClick)

import Components.UI.Form exposing (input, label, group)

type alias Model =
  { username : String
  , password : String
  }


type alias SubmitModel = Model


type Msg =
  ChangeUsername String
  | ChangePassword String
  | Clear
  | Submit


init : Model
init = Model "" ""


update : Msg -> Model -> (Model, Maybe SubmitModel)
update msg model =
  case msg of
    ChangeUsername name ->
      ({ model | username = name }, Nothing)

    ChangePassword pass ->
      ({ model | password = pass }, Nothing)

    Clear ->
      (init, Nothing)

    Submit ->
      (model, Just model)


view : Model -> Html Msg
view model =
  form [ onSubmit Submit ] [
    group
      [ label "Username"
      , input ChangeUsername "Username" "text" model.username
      ],
    group
      [ label "Password"
      , input ChangePassword "Password" "password" model.password
      ],
    group
      [ button
        [ class "btn btn-primary mr1"
        , type' "submit"
        ] [ text "Login" ]
      , button
        [ class "btn btn-primary bg-red"
        , onClick Clear
        ] [ text "Clear" ]
      ]
  ]
