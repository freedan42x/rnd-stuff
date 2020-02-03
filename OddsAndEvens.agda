module OddsAndEvens where

open import Data.Nat
open import Relation.Binary.PropositionalEquality
open import Data.Empty

data Even : ℕ → Set where
  zero-even : Even 0
  -- | If n is even, then n + 2 is also even.
  next-even : ∀ {n : ℕ}
              → Even n
              --------
              → Even (2 + n)

data Odd : ℕ → Set where
  one-odd  : Odd 1
  -- | If n is odd, then n + 2 is also odd.
  next-odd : ∀ {n : ℕ}
             → Odd n
             -------
             → Odd (2 + n)

-- | If n is even, then n + 1 is odd.
even+1 : ∀ {n : ℕ} → Even n → Odd (1 + n)
even+1 zero-even     = one-odd
even+1 (next-even n) = next-odd (even+1 n)

-- | If n is odd, then n + 1 is even.
odd+1 : ∀ {n : ℕ} → Odd n → Even (1 + n)
odd+1 one-odd      = next-even zero-even
odd+1 (next-odd n) = next-even (odd+1 n)

-- | If m and n are even, then m + n is also even.
even+even : ∀ {m n : ℕ} → Even m → Even n → Even (m + n)
even+even zero-even n     = n
even+even (next-even m) n = next-even (even+even m n)

-- | If m and n are odd, then m + n is odd.
odd+odd : ∀ {m n : ℕ} → Odd m → Odd n → Even (m + n)
odd+odd one-odd n      = odd+1 n
odd+odd (next-odd m) n = next-even (odd+odd m n)

-- | If m is even and n is odd, then m + n is odd.
even+odd : ∀ {m n : ℕ} → Even m → Odd n → Odd (m + n)
even+odd zero-even n     = n
even+odd (next-even m) n = next-odd (even+odd m n)

-- | If m is odd and n is even, then m + n is odd.
odd+even : ∀ {m n : ℕ} → Odd m → Even n → Odd (m + n)
odd+even one-odd n      = even+1 n
odd+even (next-odd m) n = next-odd (odd+even m n)

pred-odd : ∀ {n : ℕ} → n ≢ 1 → Odd n → Odd (n ∸ 2)
pred-odd n≠1 one-odd    = ⊥-elim (n≠1 refl)
pred-odd _ (next-odd n) = n

pred-even : ∀ {n : ℕ} → n ≢ 0 → Even n → Even (n ∸ 2)
pred-even n≠0 zero-even   = ⊥-elim (n≠0 refl)
pred-even _ (next-even n) = n

-- | If n is even, then n - 1 is odd.
even∸1 : ∀ {n : ℕ} → n ≢ 0 → Even n → Odd (n ∸ 1)
even∸1 n≠0 zero-even                       = ⊥-elim (n≠0 refl)
even∸1 {2} _ (next-even n)                 = one-odd
even∸1 {suc (suc (suc _))} _ (next-even n) = next-odd (even∸1 (λ ()) n)

-- odd∸1 : ∀ {n : ℕ} → Odd n → Even (n ∸ 1)
-- odd∸1 one-odd                          = zero-even
-- odd∸1 {suc (suc (suc _))} (next-odd n) = next-even (odd∸1 n)

even∸even : ∀ {m n : ℕ} → Even m → Even n → Even (m ∸ n)
even∸even m zero-even                 = m
even∸even zero-even (next-even n)     = zero-even
even∸even (next-even m) (next-even n) = even∸even m n
