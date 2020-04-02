module CanOne where

open import Function
open import Data.Nat
open import Data.Nat.Properties
open import Relation.Binary.PropositionalEquality
open ≡-Reasoning


data Bin : Set where
  ⟨⟩ : Bin
  _O : Bin → Bin
  _I : Bin → Bin

inc : Bin → Bin
inc ⟨⟩ = ⟨⟩ I
inc (n O) = n I
inc (n I) = inc n O

double : Bin → Bin
double ⟨⟩ = ⟨⟩
double (n O) = double n O
double (n I) = n I O

to : ℕ → Bin
to zero = ⟨⟩ O
to (suc n) = inc (to n)

from : Bin → ℕ
from ⟨⟩ = zero
from (n O) = 2 * from n
from (n I) = suc (2 * from n)


data One : Bin → Set where
  𝟙⟨⟩ : One (⟨⟩ I)
  _𝟙-O : ∀ {b} → One b → One (b O)
  _𝟙-I : ∀ {b} → One b → One (b I)

data Can : Bin → Set where
  canZ : Can (⟨⟩ O)
  One→Can : ∀ {b} → One b → Can b

oneS : ∀ {b} → One b → One (inc b)
oneS 𝟙⟨⟩ = 𝟙⟨⟩ 𝟙-O
oneS (n 𝟙-O) = n 𝟙-I
oneS (n 𝟙-I) = oneS n 𝟙-O

canS : ∀ {b} → Can b → Can (inc b)
canS canZ = One→Can 𝟙⟨⟩
canS (One→Can n) = One→Can (oneS n)

ℕ→Can : ∀ n → Can (to n)
ℕ→Can zero = canZ
ℕ→Can (suc n) = canS (ℕ→Can n)

double≡O : ∀ {b} → One b → double b ≡ b O
double≡O 𝟙⟨⟩ = refl
double≡O (n 𝟙-O) = cong _O (double≡O n)
double≡O (_ 𝟙-I) = refl

inc∘double≡I : ∀ {b} → One b → inc (double b) ≡ b I
inc∘double≡I 𝟙⟨⟩ = refl
inc∘double≡I (n 𝟙-O) = cong _I (double≡O n)
inc∘double≡I (_ 𝟙-I) = refl


2+2*b≡2*[1+b]-One : ∀ {b} → One b → inc (inc (double b)) ≡ double (inc b)
2+2*b≡2*[1+b]-One 𝟙⟨⟩ = refl
2+2*b≡2*[1+b]-One (n 𝟙-O) = cong _O (inc∘double≡I n)
2+2*b≡2*[1+b]-One (n 𝟙-I) = cong _O (sym (double≡O (oneS n)))

2+2*b≡2*[1+b]-Can : ∀ {b} → Can b → inc (inc (double b)) ≡ double (inc b)
2+2*b≡2*[1+b]-Can canZ = refl
2+2*b≡2*[1+b]-Can (One→Can n) = 2+2*b≡2*[1+b]-One n

to[2*n]≡2*to[n] : ∀ n → to (2 * n) ≡ double (to n)
to[2*n]≡2*to[n] zero = refl
to[2*n]≡2*to[n] (suc n) =
  begin
    inc (to (n + suc (n + 0)))
  ≡⟨ cong (inc ∘ to) (+-suc n (n + zero)) ⟩
    inc (inc (to (2 * n)))
  ≡⟨ cong (inc ∘ inc) (to[2*n]≡2*to[n] n) ⟩
    inc (inc (double (to n)))
  ≡⟨ 2+2*b≡2*[1+b]-Can (ℕ→Can n) ⟩
    double (inc (to n))
  ∎

one-to∘from : ∀ {b} → One b → to (from b) ≡ b
one-to∘from 𝟙⟨⟩ = refl
one-to∘from {(b O)} (n 𝟙-O) =
  begin
    to (2 * from b)
  ≡⟨ to[2*n]≡2*to[n] (from b) ⟩
    double (to (from b))
  ≡⟨ cong double (one-to∘from n) ⟩
    double b
  ≡⟨ double≡O n ⟩
    b O
  ∎
one-to∘from {b I} (n 𝟙-I) =
  begin
    inc (to (2 * from b))
  ≡⟨ cong inc (to[2*n]≡2*to[n] (from b)) ⟩
    inc (double (to (from b)))
  ≡⟨ cong (inc ∘ double) (one-to∘from n) ⟩
    inc (double b)
  ≡⟨ inc∘double≡I n ⟩
    b I
  ∎

can-to∘from : ∀ {b} → Can b → to (from b) ≡ b
can-to∘from canZ = refl
can-to∘from (One→Can n) = one-to∘from n
