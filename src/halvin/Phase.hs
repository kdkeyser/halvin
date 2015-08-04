{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleInstances #-}

module Phase where

import AckPropose
import AckAccept
import Position
import Transaction

data Phase = Proposal | Decision | Accept | Delivery | FailureRecovery deriving (Show, Eq)

data Role = Leader | Follower deriving (Show, Eq)

type ConflictingTransactionIDs = [TransactionID]

data LeaderState (a :: Phase) where
  Proposed :: TransactionID -> Position -> ConflictingTransactionIDs -> [AckPropose] -> LeaderState Proposal
  Decided :: TransactionID -> Position -> ConflictingTransactionIDs -> [AckAccept] -> LeaderState Decision
