module Types (Token(..), Expr(..)) where

data Token
  = Number Double | Plus | Minus | Times | Divide | Power
  | FloorDivide | Modulo | Open | Close
  deriving (Eq, Show)

data Expr
  = Lit Double | Positive Expr | Negative Expr
  | Add Expr Expr | Sub Expr Expr
  | Mul Expr Expr | Div Expr Expr | Pow Expr Expr
  deriving (Eq, Show)
