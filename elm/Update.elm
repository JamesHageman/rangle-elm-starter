module Update exposing (..)

import Types exposing (Model, Msg)
import Location
import Routes
import Components.Counter as Counter
import Components.LoginForm as LoginForm


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Types.PathUpdated path ->
      { model | route = Routes.match path } ! []

    Types.SetPath path ->
      model ! [ Location.setPath path ]

    Types.CounterMsg msg ->
      { model | counter = (Counter.update msg model.counter) } ! []

    Types.LoginFormMsg msg ->
      let
        (formModel, submitModel) = LoginForm.update msg model.loginForm
      in
        { model | loginForm = formModel } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ Location.pathUpdates Types.PathUpdated ]
