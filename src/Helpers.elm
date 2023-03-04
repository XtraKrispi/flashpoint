module Helpers exposing (..)

import Types exposing (Side(..))


opposite : Side -> Side
opposite side =
    case side of
        USA ->
            China

        China ->
            USA
