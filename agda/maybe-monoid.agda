module maybe-monoid where

open import Data.Maybe
open import Relation.Binary.PropositionalEquality
open import Function


data Maybe' (A : Set) : Set where
  maybe' : Maybe A → Maybe' A


record Monoid (A : Set) : Set where
  field
    ∅ : A
    _<>_ : A → A → A
    <>-identityˡ : ∀ (x : A) → ∅ <> x ≡ x
    <>-identityʳ : ∀ (x : A) → x <> ∅ ≡ x
    <>-assoc : ∀ (x y z : A) → x <> (y <> z) ≡ (x <> y) <> z
open Monoid ⦃ ... ⦄


instance
  MaybeMonoid : ∀ {A} ⦃ _ : Monoid A ⦄ → Monoid (Maybe A)
  ∅ ⦃ MaybeMonoid ⦄ = nothing
  _<>_ ⦃ MaybeMonoid ⦄ nothing y = y
  _<>_ ⦃ MaybeMonoid ⦄ (just x) nothing = just x
  _<>_ ⦃ MaybeMonoid ⦄ (just x) (just y) = just (x <> y)
  <>-identityˡ ⦃ MaybeMonoid ⦄ _ = refl
  <>-identityʳ ⦃ MaybeMonoid ⦄ nothing = refl
  <>-identityʳ ⦃ MaybeMonoid ⦄ (just _) = refl
  <>-assoc ⦃ MaybeMonoid ⦄ nothing _ _ = refl
  <>-assoc ⦃ MaybeMonoid ⦄ (just _) nothing _ = refl
  <>-assoc ⦃ MaybeMonoid ⦄ (just _) (just _) nothing = refl
  <>-assoc ⦃ MaybeMonoid ⦄ (just x) (just y) (just z) = cong just (<>-assoc x y z)

  Maybe'Monoid : ∀ {A} ⦃ _ : Monoid A ⦄ → Monoid (Maybe' A)
  ∅ ⦃ Maybe'Monoid ⦄ = maybe' (just ∅)
  _<>_ ⦃ Maybe'Monoid ⦄ (maybe' (just x)) (maybe' (just y)) = maybe' (just (x <> y))
  _<>_ ⦃ Maybe'Monoid ⦄ _ _ = maybe' nothing 
  <>-identityˡ ⦃ Maybe'Monoid ⦄ (maybe' nothing) = refl
  <>-identityˡ ⦃ Maybe'Monoid ⦄ (maybe' (just x)) = cong (maybe' ∘ just) (<>-identityˡ x)
  <>-identityʳ ⦃ Maybe'Monoid ⦄ (maybe' nothing) = refl
  <>-identityʳ ⦃ Maybe'Monoid ⦄ (maybe' (just x)) = cong (maybe' ∘ just) (<>-identityʳ x)
  <>-assoc ⦃ Maybe'Monoid ⦄ (maybe' nothing) (maybe' nothing) (maybe' nothing) = refl
  <>-assoc ⦃ Maybe'Monoid ⦄ (maybe' nothing) (maybe' nothing) (maybe' (just _)) = refl
  <>-assoc ⦃ Maybe'Monoid ⦄ (maybe' nothing) (maybe' (just _)) (maybe' nothing) = refl
  <>-assoc ⦃ Maybe'Monoid ⦄ (maybe' nothing) (maybe' (just _)) (maybe' (just _)) = refl
  <>-assoc ⦃ Maybe'Monoid ⦄ (maybe' (just _)) (maybe' nothing) (maybe' nothing) = refl
  <>-assoc ⦃ Maybe'Monoid ⦄ (maybe' (just _)) (maybe' nothing) (maybe' (just _)) = refl
  <>-assoc ⦃ Maybe'Monoid ⦄ (maybe' (just _)) (maybe' (just _)) (maybe' nothing) = refl
  <>-assoc ⦃ Maybe'Monoid ⦄ (maybe' (just x)) (maybe' (just y)) (maybe' (just z)) =
    cong (maybe' ∘ just) (<>-assoc x y z)
