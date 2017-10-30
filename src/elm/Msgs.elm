module Msgs exposing (..)

import Models exposing (Receipt, ReceiptOrder)


type Msg
    = NoOp
    | ToggleSort ReceiptOrder
    | CheckReceipt Int
    | CheckAll
    | UncheckAll
