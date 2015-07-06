{-# LANGUAGE TemplateHaskell #-}
module NodeState where

import Control.Lens
import Control.Lens.TH
import Control.Concurrent.STM

import DeliveryQueue
import TransactionHashMap
import Cluster
import Position

data NodeState a = NodeState {
    _deliveryQueueTVar :: TVar DeliveryQueue
  , _highestPosition :: TVar Position
  , _transactionHashMap :: TVar (TransactionHashMap a)
  }
makeLenses ''NodeState

newNodeState :: STM (NodeState a)
newNodeState = do
    deliveryQueueTVar <- newTVar DeliveryQueue.empty
    highestPosition <- newTVar 0
    transactionHashMap <- newTVar TransactionHashMap.empty
    return $ NodeState deliveryQueueTVar highestPosition transactionHashMap