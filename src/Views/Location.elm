module Views.Location exposing (..)

import Helpers exposing (countryToString, fonopToString)
import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (Country(..), FonopCr, FonopLocation, Location, Side(..))
import Views.Helpers exposing (sideCube, sideSpace)


flag : Country -> Html msg
flag c =
    Html.img
        [ Attr.class "rounded-tl-xl border border-gray-300"
        , Attr.alt (countryToString c)
        , Attr.src ("/" ++ countryToString c ++ ".jpg")
        ]
        []


viewWithFonopCr : FonopLocation -> Html msg
viewWithFonopCr loc =
    Html.div [ Attr.class "flex items-center space-x-10" ]
        [ view loc.location
        , viewFonopCr loc.fonopCr
        ]


view : Location -> Html msg
view location =
    let
        track desc maxNumber currentNumberUSA currentNumberChina =
            Html.div [ Attr.class "mx-2 flex justify-between" ]
                [ List.range 1 maxNumber
                    |> List.map
                        (\idx ->
                            if idx <= currentNumberUSA then
                                sideCube USA

                            else
                                sideSpace USA
                        )
                    |> Html.div [ Attr.class "flex space-x-1" ]
                , Html.div [ Attr.class "uppercase" ] [ Html.text desc ]
                , List.range 1 maxNumber
                    |> List.map
                        (\idx ->
                            if idx <= currentNumberChina then
                                sideCube China

                            else
                                sideSpace China
                        )
                    |> Html.div [ Attr.class "flex space-x-1" ]
                ]
    in
    Html.div [ Attr.class "flex justify-center items-center w-[19rem] h-[8rem] rounded-xl border-solid border-black border-2" ]
        [ Html.div [ Attr.class "flex flex-col justify-between w-[18.6rem] h-[7.6rem] rounded-xl border-solid border-black border-2 pb-2" ]
            [ Html.div [ Attr.class "flex justify-between items-center border-b-2" ]
                [ Html.div [ Attr.class "w-12" ] [ flag location.country ]
                , Html.div [ Attr.class "uppercase" ] [ Html.text (countryToString location.country) ]
                , Html.div [ Attr.class "mr-2" ]
                    [ location.locked
                        |> Maybe.map sideCube
                        |> Maybe.withDefault
                            (Html.img [ Attr.class "w-6", Attr.src "/lock.svg" ] [])
                    ]
                ]
            , track "Economic" location.maxEconomic location.usEconomicTrack location.chinaEconomicTrack
            , track "Diplomatic" location.maxDiplomatic location.usDiplomaticTrack location.chinaDiplomaticTrack
            ]
        ]


viewFonopCr : FonopCr -> Html msg
viewFonopCr f =
    Html.div [ Attr.class "flex items-center justify-center rounded-full h-[8rem] w-[14rem] border border-black" ]
        [ Html.div [ Attr.class "rounded-full h-[7.5rem] w-[13.5rem] border border-black p-4" ]
            [ Html.div [ Attr.class "flex justify-center uppercase" ]
                [ Html.text (fonopToString f.name) ]
            , Html.div [ Attr.class "flex justify-between" ]
                [ Html.div [ Attr.class "flex flex-col items-center" ]
                    [ Html.div [ Attr.class "uppercase" ]
                        [ Html.text "Fonop" ]
                    , List.range 1 2
                        |> List.map
                            (\idx ->
                                if idx <= f.fonop then
                                    sideCube USA

                                else
                                    sideSpace USA
                            )
                        |> Html.div [ Attr.class "flex space-x-1" ]
                    ]
                , Html.div [ Attr.class "flex flex-col items-center" ]
                    [ Html.div [ Attr.class "uppercase" ]
                        [ Html.text "CR" ]
                    , List.range 1 2
                        |> List.map
                            (\idx ->
                                if idx <= f.cr then
                                    sideCube China

                                else
                                    sideSpace China
                            )
                        |> Html.div [ Attr.class "flex space-x-1" ]
                    ]
                ]
            ]
        ]
