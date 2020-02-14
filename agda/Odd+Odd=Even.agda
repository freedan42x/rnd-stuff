module Odd+Odd=Even where

open import Data.Nat using (ℕ; zero; suc; _+_)

e+e≡e : ∀ {m n : ℕ}
  → even m
  → even n
    ------------
  → even (m + n)

o+e≡o : ∀ {m n : ℕ}
  → odd m
  → even n
    -----------
  → odd (m + n)

e+e≡e zero     en  =  en
e+e≡e (suc om) en  =  suc (o+e≡o om en)

o+e≡o (suc em) en  =  suc (e+e≡e em en)




o+o≡e : ∀ {m n : ℕ}
  → odd m
  → odd n
    -----------
  → even (m + n)

o+o≡e (suc em) on = suc (e+o≡e em on)
