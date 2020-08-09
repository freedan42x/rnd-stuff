module Lambda where

import           Parser
import           Control.Applicative



data Expr
  = Var String
  | Lam String Expr
  | App Expr [Expr]
  deriving Show

data Statement
  = Let String Expr
  | MkType String [String] Type
  deriving Show

type Code = [Statement]

data Type
  = TVar String
  | TFun Type Type
  deriving Show

type Ctx = [(String, Type)]


--inferType :: Expr -> Ctx -> a
--inferType (Var s) = _


varP :: Parser Expr
varP = do
  name <- identifier
  pure $ Var name


lamP :: Parser Expr
lamP = do
  arg <- identifier
  spaces
  string "=>"
  spaces
  expr <- exprP
  pure $ Lam arg expr


appP :: Parser Expr
appP = do
  expr1 <- exprP
  exprs <- some $ spaces *> exprP
  pure $ App expr1 exprs


exprP :: Parser Expr
exprP = parens $ varP <|> lamP <|> appP


statementP :: Parser Statement
statementP = do
  name <- identifier
  spaces
  char '='
  spaces
  expr <- exprP
  pure $ Let name expr


codeP :: Parser Code
codeP = do
  st  <- statementP
  sts <- many $ char '\n' *> statementP
  pure $ st : sts
