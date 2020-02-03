module Commutativity where

open import Data.Nat using (ℕ; zero; suc; _+_)
open import Data.Nat.Properties using (+-assoc)
import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; cong; trans; sym)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _≡⟨_⟩_; _∎)

+-identityʳ : ∀ (m : ℕ) → m + zero ≡ m
+-identityʳ zero =
  begin
    zero + zero
  ≡⟨⟩
    zero
  ∎
+-identityʳ (suc m) =
  begin
    suc m + zero
  ≡⟨⟩
    suc (m + zero)
  ≡⟨ cong suc (+-identityʳ m) ⟩
    suc m
  ∎

+-suc : ∀ (m n : ℕ) → m + suc n ≡ suc (m + n)
+-suc zero n =
  begin
    zero + suc n
  ≡⟨⟩
    suc n
  ≡⟨⟩
    suc (zero + n)
  ∎
+-suc (suc m) n =
  begin
    suc m + suc n
  ≡⟨⟩
    suc (m + suc n)
  ≡⟨ cong suc (+-suc m n) ⟩ 
    suc (suc (m + n))
  ≡⟨⟩
    suc (suc m + n)
  ∎

+-comm : ∀ (m n : ℕ) → m + n ≡ n + m
+-comm m zero =
  begin
    m + zero
  ≡⟨ +-identityʳ m ⟩
    m
  ≡⟨⟩
    zero + m
  ∎
+-comm m (suc n) =
  begin
    m + suc n
  ≡⟨ +-suc m n⟩
    suc (m + n)
  ≡⟨ cong suc (+-comm m n) ⟩
    suc (n + m)
  ≡⟨⟩
    suc n + m
  ∎


*-zero : ∀ (n : ℕ) → zero ≡ n * zero
*-zero zero = refl
*-zero (suc n) = *-zero n

*-suc : ∀ (m n : ℕ) → m * suc n ≡ m + m * n
*-suc zero n = refl
*-suc (suc m) n = cong suc (sym (
  begin
    m + (n + m * n)
  ≡⟨ +-comm m (n + m * n) ⟩
    n + m * n + m
  ≡⟨ +-assoc n (m * n) m ⟩
    n + ((m * n) + m)
  ≡⟨ cong (n +_) (sym (trans (*-suc m n) (+-comm m (m * n)))) ⟩
    n + m * suc n
  ∎))

*-comm : ∀ (m n : ℕ) → m * n ≡ n * m
*-comm zero n = *-zero n
*-comm (suc m) n rewrite *-suc n m = cong (n +_) (*-comm m n)
