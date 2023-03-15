module Views.VictoryPointTrack exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr


view : Int -> Html msg
view vps =
    Html.div []
        [ Html.div [ Attr.class "uppercase" ]
            [ Html.text "Victory Point Track" ]
        , Html.div [ Attr.class "flex space-x-2" ]
            (List.range -15 15
                |> List.map
                    (\i ->
                        Html.div
                            [ Attr.class "relative w-12 h-12 rounded-xl border flex items-center justify-center"
                            , Attr.classList
                                [ ( "bg-blue-500", i > 0 )
                                , ( "bg-red-500", i < 0 )
                                ]
                            ]
                            [ if vps == i then
                                Html.div [ Attr.class "absolute rounded-full h-8 w-8 bg-black top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2" ] []

                              else
                                Html.text ""
                            , Html.div [] [ Html.text (String.fromInt (abs i)) ]
                            ]
                    )
            )
        ]
