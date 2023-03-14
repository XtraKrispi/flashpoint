module Views.Forces exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (Forces(..), Side(..))


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
    Html.div [ Attr.class "flex justify-center items-center w-[30rem] py-1 border rounded-xl" ]
        [ Html.div [ Attr.class "w-[29.5rem] rounded-xl", Attr.classList [ ( "bg-blue-500", side == USA ), ( "bg-red-500", side == China ) ] ]
            [ Html.div [ Attr.class "uppercase border-b-2 box-border" ]
                [ case side of
                    USA ->
                        Html.div [ Attr.class "flex items-center justify-between" ]
                            [ Html.div [ Attr.class "w-12" ]
                                [ flag USA
                                ]
                            , Html.div []
                                [ Html.text "United States of America"
                                ]
                            , Html.div [ Attr.class "w-12" ] []
                            ]

                    China ->
                        Html.div [ Attr.class "flex items-center justify-between" ]
                            [ Html.div [ Attr.class "w-12" ]
                                [ flag China
                                ]
                            , Html.div []
                                [ Html.text "People's Republic of China"
                                ]
                            , Html.div [ Attr.class "w-12" ] []
                            ]
                ]
            , Html.div [ Attr.class "flex space-x-2" ]
                [ Html.div [ Attr.class "grow bg-white text-center" ]
                    [ Html.text "Available" ]
                , Html.div [ Attr.class "grow bg-white text-center" ]
                    [ Html.text "Reserve" ]
                ]
            , Html.div []
                [ Html.div [] [ Html.text "Political Warfare" ]
                ]
            ]
        ]
