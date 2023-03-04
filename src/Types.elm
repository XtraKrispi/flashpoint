module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , appModel : AppModel
    }


type AppModel
    = Setup Difficulty
    | Playing GameState
    | GameOver


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | ChooseSide Difficulty Side
    | ChangeDifficulty Difficulty
    | GameSetup GameState


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend


type Difficulty
    = Easy
    | Normal
    | Hard


type Tension
    = Low
    | Medium
    | High
    | Critical


type Campaign
    = FirstCampaign
    | SecondCampaign
    | ThirdCampaign


type PoliticalWarfare
    = Empty
    | FirstSlot
    | SecondSlot
    | ThirdSlot


type Side
    = China
    | USA


type alias SideForces =
    { available : Int
    , reserve : Int
    , politicalWarfare : PoliticalWarfare
    }


type FonopCrName
    = ScarboroughShoal
    | ParacelIslands
    | SpratlyIslands


type alias FonopCr =
    { fonop : Int
    , cr : Int
    , name : FonopCrName
    }


type alias Location =
    { locked : Maybe Side
    , usEconomicTrack : Int
    , usDiplomaticTrack : Int
    , chinaEconomicTrack : Int
    , chinaDiplomaticTrack : Int
    , maxEconomic : Int
    , maxDiplomatic : Int
    , country : Country
    }


type alias FonopLocation =
    { location : Location
    , fonopCr : FonopCr
    }


type EventCardAction
    = PlayForEvent
    | PlayForOperationValue
    | PlayForScoringImpact
    | PlayForMode


type Country
    = Vietnam
    | Philippines
    | Malaysia
    | Brunei
    | Indonesia


type alias GameState =
    { tension : Tension
    , campaign : Campaign
    , usForces : SideForces
    , chinaForces : SideForces
    , victoryPointTrack : Int
    , eventCardDeck : List EventCard
    , scoringCards : List ScoringCard
    , soloCards : List SoloCard
    , vietnam : FonopLocation
    , philippines : FonopLocation
    , malaysia : FonopLocation
    , brunei : Location
    , indonesia : Location
    , turn : Side
    , playerSide : Side
    }


type Mode
    = Military
    | Territorial
    | Trade


type TensionImpact
    = IncreaseTension
    | DecreaseTension
    | SpecificTension Tension


type ScoringImpact
    = ScoreEconomics
    | ScoreCountry Country
    | ScoreCrFonop


type alias EventCard =
    { operationValue : Int
    , mode : Mode
    , title : String
    , side : Maybe Side
    , tensionImpact : Maybe TensionImpact
    , scoringImpact : ScoringImpact
    , eventDirections : List EventDirection
    , cardNumber : Int
    }


type Amount
    = All
    | Specific Int


type EventCountry
    = SpecificCountry Country
    | OtherCountries Int


type Condition
    = MostDiplomaticInfluence { country : Country }
    | MoreFonopCr
    | MoreFonopCrInLocation { location : FonopCrName }
    | MoreEconomicInfluence
    | MoreDiplomaticInfluence
    | MoreThanDiplomaticInfluenceInTotal { amount : Int }
    | NumberOfFonopCrOrGreater { number : Int }
    | BehindInVps
    | MoreInfluenceInCountry { country : Country }
    | TensionIsAtLevels { tension : List Tension }
    | ExactNumberOfFonopCr { number : Int }


type PlacementType
    = Each
    | Total


type EventDirection
    = MoveTensionToAnyLevel
    | ExecuteAsOpCard { operationsValue : Int, description : String }
    | MovePoliticalWarfareToAvailable { amount : Amount, side : Side }
    | MoveDiplomaticInfluenceToAvailable { amount : Amount, side : Side }
    | MoveEconomicInfluenceToAvailable { amount : Amount, side : Side }
    | MoveDiplomaticInfluenceFromCountryToAvailable { amount : Amount, side : Side, country : Country }
    | MoveDiplomaticInfluenceFromCountriesToAvailable { side : Side, amount : Amount, numberOfCountries : Int }
    | MoveEconomicInfluenceFromCountryToAvailable { amount : Amount, side : Side, country : Country }
    | PlacePoliticalWarfare { number : Int, side : Side }
    | PlaceDiplomaticInfluence { side : Side, amount : Int, countries : List EventCountry, type_ : PlacementType }
    | PlaceEconomicInfluence { side : Side, amount : Int, countries : List EventCountry, type_ : PlacementType }
    | PlaceAndMoveCrFonop
        { side : Side
        , amount : Int
        , place : FonopCrName
        , moveToAvailable : FonopCrName
        }
    | MoveFonopCrToAvailable { side : Side, amount : Int, locations : List FonopCrName }
    | PlaceFonopCrAtLocation { side : Side, amount : Int, location : FonopCrName }
    | Conditional { side : Side, condition : Condition, ifTrue : List EventDirection }
    | ConditionalActiveSide { condition : Condition, ifTrue : List EventDirection }
    | GetVictoryPoints { side : Side, amount : Int }
    | PlaceInfluence { side : Side, amount : Int, countries : List EventCountry, type_ : PlacementType }
    | PlaceFonopCr { side : Side, amount : Int }
    | MoveInfluenceToAvailable { side : Side, country : Country, amount : Amount }
    | MoveAllFonopCrToAvailable { availableLocations : List FonopCrName }
    | MoveOneTypeOfInfluenceToReserve { side : Side, amount : Int }
    | PlaceDiplomaticInfluenceFromReserveOrAvailable { side : Side, amount : Int }


type alias ScoringCard =
    { scoringImpact : ScoringImpact
    , title : String
    , description : String
    , vpValue : Int
    , cardNumber : Int
    }


type alias SoloCard =
    { politicalWarfare : List Side
    , crFonop : List FonopCrName
    , influence : List Country
    , cardNumber : Int
    }
