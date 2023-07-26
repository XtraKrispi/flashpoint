module Views.EventCard exposing (..)

import Helpers exposing (countryToString)
import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (EventCard, EventCardDescriptionLine(..), Mode(..), ScoringImpact(..), Side(..))
import Views.Helpers exposing (cardSize)
import Views.Icon


view : EventCard -> Html msg
view card =
    Html.div
        [ cardSize
        , Attr.class "border-2 rounded-xl flex bg-white"
        ]
        [ Html.div
            [ Attr.class "flex-grow-0 flex-shrink-0 basis-16 rounded-tl-xl rounded-bl-xl flex flex-col justify-between"
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
            , Html.div [ Attr.class "mb-2 mx-1 flex flex-col space-y-1 justify-center items-center" ]
                [ Html.div [ Attr.class "text-[0.5rem] text-white uppercase" ]
                    [ Html.text
                        (case card.scoringImpact of
                            ScoreEconomics ->
                                "Economics"

                            ScoreCountry c ->
                                countryToString c

                            ScoreCrFonop ->
                                "Cr/Fonop"
                        )
                    ]
                , Html.div [ Attr.class "h-6 w-full" ]
                    [ case card.scoringImpact of
                        ScoreEconomics ->
                            Views.Icon.economics

                        ScoreCountry c ->
                            Views.Icon.country c

                        ScoreCrFonop ->
                            Views.Icon.fonopCr
                    ]
                ]
            ]
        , Html.div [ Attr.class "flex flex-col justify-between items-center space-y-1" ]
            [ Html.p [ Attr.class "text-xs p-1 text-center" ] [ Html.strong [ Attr.class "break-words" ] [ Html.text card.title ] ]
            , Html.div [] [ cardText card.side card.descriptionLines ]
            , Html.div [ Attr.class "text-[0.5rem]" ]
                [ Html.text (String.fromInt card.cardNumber)
                ]
            ]
        ]


cardText : Maybe Side -> List EventCardDescriptionLine -> Html msg
cardText side descs =
    let
        processDescription desc =
            case desc of
                NormalDescription txt ->
                    Html.div [] [ Html.text txt ]

                TensionChanges txt ->
                    Html.div
                        [ Attr.class "p-2 inline-block rounded-lg text-white"
                        , Attr.classList
                            [ ( "bg-red-500", side == Just China )
                            , ( "bg-blue-500", side == Just USA )
                            , ( "bg-black", side == Nothing )
                            ]
                        ]
                        [ Html.text txt ]
    in
    descs
        |> List.map processDescription
        |> Html.div [ Attr.class "text-xs text-center gap-2" ]
