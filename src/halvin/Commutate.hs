module Commutate where

data CommutateResult = Commutates | DoesNotCommutate

class Commutating a where
  commutates :: a -> a -> CommutateResult