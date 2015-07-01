{-# LANGUAGE TypeFamilies #-}

module Main where


class Operation a where
  data State a :: *
  apply :: State a -> a b -> (State a, b)

type Node = Integer

type ClusterSize = Integer

data Config = Config (ClusterSize,Node)

data NodeState = NodeState {
    nextPosAvailable :: Integer
  }

main :: IO ()
main =
  putStrLn "Halvin"
