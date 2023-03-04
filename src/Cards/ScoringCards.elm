module Cards.ScoringCards exposing (cards)

import Types exposing (Country(..), FonopCrName(..), ScoringCard, ScoringImpact(..))


countryCard : Country -> ScoringCard
countryCard country =
    let
        { name, vp, fonop, cardNum } =
            case country of
                Indonesia ->
                    { name = "Indonesia", vp = 2, fonop = Nothing, cardNum = 50 }

                Brunei ->
                    { name = "Brunei", vp = 1, fonop = Nothing, cardNum = 49 }

                Vietnam ->
                    { name = "Vietnam", vp = 3, fonop = Just "Paracel Islands", cardNum = 52 }

                Philippines ->
                    { name = "Philippines", vp = 3, fonop = Just "Scarborough Shoal", cardNum = 53 }

                Malaysia ->
                    { name = "Malaysia", vp = 2, fonop = Just "Spratly Islands", cardNum = 51 }
    in
    { scoringImpact = ScoreCountry country
    , title = "Score " ++ name
    , description =
        "Compare all cubes in "
            ++ name
            ++ Maybe.withDefault "" (Maybe.map (\s -> "and " ++ s) fonop)
            ++ ". The side with a positive differential scores it as VPs, not exceeding "
            ++ String.fromInt vp
            ++ Maybe.withDefault ". The scoring side moves 1 cube from Reserve to Available." (Maybe.map (always "") fonop)
    , vpValue = vp
    , cardNumber = cardNum
    }


cards : List ScoringCard
cards =
    [ { scoringImpact = ScoreCrFonop
      , title = "Score CR-FONOP"
      , description = "Compare CRs and FONOPs. The side with a positive differential scores it as VPs, not exceeding 4."
      , vpValue = 4
      , cardNumber = 55
      }
    , { scoringImpact = ScoreEconomics
      , title = "Score Economics"
      , description = "For each Country in which a side has the most Economic Influence, that side scores 1 VP."
      , vpValue = 1
      , cardNumber = 54
      }
    ]
        ++ List.map countryCard [ Vietnam, Indonesia, Malaysia, Philippines, Brunei ]
