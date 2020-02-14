module OddsAndEvens3 where

open import Data.Nat
open import Data.Empty


data Even : ℕ → Set
data Odd  : ℕ → Set

data Even where
  zero : Even zero
  suc  : ∀ {n : ℕ} → Odd n → Even (suc n)

data Odd where
  suc : ∀ {n : ℕ} → Even n → Odd (suc n)


postulate
  impossible : ⊥


impossible₁ : Odd 0
impossible₁ = ⊥-elim impossible

impossible₂ : Even 1
impossible₂ = ⊥-elim impossible


infix 6 _e∸1 _o∸1
_e∸1 : ∀ {n : ℕ} → Even n → Odd  (n ∸ 1)
_o∸1 : ∀ {n : ℕ} → Odd  n → Even (n ∸ 1)

zero e∸1 = ⊥-elim impossible
suc n e∸1 = n

suc n o∸1 = n


pred-even : ∀ {n : ℕ} → Even n → Even (n ∸ 2)
pred-odd  : ∀ {n : ℕ} → Odd  n → Odd  (n ∸ 2)

pred-even zero = zero
pred-even (suc (suc n)) = n

pred-odd (suc zero) = ⊥-elim impossible
pred-odd (suc (suc n)) = n


infixl 6 _e∸e_ _o∸o_
_e∸e_ : ∀ {m n : ℕ} → Even m → Even n → Even (m ∸ n)
_o∸o_ : ∀ {m n : ℕ} → Odd  m → Odd  n → Even (m ∸ n)

m e∸e zero = m
zero e∸e _ = ⊥-elim impossible
suc m e∸e suc n = m o∸o n

suc m o∸o suc n = m e∸e n


_e∸o_ : ∀ {m n : ℕ} → Even m → Odd  n → Odd (m ∸ n)
_o∸e_ : ∀ {m n : ℕ} → Odd  m → Even n → Odd (m ∸ n)

zero e∸o _ = ⊥-elim impossible
suc m e∸o suc n = m o∸e n

m o∸e zero = m
suc m o∸e suc n = m e∸o n
