module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (..)
import Update exposing (update)
import View exposing (view)
import SampleData exposing (sampleReceipts)


init : ( Model, Cmd Msg )
init =
    ( { receipts = sampleReceipts
      , sortBy = ByTotal
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
