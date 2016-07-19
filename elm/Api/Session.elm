module Api.Session exposing (login)

import Types exposing (User, UserProfile)
import Http exposing (multipart, stringData)
import Json.Decode as Json exposing (string)
import Json.Decode.Pipeline exposing (decode, required)
import Task exposing (Task)
import Json.Encode as JS

decodeProfile : Json.Decoder UserProfile
decodeProfile =
  decode UserProfile
    |> required "first" string
    |> required "last" string


decodeUser : Json.Decoder User
decodeUser =
  decode User
    |> required "id" string
    |> required "token" string
    |> required "profile" decodeProfile


loginErrMsg : Http.Error -> String
loginErrMsg err =
  case err of
    Http.BadResponse status text ->
      case status of
        401 ->
          "The username or password you have entered is invalid."

        _ -> "There was a problem with your request, please try again."

    Http.UnexpectedPayload text ->
      "There was a problem with the server, please try again."

    Http.Timeout ->
      "Your request timed out, please try again."

    Http.NetworkError ->
      "Unable to connect to server, please try again."


login : (String, String) -> Task String User
login (username, password) =
  let
    bodyEncoder = JS.object [
      ("username", JS.string username),
      ("password", JS.string password)
    ]

    body = bodyEncoder
      |> JS.encode 0
      |> Http.string

    url = "/api/auth/login"
  in
    Http.send
      Http.defaultSettings
      { verb = "post"
      , headers =
        [ ("Content-Type", "application/json") ]
      , url = url
      , body = body
      }
        |> Http.fromJson (Json.at [ "meta" ] decodeUser)
        |> Task.mapError loginErrMsg
