module TransactionState where

import Control.Concurrent.STM

import Message
import AckPropose
import AckAccept
import Debug.Trace

data LeaderState = LeaderProposal [AckPropose] | LeaderDecision | LeaderAccept [AckAccept] | LeaderDelivery | LeaderFinished deriving (Show)

data FollowerState = FollowerPropose | FollowerAccept | FollowerStable | FollowerFinished deriving (Show)

data TransactionState = Leader (LeaderState)| Follower FollowerState deriving (Show)

processLeaderMessage :: AckMessage -> LeaderState -> LeaderState
processLeaderMessage m s =
  case (m,s) of
    (AckProposeMessage m, LeaderProposal l) -> LeaderProposal $ m:l
    (AckAcceptMessage m, LeaderAccept l)    -> LeaderAccept $ m:l
    _                                       -> trace ("Dropping " ++ show m) s

checkLeaderStateProgress :: LeaderState -> LeaderState
checkLeaderStateProgress s =
  case s of
    LeaderProposal l ->
