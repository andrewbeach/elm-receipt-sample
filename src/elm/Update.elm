module Update exposing (..)

import Array exposing (Array)
import Msgs exposing (Msg(..))
import Models exposing (Model, Receipt)


toggleReceiptChecked : Receipt -> Receipt
toggleReceiptChecked receipt =
    let
        currentChecked =
            receipt.checked
    in
        { receipt | checked = not currentChecked }

checkReceipt : Receipt -> Receipt
checkReceipt receipt =
    { receipt | checked = True }

uncheckReceipt : Receipt -> Receipt
uncheckReceipt receipt =
    { receipt | checked = False }


checkReceiptAtIndex : Int -> Array Receipt -> Array Receipt
checkReceiptAtIndex index receipts =
    let
        receiptAtIndex =
            Array.get index receipts
    in
        case receiptAtIndex of
            Just receipt ->
                Array.set index (toggleReceiptChecked receipt) receipts

            Nothing ->
                receipts


checkAllReceipts : Array Receipt -> Array Receipt
checkAllReceipts receipts =
    Array.map checkReceipt receipts


uncheckAllReceipts : Array Receipt -> Array Receipt
uncheckAllReceipts receipts =
    Array.map uncheckReceipt receipts


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleSort order ->
            ( { model | sortBy = order }, Cmd.none )

        CheckReceipt index ->
            ( { model | receipts = checkReceiptAtIndex index model.receipts }, Cmd.none )

        CheckAll ->
            ( { model | receipts = checkAllReceipts model.receipts }, Cmd.none )

        UncheckAll ->
            ( { model | receipts = uncheckAllReceipts model.receipts }, Cmd.none )
