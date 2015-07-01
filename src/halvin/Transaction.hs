module Transaction where

import Commutate

newtype TransactionID = TransactionID Int deriving(Ord)

data Transaction a = Transaction {
    id :: TransactionID
  , operation :: a
  } deriving(Ord)

instance (Commuate a) => Commutate (Transaction a) where
  commutates a b = commutates (operation a) (operation b)

data State = Pending | Accepted | Stable

