import Html.App exposing (program)
import Model exposing (init)
import Update exposing (update, subscriptions)
import Containers.App exposing (view)

main =
  program { init = init, update = update, view = view, subscriptions = subscriptions }
