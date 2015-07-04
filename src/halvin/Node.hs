{-# LANGUAGE TemplateHaskell #-}
module Node where

import Control.Lens
import Control.Lens.TH
import Control.Concurrent.STM

import DeliveryQueue
import Cluster
import Transaction

newtype NodeID = NodeID Integer

data NodeState a = NodeState {
    _deliveryQueueTVar :: TVar (DeliveryQueue a)
  }
makeLenses ''NodeState

data Node a = Node {
    _cluster :: Cluster
  , _id :: NodeID
  , _state :: NodeState a

}
makeLenses ''Node

create :: Cluster -> NodeID -> STM (Node a)
create cluster id = do
    deliveryQueueTVar <- newTVar DeliveryQueue.empty
    return $ Node cluster id $ NodeState deliveryQueueTVar