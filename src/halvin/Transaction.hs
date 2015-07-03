module Transaction where

import Commutating

newtype TransactionID = TransactionID Int deriving(Eq, Ord)

data State = Pending | Accepted | Stable

data Transaction a = Transaction {
    id :: TransactionID
  , operation :: a
  , state :: State
  }

instance Eq (Transaction a) where
  (==) a b = (Transaction.id a) == (Transaction.id b)

instance Ord (Transaction a) where
  compare a b = compare (Transaction.id a) (Transaction.id b)

instance (Commutating a) => Commutating (Transaction a) where
  commutates a b = commutates (operation a) (operation b)


