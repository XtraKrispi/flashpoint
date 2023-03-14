module Cards.Helpers exposing (draw)

import Maybe.Extra as Maybe
import State


dealCard : State.State (List a) (Maybe a)
dealCard =
    State.get
        |> State.andThen
            (\cards ->
                let
                    ( top, rest ) =
                        ( List.head cards, List.drop 1 cards )
                in
                State.put rest
                    |> State.map (always top)
            )


drawState : Int -> State.State (List a) (List a)
drawState n =
    State.replicate n dealCard
        |> State.map Maybe.values


draw : Int -> List a -> ( List a, List a )
draw n cards =
    State.runState (drawState n) cards
