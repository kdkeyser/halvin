{-# LANGUAGE TypeFamilies #-}

module Main where

data CommutateResult = Commutates | DoesNotCommutate

class Commutating a where
  commutates :: a -> a -> CommutateResult

class Operation a where
  data State a :: *
  apply :: State a -> a b -> (State a, b)

type Node = Integer

type ClusterSize = Integer

data Config = Config (ClusterSize,Node)

data NodeState = NodeState {
    nextPosAvailable :: Integer
  ,
  }


main :: IO ()
main =
  putStrLn "Halvin"
