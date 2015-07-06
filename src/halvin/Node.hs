{-# LANGUAGE TemplateHaskell #-}
module Node where

import Control.Lens
import Control.Lens.TH
import Control.Concurrent.STM

import NodeState
import Cluster
import Position

newtype NodeID = NodeID Integer

data Node a = Node {
    _cluster :: Cluster
  , _id :: NodeID
  , _state :: NodeState a

}
makeLenses ''Node

create :: Cluster -> NodeID -> STM (Node a)
create cluster id = do
    nodeState <- newNodeState
    return $ Node cluster id nodeState

{-
getNextPosition :: Node a -> STM Position
getNextPosition node = do
    currentHighestPosition <- readTVar currentHighestPositionTVar
    let newHighestPosition = (succ currentHighestPosition) `mod` clusterWidth
    writeTVar currentHighestPositionTVar newHighestPosition
    return 0
  where
    currentHighestPositionTVar = node ^. state . highestPosition
    clusterWidth = node ^. cluster . size-}
