module Types exposing (..)

import Routes
import Components.Counter as Counter


type alias User =
  { firstName : String
  , lastName : String
  }


type alias Model =
  { user : Maybe User
  , counter : Counter.Model
  , route : Routes.Route
  }

type Msg =
  SetPath String
  | PathUpdated String
  | CounterMsg Counter.Msg
