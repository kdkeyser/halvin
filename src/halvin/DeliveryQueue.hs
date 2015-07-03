module DeliveryQueue where

import Data.PSQueue as PSQueue
import Transaction
import Commutating

newtype Position = Position Int deriving (Eq, Ord)

newtype DeliveryQueue a = DeliveryQueue (PSQueue.PSQ (Transaction a) Int)

getNonCommutatingTransactions :: (Commutating a) => Transaction a -> DeliveryQueue a -> [Transaction a]
getNonCommutatingTransactions t (DeliveryQueue dq) =
  filter (\x -> (commutates x t) == DoesNotCommutate ) $ map PSQueue.key $ PSQueue.toAscList dq

getHighestPosition :: DeliveryQueue a -> Position
getHighestPosition (DeliveryQueue psq) =
  case PSQueue.findMin psq of
    Nothing -> Position 0
    Just b -> Position $ negate $ PSQueue.prio b