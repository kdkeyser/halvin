module DeliveryQueue where

import qualified Data.Set as Set
import qualified Data.PSQueue as PSQueue

import Transaction
import Commutating
import Position
import NonCommutatingTransactionSet

newtype DeliveryQueue = DeliveryQueue (PSQueue.PSQ TransactionID Position)

empty :: DeliveryQueue
empty =
    DeliveryQueue PSQueue.empty

getHighestPosition :: DeliveryQueue -> Position
getHighestPosition (DeliveryQueue psq) =
  case PSQueue.findMin psq of
    Nothing -> 0
    Just b -> negate $ PSQueue.prio b

