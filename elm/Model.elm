module Model exposing (init)

import Routes
import Types exposing (Model, Msg)
import Components.Counter as Counter
import Components.LoginForm as LoginForm


initialModel : Model
initialModel =
  { user = Nothing
  , counter = Counter.init
  , route = Routes.Home
  , loginForm = LoginForm.init
  }


init : (Model, Cmd Msg)
init = (initialModel, Cmd.none)
