module TransactionState where

import Control.Concurrent.STM

import Message
import AckPropose
import AckAccept

data LeaderState = LeaderProposal [AckPropose] | LeaderDecision | LeaderAccept [AckAccept] | LeaderDelivery | LeaderFinished

data FollowerState = FollowerPropose | FollowerAccept | FollowerStable | FollowerFinished

data TransactionState = Leader (LeaderState)| Follower FollowerState

processLeaderMessage :: AckMessage -> LeaderState -> LeaderState
processLeaderMessage m s =
  case (m,s) of
    (AckProposeMessage m, LeaderProposal l) -> LeaderProposal $ m:l
    (AckAcceptMessage m, LeaderAccept l)    -> LeaderAccept $ m:l
    _                                       -> s