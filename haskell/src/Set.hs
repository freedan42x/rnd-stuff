module Set where

import           Data.Functor.Const


data SBool a where
  STrue :: SBool True
  SFalse :: SBool False


class Truthful a where
  type BoolRep a
  truth :: BoolRep a ~ SBool True => a


newtype Set prop =
  Pred { elemS :: ∀ a. prop a
       }

newtype Obj cat =
  Obj { getObj :: ∀ a. Truthful a => Set (Const a)
      }
