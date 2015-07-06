module TransactionState where

import AckPropose
import AckAccept

data SendingStatus = Sending | Sent
data LeaderState = LeaderPropose SendingStatus [AckPropose] | LeaderAccept SendingStatus [AckAccept] | LeaderStable SendingStatus | LeaderFinished
data FollowerState = FollowerPropose | FollowerAccept | FollowerStable | FollowerFinished

data TransactionState = Leader (LeaderState)| Follower FollowerState