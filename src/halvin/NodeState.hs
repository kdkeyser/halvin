{-# LANGUAGE TemplateHaskell #-}
module NodeState where

import Control.Lens
import Control.Lens.TH
import Control.Concurrent.STM

import qualified DeliveryQueue as DQ
import qualified TransactionHashMap as THM
import Cluster
import Position
import Transaction

data NodeState a = NodeState {
    _deliveryQueueTVar :: TVar DQ.DeliveryQueue
  , _transactionHashMapTVar :: TVar (THM.TransactionHashMap a)
  }
makeLenses ''NodeState

newNodeState :: STM (NodeState a)
newNodeState = do
    deliveryQueueTVar <- newTVar DQ.empty
    transactionHashMapTVar <- newTVar THM.empty
    return $ NodeState deliveryQueueTVar transactionHashMapTVar

insertTransaction :: NodeState a -> Transaction a -> Position -> STM ()
insertTransaction nodeState transaction position = do
  let dqTVar = nodeState ^. deliveryQueueTVar
  let transHMTVar = nodeState ^. transactionHashMapTVar
  let transactionID = transaction ^. Transaction.id
  modifyTVar dqTVar $ DQ.insert transactionID position
  modifyTVar transHMTVar $ THM.insert transactionID transaction