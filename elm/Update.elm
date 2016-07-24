module Update exposing (..)

import Types exposing (Model, Msg)
import Ports
import Routes
import Components.Counter as Counter
import Components.LoginForm as LoginForm
import Api.Session exposing (login)
import Task exposing (..)
import Dict exposing (Dict)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Types.PathUpdated path ->
            { model | route = Routes.match path } ! []

        Types.SetPath path ->
            model ! [ Ports.setPath path ]

        Types.CounterMsg msg ->
            { model | counter = (Counter.update msg model.counter) } ! []

        Types.LoginFormMsg msg ->
            let
                ( formModel, submitModel ) =
                    LoginForm.update msg model.loginForm

                effects =
                    case submitModel of
                        Just { username, password } ->
                            [ requestSequence
                                "login"
                                Types.LoginSuccess
                                (login ( username, password ))
                            ]

                        Nothing ->
                            []
            in
                { model | loginForm = formModel } ! effects

        Types.LoginSuccess user ->
            { model | user = Just user } ! [ Ports.setSession (Just user) ]

        Types.RequestMsg msg ->
            let
                ( errors, effects ) =
                    updateErrors msg model.errors
            in
                { model | errors = errors } ! [ effects ]

        Types.Logout ->
            { model | user = Nothing } ! [ Ports.setSession Nothing ]


updateErrors :
    Types.Request
    -> Dict String String
    -> ( Dict String String, Cmd Msg )
updateErrors msg errors =
    case msg of
        Types.Error key errorMsg ->
            Dict.insert key errorMsg errors ! []

        Types.Success key appMsg ->
            Dict.remove key errors ! [ dispatch appMsg ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ports.pathUpdates Types.PathUpdated
        , Ports.sessionInit Types.LoginSuccess
        ]


dispatch : msg -> Cmd msg
dispatch msg =
    Task.perform identity identity (Task.succeed msg)


requestSequence : String -> (a -> Msg) -> Task String a -> Cmd Msg
requestSequence key successActionCreator task =
    Task.perform
        (Types.RequestMsg << Types.Error key)
        (Types.RequestMsg << Types.Success key << successActionCreator)
        task
