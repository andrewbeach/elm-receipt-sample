module Msgs exposing (..)

import Models exposing (Receipt, ReceiptOrder)


type Msg
    = NoOp
    | ToggleSort ReceiptOrder
    | CheckReceiptById Int
    | CheckAll
    | UncheckAll
    | DeleteReceiptById Int
    | DeleteSelected
