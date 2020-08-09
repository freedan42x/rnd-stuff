module Main where

import           NeatInterpolation
import qualified Data.Text as T
import           Control.Monad
import           Lambda
import           Parser



code :: String
code = T.unpack
  [text|
    type Bool = a -> a -> a
    true : Bool
    true = t => f => t
  |]


main :: IO ()
main = print $ parse codeP code
