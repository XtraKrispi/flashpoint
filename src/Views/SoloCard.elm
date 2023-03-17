module Views.SoloCard exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (SoloCard)
import Views.Helpers exposing (cardSize)


view : SoloCard -> Html msg
view card =
    Html.div
        [ cardSize
        , Attr.class "border-2 rounded-xl flex "
        ]
        []
