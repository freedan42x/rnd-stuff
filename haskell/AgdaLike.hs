{-# LANGUAGE GADTs, DataKinds #-}

module AgdaLike where

import Prelude (
  Show, Int, pred, succ
  )

data Nat where
  Z :: Nat
  S :: Nat -> Nat
  deriving Show

($) :: (a -> b) -> a -> b
f $ x = f x

(.) :: (b -> c) -> (a -> b) -> a -> c
(.) f g = \x -> f $ g x

toNat :: Int -> Nat
toNat 0 = Z
toNat n = S . toNat $ pred n

fromNat :: Nat -> Int
fromNat Z     = 0
fromNat (S n) = succ $ fromNat n

(+) :: Nat -> Nat -> Nat
m + Z     = m
m + (S n) = S $ m + n

(-) :: Nat -> Nat -> Nat
Z - _         = Z
m - Z         = m
(S m) - (S n) = m - n

(*) :: Nat -> Nat -> Nat
m * Z     = Z
m * (S n) = m + (m * n)

(^) :: Nat -> Nat -> Nat
m ^ Z     = S Z
m ^ (S n) = m * (m ^ n)

data Bool where
  True  :: Bool
  False :: Bool
  deriving Show

not :: Bool -> Bool
not True = False
not _    = True

(&&) :: Bool -> Bool -> Bool
True  && b = b
False && _ = False

(||) :: Bool -> Bool -> Bool
True  || _ = True
False || b = b
