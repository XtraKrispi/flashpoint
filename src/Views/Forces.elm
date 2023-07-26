module Views.Forces exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (Forces(..), PoliticalWarfare(..), Side(..))
import Views.Helpers exposing (sideCube, sideSpace)


flag : Side -> Html msg
flag s =
    let
        ( sideDesc, flagUrl ) =
            case s of
                USA ->
                    ( "United States of America", "United_States" )

                China ->
                    ( "People's Republic of China", "China" )
    in
    Html.img
        [ Attr.class "rounded-tl-xl border border-gray-300"
        , Attr.alt sideDesc
        , Attr.src ("/" ++ flagUrl ++ ".jpg")
        ]
        []


view : Forces -> Html msg
view f =
    let
        ( side, forces ) =
            case f of
                USAForces fs ->
                    ( USA, fs )

                ChinaForces fs ->
                    ( China, fs )
    in
    Html.div []
        [ Html.div [ Attr.class "flex justify-center items-center w-[35rem] py-1 border-2 border-black rounded-xl" ]
            [ Html.div
                [ Attr.class "w-[34.5rem] rounded-xl flex flex-col space-y-2 border-2 border-black"
                , Attr.classList
                    [ ( "bg-blue-500", side == USA )
                    , ( "bg-red-500", side == China )
                    ]
                ]
                [ Html.div [ Attr.class "uppercase border-b-2 box-border" ]
                    [ case side of
                        USA ->
                            Html.div [ Attr.class "flex items-center justify-between" ]
                                [ Html.div [ Attr.class "w-12" ]
                                    [ flag USA
                                    ]
                                , Html.div [ Attr.class "text-white" ]
                                    [ Html.text "United States of America"
                                    ]
                                , Html.div [ Attr.class "w-12" ] []
                                ]

                        China ->
                            Html.div [ Attr.class "flex items-center justify-between" ]
                                [ Html.div [ Attr.class "w-12" ]
                                    [ flag China
                                    ]
                                , Html.div [ Attr.class "text-white" ]
                                    [ Html.text "People's Republic of China"
                                    ]
                                , Html.div [ Attr.class "w-12" ] []
                                ]
                    ]
                , Html.div [ Attr.class "flex space-x-2 uppercase" ]
                    [ Html.div [ Attr.class "w-1/2 bg-white/50 text-center pb-2" ]
                        [ Html.div [] [ Html.text "Available" ]
                        , Html.div [ Attr.class "flex flex-wrap gap-1 justify-center" ]
                            (List.range 1 forces.available
                                |> List.map (always (sideCube side))
                            )
                        ]
                    , Html.div [ Attr.class "w-1/2 bg-white/50 text-center pb-2" ]
                        [ Html.div [] [ Html.text "Reserve" ]
                        , Html.div [ Attr.class "flex flex-wrap gap-1 justify-center" ]
                            (List.range 1 forces.reserve
                                |> List.map (always (sideCube side))
                            )
                        ]
                    ]
                , Html.div [ Attr.class "flex justify-center bg-white/50 p-2 flex-col items-center" ]
                    [ Html.div [ Attr.class "uppercase" ]
                        [ Html.text "Political Warfare" ]
                    , Html.div [ Attr.class "flex space-x-2" ]
                        (List.range 1 3
                            |> List.map
                                (\i ->
                                    Html.div []
                                        [ case ( forces.politicalWarfare, i ) of
                                            ( FirstSlot, 1 ) ->
                                                sideCube side

                                            ( SecondSlot, 1 ) ->
                                                sideCube side

                                            ( SecondSlot, 2 ) ->
                                                sideCube side

                                            ( ThirdSlot, 1 ) ->
                                                sideCube side

                                            ( ThirdSlot, 2 ) ->
                                                sideCube side

                                            ( ThirdSlot, 3 ) ->
                                                sideCube side

                                            _ ->
                                                sideSpace side
                                        ]
                                )
                        )
                    ]
                ]
            ]
        ]
