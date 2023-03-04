module Setup exposing (initGame, initGameCmd)

import Cards.EventCards as EventCards
import Cards.ScoringCards as ScoringCards
import Cards.SoloCards as SoloCards
import Helpers exposing (opposite)
import Random
import Random.List as RL
import Types exposing (Campaign(..), Country(..), Difficulty(..), EventCard, FonopCrName(..), FonopLocation, GameState, Location, PoliticalWarfare(..), ScoringCard, Side(..), SoloCard, Tension(..))


initGameCmd : Difficulty -> Side -> (GameState -> msg) -> Cmd msg
initGameCmd difficulty side msg =
    let
        state =
            initGame difficulty side [] [] []

        eventCardsGen =
            RL.shuffle EventCards.cards

        scoringCardsGen =
            RL.shuffle ScoringCards.cards

        soloCardsGen =
            RL.shuffle SoloCards.cards
    in
    Random.map3 (initGame difficulty side) eventCardsGen scoringCardsGen soloCardsGen
        |> Random.generate msg


initGame : Difficulty -> Side -> List EventCard -> List ScoringCard -> List SoloCard -> GameState
initGame difficulty side eventCards scoringCards soloCards =
    let
        victoryPoints =
            case ( difficulty, side ) of
                ( Easy, USA ) ->
                    3

                ( Normal, USA ) ->
                    0

                ( Hard, USA ) ->
                    -3

                ( Easy, China ) ->
                    4

                ( Normal, China ) ->
                    7

                ( Hard, China ) ->
                    10

        ( usForces, chinaForces ) =
            case side of
                USA ->
                    ( { available = 4
                      , reserve = 2
                      , politicalWarfare = Empty
                      }
                    , { available = 6
                      , reserve = 0
                      , politicalWarfare = Empty
                      }
                    )

                China ->
                    ( { available = 6
                      , reserve = 0
                      , politicalWarfare = Empty
                      }
                    , { available = 4
                      , reserve = 2
                      , politicalWarfare = Empty
                      }
                    )
    in
    { tension = Low
    , campaign = FirstCampaign
    , usForces =
        usForces
    , chinaForces =
        chinaForces
    , victoryPointTrack = victoryPoints
    , eventCardDeck = eventCards
    , scoringCards = scoringCards
    , soloCards = soloCards
    , vietnam = vietnam
    , philippines = philippines
    , malaysia = malaysia
    , brunei = brunei
    , indonesia = indonesia
    , turn = opposite side
    , playerSide = side
    }


vietnam : FonopLocation
vietnam =
    { location =
        { locked = Nothing
        , usEconomicTrack = 2
        , usDiplomaticTrack = 0
        , chinaEconomicTrack = 2
        , chinaDiplomaticTrack = 0
        , maxEconomic = 3
        , maxDiplomatic = 3
        , country = Vietnam
        }
    , fonopCr =
        { fonop = 0
        , cr = 0
        , name = ParacelIslands
        }
    }


philippines : FonopLocation
philippines =
    { location =
        { locked = Nothing
        , usEconomicTrack = 2
        , usDiplomaticTrack = 0
        , chinaEconomicTrack = 2
        , chinaDiplomaticTrack = 0
        , maxEconomic = 3
        , maxDiplomatic = 3
        , country = Philippines
        }
    , fonopCr =
        { fonop = 0
        , cr = 0
        , name = ScarboroughShoal
        }
    }


malaysia : FonopLocation
malaysia =
    { location =
        { locked = Nothing
        , usEconomicTrack = 1
        , usDiplomaticTrack = 0
        , chinaEconomicTrack = 1
        , chinaDiplomaticTrack = 0
        , maxEconomic = 2
        , maxDiplomatic = 2
        , country = Malaysia
        }
    , fonopCr =
        { fonop = 0
        , cr = 0
        , name = SpratlyIslands
        }
    }


brunei : Location
brunei =
    { locked = Nothing
    , usEconomicTrack = 0
    , usDiplomaticTrack = 0
    , chinaEconomicTrack = 0
    , chinaDiplomaticTrack = 0
    , maxEconomic = 1
    , maxDiplomatic = 1
    , country = Brunei
    }


indonesia : Location
indonesia =
    { locked = Nothing
    , usEconomicTrack = 1
    , usDiplomaticTrack = 0
    , chinaEconomicTrack = 1
    , chinaDiplomaticTrack = 0
    , maxEconomic = 2
    , maxDiplomatic = 2
    , country = Indonesia
    }
