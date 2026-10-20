module Evaluator (evaluate) where

import Lexer
import Parser
import Eval

-- Public function: use this in GHCi or in your own experiments.
evaluate :: String -> Either String Double
evaluate input = do
  tokens <- tokenize input
  (expr, _unused) <- parseExpression tokens
  eval expr
