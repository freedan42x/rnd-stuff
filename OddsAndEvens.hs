module OddsAndEvens where

data Even = Zero | NextEven Even deriving Show
data Odd  = One  | NextOdd  Odd  deriving Show

------------------------------------------
toEven :: Int -> Even
toEven 0 = Zero
toEven n = NextEven . toEven $ n - 2

fromEven :: Even -> Int
fromEven Zero         = 0
fromEven (NextEven n) = 2 + fromEven n

toOdd :: Int -> Odd
toOdd 1 = One
toOdd n = NextOdd . toOdd $ n - 2

fromOdd :: Odd -> Int
fromOdd One         = 1
fromOdd (NextOdd n) = 2 + fromOdd n

succEven :: Even -> Odd
succEven = toOdd . succ . fromEven

succOdd :: Odd -> Even
succOdd = toEven . succ . fromOdd
------------------------------------------
evenPlusEven :: Even -> Even -> Even
evenPlusEven Zero         n = n
evenPlusEven (NextEven m) n = NextEven $ m `evenPlusEven` n

oddPlusOdd :: Odd -> Odd -> Even
oddPlusOdd One         n = succOdd n
oddPlusOdd (NextOdd m) n = NextEven $ m `oddPlusOdd` n

evenPlusOdd :: Even -> Odd -> Odd
evenPlusOdd Zero       One = One
evenPlusOdd m  (NextOdd n) = NextOdd $ m `evenPlusOdd` n
evenPlusOdd (NextEven m) n = NextOdd $ m `evenPlusOdd` n

oddPlusEven :: Odd -> Even -> Odd
oddPlusEven m n = evenPlusOdd n m
------------------------------------------

main = do
  putStrLn . show . fromEven $ evenPlusEven (toEven 4) (toEven 6)
  putStrLn . show . fromOdd  $ evenPlusOdd (toEven 4) (toOdd 7)
  putStrLn . show . fromEven $ oddPlusOdd (toOdd 3) (toOdd 9)
  putStrLn . show . fromOdd  $ oddPlusEven (toOdd 7) (toEven 6)
