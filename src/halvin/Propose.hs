{-# LANGUAGE TemplateHaskell #-}
module Propose where

import Control.Lens
import Control.Lens.TH

import Transaction
import Position
import Epoch
import NonCommutatingTransactionSet

data Propose a = Propose {
    _dependencies :: NonCommutatingTransactionSet a
  , _epoch :: Epoch
  , _position :: Position
  , _transaction :: Transaction a
  }
makeLenses ''Propose
