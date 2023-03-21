module Views.EventCard exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (EventCard, Mode(..), Side(..))
import Views.Helpers exposing (cardSize)


view : EventCard -> Html msg
view card =
    Html.div
        [ cardSize
        , Attr.class "border-2 rounded-xl flex "
        ]
        [ Html.div
            [ Attr.class "w-[30%] rounded-tl-xl rounded-bl-xl"
            , Attr.classList
                [ ( "bg-red-500", card.side == Just China )
                , ( "bg-blue-500", card.side == Just USA )
                , ( "bg-gray-500", card.side == Nothing )
                ]
            ]
            [ Html.div [ Attr.class "flex flex-col items-center" ]
                [ Html.div [ Attr.class "text-white text-[2.5rem]" ] [ Html.text (String.fromInt card.operationValue) ]
                , Html.div [ Attr.class "p-1" ]
                    [ Html.img
                        [ case card.mode of
                            Trade ->
                                Attr.src "/economics.svg"

                            Territorial ->
                                Attr.src "/territorial.svg"

                            Military ->
                                Attr.src "/military.svg"
                        ]
                        []
                    ]
                ]
            , Html.div [] []
            ]
        , Html.div [ Attr.class "w-full flex flex-col justify-between items-center space-y-1" ]
            [ Html.p [ Attr.class "text-xs p-2 text-center" ] [ Html.strong [] [ Html.text card.title ] ]
            , Html.div [] []
            , Html.div [ Attr.class "text-[0.5rem]" ]
                [ Html.text (String.fromInt card.cardNumber)
                ]
            ]
        ]
