{-# LANGUAGE
  KindSignatures,
  DataKinds,
  GADTs,
  UnicodeSyntax,
  PolyKinds,
  TypeOperators
#-}
{-# OPTIONS_GHC -Wno-missing-methods #-}

module GADTs



type Set = *

data Nat :: Set where
  Zero :: Nat
  Suc  :: Nat → Nat


instance Show Nat where
  show Zero       = "Zero"
  show (Suc Zero) = "Suc " ++ show Zero
  show (Suc n)    = "Suc (" ++ show n ++ ")"

instance Num Nat where
  Zero  + n = n
  Suc m + n = Suc $ m + n

  Zero  * n = Zero
  Suc m * n = n + m * n

  Zero  - n     = Zero
  m     - Zero  = m
  Suc m - Suc n = m - n

instance Eq Nat where
  Zero  == Zero  = True
  Suc m == Suc n = m == n
  _     == _     = False

  m /= n = not $ m == n


toNat :: Int → Nat
toNat 0 = Zero
toNat n = Suc . toNat $ n - 1

fromNat :: Nat → Int
fromNat Zero    = 0
fromNat (Suc n) = succ $ fromNat n



data Even (n :: Nat) :: Set where
  ZEven :: Even Zero
  SOdd  :: Odd n → Even (Suc n)

data Odd (n :: Nat) :: Set where
  SEven :: Even n → Odd (Suc n)


fromEven :: Even n → Nat
fromEven ZEven    = Zero
fromEven (SOdd n) = Suc $ fromOdd n

fromOdd :: Odd n → Nat
fromOdd (SEven n) = Suc $ fromEven n


isEven :: Nat → Bool
isEven = even . fromNat

isOdd :: Nat → Bool
isOdd = not . isEven


instance Show (Even a) where
  show = ("Even " ++) . show . fromNat . fromEven

instance Show (Odd a) where
  show = ("Odd " ++) . show . fromNat . fromOdd



infixr 3 :>
data List (a :: Set) :: Set where
  Nil  :: List a
  (:>) :: a → List a → List a
  deriving (Show, Eq)

infixl 4 +++
(+++) :: List a -> List a -> List a
Nil +++ ys = ys
(x :> xs) +++ ys = x :> xs +++ ys


toList :: [a] → List a
toList []       = Nil
toList (x : xs) = x :> toList xs


fromList :: List a → [a]
fromList Nil       = []
fromList (x :> xs) = x : fromList xs


head' :: List a → a
head' (x :> _) = x

tail' :: List a → List a
tail' (_ :> xs) = xs

init' :: List a → List a
init' (xs :> _ :> Nil) = xs :> Nil
init' (x :> xs) = x :> (init' xs)

last' :: List a → a
last' (x :> Nil) = x
last' (_ :> xs)  = last' xs


map' :: (a → b) → List a → List b
map' _ Nil       = Nil
map' f (x :> xs) = f x :> map' f xs

filter' :: (a → Bool) → List a → List a
filter' _ Nil = Nil
filter' f (x :> xs)
  | f x == True = x :> filter' f xs
  | otherwise   = filter' f xs

reverse' :: List a → List a
reverse' Nil = Nil
reverse' (x :> xs) = reverse' xs +++ toList [x]
