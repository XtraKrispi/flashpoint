module Cards.EventCards exposing (..)

import Types
    exposing
        ( Amount(..)
        , Condition(..)
        , Country(..)
        , Difficulty(..)
        , EventCard
        , EventCardDescriptionLine(..)
        , EventCountry(..)
        , EventDirection(..)
        , FonopCrName(..)
        , Mode(..)
        , PlacementType(..)
        , ScoringImpact(..)
        , Side(..)
        , Tension(..)
        , TensionImpact(..)
        )


oneOpCard : Mode -> String -> ScoringImpact -> Int -> EventCard
oneOpCard mode title scoring cardNumber =
    { operationValue = 1
    , mode = mode
    , title = title
    , descriptionLines =
        [ TensionChanges "Tension to Any Level"
        , NormalDescription "Then execute as a 1 Operation Value card."
        ]
    , side = Nothing
    , tensionImpact = Nothing
    , scoringImpact = scoring
    , eventDirections =
        [ MoveTensionToAnyLevel
        , ExecuteAsOpCard { operationsValue = 1 }
        ]
    , cardNumber = cardNumber
    }


cards : List EventCard
cards =
    [ oneOpCard Trade
        "Chairman of Industrial / Commercial Bank of China (Jiang Jianqing)"
        ScoreEconomics
        39
    , oneOpCard Trade
        "Chairman of CK Hutchison Holdings (Li Ka-shing)"
        ScoreEconomics
        38
    , oneOpCard Military
        "Secretary-General of the United Nations (António Guterres)"
        (ScoreCountry Malaysia)
        37
    , oneOpCard Territorial
        "General Secretary of the Communist Party of Vietnam (Nguyễn Phú Trọng)"
        (ScoreCountry Vietnam)
        1
    , oneOpCard Territorial
        "President of the Philippines (Rodrigo Duterte)"
        ScoreCrFonop
        2
    , oneOpCard Trade
        "President of the Republic of Indonesia (Joko Widodo)"
        (ScoreCountry Indonesia)
        3
    , oneOpCard Territorial
        "Prime Minister of Malaysia (Mahathir Mohamad)"
        (ScoreCountry Malaysia)
        4
    , oneOpCard Trade
        "Prime Minister of Japan (Shinzō Abe)"
        ScoreEconomics
        5
    , oneOpCard Trade
        "Prime Minister of India (Narendra Damodardas Modi)"
        (ScoreCountry Indonesia)
        6
    , oneOpCard Military
        "Chairman - The Workers' Party of Korea (Kim Jong-un)"
        ScoreCrFonop
        7
    , oneOpCard Military
        "President of Russia (Vladimir Putin)"
        (ScoreCountry Brunei)
        8
    , oneOpCard Military
        "Leader of Taiwan (Tsai Ing-wen)"
        (ScoreCountry Malaysia)
        9
    , { operationValue = 3
      , mode = Military
      , title = "Chinese Hackers Targer US Carrier"
      , descriptionLines =
            [ NormalDescription "Move all US PW to Available."
            , NormalDescription "Place 3 Chinese PW."
            ]
      , side = Just China
      , tensionImpact = Just IncreaseTension
      , scoringImpact = ScoreEconomics
      , eventDirections =
            [ MovePoliticalWarfareToAvailable { side = USA, amount = All }
            , PlacePoliticalWarfare { side = China, number = 3 }
            ]
      , cardNumber = 10
      }
    , { operationValue = 2
      , mode = Military
      , title = "China and Malaysia Sign Naval Co-operation Deal"
      , descriptionLines = [ NormalDescription "Place 1 Chinese Diplomatic Influence in Malaysia and 2 other Countries." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Malaysia
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = China
                , amount = 1
                , countries = [ SpecificCountry Malaysia, OtherCountries 2 ]
                , type_ = Each
                }
            ]
      , cardNumber = 11
      }
    , { operationValue = 2
      , mode = Trade
      , title = "Chinese-Funded Asian Infrastructure Investment Bank Invests Heavily"
      , descriptionLines =
            [ NormalDescription "Place 1 Chinese Economic Influence in 2 Countries."
            , TensionChanges "Tension to Low"
            ]
      , side = Just China
      , tensionImpact = Just (SpecificTension Low)
      , scoringImpact = ScoreCountry Philippines
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = China
                , amount = 1
                , countries = [ OtherCountries 2 ]
                , type_ = Each
                }
            ]
      , cardNumber = 12
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "Vietnam Reclaims Sand Cay"
      , descriptionLines =
            [ NormalDescription "Place 1 FONOP at Paracel Islands and move 1 CR from Paracel Islands to Available."
            , TensionChanges "Increase Tension"
            ]
      , side = Just USA
      , tensionImpact = Just IncreaseTension
      , scoringImpact = ScoreCountry Vietnam
      , eventDirections =
            [ PlaceAndMoveCrFonop
                { side = USA
                , amount = 1
                , place = ParacelIslands
                , moveToAvailable = ParacelIslands
                }
            ]
      , cardNumber = 13
      }
    , { operationValue = 2
      , mode = Trade
      , title = "U.S. Participates in \"Democracy Diamond\" Meeting (including India, Japan and Australia)"
      , descriptionLines =
            [ NormalDescription "Place 1 US Diplomatic Influence in 3 Countries." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = USA
                , amount = 1
                , countries = [ OtherCountries 3 ]
                , type_ = Each
                }
            ]
      , cardNumber = 14
      }
    , { operationValue = 2
      , mode = Military
      , title = "Philippines Boosts Military Budget"
      , descriptionLines =
            [ NormalDescription "Place 2 FONOPs at Scarborough Shoal"
            , TensionChanges "Tension to Low"
            ]
      , side = Just USA
      , tensionImpact = Just (SpecificTension Low)
      , scoringImpact = ScoreCountry Philippines
      , eventDirections =
            [ PlaceFonopCrAtLocation
                { side = USA
                , amount = 2
                , location = ScarboroughShoal
                }
            ]
      , cardNumber = 15
      }
    , { operationValue = 2
      , mode = Military
      , title = "Chinese Fishing Boats Breach Indonesian Waters"
      , descriptionLines =
            [ NormalDescription "If US has the most Diplomatic Influence in Philippines, move 2 Chinese Diplomatic Influence from Indonesia to Available" ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Indonesia
      , eventDirections =
            [ Conditional
                { side = USA
                , condition = MostDiplomaticInfluence { country = Philippines }
                , ifTrue = [ MoveDiplomaticInfluenceFromCountryToAvailable { side = China, amount = Specific 2, country = Indonesia } ]
                }
            ]
      , cardNumber = 16
      }
    , { operationValue = 2
      , mode = Military
      , title = "Japan Escorts US Vessels"
      , descriptionLines =
            [ NormalDescription "If more FONOPs than CRs, place 1 US Diplomatic influence in 3 Countries." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Malaysia
      , eventDirections =
            [ Conditional
                { side = USA
                , condition = MoreFonopCr
                , ifTrue =
                    [ PlaceDiplomaticInfluence
                        { side = USA
                        , amount = 1
                        , countries = [ OtherCountries 3 ]
                        , type_ = Each
                        }
                    ]
                }
            ]
      , cardNumber = 17
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "Vietnam Grants Indian Firm ONGC Videsh Drilling Rights"
      , descriptionLines =
            [ NormalDescription "If there are more FONOPs than CRs in Paracel Islands, move all Chinese Economic Influence from Vietnam to Available"
            , TensionChanges "Increase Tension"
            ]
      , side = Just USA
      , tensionImpact = Just IncreaseTension
      , scoringImpact = ScoreCountry Vietnam
      , eventDirections =
            [ Conditional
                { side = USA
                , condition = MoreFonopCrInLocation { location = ParacelIslands }
                , ifTrue =
                    [ MoveEconomicInfluenceFromCountryToAvailable
                        { amount = All
                        , side = China
                        , country = Vietnam
                        }
                    ]
                }
            ]
      , cardNumber = 18
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "Duerte 'Bans' All Fishing in Scarborough Shoal"
      , descriptionLines =
            [ NormalDescription "Move all Chinese Economic Influence from Philippines to Available."
            , TensionChanges "Increase Tension"
            ]
      , side = Just USA
      , tensionImpact = Just IncreaseTension
      , scoringImpact = ScoreCountry Philippines
      , eventDirections =
            [ MoveEconomicInfluenceFromCountryToAvailable
                { amount = All
                , side = China
                , country = Philippines
                }
            ]
      , cardNumber = 19
      }
    , { operationValue = 2
      , mode = Trade
      , title = "Chinese Checkbook Diplomacy"
      , descriptionLines = [ NormalDescription "Place 3 Chinese Economic Influence total in Malaysia, Indonesia and/or Brunei." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Indonesia
      , eventDirections =
            [ PlaceEconomicInfluence
                { side = China
                , amount = 3
                , type_ = Total
                , countries =
                    [ SpecificCountry Malaysia
                    , SpecificCountry Indonesia
                    , SpecificCountry Brunei
                    ]
                }
            ]
      , cardNumber = 20
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "Chinese Economic Crisis"
      , descriptionLines = [ NormalDescription "Place 2 Economic Influence. Then, if US has more Economic Influence than China, US receives 1 VP." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreEconomics
      , eventDirections =
            [ PlaceEconomicInfluence
                { side = USA
                , amount = 2
                , countries = []
                , type_ = Total
                }
            , Conditional { side = USA, condition = MoreEconomicInfluence, ifTrue = [ GetVictoryPoints { side = USA, amount = 1 } ] }
            ]
      , cardNumber = 21
      }
    , { operationValue = 2
      , mode = Trade
      , title = "ASEAN Countries Work Together"
      , descriptionLines = [ NormalDescription "If US has 6 or more Diplomatic Influence, place 1 US Influence in 3 Countries." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ Conditional
                { side = USA
                , condition = MoreThanDiplomaticInfluenceInTotal { amount = 6 }
                , ifTrue =
                    [ PlaceInfluence
                        { side = USA
                        , amount = 1
                        , countries = [ OtherCountries 3 ]
                        , type_ = Each
                        }
                    ]
                }
            ]
      , cardNumber = 22
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "PLAN's Wu: Beijing Won't Stop South China Sea Island Reclamation"
      , descriptionLines = [ NormalDescription "If China has 2 or more CRs, place 1 CR.", TensionChanges "Tension to Critical" ]
      , side = Just China
      , tensionImpact = Just (SpecificTension Critical)
      , scoringImpact = ScoreCountry Philippines
      , eventDirections =
            [ Conditional
                { side = China
                , condition = NumberOfFonopCrOrGreater { number = 2 }
                , ifTrue = [ PlaceFonopCr { side = China, amount = 1 } ]
                }
            ]
      , cardNumber = 23
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "Duterte Under Pressure to Stand Up to Beijing"
      , descriptionLines =
            [ NormalDescription "Move 2 Chinese Influence from Philippines to Available and move 1 Chinese PW to Available"
            , TensionChanges "Increase Tension"
            ]
      , side = Just USA
      , tensionImpact = Just IncreaseTension
      , scoringImpact = ScoreCountry Philippines
      , eventDirections =
            [ MoveInfluenceToAvailable
                { side = China
                , country = Philippines
                , amount = Specific 2
                }
            , MovePoliticalWarfareToAvailable
                { amount = Specific 1
                , side = China
                }
            ]
      , cardNumber = 24
      }
    , { operationValue = 2
      , mode = Military
      , title = "Chinese Jets Intercept US 'Sniffer' Aircraft"
      , descriptionLines =
            [ NormalDescription "If China has 6 or more Diplomatic Influence, move all US PW to Available."
            , NormalDescription "Move 2 US Diplomatic Influence to Available"
            , TensionChanges "Increase Tension"
            ]
      , side = Just China
      , tensionImpact = Just IncreaseTension
      , scoringImpact = ScoreCountry Malaysia
      , eventDirections =
            [ Conditional
                { side = China
                , condition = MoreThanDiplomaticInfluenceInTotal { amount = 6 }
                , ifTrue = [ MovePoliticalWarfareToAvailable { amount = All, side = USA } ]
                }
            , MoveDiplomaticInfluenceToAvailable { side = USA, amount = Specific 2 }
            ]
      , cardNumber = 25
      }
    , { operationValue = 2
      , mode = Trade
      , title = "Beijing Cracks Down on \"Corruption\""
      , descriptionLines = [ NormalDescription "Place 3 Chinese Diplomatic Influence." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = China
                , amount = 3
                , countries = []
                , type_ = Total
                }
            ]
      , cardNumber = 26
      }
    , { operationValue = 2
      , mode = Trade
      , title = "China Develps \"One Belt One Road\" Plan for Eurasian Trade"
      , descriptionLines =
            [ NormalDescription "Move 3 US Economic Influence to Available."
            , TensionChanges "Tension to Low"
            ]
      , side = Just China
      , tensionImpact = Just (SpecificTension Low)
      , scoringImpact = ScoreCountry Indonesia
      , eventDirections =
            [ MoveEconomicInfluenceToAvailable
                { amount = Specific 3
                , side = USA
                }
            ]
      , cardNumber = 27
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "Typhoon"
      , descriptionLines =
            [ NormalDescription "If behind in VPs, select Scarborough Shoal, Paracel Islands or Spratly Islands."
            , NormalDescription "Move all FONOPs and CRs there to Available."
            , TensionChanges "Tension to Low"
            ]
      , side = Nothing
      , tensionImpact = Just (SpecificTension Low)
      , scoringImpact = ScoreCrFonop
      , eventDirections =
            [ ConditionalActiveSide
                { condition = BehindInVps
                , ifTrue =
                    [ MoveAllFonopCrToAvailable
                        { availableLocations =
                            [ ScarboroughShoal
                            , ParacelIslands
                            , SpratlyIslands
                            ]
                        }
                    ]
                }
            ]
      , cardNumber = 40
      }
    , { operationValue = 2
      , mode = Trade
      , title = "COVID-19 Outbreak in China"
      , descriptionLines =
            [ NormalDescription "Move 3 Chinese Economic Influence to Available."
            , NormalDescription "Move 1 US Economic Influence to Available."
            , TensionChanges "Decrease Tension"
            ]
      , side = Just USA
      , tensionImpact = Just DecreaseTension
      , scoringImpact = ScoreEconomics
      , eventDirections =
            [ MoveEconomicInfluenceToAvailable
                { amount = Specific 3
                , side = China
                }
            , MoveEconomicInfluenceToAvailable
                { amount = Specific 1
                , side = USA
                }
            ]
      , cardNumber = 41
      }
    , { operationValue = 2
      , mode = Trade
      , title = "US-China Trade War"
      , descriptionLines =
            [ NormalDescription "Move 3 US Economic Influence to Available."
            , TensionChanges "Tension to Critical"
            ]
      , side = Just China
      , tensionImpact = Just (SpecificTension Critical)
      , scoringImpact = ScoreEconomics
      , eventDirections =
            [ MoveEconomicInfluenceToAvailable
                { side = USA
                , amount = Specific 3
                }
            ]
      , cardNumber = 43
      }
    , { operationValue = 2
      , mode = Trade
      , title = "UN Action Petitioned"
      , descriptionLines = [ NormalDescription "Place 2 US Diplomatic Influence. Then if the US has the most Diplomatic Influence, US receives 1 VP." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = USA
                , amount = 2
                , countries = []
                , type_ = Total
                }
            , Conditional
                { side = USA
                , condition = MoreDiplomaticInfluence
                , ifTrue =
                    [ GetVictoryPoints
                        { side = USA
                        , amount = 1
                        }
                    ]
                }
            ]
      , cardNumber = 44
      }
    , { operationValue = 2
      , mode = Trade
      , title = "Death of Vietnamese President (Tran Dai Quang)"
      , descriptionLines = [ NormalDescription "If US has the most influence in Vietnam, move 2 Chinese Diplomatic Influence from Vietnam to Available." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Vietnam
      , eventDirections =
            [ Conditional
                { side = USA
                , condition = MoreInfluenceInCountry { country = Vietnam }
                , ifTrue =
                    [ MoveDiplomaticInfluenceFromCountryToAvailable
                        { side = China
                        , amount = Specific 2
                        , country = Vietnam
                        }
                    ]
                }
            ]
      , cardNumber = 45
      }
    , { operationValue = 2
      , mode = Military
      , title = "North Korea Launches Missile"
      , descriptionLines = [ NormalDescription "Move 2 US Economic or Diplomatic Influence to Reserve." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Indonesia
      , eventDirections =
            [ MoveOneTypeOfInfluenceToReserve
                { side = USA
                , amount = 2
                }
            ]
      , cardNumber = 46
      }
    , { operationValue = 3
      , mode = Territorial
      , title = "China Blockades BRP Sierra Madre on Second Thomas Shoal"
      , descriptionLines = [ NormalDescription "If Tension is High or Critical, move 1 FONOP from Scarborough Shoal to Available and move 3 US Influence from Philippines to Available." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCrFonop
      , eventDirections =
            [ ConditionalActiveSide
                { condition =
                    TensionIsAtLevels
                        { tension = [ High, Critical ]
                        }
                , ifTrue =
                    [ MoveFonopCrToAvailable
                        { side = USA
                        , amount = 1
                        , locations = [ ScarboroughShoal ]
                        }
                    , MoveInfluenceToAvailable
                        { side = USA
                        , country = Philippines
                        , amount = Specific 3
                        }
                    ]
                }
            ]
      , cardNumber = 28
      }
    , { operationValue = 3
      , mode = Trade
      , title = "Beijing Attacks Legitimacy of Permanent Court of Arbitration"
      , descriptionLines = [ NormalDescription "Place 3 Chinese Influence total in Vietnam, Philippines and/or Malaysia." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCrFonop
      , eventDirections =
            [ PlaceInfluence
                { side = China
                , amount = 3
                , countries =
                    [ SpecificCountry Vietnam
                    , SpecificCountry Philippines
                    , SpecificCountry Malaysia
                    ]
                , type_ = Total
                }
            ]
      , cardNumber = 29
      }
    , { operationValue = 3
      , mode = Military
      , title = "US Bombers Fly Over South China Sea"
      , descriptionLines =
            [ NormalDescription "Place 1 FONOP. Move 1 Chinese Diplomatic Influence from 3 Countries to Available."
            , TensionChanges "Increase Tension"
            ]
      , side = Just USA
      , tensionImpact = Just IncreaseTension
      , scoringImpact = ScoreCrFonop
      , eventDirections =
            [ PlaceFonopCr { side = USA, amount = 1 }
            , MoveDiplomaticInfluenceFromCountriesToAvailable
                { side = China
                , amount = Specific 3
                , numberOfCountries = 3
                }
            ]
      , cardNumber = 30
      }
    , { operationValue = 3
      , mode = Trade
      , title = "Nationalist Protests Erupt in Major Cities, Universities"
      , descriptionLines = [ NormalDescription "If Tension is High or Critical, place 1 US Economic Influence and place 3 US Diplomatic Influence." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ ConditionalActiveSide
                { condition = TensionIsAtLevels { tension = [ High, Critical ] }
                , ifTrue =
                    [ PlaceEconomicInfluence
                        { side = USA
                        , amount = 1
                        , type_ = Total
                        , countries = []
                        }
                    , PlaceDiplomaticInfluence
                        { side = USA
                        , amount = 3
                        , type_ = Total
                        , countries = []
                        }
                    ]
                }
            ]
      , cardNumber = 31
      }
    , { operationValue = 3
      , mode = Military
      , title = "USS Carl Vinson Makes Historic Port Call in Vietnam"
      , descriptionLines = [ NormalDescription "If at least 3 US Influence in Vietnam, place 2 US Influence in Vietname and place 1 FONOP at Paracel Islands." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Vietnam
      , eventDirections =
            [ Conditional
                { side = USA
                , condition = MoreInfluenceInCountry { country = Vietnam }
                , ifTrue =
                    [ PlaceInfluence
                        { side = USA
                        , amount = 2
                        , countries = [ SpecificCountry Vietnam ]
                        , type_ = Total
                        }
                    , PlaceFonopCrAtLocation
                        { side = USA
                        , amount = 1
                        , location = ParacelIslands
                        }
                    ]
                }
            ]
      , cardNumber = 32
      }
    , { operationValue = 3
      , mode = Military
      , title = "US Companies Fear Chinese Reprisals Over Support for Hong Kong Protests"
      , descriptionLines = [ NormalDescription "Move 3 US Diplomatic Influence to Available." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreEconomics
      , eventDirections =
            [ MoveDiplomaticInfluenceToAvailable
                { side = USA
                , amount = Specific 3
                }
            ]
      , cardNumber = 33
      }
    , { operationValue = 3
      , mode = Military
      , title = "U.S. Accuses China of Major Human Rights Violations"
      , descriptionLines =
            [ NormalDescription "Move 1 Chinese Diplomatic Influence to Available."
            , NormalDescription "Place 2 US Diplomatic Influence."
            ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCrFonop
      , eventDirections =
            [ MoveDiplomaticInfluenceToAvailable
                { side = China
                , amount = Specific 1
                }
            , PlaceDiplomaticInfluence
                { side = USA
                , countries = []
                , amount = 2
                , type_ = Total
                }
            ]
      , cardNumber = 34
      }
    , { operationValue = 3
      , mode = Territorial
      , title = "Protests by Chinese Veterans Over Pensions Distract Beijing"
      , descriptionLines = [ NormalDescription "If US has more than 7 Diplomatic Influence, place 3 US Influence and move 1 Chinese Economic Influence to Available." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Philippines
      , eventDirections =
            [ Conditional
                { side = USA
                , condition = MoreThanDiplomaticInfluenceInTotal { amount = 7 }
                , ifTrue =
                    [ PlaceInfluence
                        { side = USA
                        , amount = 3
                        , type_ = Total
                        , countries = []
                        }
                    , MoveEconomicInfluenceToAvailable
                        { side = China
                        , amount = Specific 1
                        }
                    ]
                }
            ]
      , cardNumber = 35
      }
    , { operationValue = 3
      , mode = Territorial
      , title = "China Seizes US Submarine Drone"
      , descriptionLines = [ NormalDescription "Move 1 FONOP to Available. Place 1 Chinese Influence in 3 Countries." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Vietnam
      , eventDirections =
            [ MoveFonopCrToAvailable
                { side = USA
                , amount = 1
                , locations = []
                }
            , PlaceInfluence
                { side = China
                , amount = 1
                , type_ = Each
                , countries = [ OtherCountries 3 ]
                }
            ]
      , cardNumber = 36
      }
    , { operationValue = 3
      , mode = Trade
      , title = "US and Chinese Planes Collide"
      , descriptionLines =
            [ NormalDescription "Move 3 US Diplomatic Influence to Available."
            , TensionChanges "Tension to Critical"
            ]
      , side = Just China
      , tensionImpact = Just (SpecificTension Critical)
      , scoringImpact = ScoreCountry Indonesia
      , eventDirections =
            [ MoveDiplomaticInfluenceToAvailable
                { side = USA
                , amount = Specific 3
                }
            ]
      , cardNumber = 42
      }
    , { operationValue = 3
      , mode = Military
      , title = "Chinese Declare ADIZ"
      , descriptionLines = [ NormalDescription "Move 1 US Diplomatic Influence from 3 Countries to Available." ]
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCrFonop
      , eventDirections =
            [ MoveDiplomaticInfluenceFromCountriesToAvailable
                { side = USA
                , amount = Specific 1
                , numberOfCountries = 3
                }
            ]
      , cardNumber = 47
      }
    , { operationValue = 3
      , mode = Military
      , title = "US Announces Formal Review of Taiwan Relations Act"
      , descriptionLines = [ NormalDescription "If US has 3 FONOPs, place 3 US Diplomatic Influence from Reserve and/or Available." ]
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ Conditional
                { side = USA
                , condition = ExactNumberOfFonopCr { number = 3 }
                , ifTrue =
                    [ PlaceDiplomaticInfluenceFromReserveOrAvailable
                        { side = USA
                        , amount = 3
                        }
                    ]
                }
            ]
      , cardNumber = 48
      }
    ]
