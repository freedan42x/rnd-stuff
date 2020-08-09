module Parser where

import           Data.Char                      ( isAlpha )
import           Data.Tuple                     ( swap )
import           Control.Arrow                  ( second )
import           Control.Applicative
import           Control.Monad                  ( void )



newtype Parser a =
  P { runP :: String -> [(String, a)] }


instance Functor Parser where
  fmap f (P p) = P $ \s -> second f <$> p s


instance Applicative Parser where
  pure x = P $ \s -> [(s, x)]
  P pf <*> P p = P $ \s -> [ (r', f x) | (r, f) <- pf s, (r', x) <- p r ]


instance Alternative Parser where
  empty = P $ const []
  P p1 <|> P p2 = P $ \s -> p1 s <> p2 s


instance Monad Parser where
  P p >>= f = P $ \s -> p s >>= \(r, x) -> runP (f x) r



parse :: Parser a -> String -> Maybe a
parse (P p) s = helper (p s)
 where
  helper = \case
    ("", x) : xs -> Just x
    _       : xs -> helper xs
    _            -> Nothing


predC :: (Char -> Bool) -> Parser Char
predC p = P $ \case
  (x : xs) | p x -> [(xs, x)]
  _              -> []


char :: Char -> Parser Char
char = predC . (==)


string :: String -> Parser String
string = sequence . map char


identifier :: Parser String
identifier = P $ \s -> [swap $ span isAlpha s]


spaces :: Parser ()
spaces = void $ some $ char ' '


parens :: Parser a -> Parser a
parens p = do
  par1 <- many $ char '('
  x    <- p
  par2 <- many $ char ')'
  if length par1 == length par2 then pure x else empty
