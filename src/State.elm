module State exposing (..)


type State s a
    = State (s -> ( a, s ))


runState : State s a -> s -> ( a, s )
runState (State stateFn) =
    stateFn


exec : State s a -> s -> s
exec (State stateFn) =
    Tuple.second << stateFn


eval : State s a -> s -> a
eval (State stateFn) =
    Tuple.first << stateFn


get : State s s
get =
    State (\s -> ( s, s ))


put : s -> State s ()
put s =
    State (\_ -> ( (), s ))


map : (a -> b) -> State s a -> State s b
map fn (State sFn) =
    State (Tuple.mapFirst fn << sFn)


map2 : (a -> b -> c) -> State s a -> State s b -> State s c
map2 fn (State s1) (State s2) =
    State
        (\s ->
            let
                ( a, s_ ) =
                    s1 s

                ( b, s__ ) =
                    s2 s_
            in
            ( fn a b, s__ )
        )


pure : a -> State s a
pure a =
    State (\s -> ( a, s ))


andMap :
    State s (a -> b)
    -> State s a
    -> State s b
andMap (State sab) (State sa) =
    State
        (\s ->
            let
                ( ab, s1 ) =
                    s
                        |> sab

                ( a, s2 ) =
                    sa s1
            in
            ( ab a, s2 )
        )


andThen : (a -> State s b) -> State s a -> State s b
andThen fn (State sa) =
    State
        (\s ->
            let
                ( a, s1 ) =
                    sa s

                (State sb) =
                    fn a
            in
            sb s1
        )


replicate : Int -> State s a -> State s (List a)
replicate cnt0 f =
    let
        loop cnt =
            if cnt <= 0 then
                pure []

            else
                map2 (\a b -> a :: b) f (loop (cnt - 1))
    in
    loop cnt0
