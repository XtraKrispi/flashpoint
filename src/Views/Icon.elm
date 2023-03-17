module Views.Icon exposing (..)

import Helpers exposing (countryToString)
import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (Country)


usa : Html msg
usa =
    Html.div [ Attr.class "flex flex-col items-center justify-center bg-gray-600 h-full w-full rounded-lg overflow-hidden space-y-1 p-1" ]
        [ Html.div [ Attr.class "rounded-lg bg-white w-full h-full overflow-hidden" ]
            [ Html.img [ Attr.class "h-full w-full", Attr.src "/United_States.jpg" ] []
            ]
        ]


china : Html msg
china =
    Html.div [ Attr.class "flex flex-col items-center justify-center bg-gray-600 h-full w-full rounded-lg overflow-hidden space-y-1 p-1" ]
        [ Html.div [ Attr.class "rounded-lg bg-white w-full h-full overflow-hidden" ]
            [ Html.img [ Attr.class "h-full w-full", Attr.src "/China.jpg" ] []
            ]
        ]


fonopCr : Html msg
fonopCr =
    Html.div [ Attr.class "flex flex-col items-center justify-center bg-gray-600 h-full w-full rounded-lg overflow-hidden space-y-1 p-1" ]
        [ Html.div [ Attr.class "rounded-t-lg bg-white w-full h-full overflow-hidden" ] [ Html.img [ Attr.class "h-[200%] w-full", Attr.src "/China.jpg" ] [] ]
        , Html.div [ Attr.class "rounded-b-lg bg-white w-full h-full overflow-hidden" ] [ Html.img [ Attr.class "h-[200%] w-full", Attr.src "/United_States.jpg" ] [] ]
        ]


country : Country -> Html msg
country c =
    Html.div [ Attr.class "flex flex-col items-center justify-center bg-gray-600 h-full w-full rounded-lg overflow-hidden space-y-1 p-1" ]
        [ Html.div [ Attr.class "rounded-lg bg-white w-full h-full overflow-hidden" ]
            [ Html.img [ Attr.class "h-full w-full", Attr.src ("/" ++ countryToString c ++ ".jpg") ] []
            ]
        ]


economics : Html msg
economics =
    Html.div [ Attr.class "flex flex-col items-center justify-center bg-gray-600 h-full w-full rounded-lg overflow-hidden space-y-1 p-1" ]
        [ Html.div [ Attr.class "flex items-center justify-center rounded-t-lg bg-red-500 text-white w-full h-full overflow-hidden" ]
            [ Html.div []
                [ Html.text "¥"
                ]
            ]
        , Html.div [ Attr.class "flex items-center justify-center rounded-b-lg bg-blue-500 text-white w-full h-full overflow-hidden" ]
            [ Html.div []
                [ Html.text "$"
                ]
            ]
        ]
