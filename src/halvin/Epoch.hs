module Epoch where

newtype Epoch = Epoch Int deriving (Eq, Ord)

initial :: Epoch
initial = Epoch 0

next :: Epoch -> Epoch
next (Epoch a) = Epoch $ succ a


