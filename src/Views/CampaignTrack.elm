module Views.CampaignTrack exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (Campaign(..), Tension(..))


view : Campaign -> Html msg
view c =
    let
        mappings =
            [ ( 1, FirstCampaign ), ( 2, SecondCampaign ), ( 3, ThirdCampaign ) ]
    in
    Html.div [ Attr.class "flex flex-col space-y-2" ]
        [ Html.div [ Attr.class "uppercase" ] [ Html.text "Campaign" ]
        , Html.div [ Attr.class "flex space-x-2" ]
            (List.range 1 3
                |> List.map
                    (\v ->
                        Html.div [ Attr.class "relative border-2 border-white rounded-md p-4 text-white bg-gray-600 uppercase" ]
                            [ if List.any (\( i, c_ ) -> i == v && c == c_) mappings then
                                Html.div [ Attr.class "absolute rounded-full h-8 w-8 bg-black top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2" ] []

                              else
                                Html.text ""
                            , Html.div [] [ Html.text (String.fromInt v) ]
                            ]
                    )
            )
        ]
