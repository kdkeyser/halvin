module Main where

data CommutateResult = Commutates | DoesNotCommutate

class Commutating a where
  commutates :: a -> a -> CommutateResult



main :: IO ()
main =
  putStrLn "Halvin"
