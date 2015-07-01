module DeliveryQueue where

import Data.PSQueue as PSQueue
import Transaction
import Commutate

data DeliveryQueue a = DeliveryQueue (Transaction a) Position

getNonCommutatingTransactions :: (Commutate a) => Transaction a -> DeliveryQueue a -> [Transaction a]
getNonCommuatingTransactions t dq =
  PSQueue.