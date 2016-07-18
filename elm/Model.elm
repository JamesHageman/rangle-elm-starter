module Model exposing (..)

import Routes
import Types exposing (Model, Msg)
import Components.Counter as Counter


init : (Model, Cmd Msg)
init = (Model Nothing Counter.init Routes.Home, Cmd.none)
