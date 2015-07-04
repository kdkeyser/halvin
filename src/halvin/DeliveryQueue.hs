module DeliveryQueue where

import qualified Data.Set as Set
import qualified Data.PSQueue as PSQueue

import Transaction
import Commutating
import Position
import NonCommutatingTransactionSet

newtype DeliveryQueue a = DeliveryQueue (PSQueue.PSQ (Transaction a) Int)

empty :: DeliveryQueue a
empty =
    DeliveryQueue PSQueue.empty

getNonCommutatingTransactions :: (Commutating a) => Transaction a -> DeliveryQueue a -> NonCommutatingTransactionSet a
getNonCommutatingTransactions t (DeliveryQueue dq) =
    PSQueue.foldl (\set binding ->
      let transaction = PSQueue.key binding in
      if commutates t transaction == DoesNotCommutate
      then
        Set.insert transaction set
      else
        set
    ) Set.empty dq

getHighestPosition :: DeliveryQueue a -> Position
getHighestPosition (DeliveryQueue psq) =
  case PSQueue.findMin psq of
    Nothing -> 0
    Just b -> negate $ PSQueue.prio b