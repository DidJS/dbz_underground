module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Components.CharacterList as CharacterList

type alias Model =
    {
        characterListModel: CharacterList.Model
    }

initialModel: Model
initialModel =
    {
        characterListModel = CharacterList.initialModel
    }

init: (Model, Cmd Msg)
init =
    (initialModel, Cmd.none)

type Msg =
    CharacterListMsg CharacterList.Msg

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        CharacterListMsg characterMsg ->
            let
                (updateModel, cmd) = CharacterList.update characterMsg model.characterListModel
            in
                ({model | characterListModel = updateModel}, Cmd.map CharacterListMsg cmd)

subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.none

view: Model -> Html Msg
view model =
    div []
    [
        App.map CharacterListMsg (CharacterList.view model.characterListModel)
    ]

main: Program Never
main =
    App.program {init = init, update = update, view = view, subscriptions = subscriptions}