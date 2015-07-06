module NonCommutatingTransactionSet where

import Data.Set
import Transaction

type NonCommutatingTransactionSet a =  Set (Transaction a)

empty = Data.Set.empty

