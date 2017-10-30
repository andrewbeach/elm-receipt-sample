module View exposing (..)

import Array exposing (Array)
import Html exposing (Html, button, div, h1, input, span, table, tr, td, text)
import Html.Attributes exposing (class, type_, checked)
import Html.Events exposing (onClick)
import Msgs exposing (Msg(..))
import Models exposing (Model, Receipt, ReceiptOrder(..), getCategory, getVendor, getTotal)


receiptField : String -> Html Msg
receiptField value =
    td [ class "receipt-row-field" ] [ text value ]


receiptCheckbox : Receipt -> Html Msg
receiptCheckbox receipt =
    input
        [ class "receipt-checkbox"
        , type_ "checkbox"
        , checked receipt.checked
        , onClick (CheckReceiptById receipt.id)
        ]
        []

deleteButton : Receipt -> Html Msg
deleteButton receipt =
    td [ class "delete-receipt"
         , onClick <| DeleteReceiptById receipt.id ]
         [ text "Delete" ]


receiptRow : Receipt -> Html Msg
receiptRow receipt =
    tr [ class "receipt-row" ]
        [ td [] [ receiptCheckbox receipt ]
        , receiptField (toString receipt.id)
        , receiptField (getVendor receipt)
        , receiptField (getTotal receipt)
        , receiptField (getCategory receipt)
        , deleteButton receipt
        ]


sortToggle : String -> ReceiptOrder -> Html Msg
sortToggle value order =
    button
        [ class "toggle"
        , onClick (ToggleSort order)
        ]
        [ text value ]


sortReceipts : ReceiptOrder -> Array Receipt -> Array Receipt
sortReceipts order receipts =
    case order of
        ByCategory ->
            Array.fromList <| List.sortBy getCategory <| Array.toList receipts

        ByTotal ->
            Array.fromList <| List.sortBy getTotal <| Array.toList receipts

        ByVendor ->
            Array.fromList <| List.sortBy getVendor <| Array.toList receipts


summingReceipts : Receipt -> Float -> Float
summingReceipts receipt currentSum =
    case receipt.total of
        Just total ->
            currentSum + total

        Nothing ->
            currentSum


sumReceipts : Array Receipt -> Float
sumReceipts receipts =
    Array.foldl summingReceipts 0 receipts


sumCheckedReceipts : Array Receipt -> Float
sumCheckedReceipts receipts =
   sumReceipts <| Array.filter .checked receipts


allToggle : String -> Msg -> Html Msg
allToggle label msg =
   button [ class "toggle"
          , onClick msg ]
          [ text label ]


view : Model -> Html Msg
view model =
    div [ class "receipts" ]
        [ sortToggle "Sort by Vendor" ByVendor
        , sortToggle "Sort by Total" ByTotal
        , sortToggle "Sort by Category" ByCategory
        , table [ class "receipt-list" ] <|
            Array.toList <|
                Array.map receiptRow <|
                    sortReceipts model.sortBy model.receipts
        , allToggle "All" CheckAll
        , allToggle "None" UncheckAll
        , allToggle "Delete Selected" DeleteSelected
        , h1 [ class "receipt-total" ]
             [ text <| String.append "Selected: $ " <| toString <| sumCheckedReceipts model.receipts ]
        , h1 [ class "receipt-total" ]
             [ text <| String.append "Total: $ " <| toString <| sumReceipts model.receipts ]
        ]
