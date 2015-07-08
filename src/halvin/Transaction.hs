{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Transaction where

import Control.Lens
import Control.Lens.TH
import Data.Function
import Data.Hashable

import Commutating
import TransactionState

newtype TransactionID = TransactionID Int deriving(Eq, Ord, Hashable)


data Transaction a = Transaction {
    _id :: TransactionID
  , _operation :: a
  , _transactionState :: TransactionState
  }
makeLenses ''Transaction

(^&^) :: Getting a c a -> (a -> a -> b) -> (c -> c -> b)
(^&^) x y = y `on` view x

onId = (^&^) Transaction.id
onOperation = (^&^) operation

instance Eq (Transaction a) where
  (==) = onId (==)

instance Ord (Transaction a) where
  compare = onId compare

instance (Commutating a) => Commutating (Transaction a) where
  commutates = onOperation commutates

create :: TransactionID -> TransactionState -> a -> Transaction a
create transactionID transactionState operation =
  Transaction transactionID operation transactionState