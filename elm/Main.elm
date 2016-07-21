import Html.App exposing (program)
import Model exposing (init)
import Update exposing (update, subscriptions)
import Containers.App exposing (view)
import Types


type alias Updater msg model =
  (msg -> model -> (model, Cmd msg))


type alias UpdateMiddleware msg model =
  (Updater msg model -> Updater msg model)


loggerMiddleware : UpdateMiddleware Types.Msg Types.Model
loggerMiddleware update msg model =
  let
    b = Debug.log "Msg" msg
    (newState, fx) = update msg model
  in
    (Debug.log "Model" newState, fx)


main =
  program { init = init, update = loggerMiddleware update, view = view, subscriptions = subscriptions }
