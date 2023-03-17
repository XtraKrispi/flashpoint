module Views.Helpers exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (Side(..))


sideCube : Side -> Html msg
sideCube s =
    Html.div
        [ Attr.classList
            [ ( "bg-blue-500", s == USA )
            , ( "bg-red-500", s == China )
            ]
        , Attr.class "w-6 h-6 rounded-sm drop-shadow-sm"
        ]
        []


sideSpace : Side -> Html msg
sideSpace s =
    Html.div
        [ Attr.classList
            [ ( "bg-blue-200", s == USA )
            , ( "bg-red-200", s == China )
            ]
        , Attr.class "w-6 h-6 rounded-sm drop-shadow-sm"
        ]
        []


cardSize : Html.Attribute msg
cardSize =
    Attr.class "h-[12rem] w-[10rem]"
