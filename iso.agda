module iso where

open import Data.Unit
open import Data.List
open import Data.Nat
open import Data.Sum
open import Data.Maybe

open import Relation.Binary.PropositionalEquality

infix 0 _≃_
record _≃_ (A B : Set) : Set where
  constructor iso
  field
    A→B   : A → B
    B→A   : B → A
    A→B→A : ∀ x → A→B (B→A x) ≡ x
    B→A→B : ∀ x → B→A (A→B x) ≡ x


[⊤]≃ℕ : List ⊤ ≃ ℕ
[⊤]≃ℕ = iso to from to∘from from∘to
  where
    to : List ⊤ → ℕ
    to []       = zero
    to (_ ∷ ts) = suc (to ts)

    from : ℕ → List ⊤
    from zero    = []
    from (suc n) = tt ∷ from n

    to∘from : ∀ n → to (from n) ≡ n
    to∘from zero    = refl 
    to∘from (suc n) = cong suc (to∘from n)
  
    from∘to : ∀ ts → from (to ts) ≡ ts
    from∘to []        = refl
    from∘to (tt ∷ ts) = cong (tt ∷_) (from∘to ts)


maybeA≃⊤⊎A : {A : Set} → Maybe A ≃ ⊤ ⊎ A
maybeA≃⊤⊎A = iso to from to∘from from∘to
  where
    to : {A : Set} → Maybe A → ⊤ ⊎ A
    to nothing  = inj₁ tt
    to (just x) = inj₂ x

    from : {A : Set} → ⊤ ⊎ A → Maybe A
    from (inj₁ tt) = nothing
    from (inj₂ x)  = just x

    to∘from : {A : Set} (x : ⊤ ⊎ A) → to (from x) ≡ x
    to∘from (inj₁ tt) = refl
    to∘from (inj₂ _)  = refl

    from∘to : {A : Set} (x : Maybe A) → from (to x) ≡ x
    from∘to nothing  = refl
    from∘to (just _) = refl
