module Views.ScoringCard exposing (view)

import Helpers exposing (countryToString)
import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (Facing, ScoringCard, ScoringImpact(..))
import Views.Helpers exposing (cardSize)
import Views.Icon


view : ( Facing, ScoringCard ) -> Html msg
view ( facing, card ) =
    let
        ( cardTitle, icon ) =
            case card.scoringImpact of
                ScoreEconomics ->
                    ( "Economics", Views.Icon.economics )

                ScoreCountry country ->
                    ( countryToString country, Views.Icon.country country )

                ScoreCrFonop ->
                    ( "Fonop/CR", Views.Icon.fonopCr )
    in
    Html.div
        [ cardSize
        , Attr.class "border-2 rounded-xl flex "
        ]
        [ Html.div [ Attr.class "bg-green-600 flex-grow-0 flex-shrink-0 basis-16 uppercase relative rounded-l-xl" ]
            [ Html.div [ Attr.class "rotate-[270deg] bottom-0 left-0 absolute ml-[0.25rem]", Attr.style "transform-origin" "0 0" ]
                [ Html.span [ Attr.class "mr-1 text-white" ] [ Html.text "Score" ]
                , Html.span [ Attr.class "text-gray-300" ]
                    [ Html.text cardTitle
                    ]
                ]
            ]
        , Html.div [ Attr.class "w-full flex flex-col justify-between items-center space-y-1" ]
            [ Html.div [ Attr.class "mt-2" ]
                [ Html.div
                    [ Attr.class "h-10 w-14"
                    ]
                    [ icon ]
                ]
            , Html.div [ Attr.class "text-xs px-2 text-center" ] [ Html.text card.description ]
            , Html.div [ Attr.class "text-[0.5rem]" ]
                [ Html.text (String.fromInt card.cardNumber)
                ]
            ]
        ]
