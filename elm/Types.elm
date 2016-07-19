module Types exposing (..)

import Routes
import Components.Counter as Counter
import Components.LoginForm as LoginForm
import Dict exposing (Dict)


type alias UserProfile =
  { firstName : String
  , lastName : String
  }

type alias User =
  { id : String
  , token : String
  , profile : UserProfile
  }


type alias Model =
  { user : Maybe User
  , counter : Counter.Model
  , route : Routes.Route
  , loginForm : LoginForm.Model
  , errors : Dict String String
  }


type Request =
  Error String String
  | Success String Msg


type Msg =
  SetPath String
  | PathUpdated String
  | CounterMsg Counter.Msg
  | LoginFormMsg LoginForm.Msg
  | RequestMsg Request
  | LoginSuccess User
  | Logout
