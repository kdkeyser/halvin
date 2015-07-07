{-# LANGUAGE ScopedTypeVariables #-}

module TransactionHashMap where

import qualified Data.HashMap.Strict as HashMap
import qualified Data.Foldable as Foldable
import qualified Data.Set as Set

import Data.Maybe

import Transaction
import Commutating
import NonCommutatingTransactionSet

type TransactionHashMap a = (HashMap.HashMap TransactionID (Transaction a))

empty = HashMap.empty

{-getNonCommutatingTransactions :: (Commutating a, Foldable.Foldable b) => Transaction a -> b TransactionID -> TransactionHashMap a -> NonCommutatingTransactionSet a
getNonCommutatingTransactions transaction transactionIDs thm =
    Foldable.foldl (\set transactionID ->
      let (Just t) = HashMap.lookup transactionID thm in
      if commutates t transaction == DoesNotCommutate
      then
        Set.insert t set
      else
        set
    ) Set.empty transactionIDs-}

insert :: TransactionID -> Transaction a -> TransactionHashMap a -> TransactionHashMap a
insert = HashMap.insert