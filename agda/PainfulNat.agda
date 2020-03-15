module PainfulNat where

open import Data.Bool
open import Relation.Binary.PropositionalEquality
open ≡-Reasoning


postulate
  fun-ext : ∀ {A B : Set} {f g : A → B} → (∀ x → f x ≡ g x) → f ≡ g


data Painfulℕ : Set where
  pain : ∀ zero? → (zero? ≡ false → Painfulℕ) → Painfulℕ

pzero : (true ≡ false → Painfulℕ) → Painfulℕ
pzero = pain true

psuc : Painfulℕ → Painfulℕ
psuc n = pain false λ {refl → n}

_+_ : Painfulℕ → Painfulℕ → Painfulℕ
pain true  _  + n = n
pain false fm + n = psuc (fm refl + n)

+-pzero : ∀ n {p} → n + pzero p ≡ n
+-pzero (pain true _)   = cong (pain true) (fun-ext λ ())
+-pzero (pain false fn) = cong (pain false) (fun-ext λ {refl → +-pzero (fn refl)})

+-psuc : ∀ m n → m + psuc n ≡ psuc (m + n)
+-psuc (pain true _)   _ = refl
+-psuc (pain false fm) n = cong psuc (+-psuc (fm refl) n)

+-pcomm : ∀ m n → m + n ≡ n + m
+-pcomm (pain true _)   n = sym (+-pzero n)
+-pcomm (pain false fm) n = sym (
  begin
    n + pain false fm
  ≡⟨ cong (λ fm → n + pain false fm) (fun-ext λ {refl → refl}) ⟩
    n + psuc (fm refl)
  ≡⟨ +-psuc n (fm refl) ⟩
    psuc (n + fm refl)
  ≡⟨ cong psuc (sym (+-pcomm (fm refl) n)) ⟩
    psuc (fm refl) + n
  ∎)
