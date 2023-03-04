module Cards.EventCards exposing (..)

import Types exposing (Amount(..), Condition(..), Country(..), EventCard, EventCountry(..), EventDirection(..), FonopCrName(..), Mode(..), PlacementType(..), ScoringImpact(..), Side(..), Tension(..), TensionImpact(..))


oneOpCard : Mode -> String -> ScoringImpact -> Int -> EventCard
oneOpCard mode title scoring cardNumber =
    { operationValue = 1
    , mode = mode
    , title = title
    , side = Nothing
    , tensionImpact = Nothing
    , scoringImpact = scoring
    , eventDirections =
        [ MoveTensionToAnyLevel
        , ExecuteAsOpCard { operationsValue = 1, description = "Then execute as a 1 Operation Value card." }
        ]
    , cardNumber = cardNumber
    }


cards : List EventCard
cards =
    [ oneOpCard Trade
        "Chairman of Industrial/Commercial Bank of China (Jiang Jianqing)"
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
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Malaysia
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = China
                , amount = 1
                , countries = [ SpecificCountry Malaysia, OtherCountries 2 ]
                }
            ]
      , cardNumber = 11
      }
    , { operationValue = 2
      , mode = Trade
      , title = "Chinese-Funded Asian Infrastructure Investment Bank Invests Heavily"
      , side = Just China
      , tensionImpact = Just (SpecificTension Low)
      , scoringImpact = ScoreCountry Philippines
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = China
                , amount = 1
                , countries = [ OtherCountries 2 ]
                }
            ]
      , cardNumber = 12
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "Vietnam Reclaims Sand Cay"
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
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ PlaceDiplomaticInfluence { side = USA, amount = 1, countries = [ OtherCountries 3 ] }
            ]
      , cardNumber = 14
      }
    , { operationValue = 2
      , mode = Military
      , title = "Philippines Boosts Military Budget"
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
                        }
                    ]
                }
            ]
      , cardNumber = 17
      }
    , { operationValue = 2
      , mode = Territorial
      , title = "Vietnam Grants Indian Firm ONGC Videsh Drilling Rights"
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
      , title = "PLAN's Wi: Beijing Won't Stop South China Sea Island Reclamation"
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
      , side = Just China
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = China
                , amount = 3
                , countries = []
                }
            ]
      , cardNumber = 26
      }
    , { operationValue = 2
      , mode = Trade
      , title = "China Develps \"One Belt One Road\" Plan for Eurasian Trade"
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
      , side = Just USA
      , tensionImpact = Nothing
      , scoringImpact = ScoreCountry Brunei
      , eventDirections =
            [ PlaceDiplomaticInfluence
                { side = USA
                , amount = 2
                , countries = []
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
                        , location = ScarboroughShoal
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
    ]
