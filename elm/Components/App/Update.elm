module Components.App.Update exposing (..)

import Location
import Routes

type alias User =
  { firstName : String
  , lastName : String
  }

type alias Model =
  { user : Maybe User
  , count : Int
  , route : Routes.Route
  }


init : (Model, Cmd Msg)
init = (Model Nothing 0 Routes.Home, Cmd.none)


type Msg =
  SetPath String
  | PathUpdated String
  | SetRoute Routes.Route


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    PathUpdated path ->
      { model | route = Routes.decode path } ! []

    SetRoute route ->
      { model | route = route } ! []

    SetPath path ->
      model ! [ Location.setPath path ]
