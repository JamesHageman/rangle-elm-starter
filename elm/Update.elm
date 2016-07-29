module Update exposing (update, subscriptions)

import Types exposing (Model, Msg(..))
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
        PathUpdated path ->
            { model | route = Routes.match path } ! []

        SetPath path ->
            model ! [ Ports.setPath path ]

        CounterMsg msg ->
            { model | counter = (Counter.update msg model.counter) } ! []

        LoginFormMsg msg ->
            let
                ( formModel, submitModel ) =
                    LoginForm.update msg model.loginForm

                effect =
                    case submitModel of
                        Just { username, password } ->
                            requestSequence
                                "login"
                                LoginSuccess
                                (login ( username, password ))

                        Nothing ->
                            Cmd.none
            in
                { model | loginForm = formModel } ! [ effect ]

        LoginSuccess user ->
            { model | user = Just user } ! [ Ports.setSession (Just user) ]

        RequestMsg msg ->
            let
                ( errors, effects ) =
                    updateErrors msg model.errors
            in
                { model | errors = errors } ! [ effects ]

        Logout ->
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


dispatch : msg -> Cmd msg
dispatch msg =
    Task.perform identity identity (Task.succeed msg)


requestSequence : String -> (a -> Msg) -> Task String a -> Cmd Msg
requestSequence key successActionCreator task =
    Task.perform
        (RequestMsg << Types.Error key)
        (RequestMsg << Types.Success key << successActionCreator)
        task


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ports.pathUpdates Types.PathUpdated
        , Ports.sessionInit Types.LoginSuccess
        ]
