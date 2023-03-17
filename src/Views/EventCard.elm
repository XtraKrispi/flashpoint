module Views.EventCard exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (EventCard)
import Views.Helpers exposing (cardSize)


view : EventCard -> Html msg
view card =
    Html.div
        [ cardSize
        , Attr.class "border-2 rounded-xl flex "
        ]
        []
