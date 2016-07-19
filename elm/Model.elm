module Model exposing (init)

import Routes
import Types exposing (Model, Msg)
import Components.Counter as Counter
import Components.LoginForm as LoginForm
import Dict exposing (Dict)


initialModel : Model
initialModel =
  { user = Nothing
  , counter = Counter.init
  , route = Routes.Home
  , loginForm = LoginForm.init
  , errors = Dict.empty
  }


init : (Model, Cmd Msg)
init = (initialModel, Cmd.none)
