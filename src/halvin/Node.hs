module Node where

import Control.Concurrent.STM
import DeliveryQueue
import Cluster
import Transaction

newtype NodeID = NodeID Integer

data NodeState a = NodeState {
    deliveryQueue :: TVar (DeliveryQueue a)
  }

data Node a = Node {
    state :: NodeState a
  , id :: NodeID
  , cluster :: Cluster
}

getNextPosAvailable

submit :: a -> Transaction a
submit action =
  undefined