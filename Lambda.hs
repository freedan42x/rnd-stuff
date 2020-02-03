{-# LANGUAGE Rank2Types #-}
module Lambda where

import Prelude hiding (or, not, and, pred)
import Control.Monad

type B = forall a. a -> a -> a

true :: B
true  = const

false :: B
false = const id

toBool :: B -> Bool
toBool = flip ($ True) False

not :: B -> B
not = flip ($ false) true

or :: B -> B -> B
or b = b true

and :: B -> B -> B
and = flip flip false

xor :: B -> B -> B
xor b b' = b (not b') b'


type CNum = forall a. (a -> a) -> (a -> a)

zero :: CNum
zero = const id

one :: CNum
one  = id

two :: CNum
two  = join (.)

suc :: CNum -> CNum
suc = ap (.)

add :: CNum -> CNum -> CNum
add = liftM2 (.)

mult :: CNum -> CNum -> CNum
mult = (.)

pow :: CNum -> CNum -> CNum
pow = flip id

pred :: CNum -> CNum
pred = \n f x -> n (\g h -> h (g f)) (\u -> x) (\u -> u)
-- Definitely not the best idea to pointfree this! :p
_ = flip flip id . (flip .) . flip flip const . ((.) .) . (. ((flip id .) . flip id))

--minus :: CNum -> CNum -> CNum
--minus m n = How do we do this? `n pred m` throws an error.

toInt :: CNum -> Int
toInt = flip ($ (1 +)) 0
