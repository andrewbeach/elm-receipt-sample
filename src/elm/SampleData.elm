module SampleData exposing (..)

import Models exposing (Receipt)
import Array exposing (Array, fromList)


sampleReceipt1 : Receipt
sampleReceipt1 =
    Receipt 0 (Just "Walmart") (Just 24.5) (Just "Grocery") False


sampleReceipt2 : Receipt
sampleReceipt2 =
    Receipt 1 (Just "Amazon") Nothing (Just "General") False


sampleReceipt3 : Receipt
sampleReceipt3 =
    Receipt 2 (Just "Harris Teeter") (Just 109.45) Nothing False


sampleReceipt4 : Receipt
sampleReceipt4 =
    Receipt 3 (Just "Amazon") (Just 76) (Just "Computer / Internet") False


sampleReceipt5 : Receipt
sampleReceipt5 =
    Receipt 4 (Just "Harris Teeter") (Just 45) (Just "Groceries") False


sampleReceipts : Array Receipt
sampleReceipts =
    Array.fromList
        [ sampleReceipt1
        , sampleReceipt2
        , sampleReceipt3
        , sampleReceipt4
        , sampleReceipt5
        ]
