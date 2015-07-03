module Commutating where

data CommutateResult = Commutates | DoesNotCommutate deriving (Eq)

class Commutating a where
  commutates :: a -> a -> CommutateResult