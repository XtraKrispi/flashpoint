module Helpers exposing (..)

import Types exposing (Country(..), FonopCrName(..), Side(..))


opposite : Side -> Side
opposite side =
    case side of
        USA ->
            China

        China ->
            USA


countryToString : Country -> String
countryToString c =
    case c of
        Vietnam ->
            "Vietnam"

        Brunei ->
            "Brunei"

        Indonesia ->
            "Indonesia"

        Philippines ->
            "Philippines"

        Malaysia ->
            "Malaysia"


fonopToString : FonopCrName -> String
fonopToString f =
    case f of
        SpratlyIslands ->
            "Spratly Islands"

        ScarboroughShoal ->
            "Scarborough Shoal"

        ParacelIslands ->
            "Paracel Islands"
