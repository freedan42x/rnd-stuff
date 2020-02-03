module Binary where

open import Data.Nat using (ℕ; zero; suc)

data Bin : Set where
  nil : Bin
  x0_ : Bin → Bin
  x1_ : Bin → Bin

inc : Bin → Bin
inc nil    = x1 nil
inc (x0 n) = x1 n
inc (x1 n) = x0 (inc n)

to : ℕ → Bin
to zero    = x0 nil
to (suc n) = inc (to n)

from : Bin → ℕ
from (x0 nil) = zero
from (inc n)  = suc (from n)
