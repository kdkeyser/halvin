{-# LANGUAGE TypeFamilies #-}

module Main where


class Operation a where
  data State a :: *
  apply :: State a -> a b -> (State a, b)

main :: IO ()
main =
  putStrLn "Halvin"
