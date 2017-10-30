module Models exposing (..)

import Array exposing (..)

type alias Model =
    { receipts : Array Receipt
    , sortBy : ReceiptOrder
    }


type alias Receipt =
    { id : Int
    , vendor : Maybe String
    , total : Maybe Float
    , category : Maybe String
    , checked : Bool
    }

type ReceiptOrder = ByCategory | ByTotal | ByVendor



-- Receipt methods

getVendor : Receipt -> String
getVendor receipt =
    case receipt.vendor of
        Just vendor ->
            vendor

        Nothing ->
            ""


getCategory : Receipt -> String
getCategory receipt =
    case receipt.category of
        Just category ->
            category

        Nothing ->
            ""


getTotal : Receipt -> String
getTotal receipt =
    case receipt.total of
        Just total ->
            "$ " ++ (toString total)

        Nothing ->
            "$ 0.00"
