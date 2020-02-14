module Lists where

open import Data.Nat using (ℕ; zero; suc; _+_)

infixr 40 _::_
data List (A : Set) : Set where
  []   : List A
  _::_ : A -> List A -> List A

map : {A B : Set} -> (A -> B) -> List A -> List B
map f []        = []
map f (x :: xs) = f x :: map f xs

infixr 40 _++_
_++_ : {A : Set} -> List A -> List A -> List A
[] ++ ys        = ys
(x :: xs) ++ ys = x :: (xs ++ ys)

filter : {A : Set} -> (A -> Bool) -> List A -> List A
filter f [] = []
filter f (x :: xs) with f x
... | true  = x :: filter f xs
... | false = filter f xs

every : {A : Set} -> (A -> Bool) -> List A -> Bool
every f []  = true
every f (x :: xs) with f x
... | true  = every f xs
... | false = false

any : {A : Set} -> (A -> Bool) -> List A -> Bool
any f []    = false
any f (x :: xs) with f x
... | true  = true
... | false = any f xs

length : {A : Set} -> List A -> Nat
length []        = zero
length (x :: xs) = suc (length xs)

max : Nat -> Nat -> Nat
max zero n          = n
max m zero          = m
max (suc m) (suc n) = suc (max m n)

min : Nat -> Nat -> Nat
min m n with max m n
... | m = n
... | n = m

maximum : {A : Set} -> List A -> Nat
maximum []        = zero
maximum (x :: xs) = max x (maximum xs)

minimum : {A : Set} -> List A -> Nat
minimum []          ()
minimum (x :: xs) = min x (minimum xs)

reverse : {A : Set} -> List A -> List A
reverse []        = []
reverse (x :: xs) = reverse xs ++ (x :: [])

sort-asc : {A : Set} -> List A -> List A
sort-asc []        = []
sort-asc (x :: xs) = minimum (x :: xs) :: sort-asc xs

sort-desc : {A : Set} -> List A -> List A
sort-desc xs = reverse (sort-asc xs)

take : {A : Set} -> Nat -> List A -> List A
take _   [] = []
take zero _ = []
take (suc n) (x :: xs) = x :: take n xs

takeWhile : {A : Set} -> (A -> Bool) -> List A -> List A
takeWhile f xs = filter (not f) xs

sum : {A : Set} -> List A -> Nat
sum []        = zero
sum (x :: xs) = x + sum xs
