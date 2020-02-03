{-# LANGUAGE GADTs, ConstraintKinds #-}

module Implication where

-- | If `x` implies `y`, then `x` = `y`.
type Implies x y = x -> y

-- | We will use reflexivity in some cases to show that statement is correct.
refl :: x ~ y => x -> y
refl = id

-- | Value of type `x` implies `x`.
impl_x :: y ~ x => Implies y x
impl_x = refl

-- | Value `y` of any type implies `y` itself.
impl_y :: y ~ x => Implies x y
impl_y = refl

-- | Implementation of isomorphic type equality.
type ISO x y = (x ~ y, y ~ x)

-- | Isomorphism implies equality.
iso_impl :: ISO x y => Implies x y
iso_impl = refl

-- | Implication is reflexive.
impl_refl :: Implies x x
impl_refl = refl

-- | Implication is symmetric(and/or isomorphic?).
impl_sym :: ISO x y => Implies x y -> Implies y x
impl_sym = refl

-- | Applying double symmetric to implication gives implication itself.
symsym_x :: i -> impl_sym (impl_sym i) -> i
symsym_x = const

-- | Reflexivity is implication.
refl_impl :: x ~ y => impl_refl -> Implies x y
refl_impl _ = impl_y

-- | Implication is transitive.
impl_trans :: x ~ y => Implies x y -> Implies y z -> Implies x z
impl_trans _ = refl
