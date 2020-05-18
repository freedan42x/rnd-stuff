module group where

open import Data.Product
open import Data.Integer
open import Data.Integer.Properties
open import Relation.Binary.PropositionalEquality


record Group (G : Set) (_∙_ : G → G → G) : Set where
  field
    idElem : G
    invert : G → G
    -- closure already implied by _∙_ type signature ?
    assoc : ∀ (a b c : G) → (a ∙ b) ∙ c ≡ a ∙ (b ∙ c)
    idˡ : ∀ (a : G) → idElem ∙ a ≡ a
    idʳ : ∀ (a : G) → a ∙ idElem ≡ a
    invˡ : ∀ (a : G) → invert a ∙ a ≡ idElem
    invʳ : ∀ (a : G) → a ∙ invert a ≡ idElem


ℤ-Group : Group ℤ _+_
ℤ-Group = record
  { idElem = 0ℤ
  ; invert = -_
  ; assoc = +-assoc
  ; idˡ = +-identityˡ
  ; idʳ = +-identityʳ
  ; invˡ = +-inverseˡ
  ; invʳ = +-inverseʳ
  }
