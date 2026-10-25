module Parser
  ( Parser
  , parseExpression, parseSum, parseProduct, parsePower, parseUnary, parseAtom
  ) where

import Types

-- Stage 2: construct an expression tree.
-- Each parser returns the expression and tokens still available.
type Parser = [Token] -> Either String (Expr, [Token])

parseExpression :: Parser
parseExpression = parseSum

parseSum :: Parser
parseSum ts = do
  (first, rest) <- parseProduct ts
  continue first rest
  where
    continue lhs (Plus:ts) = do
      (rhs, rest) <- parseProduct ts
      continue (Add lhs rhs) rest
    continue lhs (Minus:ts) = do
      (rhs, rest) <- parseProduct ts
      continue (Sub lhs rhs) rest
    continue lhs rest = Right (lhs, rest)

parseProduct :: Parser
parseProduct ts = do
  (first, rest) <- parseUnary ts
  continue first rest
  where
    continue lhs (Times:ts) = do
      (rhs, rest) <- parseUnary ts
      continue (Mul lhs rhs) rest
    continue lhs (Divide:ts) = do
      (rhs, rest) <- parseUnary ts
      continue (Div lhs rhs) rest
    continue lhs rest = Right (lhs, rest)

parsePower :: Parser
parsePower ts = do
  (first, rest) <- parseAtom ts
  case rest of 
    Power:remaining -> do
      (rhs, rest) <- parseUnary remaining
      Right (Pow first rhs, rest)
    _ -> Right (first, rest)


parseUnary :: Parser
parseUnary (Plus:ts) = do
  (expr, rest) <- parseUnary ts
  Right (Positive expr, rest)
parseUnary (Minus:ts) = do
  (expr, rest) <- parseUnary ts
  Right (Negative expr, rest)
parseUnary ts = parsePower ts

parseAtom :: Parser
parseAtom (Number n:ts) = Right (Lit n, ts)
parseAtom (Open:ts) = do
  (expr, rest) <- parseExpression ts
  case rest of
    Close:remaining -> Right (expr, remaining)
    []              -> Left "Missing closing parenthesis"
    _               -> Left "Unexpected input inside parentheses"
parseAtom _ = Left "Expected a number or '('"
