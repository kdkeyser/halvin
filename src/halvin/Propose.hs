module Propose where

import Transaction
import Position
import Epoch

data Propose a = Propose {
    transaction :: Transaction a
  , position :: Position
  , dependencies :: [TransactionID]
  , epoch :: Epoch
  }