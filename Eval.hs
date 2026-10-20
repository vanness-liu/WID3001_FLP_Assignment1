module Eval (eval, binary) where

import Types

-- Stage 3: evaluate a parsed expression (without throwing exceptions).
eval :: Expr -> Either String Double
eval (Lit n) = Right n
eval (Positive e) = eval e
eval (Negative e) = negate <$> eval e
eval (Add a b) = binary (+) a b
eval (Sub a b) = binary (-) a b
eval (Mul a b) = binary (*) a b
eval (Pow a b) = binary (**) a b
eval (Div a b) = do
  numerator <- eval a
  denominator <- eval b
  if abs denominator < 1e-9
     then Left "Division by zero"
     else Right (numerator / denominator)

binary :: (Double -> Double -> Double) -> Expr -> Expr -> Either String Double
binary op a b = do
  x <- eval a
  y <- eval b
  Right (op x y)
