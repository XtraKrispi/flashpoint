module Views.TensionTrack exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr
import Types exposing (Tension(..))


view : Tension -> Html msg
view tension =
    let
        vals =
            [ { tension = Low
              , str = "Low"
              , border = "border-blue-200"
              , font = "text-blue-200"
              }
            , { tension = Medium
              , str = "Med"
              , border = "border-green-200"
              , font = "text-green-200"
              }
            , { tension = High
              , str = "High"
              , border = "border-yellow-200"
              , font = "text-yellow-200"
              }
            , { tension = Critical
              , str = "Crit"
              , border = "border-red-200"
              , font = "text-red-200"
              }
            ]
    in
    Html.div [ Attr.class "flex flex-col space-y-2" ]
        [ Html.div [ Attr.class "uppercase" ] [ Html.text "Tension Track" ]
        , Html.div [ Attr.class "flex space-x-2" ]
            (vals
                |> List.map
                    (\v ->
                        Html.div
                            [ Attr.class
                                (v.border ++ " " ++ v.font)
                            , Attr.class "relative border-2 rounded-md p-2 bg-gray-600 uppercase"
                            ]
                            [ if v.tension == tension then
                                Html.div [ Attr.class "absolute rounded-full h-8 w-8 bg-black top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2" ] []

                              else
                                Html.text ""
                            , Html.div [] [ Html.text v.str ]
                            ]
                    )
            )
        ]
