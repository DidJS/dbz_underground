module Components.CharacterList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick, on)
import Html.Attributes exposing (attribute)
import Json.Decode exposing (string, at)
import Json.Decode as Json
import List
import Character

type alias Model =
    {
        characters: List Character.Model
       ,character: Maybe Character.Model
    }

characters: Model
characters =
    {
        characters =
        [
            {name = "Vegeta", race = "Sayan", description = "Prince de la planète Vegeta"}
           ,{name = "Bulma", race = "Human", description = "Fille du propriétaire de Capsule Corp."}
        ]
       ,character = Nothing
    }

type Msg = None | Fetch | FetchDetail String

filterCharacterByName: String -> Model -> Character.Model
filterCharacterByName name model =
    model.characters
        |> List.filter (\c -> c.name == name)
        |> List.head
        |> Maybe.withDefault(Character.initialModel)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        None ->
            (model, Cmd.none)
        Fetch ->
            (characters, Cmd.none)
        FetchDetail name ->
            (Model model.characters (Just (filterCharacterByName name model)), Cmd.none)

initialModel: Model
initialModel =
    {
        characters = []
       ,character = Nothing
    }

decodeName: Json.Decoder String
decodeName =
    at ["target", "dataset", "value"] string

renderCharacterForList: Character.Model -> Html Msg
renderCharacterForList model =
    li []
    [
        a [style liStyle, on "click" (Json.map FetchDetail decodeName), attribute "data-value" model.name][text model.name]
    ]

renderCharacters: Model -> List (Html Msg)
renderCharacters model =
    List.map renderCharacterForList model.characters

view: Model -> Html Msg
view model =
    let
        character =
            case model.character of
                Nothing ->
                    Character.initialModel
                Just c ->
                    c
    in
        div []
        [
            div [style [("background", "yellow"), ("width", "200px"), ("float", "left")]]
            [
                h2 [][text "Character List"]
               ,button [onClick Fetch][text "Fetch characters"]
               ,ul [] <| renderCharacters model
            ]
           ,div [style <| characterBlockStyle model.character]
           [
                Character.view <| character
           ]
        ]

liStyle: List (String, String)
liStyle =
    [("cursor", "pointer")]

characterBlockStyle: Maybe Character.Model -> List (String, String)
characterBlockStyle model =
    let
        style = [("background", "grey"), ("width", "600px")]
    in
        case model of
            Nothing ->
                ("display", "none") :: style
            Just _ ->
                ("display", "block") :: style