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


checkReceiptById : Int -> Array Receipt -> Array Receipt
checkReceiptById id receipts =
  Array.map
    (\r -> if r.id == id
           then toggleReceiptChecked r
           else r)
    receipts


checkAllReceipts : Array Receipt -> Array Receipt
checkAllReceipts receipts =
    Array.map checkReceipt receipts


uncheckAllReceipts : Array Receipt -> Array Receipt
uncheckAllReceipts receipts =
    Array.map uncheckReceipt receipts


deleteReceiptById : Int -> Array Receipt -> Array Receipt
deleteReceiptById id receipts =
    Array.filter (\r -> r.id /= id) receipts


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleSort order ->
            ( { model | sortBy = order }, Cmd.none )

        CheckReceiptById id ->
            ( { model | receipts = checkReceiptById id model.receipts }, Cmd.none )

        DeleteReceiptById id ->
            ( { model | receipts = deleteReceiptById id model.receipts }, Cmd.none )

        DeleteSelected ->
            ( { model | receipts = Array.filter (not << .checked) model.receipts }, Cmd.none )

        CheckAll ->
            ( { model | receipts = checkAllReceipts model.receipts }, Cmd.none )

        UncheckAll ->
            ( { model | receipts = uncheckAllReceipts model.receipts }, Cmd.none )
