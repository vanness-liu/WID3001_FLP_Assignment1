module Eval (eval, binary) where

import Types

-- Stage 3: evaluate a parsed expression (without throwing exceptions).
eval :: Expr -> Either String Double
eval (Lit n) = checkFinite n
eval (Positive e) = eval e
eval (Negative e) = negate <$> eval e
eval (Add a b) = binary (+) a b
eval (Sub a b) = binary (-) a b
eval (Mul a b) = binary (*) a b
eval (Pow a b) = do
  base <- eval a
  power <- eval b
  if base == 0 && power < 0
    then Left "Zero cannot be raised to a negative power"
  else if base < 0 && not (isWhole power)
    then Left "Negative base with a non-integer exponent is not supported"
  else checkFinite (base ** power)

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
  checkFinite (op x y)

isWhole :: Double -> Bool
isWhole y = y == fromInteger (truncate y)

checkFinite :: Double -> Either String Double
checkFinite r
  | isNaN r      = Left "Result is not a number"
  | isInfinite r = Left "Result is too large or not finite"
  | otherwise    = Right r

