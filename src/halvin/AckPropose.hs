module AckPropose where

import Transaction
import Position

data AckPropose a = AckPropose {
    transaction :: Transaction a
  , position :: Position
}