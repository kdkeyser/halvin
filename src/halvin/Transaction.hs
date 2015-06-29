module Transaction where

data TransactionID = TransactionID

data Transaction a = Transaction {
    id :: TransactionID
  , operation :: a
  }

data State = Pending | Accepted | Stable

