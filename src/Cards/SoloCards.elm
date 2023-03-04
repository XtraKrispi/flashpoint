module Cards.SoloCards exposing (..)

import Types exposing (Country(..), FonopCrName(..), Side(..), SoloCard)


cards : List SoloCard
cards =
    [ { politicalWarfare = [ USA ]
      , crFonop = [ ScarboroughShoal, SpratlyIslands, ParacelIslands ]
      , influence = [ Philippines, Indonesia, Brunei, Vietnam, Malaysia ]
      , cardNumber = 63
      }
    , { politicalWarfare = [ USA ]
      , crFonop = [ SpratlyIslands, ParacelIslands, ScarboroughShoal ]
      , influence = [ Malaysia, Philippines, Indonesia, Brunei, Vietnam ]
      , cardNumber = 62
      }
    , { politicalWarfare = [ USA, China ]
      , crFonop = [ ParacelIslands, ScarboroughShoal, SpratlyIslands ]
      , influence = [ Malaysia, Vietnam, Indonesia, Brunei, Philippines ]
      , cardNumber = 61
      }
    , { politicalWarfare = [ USA ]
      , crFonop = [ ScarboroughShoal, ParacelIslands, SpratlyIslands ]
      , influence = [ Brunei, Vietnam, Malaysia, Philippines, Indonesia ]
      , cardNumber = 60
      }
    , { politicalWarfare = [ USA ]
      , crFonop = [ ParacelIslands, SpratlyIslands, ScarboroughShoal ]
      , influence = [ Indonesia, Brunei, Vietnam, Malaysia, Philippines ]
      , cardNumber = 59
      }
    , { politicalWarfare = [ USA ]
      , crFonop = [ ParacelIslands, ScarboroughShoal, SpratlyIslands ]
      , influence = [ Vietnam, Philippines, Brunei, Indonesia, Malaysia ]
      , cardNumber = 58
      }
    , { politicalWarfare = [ USA, China ]
      , crFonop = [ SpratlyIslands, ScarboroughShoal, ParacelIslands ]
      , influence = [ Philippines, Malaysia, Indonesia, Brunei, Vietnam ]
      , cardNumber = 57
      }
    , { politicalWarfare = [ USA, China ]
      , crFonop = [ ScarboroughShoal, ParacelIslands, SpratlyIslands ]
      , influence = [ Vietnam, Malaysia, Philippines, Indonesia, Brunei ]
      , cardNumber = 56
      }
    ]
