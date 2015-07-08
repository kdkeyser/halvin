{-# LANGUAGE TemplateHaskell #-}
module Node where

import Control.Lens
import Control.Lens.TH
import Control.Concurrent.STM

import NodeState
import Cluster
import Position
import Commutating
import qualified Transaction
import qualified TransactionState
import qualified DeliveryQueue as DQ

newtype NodeID = NodeID Int

data Node a = Node {
    _cluster :: Cluster
  , _id :: NodeID -- zero based ID, i.e. nodes 0,1,2,...,N-1
  , _state :: NodeState a

}
makeLenses ''Node

--Some helper accessors
deliveryQueue :: Node a -> STM DQ.DeliveryQueue
deliveryQueue node =
  readTVar $ node ^. state . deliveryQueueTVar

create :: Cluster -> NodeID -> STM (Node a)
create cluster id = do
    nodeState <- newNodeState
    return $ Node cluster id nodeState

calcNextPosition :: Int -> Int -> Int -> Int
calcNextPosition currentPosition width position =
    let lambda = succ currentPosition `mod` width in
    let delta = if lambda <= position then position - lambda else width - lambda + position in
    currentPosition + delta + 1

-- If you use the position obtained from this call, you need to atomically add the associated transaction to the deliveryQueue
getNextPosition :: Node a -> STM Position
getNextPosition node = do
    dq <- deliveryQueue node
    return $ calcNextPosition (DQ.getHighestPosition dq) clusterWidth nodePositionNr
  where
    (NodeID nodePositionNr) = node ^. Node.id
    clusterWidth = node ^. cluster . size

submitTransaction :: (Commutating a) => Node a -> a -> Transaction.TransactionID -> STM ()
submitTransaction node operation transactionID = do
    position <- getNextPosition node
    let transactionState = TransactionState.Leader $ TransactionState.LeaderPropose TransactionState.Sending []
    let transaction = Transaction.create transactionID transactionState operation
    insertTransaction (node ^. state) transaction position
    return ()

