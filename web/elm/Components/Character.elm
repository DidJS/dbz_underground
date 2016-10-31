module Character exposing (..)

import Html exposing (Html, div, text)

type alias Model = {
    name: String,
    race: String,
    description: String
}

initialModel: Model
initialModel =
    Model "" "" ""

view: Model -> Html a
view model =
    div[]
    [
        div [][text <| "Name: " ++ model.name]
       ,div [][text <| "Race: " ++ model.race]
       ,div [][text <| "Description: " ++ model.description]
    ]