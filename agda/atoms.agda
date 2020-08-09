module atoms where

open import Data.Nat
open import Data.Product
open import Data.List
open import Relation.Binary.PropositionalEquality
open import Function



data Valence : Set where
  I II III IV V VI VII VIII : Valence


fromValence : Valence → ℕ
fromValence v = case v of λ
  { I → 1
  ; II → 2
  ; III → 3
  ; IV → 4
  ; V → 5
  ; VI → 6
  ; VII → 7
  ; VIII → 8
  }


private
  variable
    v : Valence


data Atom : Valence → Set where
  H Li : Atom I
  O Zn Cu : Atom II
  C : Atom IV


data Molecule : Set where
  ix : Atom v → ℕ → Molecule
  _∙_ : Molecule → Molecule → Molecule
  coef : ℕ → Molecule → Molecule


single : Atom v → Molecule
single atom = ix atom 1


data _+_⇒_+_ : Molecule → Molecule → Molecule → Molecule → Set where
  sameVal : ∀ {X Y : Atom II} {n} → ix X n + ix Y n ∙ ix O n ⇒ ix X n ∙ ix O n + ix Y n
  

w : ix Cu 
