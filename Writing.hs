module Writing where

import Data.List (nub)


main :: IO ()
main = do
  s <- readFile "writing.in"
  let t = length s `div` (length $ nub s)
  writeFile "writing.out" $ take t s
