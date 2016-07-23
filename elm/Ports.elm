port module Ports exposing (..)

import Types exposing (User)

port setPath : String -> Cmd msg

port pathUpdates : (String -> msg) -> Sub msg

port setSession : Maybe User -> Cmd msg

port sessionInit : (User -> msg) -> Sub msg

