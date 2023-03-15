module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Cards.Helpers
import Dict exposing (diff)
import Html
import Html.Attributes as Attr
import Html.Events as Events
import Lamdera
import Setup
import Types exposing (..)
import Url
import Views.CampaignTrack
import Views.Forces
import Views.Location
import Views.TensionTrack
import Views.VictoryPointTrack


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , appModel = Setup Normal
      }
    , Cmd.none
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            ( model, Cmd.none )

        ChooseSide difficulty side ->
            ( model, Setup.initGameCmd difficulty side GameSetup )

        ChangeDifficulty difficulty ->
            ( { model | appModel = Setup difficulty }, Cmd.none )

        GameSetup gs ->
            ( { model | appModel = Playing gs }, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )


setupView : Difficulty -> Html.Html FrontendMsg
setupView difficulty =
    Html.div [ Attr.class "h-screen flex justify-center items-center flex-col" ]
        [ Html.div [] [ Html.img [ Attr.class "w-48", Attr.alt "Flashpoint: South China Sea", Attr.src "/box-art.webp" ] [] ]
        , Html.div [ Attr.class "flex justify-center flex-col items-center" ]
            [ Html.div [] [ Html.text "Please choose your difficulty" ]
            , difficultySelector difficulty
            , Html.div [] [ Html.text "Please choose a side" ]
            , Html.div [ Attr.class "flex space-x-2" ]
                [ Html.button [ Attr.class "w-32 hover:scale-125 hover:z-10 transition-all duration-100 drop-shadow-lg", Events.onClick (ChooseSide difficulty USA) ]
                    [ Html.img
                        [ Attr.alt "USA"
                        , Attr.src "/United_States.jpg"
                        ]
                        []
                    ]
                , Html.button [ Attr.class "w-32 hover:scale-125 hover:z-10 transition-all duration-100 drop-shadow-lg", Events.onClick (ChooseSide difficulty China) ]
                    [ Html.img
                        [ Attr.alt "China"
                        , Attr.src "/China.jpg"
                        ]
                        []
                    ]
                ]
            ]
        ]


difficultySelector : Difficulty -> Html.Html FrontendMsg
difficultySelector difficulty =
    let
        toString diff =
            case diff of
                Easy ->
                    "easy"

                Normal ->
                    "normal"

                Hard ->
                    "hard"

        radio diff =
            Html.div []
                [ Html.input
                    [ Attr.type_ "radio"
                    , Attr.name "difficulty"
                    , Attr.id (toString diff)
                    , Attr.class "peer hidden"
                    , Attr.checked (difficulty == diff)
                    , Events.onCheck (always (ChangeDifficulty diff))
                    ]
                    []
                , Html.label
                    [ Attr.for (toString diff)
                    , Attr.class "block cursor-pointer select-none rounded-xl p-2 text-center peer-checked:bg-blue-500 peer-checked:font-bold peer-checked:text-white uppercase"
                    , Attr.classList [ ( "peer-hover:bg-blue-200 peer-hover:font-bold peer-hover:text-white", difficulty /= diff ) ]
                    ]
                    [ Html.text (toString diff) ]
                ]
    in
    Html.div [ Attr.class "grid w-[40rem] grid-cols-3 space-x-2 rounded-xl bg-gray-200 p-2" ]
        [ radio Easy
        , radio Normal
        , radio Hard
        ]


view : Model -> Browser.Document FrontendMsg
view model =
    { title = ""
    , body =
        [ Html.node "link" [ Attr.rel "stylesheet", Attr.href "/output.css" ] []
        , case model.appModel of
            Setup difficulty ->
                setupView difficulty

            Playing gameState ->
                Html.div [ Attr.class "flex flex-col space-y-2" ]
                    [ Views.Location.viewWithFonopCr gameState.vietnam
                    , Views.Location.viewWithFonopCr gameState.philippines
                    , Views.Location.viewWithFonopCr gameState.malaysia
                    , Views.Location.view gameState.brunei
                    , Views.Location.view gameState.indonesia
                    , Views.TensionTrack.view gameState.tension
                    , Views.CampaignTrack.view gameState.campaign
                    , Views.Forces.view gameState.usForces
                    , Views.Forces.view gameState.chinaForces
                    , Views.VictoryPointTrack.view gameState.victoryPointTrack
                    ]

            GameOver ->
                Html.div [] []
        ]
    }
